// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:nostr_core/nostr/nostr.dart';

part 'db_user_followers.g.dart';

@Collection()
class DbUserFollowers {
  String get id => pubkey;

  String pubkey;
  List<String> followers;
  int lastRefreshed;

  DbUserFollowers({
    required this.pubkey,
    required this.followers,
    required this.lastRefreshed,
  });

  factory DbUserFollowers.fromData(String pubkey, List<String> followers) {
    return DbUserFollowers(
      pubkey: pubkey,
      followers: followers,
      lastRefreshed: currentUnixTimestampSeconds(),
    );
  }
}
