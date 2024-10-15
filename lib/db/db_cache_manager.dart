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
import 'package:nostr_core/db/db_nip05.dart';
import 'package:nostr_core/db/db_relay_set.dart';
import 'package:nostr_core/db/db_user_relay_list.dart';
import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/dm_session_info.dart';
import 'package:nostr_core/models/event_filter.dart';
import 'package:nostr_core/models/event_stats.dart';
import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/models/nip05.dart';
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
      maxSizeMiB: 1024,
      compactOnLaunch: const CompactCondition(
          minRatio: 2.0,
          minBytes: 100 * 1024 * 1024,
          minFileSize: 256 * 1024 * 1024),
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
      ],
    );
  }

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
  Future<void> removeAllRelaySets() async {
    isar.write((isar) {
      isar.dbRelaySets.clear();
    });
  }

  @override
  Future<void> removeAllContactLists() async {
    isar.write((isar) {
      isar.dbContactLists.clear();
    });
  }

  @override
  Future<void> removeAllUserRelayLists() async {
    isar.write((isar) {
      isar.dbUserRelayLists.clear();
    });
  }

  @override
  Future<void> removeRelaySet(String name, String pubKey) async {
    isar.write((isar) {
      isar.dbRelaySets.delete(RelaySet.buildId(name, pubKey));
    });
  }

  @override
  Future<void> removeContactList(String pubKey) async {
    isar.write((isar) {
      isar.dbContactLists.delete(pubKey);
    });
  }

  @override
  Future<void> removeUserRelayList(String pubKey) async {
    isar.write((isar) {
      isar.dbUserRelayLists.delete(pubKey);
    });
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
        .splitDisplayNameWordsElementStartsWith(search)
        .or()
        .splitNameWordsElementStartsWith(search)
        .or()
        .nip05Contains(search)
        .findAll()
        .take(limit);
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
  Event? loadEvent({String? e, String? pubkey, String? pTag, int? kind}) {
    Event? event;

    final evs = isar.dbEvents
        .where()
        .optional(kind != null, (q) => q.kindEqualTo(kind!))
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
      ],
    );
  }
}
