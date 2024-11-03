import 'dart:convert';

import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_core/nostr/nostr.dart';
import 'package:nostr_core/utils/utils.dart';

class EventStats extends Equatable {
  const EventStats({
    required this.eventId,
    required this.reactions,
    required this.replies,
    required this.quotes,
    required this.reposts,
    required this.zaps,
    required this.newestCreatedAt,
  });

  final String eventId;
  final Map<String, String> reactions;
  final Map<String, String> replies;
  final Map<String, String> quotes;
  final Map<String, String> reposts;
  final Map<String, Map<String, int>> zaps;
  final int newestCreatedAt;

  List<int> get getZapsData {
    int total = 0;
    int highestZap = 0;

    zaps.forEach((user, groupedZaps) {
      groupedZaps.forEach(
        (zap, value) {
          total += value;
          if (value > highestZap) {
            highestZap = value;
          }
        },
      );
    });

    return [total, highestZap];
  }

  Map<String, int> get getZappersList {
    Map<String, int> zappers = {};

    zaps.forEach((user, groupedZaps) {
      zappers[user] = groupedZaps.values.reduce((a, b) => a + b);
    });

    return zappers;
  }

  bool isSelfReaction(String pubkey) => reactions.values.contains(pubkey);
  bool isSelfReply(String pubkey) => replies.values.contains(pubkey);
  bool isSelfQuote(String pubkey) => quotes.values.contains(pubkey);
  bool isSelfRepost(String pubkey) => reposts.values.contains(pubkey);
  bool isSelfZap(String pubkey) => zaps.keys.contains(pubkey);

  bool hasZapId(String id) {
    return zaps.values.any((element) => element[id] != null);
  }

  EventStats addEvent(Event ev) {
    final createdAt = getNewestCreatedAt(ev.createdAt);

    if (ev.kind == EventKind.REACTION && !reactions.containsKey(ev.id)) {
      return copyWith(
        reactions: Map<String, String>.from(reactions)
          ..addAll({ev.id: ev.pubkey}),
        newestCreatedAt: createdAt,
      );
    } else if (ev.kind == EventKind.TEXT_NOTE) {
      if (ev.isQuote() && !quotes.containsKey(ev.id)) {
        return copyWith(
          quotes: Map<String, String>.from(quotes)..addAll({ev.id: ev.pubkey}),
          newestCreatedAt: createdAt,
        );
      } else {
        for (final tags in ev.stTags) {
          if (canAddNote(tags, eventId)) {
            return copyWith(
              replies: Map<String, String>.from(replies)
                ..addAll({ev.id: ev.pubkey}),
              newestCreatedAt: createdAt,
            );
          }
        }
      }
    } else if (ev.kind == EventKind.REPOST && !reposts.containsKey(ev.id)) {
      return copyWith(
        reposts: Map<String, String>.from(reposts)..addAll({ev.id: ev.pubkey}),
        newestCreatedAt: createdAt,
      );
    } else if (ev.kind == EventKind.ZAP && !hasZapId(ev.id)) {
      final p = getZapPubkey(ev.stTags).first;
      final zp = p.isNotEmpty ? p : ev.pubkey;
      final newZaps = Map<String, Map<String, int>>.from(zaps);
      newZaps[zp] = {...zaps[zp] ?? {}, ev.id: getZapEvent(ev).toInt()};

      return copyWith(
        zaps: newZaps,
        newestCreatedAt: createdAt,
      );
    }

    return this;
  }

