// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:nostr_core/models/app_shared_settings.dart';

part 'db_user_app_settings.g.dart';

@Collection()
class DbUserAppSettings {
  String get id => pubkey;

  String pubkey;
  String data;

  DbUserAppSettings({
    required this.pubkey,
    required this.data,
  });

  static DbUserAppSettings fromUserAppSettings(AppSharedSettings appSettings) {
    return DbUserAppSettings(
      pubkey: appSettings.pubkey,
      data: appSettings.toJson(),
    );
  }

  AppSharedSettings appSettings() {
    return AppSharedSettings.fromJson(data);
  }
}
