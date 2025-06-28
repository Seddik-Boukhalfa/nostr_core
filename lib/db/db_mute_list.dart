import 'package:isar/isar.dart';
import 'package:nostr_core/models/mute_list.dart';

part 'db_mute_list.g.dart';

@Collection(inheritance: true)
class DbMuteList extends MuteList {
  DbMuteList({required super.pubkey, required super.mutes});

  String get id => pubkey;

  static DbMuteList fromMuteList(MuteList muteList) {
    DbMuteList dbContactList = DbMuteList(
      pubkey: muteList.pubkey,
      mutes: muteList.mutes,
    );
    dbContactList.createdAt = muteList.createdAt;
    dbContactList.loadedTimestamp = muteList.loadedTimestamp;

    return dbContactList;
  }
}
