import 'dart:convert';

import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:nostr_core/nostr/nostr.dart';
import 'package:nostr_core/utils/utils.dart';

class EventStats {
  EventStats({
    required this.eventId,
    required this.reactions,
    required this.replies,
    required this.quotes,
    required this.reposts,
    required this.zaps,
    required this.newestCreatedAt,
  });

  String eventId;
  Map<String, String> reactions;
  Map<String, String> replies;
  Map<String, String> quotes;
  Map<String, String> reposts;
  Map<String, Map<String, int>> zaps;
  int newestCreatedAt;

  List<int> get getZapsData {
    int total = 0;
    int highestZap = 0;

    zaps.forEach(
      (user, groupedZaps) {
        groupedZaps.forEach(
          (zap, value) {
            total += value;

            if (value > highestZap) {
              highestZap = value;
            }
          },
        );
      },
    );

    return [total, highestZap];
  }

  bool isSelfReaction(String pubkey) => reactions.values.contains(pubkey);
  bool isSelfReply(String pubkey) => replies.values.contains(pubkey);
  bool isSelfQuote(String pubkey) => quotes.values.contains(pubkey);
  bool isSelfRepost(String pubkey) => reposts.values.contains(pubkey);
  bool isSelfZap(String pubkey) => zaps.keys.contains(pubkey);

  bool hasZapId(String id) {
    return zaps.values
        .where(
          (element) => element[id] != null,
        )
        .isNotEmpty;
  }

  bool addEvent(Event ev) {
    if (ev.kind == EventKind.REACTION && !reactions.keys.contains(ev.id)) {
      reactions[ev.id] = ev.pubkey;
      updateCreatedAt(ev.createdAt);
      return true;
    } else if (ev.kind == EventKind.TEXT_NOTE) {
      if (ev.isQuote() && !quotes.keys.contains(ev.id)) {
        quotes[ev.id] = ev.pubkey;
        updateCreatedAt(ev.createdAt);
        return true;
      } else {
        for (final tags in ev.stTags) {
          if (canAddNote(tags, eventId)) {
            replies[ev.id] = ev.pubkey;
            updateCreatedAt(ev.createdAt);
            return true;
          }
        }
      }
    } else if (ev.kind == EventKind.REPOST && !reposts.keys.contains(ev.id)) {
      reposts[ev.id] = ev.pubkey;
      updateCreatedAt(ev.createdAt);
      return true;
    } else if (ev.kind == EventKind.ZAP && !hasZapId(ev.id)) {
      final p = getZapPubkey(ev.stTags).first;
      final zp = p.isNotEmpty ? p : ev.pubkey;
      zaps[zp] = {...zaps[zp] ?? {}, ev.id: getZapEvent(ev).toInt()};
      updateCreatedAt(ev.createdAt);
      return true;
    }

    return false;
  }

  double getZapEvent(Event event) {
    final ZapReceipt receipt = Nip57.getZapReceipt(event);
    final Bolt11PaymentRequest req = Bolt11PaymentRequest(receipt.bolt11);

    return (req.amount.toDouble() * 100000000).round().toDouble();
  }

  void updateCreatedAt(int createdAt) {
    if (createdAt > newestCreatedAt) {
      newestCreatedAt = createdAt;
    }
  }

  List<String> getZapPubkey(List<List<String>> tags) {
    String? zapRequestEventStr;
    String senderPubkey = '';
    String content = '';

    for (final tag in tags) {
      if (tag.length > 1) {
        final key = tag[0];
        if (key == 'description') {
          zapRequestEventStr = tag[1];
        }
      }
    }

    if (StringUtil.isNotBlank(zapRequestEventStr)) {
      try {
        final eventJson = jsonDecode(zapRequestEventStr!);
        final zapRequestEvent = Event.fromJson(eventJson);
        senderPubkey = zapRequestEvent.pubkey;
        content = zapRequestEvent.content;
      } catch (e) {
        senderPubkey =
            SpiderUtil.subUntil(zapRequestEventStr!, 'pubkey":"', '"');
      }
    }

    return [senderPubkey, content];
  }

  bool canAddNote(List<String> tag, String noteId) {
    return (tag.first == 'e' &&
            tag.length > 3 &&
            tag[3] == 'root' &&
            tag[1] == noteId) ||
        tag.first == 'e' && tag.length > 1 && tag[1] == noteId;
  }
}
