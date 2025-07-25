import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:nostr_core/cache/cache_manager.dart';
import 'package:nostr_core/db/db_contact_list.dart';
import 'package:nostr_core/db/db_dm_info.dart';
import 'package:nostr_core/db/db_event.dart';
import 'package:nostr_core/db/db_event_stats.dart';
import 'package:nostr_core/db/db_metadata.dart';
import 'package:nostr_core/db/db_mute_list.dart';
import 'package:nostr_core/db/db_nip05.dart';
import 'package:nostr_core/db/db_relay_set.dart';
import 'package:nostr_core/db/db_user_app_settings.dart';
import 'package:nostr_core/db/db_user_drafts.dart';
import 'package:nostr_core/db/db_user_followers.dart';
import 'package:nostr_core/db/db_user_relay_list.dart';
import 'package:nostr_core/db/db_user_wot.dart';
import 'package:nostr_core/db/db_wot_score.dart';
import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/dm_session_info.dart';
import 'package:nostr_core/models/event_filter.dart';
import 'package:nostr_core/models/event_stats.dart';
import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/models/mute_list.dart';
import 'package:nostr_core/models/nip05.dart';
import 'package:nostr_core/models/wot_models.dart';
import 'package:nostr_core/nostr/event.dart';
import 'package:nostr_core/utils/helpers.dart';

import '../models/relay_set.dart';
import '../models/user_relay_list.dart';

class DbCacheManager extends CacheManager {
  late Isar isar;
  EventFilter? eventFilter;

  Future<void> init({String? directory}) async {
    if (directory == Isar.sqliteInMemory) {
      await Isar.initialize();
    }

    isar = Isar.open(
      name: "nostr_core_${kDebugMode ? "debug" : "release"}",
      inspector: kDebugMode,
      maxSizeMiB: 4096,
      compactOnLaunch: const CompactCondition(
        minRatio: 2.0,
        minBytes: 100 * 1024 * 1024,
        minFileSize: 256 * 1024 * 1024,
      ),
      directory: directory ?? Directory.systemTemp.path,
      engine: directory == Isar.sqliteInMemory
          ? IsarEngine.sqlite
          : IsarEngine.isar,
      schemas: [
        DbEventSchema,
        DbUserRelayListSchema,
        DbRelaySetSchema,
        DbContactListSchema,
        DbMetadataSchema,
        DbNip05Schema,
        DbDmSessionInfoSchema,
        DbEventStatsSchema,
        DbUserFollowersSchema,
        DbUserDraftsSchema,
        DbUserAppSettingsSchema,
        DbUserWotSchema,
        DbMuteListSchema,
        DbWotScoreSchema,
      ],
    );
  }

  double getDatabaseSizeInMb() {
    return (isar.getSize(includeIndexes: true) / (1024 * 1024));
  }

  /// *********************************************************************************************
  ///
  @override
  Future<void> saveUserRelayList(UserRelayList userRelayList) async {
    if (userRelayList.pubkey.isNotEmpty) {
      isar.write((isar) {
        isar.dbUserRelayLists
            .put(DbUserRelayList.fromUserRelayList(userRelayList));
      });
    }
  }

  @override
  UserRelayList? loadUserRelayList(String pubKey) {
    return isar.dbUserRelayLists.get(pubKey);
  }

  @override
  RelaySet? loadRelaySet(String name, String pubKey) {
    return isar.dbRelaySets.get(RelaySet.buildId(name, pubKey));
  }

  @override
  Future<void> saveRelaySet(RelaySet relaySet) async {
    if (relaySet.id.isNotEmpty) {
      isar.write((isar) {
        isar.dbRelaySets.put(DbRelaySet.fromRelaySet(relaySet));
      });
    }
  }

