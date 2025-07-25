import 'package:nostr_core/db/db_user_app_settings.dart';
import 'package:nostr_core/db/db_user_drafts.dart';
import 'package:nostr_core/db/db_user_followers.dart';
import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/dm_session_info.dart';
import 'package:nostr_core/models/event_stats.dart';
import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/models/mute_list.dart';
import 'package:nostr_core/models/nip05.dart';
import 'package:nostr_core/models/relay_set.dart';
import 'package:nostr_core/models/user_relay_list.dart';
import 'package:nostr_core/models/wot_models.dart';
import 'package:nostr_core/nostr/event.dart';

abstract class CacheManager {
  Future<void> saveEvent(Event event);
  Future<void> saveEvents(List<Event> events);
  Event? loadEventById(String id, bool r);
  Event? loadEvent({String? e, String? pubkey, String? pTag, int? kind});
  List<Event> loadEvents({
    List<String> pubKeys,
    List<String>? ids,
    List<String>? eTags,
    List<int> kinds,
    String? pTag,
    String? currentUser,
  });

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

  WotScore? loadWotScore(String pubkey, String originPubkey);
  List<WotScore> loadWotScoreList(List<String> pubkeys, String originPubkey);
  Future<void> saveWotScoresBatch(List<WotScore> wotScores);
  Future<void> saveWotScore(WotScore wotScore);
  Future<void> removeWotScore(String id);
  Future<void> removeAllWotScore();
  Map<String, WotScore> loadWotScoreMap(
    List<String> pubkeys,
    String originPubkey,
  );
  Map<String, Map<String, int>> getWotAvailabilityBatch({
    required List<String> originPubkeyList,
    required List<String> peerPubkeys,
  });

  Future<void> saveContactList(ContactList contactList);
  Future<void> saveContactLists(List<ContactList> contactLists);
  ContactList? loadContactList(String pubKey);
  Future<void> removeContactList(String pubKey);
  Future<void> removeAllContactLists();
  int? getContactWotAvailability({
    required List<String> originPubkeyList,
    required String peerPubkey,
  });

  Future<void> saveMuteList(MuteList muteList);
  Future<void> saveMuteLists(List<MuteList> muteLists);
  MuteList? loadMuteList(String pubKey);
  Future<void> removeMuteList(String pubKey);
  Future<void> removeAllMuteLists();
  int? getMutesWotAvailability({
    required List<String> originPubkeyList,
    required String peerPubkey,
  });

  Future<void> saveMetadata(Metadata metadata);
  Future<void> saveMetadatas(List<Metadata> metadatas);
  Metadata? loadMetadata(String pubKey);
  Metadata? getMetadataByNip05(String nip05);
  List<Metadata?> loadMetadatas(List<String> pubKeys);
  List<Metadata> getAllMetadatas();
  Future<void> removeMetadata(String pubKey);
  Future<void> removeAllMetadatas();
  Iterable<Metadata> searchMetadatas(String search, int limit);
  Iterable<Metadata> searchRelatedMetadatas(
    String search,
    List<String> pubkeys,
    int limit,
  );

  Future<void> saveNip05(Nip05 nip05);
  Future<void> saveNip05s(List<Nip05> nip05s);
  Nip05? loadNip05(String pubKey);
  List<Nip05?> loadNip05s(List<String> pubKeys);
  Future<void> removeNip05(String pubKey);
  Future<void> removeAllNip05s();

  Future<void> saveDmSessionsInfo(DMSessionInfo info);
  Future<void> saveDmSessionsInfos(List<DMSessionInfo> infos);
  List<DMSessionInfo> loadDmSessionsInfo(String id);
  List<DMSessionInfo?> loadDmSessionsInfos(List<String> ids);
  Future<void> removeDmSessionsInfo(String id);
  Future<void> removeAllDmSessionsInfo();

  Future<void> saveEventStats(EventStats stats);
  Future<void> saveEventStatsList(List<EventStats> stats);
  EventStats? loadEventStats(String eventId);
  List<EventStats?> loadEventStatsList(List<String> eventIds);
  Future<void> removeEventStats(String eventId);
  Future<void> removeAllEventStats();

  Future<void> saveUserFollowers(DbUserFollowers dbUserFollowers);
  Future<DbUserFollowers?> loadUserFollowers(String pubkey);
  Future<void> removeUserFollowers(String pubkey);
  Future<void> removeAllUserFollowers();

  Future<void> saveUserDrafts(DbUserDrafts dbUserDrafts);
  Future<DbUserDrafts?> loadUserDrafts(String pubkey);
  Future<void> removeUserDrafts(String pubkey);
  Future<void> removeAllUserDrafts();

  Future<void> saveUserAppSettings(DbUserAppSettings dbUserAppSettings);
  Future<DbUserAppSettings?> loadUserAppSettings(String pubkey);
  Future<void> removeUserAppSettings(String pubkey);
  Future<void> removeAllAppSettings();

  Future<void> saveUserWot(WotModel wotModel);
  Future<WotModel?> loadUserWot(String pubkey);
  Future<void> removeUserWot(String pubkey);
  Future<void> removeAllWot();

  Future<void> clearCache();
}
