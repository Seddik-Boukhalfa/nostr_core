// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:nostr_core/models/user_drafts.dart';

part 'db_user_drafts.g.dart';

@Collection()
class DbUserDrafts {
  String get id => pubkey;

  String pubkey;
  String data;

  DbUserDrafts({
    required this.pubkey,
    required this.data,
  });

  static DbUserDrafts fromUserDrafts(UserDrafts userDrafts) {
    return DbUserDrafts(
      pubkey: userDrafts.pubkey,
      data: jsonEncode({
        'replies': userDrafts.replies,
        'noteDraft': userDrafts.noteDraft,
        'articleDraft': userDrafts.articleDraft,
        'smartWidgetsDraft': userDrafts.smartWidgetsDraft,
      }),
    );
  }

  UserDrafts userDrafts() {
    final dataMap = jsonDecode(data);

    return UserDrafts(
      pubkey: pubkey,
      articleDraft: dataMap['articleDraft'] as String? ?? '',
      noteDraft: dataMap['noteDraft'] as String? ?? '',
      smartWidgetsDraft:
          Map<String, String>.from(dataMap['smartWidgetsDraft'] ?? {}),
      replies: Map<String, String>.from(dataMap['replies'] ?? {}),
    );
  }
}