  EventStats addEvents(List<Event> events) {
    final updatedReactions = Map<String, String>.from(reactions);
    final updatedReplies = Map<String, String>.from(replies);
    final updatedReposts = Map<String, String>.from(reposts);
    final updatedQuotes = Map<String, String>.from(quotes);
    final updatedZaps = Map<String, Map<String, int>>.from(zaps);
    int createdAt = newestCreatedAt;

    for (final ev in events) {
      if (ev.kind == EventKind.REACTION && !reactions.containsKey(ev.id)) {
        updatedReactions[ev.id] = ev.pubkey;
        createdAt = getNewestCreatedAt(ev.createdAt);
      } else if (ev.kind == EventKind.TEXT_NOTE) {
        if (ev.isQuote() && !quotes.containsKey(ev.id)) {
          updatedQuotes[ev.id] = ev.pubkey;
          createdAt = getNewestCreatedAt(ev.createdAt);
        } else {
          for (final tags in ev.stTags) {
            if (canAddNote(tags, eventId)) {
              updatedReplies[ev.id] = ev.pubkey;
              createdAt = getNewestCreatedAt(ev.createdAt);
            }
          }
        }
      } else if (ev.kind == EventKind.REPOST && !reposts.containsKey(ev.id)) {
        updatedReposts[ev.id] = ev.pubkey;
        createdAt = getNewestCreatedAt(ev.createdAt);
      } else if (ev.kind == EventKind.ZAP && !hasZapId(ev.id)) {
        final p = getZapPubkey(ev.stTags).first;
        final zp = p.isNotEmpty ? p : ev.pubkey;

        updatedZaps[zp] = {...zaps[zp] ?? {}, ev.id: getZapEvent(ev).toInt()};
        createdAt = getNewestCreatedAt(ev.createdAt);
      }
    }

    return copyWith(
      reactions: updatedReactions,
      newestCreatedAt: createdAt,
      quotes: updatedQuotes,
      replies: updatedReplies,
      zaps: updatedZaps,
      reposts: updatedReposts,
    );
  }

  EventStats removeReaction(String eventId) {
    final updatedReactions = Map<String, String>.from(reactions);
    updatedReactions.remove(eventId);

    return copyWith(
      reactions: updatedReactions,
    );
  }

  double getZapEvent(Event event) {
    final ZapReceipt receipt = Nip57.getZapReceipt(event);
    final Bolt11PaymentRequest req = Bolt11PaymentRequest(receipt.bolt11);

    return (req.amount.toDouble() * 100000000).round().toDouble();
  }

  int getNewestCreatedAt(int createdAt) {
    if (createdAt > newestCreatedAt) {
      return createdAt;
    } else {
      return newestCreatedAt;
    }
  }

  List<String> getZapPubkey(List<List<String>> tags) {
    String? zapRequestEventStr;
    String senderPubkey = '';
    String content = '';

    for (final tag in tags) {
      if (tag.length > 1 && tag[0] == 'description') {
        zapRequestEventStr = tag[1];
      }
    }

    if (zapRequestEventStr != null && zapRequestEventStr.isNotEmpty) {
      try {
        final eventJson = jsonDecode(zapRequestEventStr);
        final zapRequestEvent = Event.fromJson(eventJson);
        senderPubkey = zapRequestEvent.pubkey;
        content = zapRequestEvent.content;
      } catch (e) {
        senderPubkey =
            SpiderUtil.subUntil(zapRequestEventStr, 'pubkey":"', '"');
      }
    }

    return [senderPubkey, content];
  }

  bool canAddNote(List<String> tag, String noteId) {
    return ((tag.first == 'e' || tag.first == 'a') &&
            tag.length > 3 &&
            tag[3] == 'root' &&
            tag[1] == noteId) ||
        ((tag.first == 'e' || tag.first == 'a') &&
            tag.length > 1 &&
            tag[1] == noteId);
  }

  EventStats copyWith({
    String? eventId,
    Map<String, String>? reactions,
    Map<String, String>? replies,
    Map<String, String>? quotes,
    Map<String, String>? reposts,
    Map<String, Map<String, int>>? zaps,
    int? newestCreatedAt,
  }) {
    return EventStats(
      eventId: eventId ?? this.eventId,
      reactions: reactions ?? Map.from(this.reactions),
      replies: replies ?? Map.from(this.replies),
      quotes: quotes ?? Map.from(this.quotes),
      reposts: reposts ?? Map.from(this.reposts),
      zaps: zaps ?? Map.from(this.zaps),
      newestCreatedAt: newestCreatedAt ?? this.newestCreatedAt,
    );
  }

  @override
  List<Object?> get props => [
        eventId,
        reactions,
        replies,
        quotes,
        reposts,
        zaps,
        newestCreatedAt,
      ];
}
