import 'package:isar/isar.dart';
import 'package:nostr_core/models/nip05.dart';

part 'db_nip05.g.dart';

@Collection(inheritance: true)
class DbNip05 extends Nip05 {
  String get id => pubkey;

  DbNip05(
      {required super.pubkey,
      required super.nip05,
      required super.valid,
      required super.updatedAt});

  static DbNip05 fromNip05(Nip05 nip05) {
    return DbNip05(
      pubkey: nip05.pubkey,
      nip05: nip05.nip05,
      valid: nip05.valid,
      updatedAt: nip05.updatedAt,
    );
  }
}
