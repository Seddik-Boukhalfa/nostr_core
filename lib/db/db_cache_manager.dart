import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:nostr_core/cache/cache_manager.dart';
import 'package:nostr_core/db/db_contact_list.dart';
import 'package:nostr_core/db/db_dm_info.dart';
import 'package:nostr_core/db/db_event.dart';
import 'package:nostr_core/db/db_metadata.dart';
import 'package:nostr_core/db/db_nip05.dart';
import 'package:nostr_core/db/db_relay_set.dart';
import 'package:nostr_core/db/db_user_relay_list.dart';
import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/dm_session_info.dart';
import 'package:nostr_core/models/event_filter.dart';
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
      ],
    );
  }

  @override
  Future<void> saveUserRelayList(UserRelayList userRelayList) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbUserRelayLists
          .put(DbUserRelayList.fromUserRelayList(userRelayList));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED UserRelayList ${userRelayList.pubkey} took ${duration.inMilliseconds} ms");
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
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbRelaySets.put(DbRelaySet.fromRelaySet(relaySet));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED relaySet ${relaySet.name}+${relaySet.pubKey} took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Future<void> saveUserRelayLists(List<UserRelayList> userRelayLists) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbUserRelayLists.putAll(userRelayLists
          .map(
            (e) => DbUserRelayList.fromUserRelayList(e),
          )
          .toList());
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED ${userRelayLists.length} UserRelayLists took ${duration.inMilliseconds} ms");
    }
  }

  @override
  ContactList? loadContactList(String pubKey) {
    return isar.dbContactLists.get(pubKey);
  }

  @override
  Future<void> saveContactList(ContactList contactList) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbContactLists.put(DbContactList.fromContactList(contactList));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED ${contactList.pubkey} ContacList took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Future<void> saveContactLists(List<ContactList> contactLists) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbContactLists.putAll(
          contactLists.map((e) => DbContactList.fromContactList(e)).toList());
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED ${contactLists.length} ContactLists took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Metadata? loadMetadata(String pubKey) {
    return isar.dbMetadatas.get(pubKey);
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

  @override
  Future<void> removeMetadata(String pubKey) async {
    isar.write((isar) {
      isar.dbMetadatas.delete(pubKey);
    });
  }

  @override
  Future<void> saveMetadata(Metadata metadata) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbMetadatas.put(DbMetadata.fromMetadata(metadata));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print("SAVED Metadata took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Future<void> saveMetadatas(List<Metadata> metadatas) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbMetadatas.putAll(metadatas
          .map((metadata) => DbMetadata.fromMetadata(metadata))
          .toList());
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED ${metadatas.length} UserMetadatas took ${duration.inMilliseconds} ms");
    }
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
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbNip05s.put(DbNip05.fromNip05(nip05));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print("SAVED Nip05 took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Future<void> saveNip05s(List<Nip05> nip05s) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbNip05s
          .putAll(nip05s.map((nip05) => DbNip05.fromNip05(nip05)).toList());
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print(
          "SAVED ${nip05s.length} UserNip05s took ${duration.inMilliseconds} ms");
    }
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
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbEvents.put(DbEvent.fromEvent(event));
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print("SAVED Event took ${duration.inMilliseconds} ms");
    }
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    final startTime = DateTime.now();
    isar.write((isar) {
      isar.dbEvents
          .putAll(events.map((event) => DbEvent.fromEvent(event)).toList());
    });
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    if (kDebugMode) {
      print("SAVED ${events.length} Events took ${duration.inMilliseconds} ms");
    }
  }

  @override
  List<Event> loadEvents({
    List<String>? pubKeys,
    List<int>? kinds,
    String? pTag,
    String? currentUser,
  }) {
    List<Event> events = isar.dbEvents
        .where()
        .optional(
          Helpers.isNotBlank(currentUser),
          (q) => q.currentUserEqualTo(currentUser!),
        )
        .and()
        .optional(kinds != null && kinds.isNotEmpty,
            (q) => q.anyOf(kinds!, (q, kind) => q.kindEqualTo(kind)))
        .and()
        .optional(pubKeys != null && pubKeys.isNotEmpty,
            (q) => q.anyOf(pubKeys!, (q, pubKey) => q.pubkeyEqualTo(pubKey)))
        .and()
        .optional(Helpers.isNotBlank(pTag), (q) => q.pTagsElementEqualTo(pTag!))
        .findAll();

    return eventFilter != null
        ? events.where((event) => eventFilter!.filter(event)).toList()
        : events;
  }

  @override
  Event? loadEvent(String id, bool r) {
    Event? event;
    if (r) {
      final evs = isar.dbEvents.where().dTagEqualTo(id).findAll();
      if (evs.isEmpty) {
        return null;
      }

      return evs.first;
    } else {
      event = isar.dbEvents.get(id);
    }

    return eventFilter == null || (event != null && eventFilter!.filter(event))
        ? event
        : null;
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
  Future<void> clearCache() async {
    Future.wait(
      [
        removeAllContactLists(),
        removeAllEvents(),
        removeAllMetadatas(),
        removeAllNip05s(),
        removeAllRelaySets(),
        removeAllUserRelayLists(),
      ],
    );
  }
}
