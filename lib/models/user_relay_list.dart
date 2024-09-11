import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/nostr/event.dart';
import 'package:nostr_core/nostr/nips/nip_065.dart';
import 'package:nostr_core/utils/enums.dart';

class UserRelayList {
  String pubkey;
  int createdAt;
  int refreshedTimestamp;

  Map<String, ReadWriteMarker> relays;

  UserRelayList({
    required this.pubkey,
    required this.relays,
    required this.createdAt,
    required this.refreshedTimestamp,
  });

  Iterable<String> get urls => relays.keys;

  Iterable<String> get readUrls => relays.entries
      .where((entry) => entry.value.isRead)
      .map((entry) => entry.key);

  static UserRelayList fromNip65(Nip65 nip65) {
    return UserRelayList(
      pubkey: nip65.pubkey,
      relays: {for (var entry in nip65.relays.entries) entry.key: entry.value},
      createdAt: nip65.createdAt,
      refreshedTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  Nip65 toNip65() {
    return Nip65.fromMap(pubkey, relays);
  }

  static UserRelayList fromNip02EventContent(Event event) {
    return UserRelayList(
      pubkey: event.pubkey,
      relays: ContactList.relaysFromContent(event),
      createdAt: event.createdAt,
      refreshedTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }
}
