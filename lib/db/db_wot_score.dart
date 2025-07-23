import 'package:isar/isar.dart';
import 'package:nostr_core/models/wot_models.dart';

part 'db_wot_score.g.dart';

@Collection(inheritance: true)
class DbWotScore extends WotScore {
  DbWotScore({
    required super.id,
    required super.pubkey,
    required super.score,
    required super.createdAt,
    required super.originPubkey,
  });

  @override
  String get id => pubkey;

  static DbWotScore fromWotScore(WotScore ws) {
    return DbWotScore(
      id: ws.id,
      pubkey: ws.pubkey,
      score: ws.score,
      createdAt: ws.createdAt,
      originPubkey: ws.originPubkey,
    );
  }

  WotScore fromDbWotScore() {
    return WotScore(
      id: id,
      pubkey: pubkey,
      createdAt: createdAt,
      originPubkey: originPubkey,
      score: score,
    );
  }
}