  @override
  Future<void> saveUserRelayLists(List<UserRelayList> userRelayLists) async {
    final validRelayList = userRelayLists
        .where(
          (r) => r.pubkey.isNotEmpty,
        )
        .toList();

    isar.write(
      (isar) {
        isar.dbUserRelayLists.putAll(
          validRelayList
              .map(
                (e) => DbUserRelayList.fromUserRelayList(e),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Future<void> removeAllRelaySets() async {
    isar.write((isar) {
      isar.dbRelaySets.clear();
    });
  }

  @override
  Future<void> removeAllUserRelayLists() async {
    isar.write((isar) {
      isar.dbUserRelayLists.clear();
    });
  }

  @override
  Future<void> removeUserRelayList(String pubKey) async {
    isar.write((isar) {
      isar.dbUserRelayLists.delete(pubKey);
    });
  }

  @override
  Future<void> removeRelaySet(String name, String pubKey) async {
    isar.write((isar) {
      isar.dbRelaySets.delete(RelaySet.buildId(name, pubKey));
    });
  }

  // *********************************************************************************************

  @override
  ContactList? loadContactList(String pubKey) {
    return isar.dbContactLists.get(pubKey);
  }

  @override
  Future<void> saveContactList(ContactList contactList) async {
    if (contactList.pubkey.isNotEmpty) {
      isar.write(
        (isar) {
          isar.dbContactLists.put(DbContactList.fromContactList(contactList));
        },
      );
    }
  }

  @override
  int? getContactWotAvailability({
    required List<String> originPubkeyList,
    required String peerPubkey,
  }) {
    if (originPubkeyList.isEmpty) {
      return null;
    }

    final foundCount = isar.dbContactLists
        .where()
        .group(
          (q) => q
              .optional(
                originPubkeyList.isNotEmpty,
                (q) => q.anyOf(originPubkeyList, (q, p) => q.pubkeyEqualTo(p)),
              )
              .and()
              .optional(
                peerPubkey.isNotEmpty,
                (q) => q.contactsElementEqualTo(peerPubkey),
              ),
        )
        .count();

    return foundCount;
  }

  @override
  Future<void> saveContactLists(List<ContactList> contactLists) async {
    final validContactList = contactLists
        .where(
          (c) => c.pubkey.isNotEmpty,
        )
        .toList();

    isar.write(
      (isar) {
        isar.dbContactLists.putAll(
          validContactList
              .map((e) => DbContactList.fromContactList(e))
              .toList(),
        );
      },
    );
  }

  @override
  Future<void> removeAllContactLists() async {
    isar.write((isar) {
      isar.dbContactLists.clear();
    });
  }

  @override
  Future<void> removeContactList(String pubKey) async {
    isar.write((isar) {
      isar.dbContactLists.delete(pubKey);
    });
  }

  // *********************************************************************************************

  @override
  MuteList? loadMuteList(String pubKey) {
    return isar.dbMuteLists.get(pubKey);
  }

  @override
  int? getMutesWotAvailability({
    required List<String> originPubkeyList,
    required String peerPubkey,
  }) {
    if (originPubkeyList.isEmpty) {
      return null;
    }

    final foundCount = isar.dbMuteLists
        .where()
        .group(
          (q) => q
              .optional(
                originPubkeyList.isNotEmpty,
                (q) => q.anyOf(originPubkeyList, (q, p) => q.pubkeyEqualTo(p)),
              )
              .and()
              .optional(
                peerPubkey.isNotEmpty,
                (q) => q.mutesElementEqualTo(peerPubkey),
              ),
        )
        .count();

    return foundCount;
  }

  @override
  Future<void> removeAllMuteLists() async {
    isar.write((isar) {
      isar.dbMuteLists.clear();
    });
  }

  @override
  Future<void> removeMuteList(String pubKey) async {
    isar.write((isar) {
      isar.dbMuteLists.delete(pubKey);
    });
  }

  @override
  Future<void> saveMuteList(MuteList muteList) async {
    if (muteList.pubkey.isNotEmpty) {
      isar.write(
        (isar) {
          isar.dbMuteLists.put(DbMuteList.fromMuteList(muteList));
        },
      );
    }
  }

  @override
  Future<void> saveMuteLists(List<MuteList> muteLists) async {
    final validMuteList = muteLists
        .where(
          (c) => c.pubkey.isNotEmpty,
        )
        .toList();

    isar.write(
      (isar) {
        isar.dbMuteLists.putAll(
          validMuteList.map((e) => DbMuteList.fromMuteList(e)).toList(),
        );
      },
    );
  }

  /// *********************************************************************************************
  ///
  List<Event> loadNoteStats(String id) {
    final events =
        isar.dbEvents.where().rootEqualTo(id).or().replyEqualTo(id).findAll();

    return eventFilter != null
        ? events.where((event) => eventFilter!.filter(event)).toList()
        : events;
  }

  /// *********************************************************************************************

  @override
  Metadata? loadMetadata(String pubKey) {
    return isar.dbMetadatas.get(pubKey);
  }

  @override
  Future<void> removeMetadata(String pubKey) async {
    isar.write((isar) {
      isar.dbMetadatas.delete(pubKey);
    });
  }

  @override
  Future<void> saveMetadata(Metadata metadata) async {
    if (metadata.pubkey.isNotEmpty) {
      isar.write((isar) {
        isar.dbMetadatas.put(DbMetadata.fromMetadata(metadata));
      });
    }
  }

  @override
  Future<void> saveMetadatas(List<Metadata> metadatas) async {
    final validMetadatas = metadatas
        .where(
          (m) => m.pubkey.isNotEmpty,
        )
        .toList();

    isar.write((isar) {
      isar.dbMetadatas.putAll(validMetadatas
          .map((metadata) => DbMetadata.fromMetadata(metadata))
          .toList());
    });
  }

  @override
  List<Metadata> getAllMetadatas() {
    return isar.dbMetadatas.where().findAll();
  }

  @override
  List<Metadata?> loadMetadatas(List<String> pubKeys) {
    return isar.dbMetadatas.getAll(pubKeys);
  }

  @override
  Iterable<Metadata> searchMetadatas(String search, int limit) {
    return isar.dbMetadatas
        .where()
        .splitDisplayNameWordsElementContains(search, caseSensitive: false)
        .or()
        .splitNameWordsElementContains(search, caseSensitive: false)
        .or()
        .nip05Contains(search, caseSensitive: false)
        .findAll()
        .take(limit);
  }

  @override
  Iterable<Metadata> searchRelatedMetadatas(
    String search,
    List<String> pubkeys,
    int limit,
  ) {
    return isar.dbMetadatas
        .where()
        .anyOf(
            pubkeys,
            (q, p) => q.pubkeyEqualTo(p).and().group((inner) => inner
                .splitDisplayNameWordsElementContains(search,
                    caseSensitive: false)
                .or()
                .splitNameWordsElementContains(search, caseSensitive: false)
                .or()
                .nip05Contains(search, caseSensitive: false)))
        .findAll()
        .take(limit);
  }

  @override
  Metadata? getMetadataByNip05(String nip05) {
    return isar.dbMetadatas
        .where()
        .nip05Contains(nip05, caseSensitive: false)
        .findFirst();
  }

  @override
  Future<void> removeAllMetadatas() async {
    isar.write((isar) {
      isar.dbMetadatas.clear();
    });
  }

  /// *********************************************************************************************

  @override
  Future<void> removeNip05(String pubKey) async {
    isar.write((isar) {
      isar.dbNip05s.delete(pubKey);
    });
  }

  @override
  Future<void> saveNip05(Nip05 nip05) async {
    isar.write((isar) {
      isar.dbNip05s.put(DbNip05.fromNip05(nip05));
    });
  }

  @override
  Future<void> saveNip05s(List<Nip05> nip05s) async {
    isar.write((isar) {
      isar.dbNip05s
          .putAll(nip05s.map((nip05) => DbNip05.fromNip05(nip05)).toList());
    });
  }

  @override
  List<Nip05?> loadNip05s(List<String> pubKeys) {
    return isar.dbNip05s.getAll(pubKeys);
  }

  @override
  Nip05? loadNip05(String pubKey) {
    return isar.dbNip05s.get(pubKey);
  }

  @override
  Future<void> removeAllNip05s() async {
    isar.write((isar) {
      isar.dbNip05s.clear();
    });
  }

  // *********************************************************************************************

  @override
  Future<DbUserAppSettings?> loadUserAppSettings(String pubkey) async {
    return isar.dbUserAppSettings.get(pubkey);
  }

  @override
  Future<void> removeAllAppSettings() async {
    isar.write((isar) {
      isar.dbUserAppSettings.clear();
    });
  }

  @override
  Future<void> removeUserAppSettings(String pubkey) async {
    isar.write((isar) {
      isar.dbUserAppSettings.delete(pubkey);
    });
  }

  @override
  Future<void> saveUserAppSettings(DbUserAppSettings dbUserAppSettings) async {
    isar.write((isar) {
      isar.dbUserAppSettings.put(dbUserAppSettings);
    });
  }

  // *********************************************************************************************

  @override
  Future<void> removeEvent(String id) async {
    isar.write((isar) {
      isar.dbEvents.delete(id);
    });
  }

  @override
  Future<void> saveEvent(Event event) async {
    if (event.id.isNotEmpty) {
      isar.write((isar) {
        isar.dbEvents.put(DbEvent.fromEvent(event));
      });
    }
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    final validEvents = events
        .where(
          (e) => e.id.isNotEmpty,
        )
        .toList();

    isar.write((isar) {
      isar.dbEvents.putAll(
          validEvents.map((event) => DbEvent.fromEvent(event)).toList());
    });
  }

  @override
  List<Event> loadEvents({
    List<String>? pubKeys,
    List<String>? kTags,
    List<String>? ids,
    List<int>? kinds,
    List<String>? eTags,
    String? pTag,
    String? currentUser,
  }) {
    final events = isar.dbEvents
        .where()
        .group(
          (q) => q
              .optional(
                Helpers.isNotBlank(currentUser),
                (q) => q.currentUserEqualTo(currentUser!),
              )
              .and()
              .optional(
                eTags?.isNotEmpty ?? false,
                (q) => q.anyOf(eTags!, (q, e) => q.eTagsElementEqualTo(e)),
              )
              .and()
              .optional(
                kTags?.isNotEmpty ?? false,
                (q) => q.anyOf(kTags!, (q, e) => q.kTagsElementEqualTo(e)),
              )
              .and()
              .optional(
                pubKeys?.isNotEmpty ?? false,
                (q) => q.anyOf(pubKeys!, (q, p) => q.pubkeyEqualTo(p)),
              )
              .and()
              .optional(
                ids?.isNotEmpty ?? false,
                (q) => q.anyOf(ids!, (q, id) => q.idEqualTo(id)),
              )
              .and()
              .optional(
                Helpers.isNotBlank(pTag),
                (q) => q.pTagsElementEqualTo(pTag!),
              )
              .and()
              .optional(
                kinds?.isNotEmpty ?? false,
                (q) => q.anyOf(kinds!, (q, k) => q.kindEqualTo(k)),
              ),
        )
        .sortByCreatedAtDesc()
        .findAll();

    return eventFilter != null
        ? events.where((event) => eventFilter!.filter(event)).toList()
        : events;
  }

  @override
  Event? loadEventById(String id, bool r) {
    Event? event;

    if (r) {
      final evs = isar.dbEvents.where().dTagEqualTo(id).findAll();
      if (evs.isEmpty) {
        return null;
      }

      event = evs.first;
    } else {
      event = isar.dbEvents.get(id);
    }

    return eventFilter == null || eventFilter!.filter(event!) ? event : null;
  }

  @override
  Event? loadEvent({
    String? e,
    String? kTag,
    String? pubkey,
    String? pTag,
    int? kind,
  }) {
    Event? event;

    final evs = isar.dbEvents
        .where()
        .optional(kind != null, (q) => q.kindEqualTo(kind!))
        .and()
        .optional(
            Helpers.isNotBlank(kTag), (q) => q.kTagsElementContains(kTag!))
        .and()
        .optional(Helpers.isNotBlank(e), (q) => q.eTagsElementContains(e!))
        .and()
        .optional(
            Helpers.isNotBlank(pTag), (q) => q.pTagsElementContains(pTag!))
        .and()
        .optional(Helpers.isNotBlank(pubkey), (q) => q.pubkeyEqualTo(pubkey!))
        .findAll();

    if (evs.isEmpty) {
      return null;
    } else {
      evs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      event = evs.first;
    }

    return eventFilter == null || eventFilter!.filter(event) ? event : null;
  }

  @override
  Future<void> removeAllEventsByPubKey(String pubKey) async {
    isar.write((isar) {
      isar.dbEvents.where().pubkeyEqualTo(pubKey).deleteAll();
    });
  }

  @override
  Future<void> removeAllEventsByKinds(List<int> kinds) async {
    isar.write((isar) {
      for (var kind in kinds) {
        isar.dbEvents.where().kindEqualTo(kind).deleteAll();
      }
    });
  }

  @override
  Future<void> removeAllEvents() async {
    isar.write((isar) {
      isar.dbEvents.clear();
    });
  }

  // *********************************************************************************************

  @override
  List<DMSessionInfo> loadDmSessionsInfo(String id) {
    return isar.dbDmSessionInfos.where().idStartsWith(id).findAll();
  }

  @override
  List<DMSessionInfo?> loadDmSessionsInfos(List<String> ids) {
    return isar.dbDmSessionInfos.getAll(ids);
  }

  @override
  Future<void> removeAllDmSessionsInfo() async {
    isar.write((isar) {
      isar.dbDmSessionInfos.clear();
    });
  }

  @override
  Future<void> removeDmSessionsInfo(String id) async {
    isar.write((isar) {
      isar.dbDmSessionInfos.delete(id);
    });
  }

  @override
  Future<void> saveDmSessionsInfo(DMSessionInfo info) async {
    isar.write((isar) {
      isar.dbDmSessionInfos.put(DbDmSessionInfo.fromEvent(info));
    });
  }

  @override
  Future<void> saveDmSessionsInfos(List<DMSessionInfo> infos) async {
    isar.write((isar) {
      isar.dbDmSessionInfos.putAll(
        infos.map((info) => DbDmSessionInfo.fromEvent(info)).toList(),
      );
    });
  }

  @override
  EventStats? loadEventStats(String eventId) {
    return isar.dbEventStats.get(eventId)?.eventStats();
  }

  @override
  List<EventStats?> loadEventStatsList(List<String> eventIds) {
    return isar.dbEventStats
        .getAll(eventIds)
        .map(
          (e) => e?.eventStats(),
        )
        .toList();
  }

  @override
  Future<void> removeEventStats(String eventId) async {
    isar.write((isar) {
      isar.dbEventStats.delete(eventId);
    });
  }

  @override
  Future<void> removeAllEventStats() async {
    isar.write((isar) {
      isar.dbEventStats.clear();
    });
  }

  @override
  Future<void> saveEventStats(EventStats stats) async {
    isar.write((isar) {
      isar.dbEventStats.put(DbEventStats.fromEventStats(stats));
    });
  }

  @override
  Future<void> saveEventStatsList(List<EventStats> stats) async {
    isar.write((isar) {
      isar.dbEventStats.putAll(
        stats.map((info) => DbEventStats.fromEventStats(info)).toList(),
      );
    });
  }

  // *********************************************************************************************

  @override
  Future<DbUserFollowers?> loadUserFollowers(String pubkey) async {
    return isar.dbUserFollowers.get(pubkey);
  }

  @override
  Future<void> removeAllUserFollowers() async {
    isar.write((isar) {
      isar.dbUserFollowers.clear();
    });
  }

  @override
  Future<void> removeUserFollowers(String pubkey) async {
    isar.write((isar) {
      isar.dbUserFollowers.delete(pubkey);
    });
  }

  @override
  Future<void> saveUserFollowers(DbUserFollowers dbUserFollowers) async {
    isar.write((isar) {
      isar.dbUserFollowers.put(dbUserFollowers);
    });
  }

  // *********************************************************************************************

  @override
  Future<DbUserDrafts?> loadUserDrafts(String pubkey) async {
    return isar.dbUserDrafts.get(pubkey);
  }

  @override
  Future<void> removeAllUserDrafts() async {
    isar.write((isar) {
      isar.dbUserDrafts.clear();
    });
  }

  @override
  Future<void> removeUserDrafts(String pubkey) async {
    isar.write((isar) {
      isar.dbUserDrafts.delete(pubkey);
    });
  }

  @override
  Future<void> saveUserDrafts(DbUserDrafts dbUserDrafts) async {
    isar.write((isar) {
      isar.dbUserDrafts.put(dbUserDrafts);
    });
  }

  // *********************************************************************************************

  @override
  Future<WotModel?> loadUserWot(String pubkey) async {
    return isar.dbUserWots.get(pubkey)?.wotModel();
  }

  @override
  Future<void> removeAllWot() async {
    isar.write((isar) {
      isar.dbUserWots.clear();
    });
  }

  @override
  Future<void> removeUserWot(String pubkey) async {
    isar.write((isar) {
      isar.dbUserWots.delete(pubkey);
    });
  }

  @override
  Future<void> saveUserWot(WotModel wotModel) async {
    isar.write((isar) {
      isar.dbUserWots.put(DbUserWot.fromWotModel(wotModel));
    });
  }

// *********************************************************************************************

  @override
  WotScore? loadWotScore(String pubkey, String originPubkey) {
    return isar.dbWotScores
        .where()
        .pubkeyEqualTo(pubkey)
        .and()
        .originPubkeyEqualTo(originPubkey)
        .findFirst();
  }

  @override
  List<WotScore> loadWotScoreList(List<String> pubkeys, String originPubkey) {
    if (pubkeys.isEmpty) return [];

    return isar.dbWotScores
        .where()
        .anyOf(pubkeys, (q, pubkey) => q.pubkeyEqualTo(pubkey))
        .and()
        .originPubkeyEqualTo(originPubkey)
        .findAll();
  }

// Add these methods to your DbCacheManager class:

// *********************************************************************************************
// Batch WoT methods for optimization

  @override
  Map<String, WotScore> loadWotScoreMap(
    List<String> pubkeys,
    String originPubkey,
  ) {
    if (pubkeys.isEmpty) return {};

    final scores = isar.dbWotScores
        .where()
        .anyOf(pubkeys, (q, pubkey) => q.pubkeyEqualTo(pubkey))
        .and()
        .originPubkeyEqualTo(originPubkey)
        .findAll();

    return {for (final score in scores) score.pubkey: score};
  }

  @override
  Future<void> saveWotScoresBatch(List<WotScore> wotScores) async {
    if (wotScores.isEmpty) return;

    isar.write(
      (isar) {
        isar.dbWotScores.putAll(
          wotScores.map((score) => DbWotScore.fromWotScore(score)).toList(),
        );
      },
    );
  }

  @override
  Map<String, Map<String, int>> getWotAvailabilityBatch({
    required List<String> originPubkeyList,
    required List<String> peerPubkeys,
  }) {
    final results = <String, Map<String, int>>{};

    if (peerPubkeys.isEmpty || originPubkeyList.isEmpty) {
      return results;
    }

    // More efficient: get all relevant contact lists at once
    final relevantContactLists = isar.dbContactLists
        .where()
        .anyOf(originPubkeyList, (q, pubkey) => q.pubkeyEqualTo(pubkey))
        .findAll();

    // More efficient: get all relevant mute lists at once
    final relevantMuteLists = isar.dbMuteLists
        .where()
        .anyOf(originPubkeyList, (q, pubkey) => q.pubkeyEqualTo(pubkey))
        .findAll();

    // Count follows for each peer
    final followCounts = <String, int>{};
    for (final peerPubkey in peerPubkeys) {
      followCounts[peerPubkey] = relevantContactLists
          .where((contactList) => contactList.contacts.contains(peerPubkey))
          .length;
    }

    // Count mutes for each peer
    final muteCounts = <String, int>{};
    for (final peerPubkey in peerPubkeys) {
      muteCounts[peerPubkey] = relevantMuteLists
          .where((muteList) => muteList.mutes.contains(peerPubkey))
          .length;
    }

    // Combine results
    for (final pubkey in peerPubkeys) {
      results[pubkey] = {
        'following': followCounts[pubkey] ?? 0,
        'mutes': muteCounts[pubkey] ?? 0,
      };
    }

    return results;
  }

  @override
  Future<void> removeAllWotScore() async {
    isar.write((isar) {
      isar.dbWotScores.clear();
    });
  }

  @override
  Future<void> removeWotScore(String id) async {
    isar.write((isar) {
      isar.dbUserWots.delete(id);
    });
  }

  @override
  Future<void> saveWotScore(WotScore wotScore) async {
    isar.write((isar) {
      isar.dbWotScores.put(DbWotScore.fromWotScore(wotScore));
    });
  }

  // *********************************************************************************************
  @override
  Future<void> clearCache() async {
    Future.wait(
      [
        removeAllContactLists(),
        removeAllEvents(),
        removeAllMetadatas(),
        removeAllNip05s(),
        removeAllRelaySets(),
        removeAllUserRelayLists(),
        removeAllEventStats(),
        removeAllMuteLists(),
        removeAllWotScore(),
        removeAllDmSessionsInfo(),
      ],
    );
  }
}
