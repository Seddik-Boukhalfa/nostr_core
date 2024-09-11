import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/dm_session_info.dart';
import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/models/nip05.dart';
import 'package:nostr_core/models/relay_set.dart';
import 'package:nostr_core/models/user_relay_list.dart';
import 'package:nostr_core/nostr/event.dart';

abstract class CacheManager {
  Future<void> saveEvent(Event event);
  Future<void> saveEvents(List<Event> events);
  Event? loadEvent(String id, bool r);
  List<Event> loadEvents({List<String> pubKeys, List<int> kinds, String? pTag});
  Future<void> removeEvent(String id);
  Future<void> removeAllEventsByPubKey(String pubKey);
  Future<void> removeAllEvents();
  Future<void> removeAllEventsByKinds(List<int> kinds);

  Future<void> saveUserRelayList(UserRelayList userRelayList);
  Future<void> saveUserRelayLists(List<UserRelayList> userRelayLists);
  UserRelayList? loadUserRelayList(String pubKey);
  Future<void> removeUserRelayList(String pubKey);
  Future<void> removeAllUserRelayLists();

  RelaySet? loadRelaySet(String name, String pubKey);
  Future<void> saveRelaySet(RelaySet relaySet);
  Future<void> removeRelaySet(String name, String pubKey);
  Future<void> removeAllRelaySets();

  Future<void> saveContactList(ContactList contactList);
  Future<void> saveContactLists(List<ContactList> contactLists);
  ContactList? loadContactList(String pubKey);
  Future<void> removeContactList(String pubKey);
  Future<void> removeAllContactLists();

  Future<void> saveMetadata(Metadata metadata);
  Future<void> saveMetadatas(List<Metadata> metadatas);
  Metadata? loadMetadata(String pubKey);
  List<Metadata?> loadMetadatas(List<String> pubKeys);
  List<Metadata> getAllMetadatas();
  Future<void> removeMetadata(String pubKey);
  Future<void> removeAllMetadatas();
  Iterable<Metadata> searchMetadatas(String search, int limit);

  Future<void> saveNip05(Nip05 nip05);
  Future<void> saveNip05s(List<Nip05> nip05s);
  Nip05? loadNip05(String pubKey);
  List<Nip05?> loadNip05s(List<String> pubKeys);
  Future<void> removeNip05(String pubKey);
  Future<void> removeAllNip05s();

  Future<void> saveDmSessionsInfo(DMSessionInfo info);
  Future<void> saveDmSessionsInfos(List<DMSessionInfo> infos);
  DMSessionInfo? loadDmSessionsInfo(String id);
  List<DMSessionInfo?> loadDmSessionsInfos(List<String> ids);
  Future<void> removeDmSessionsInfo(String id);
  Future<void> removeAllDmSessionsInfo();
}
