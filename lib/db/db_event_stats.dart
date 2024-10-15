// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:nostr_core/models/event_stats.dart';

part 'db_event_stats.g.dart';

@Collection()
class DbEventStats {
  String get id => eventId;

  String eventId;
  String data;
  int newestCreatedAt;

  DbEventStats({
    required this.eventId,
    required this.data,
    required this.newestCreatedAt,
  });

  static DbEventStats fromEventStats(EventStats eventStats) {
    return DbEventStats(
      eventId: eventStats.eventId,
      data: jsonEncode({
        'reactions': eventStats.reactions,
        'quotes': eventStats.quotes,
        'replies': eventStats.replies,
        'zaps': eventStats.zaps,
        'reposts': eventStats.reposts,
      }),
      newestCreatedAt: eventStats.newestCreatedAt,
    );
  }

  EventStats eventStats() {
    final dataMap = jsonDecode(data);

    final zaps = Map<String, dynamic>.from(dataMap['zaps'] ?? {})
        .map<String, Map<String, int>>(
      (key, value) => MapEntry(key, Map<String, int>.from(value as Map)),
    );

    return EventStats(
      eventId: eventId,
      quotes: Map<String, String>.from(dataMap['quotes'] ?? {}),
      reactions: Map<String, String>.from(dataMap['reactions'] ?? {}),
      replies: Map<String, String>.from(dataMap['replies'] ?? {}),
      reposts: Map<String, String>.from(dataMap['reposts'] ?? {}),
      zaps: zaps,
      newestCreatedAt: newestCreatedAt,
    );
  }
}
