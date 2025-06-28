// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:nostr_core/models/wot_models.dart';

part 'db_user_wot.g.dart';

@Collection()
class DbUserWot {
  String get id => pubkey;

  String pubkey;
  int createdAt;
  List<WotEntry> wot;

  DbUserWot({
    required this.pubkey,
    required this.createdAt,
    required this.wot,
  });

  static DbUserWot fromWotModel(WotModel wotModel) {
    return DbUserWot(
      pubkey: wotModel.pubkey,
      createdAt: wotModel.createdAt,
      wot: wotModel.wot.entries
          .map(
            (e) => WotEntry(
              key: e.key,
              value: e.value,
            ),
          )
          .toList(),
    );
  }

  WotModel wotModel() {
    return WotModel(
      pubkey: pubkey,
      createdAt: createdAt,
      wot: Map<String, double>.fromIterables(
        wot.map((e) => e.key),
        wot.map((e) => e.value),
      ),
    );
  }
}

@embedded
class WotEntry {
  String key;
  double value;

  WotEntry({
    required this.key,
    required this.value,
  });
}
