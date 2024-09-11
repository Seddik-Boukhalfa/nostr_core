// ignore_for_file: unnecessary_overrides

import 'package:isar/isar.dart';
import 'package:nostr_core/models/dm_session_info.dart';

part 'db_dm_info.g.dart';

@Collection(inheritance: true)
class DbDmSessionInfo extends DMSessionInfo {
  @override
  String get id => super.id;

  @override
  String get ownPubkey => super.ownPubkey;

  @override
  String get peerPubkey => super.peerPubkey;

  @override
  int get readTime => super.readTime;

  DbDmSessionInfo({
    required super.id,
    required super.peerPubkey,
    required super.ownPubkey,
    required super.readTime,
  });

  static DbDmSessionInfo fromEvent(DMSessionInfo info) {
    return DbDmSessionInfo(
      id: info.id,
      ownPubkey: info.ownPubkey,
      peerPubkey: info.peerPubkey,
      readTime: info.readTime,
    );
  }
}
