import 'package:isar/isar.dart';
import 'package:nostr_core/models/metadata.dart';

part 'db_metadata.g.dart';

@Collection(inheritance: true)
class DbMetadata extends Metadata {
  String get id => pubkey;

  List<String>? get splitDisplayNameWords =>
      displayName.trim().toLowerCase().split(" ");

  List<String>? get splitNameWords => name.trim().toLowerCase().split(" ");

  DbMetadata({
    required super.pubkey,
    required super.name,
    required super.displayName,
    required super.picture,
    required super.banner,
    required super.website,
    required super.about,
    required super.nip05,
    required super.lud16,
    required super.lud06,
    required super.createdAt,
    required super.isDeleted,
    super.refreshedTimestamp,
  });

  static DbMetadata fromMetadata(Metadata metadata) {
    return DbMetadata(
      pubkey: metadata.pubkey,
      name: metadata.name,
      displayName: metadata.displayName,
      picture: metadata.picture,
      banner: metadata.banner,
      website: metadata.website,
      about: metadata.about,
      nip05: metadata.nip05,
      lud16: metadata.lud16,
      lud06: metadata.lud06,
      createdAt: metadata.createdAt,
      isDeleted: metadata.isDeleted,
      refreshedTimestamp: metadata.refreshedTimestamp,
    );
  }
}
