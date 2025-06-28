// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:nostr_core/nostr/nostr.dart';
import 'package:nostr_core/nostr/remote_cache_event.dart';
import 'package:pointycastle/export.dart';

import '../utils/static_properties.dart';

class Event implements BaseEvent {
  late String id;

  late String pubkey;

  late int createdAt;

  late int kind;

  late List<dynamic> tags;

  late String sig;

  String content = '';

  List<String> seenOn = [];

  String currentUser = '';

  String? subscriptionId;

  int? lastUpdated;

  Event(
    this.id,
    this.pubkey,
    this.createdAt,
    this.kind,
    this.tags,
    this.content,
    this.sig, {
    this.subscriptionId,
    this.lastUpdated,
    this.currentUser = '',
    this.seenOn = const [],
    bool verify = false,
  }) {
    pubkey = pubkey.toLowerCase();
  }

  String? getEventParent() {
    String? root;
    String? reply;

    for (final tag in stTags) {
      if (kind == EventKind.REACTION ||
          kind == EventKind.REPOST ||
          kind == EventKind.ZAP) {
        if ((tag.first == 'a' || tag.first == 'e') && tag.length > 1) {
          reply = tag[1];
        }
      } else {
        if (isQuote()) {
          if (tag.first == 'q' && tag.length > 1) {
            reply = tag[1];
          }
        } else {
          if (tag.length > 3 &&
              (tag.first == 'a' || tag.first == 'e') &&
              tag[3] == 'root') {
            root = tag[1];
          } else if (tag.length > 3 && tag.first == 'e' && tag[3] == 'reply') {
            reply = tag[1];
          }
        }
      }
    }

    return reply ?? root;
  }

  String? getCustomEmojiUrl(String emoji) {
    String? url;

    final e = emoji.replaceAll(':', '');

    for (final tag in stTags) {
      if (tag.first == 'emoji' && tag.length > 2 && tag[1] == e) {
        url = tag[2];
      }
    }

    return url;
  }

  MapEntry<String, bool>? getQtag() {
    MapEntry<String, bool>? q;

    for (final tag in stTags) {
      if (tag.length >= 2 && tag.first == 'q') {
        if (tag[1].contains(':')) {
          q = MapEntry(tag[1].split(':').last, true);
        } else {
          q = MapEntry(tag[1], false);
        }
      }
    }

    return q;
  }

  bool isUncensoredNote() {
    bool isUncensoredNote = false;

    for (final tag in stTags) {
      final tagLength = tag.length;

      if (tagLength >= 2 && tag[0] == 'l' && tag[1] == 'UNCENSORED NOTE') {
        isUncensoredNote = true;
      }
    }

    return isUncensoredNote;
  }

  bool isUnRate() {
    bool hasEncryption = false;

    for (final tag in stTags) {
      if (tag.first == 'yaki_flash_news' && tag.length > 1) {
        hasEncryption = true;
      }
    }

    return hasEncryption && kind == EventKind.REACTION;
  }

  static List<String> getTags(List<List<String>> list, String tag) {
    List<String> tags = [];
    for (var e in list) {
      if (e.length > 1) {
        var key = e[0];
        var value = e[1];

        if (key == tag) {
          tags.add(value.toString());
        }
      }
    }
    return tags;
  }

  List<List<String>> get stTags => tags
      .map(
        (e) => List<String>.from(e),
      )
      .toList();

  String? get dTag {
    final sTags = getTags(stTags, "d");
    return sTags.isEmpty ? null : sTags.first;
  }

  List<String> get aTags {
    return getTags(stTags, "a");
  }

  List<String> get tTags {
    return getTags(stTags, "t");
  }

  List<String> get pTags {
    return getTags(stTags, "p");
  }

  List<String> get kTags {
    return getTags(stTags, "k");
  }

  List<String> get eTags {
    return getTags(stTags, "e");
  }

  static List<String> getEtags(List<List<String>> list, String tag) {
    List<String> tags = [];

    for (var e in list) {
      if (e.length > 3 && e[3] == tag) {
        tags = e;
      }
    }
    return tags;
  }

  bool isQuote() {
    if (kind == EventKind.TEXT_NOTE) {
      for (final tag in stTags) {
        if (tag.first == 'q' && tag.length >= 2) {
          return true;
        }
      }

      return false;
    } else {
      return false;
    }
  }

  String? get root {
    final sTags = getEtags(stTags, "root");
    return sTags.isEmpty ? null : sTags[1];
  }

  String? get reply {
    final sTags = getEtags(stTags, "reply");
    return sTags.isEmpty ? null : sTags[1];
  }

  String? eventReply() {
    final sTags = getEtags(stTags, "reply");
    return sTags.isEmpty ? null : sTags[1];
  }

  String? eventRoot() {
    final sTags = getEtags(stTags, "root");
    return sTags.isEmpty ? null : sTags[1];
  }

  factory Event.partial({
    String id = '',
    String pubkey = '',
    int createdAt = 0,
    int kind = 1,
    tags = const <List<String>>[],
    String content = '',
    String sig = '',
    String currentUser = '',
    seenOn = const <String>[],
    subscriptionId,
    bool verify = false,
  }) {
    return Event(
      id.isEmpty ? _processEventId(pubkey, createdAt, kind, tags, content) : id,
      pubkey,
      createdAt,
      kind,
      tags,
      content,
      sig,
      currentUser: currentUser,
      seenOn: seenOn,
      verify: verify,
    );
  }

  String getNEvent() {
    return Nip19.encodeShareableEntity(
      'nevent',
      id,
      [],
      pubkey,
      kind,
    );
  }

  factory Event.withoutSignature({
    int createdAt = 0,
    required int kind,
    required List<List<String>> tags,
    required String content,
    required String pubkey,
    String? subscriptionId,
    bool verify = false,
  }) {
    if (createdAt == 0) createdAt = currentUnixTimestampSeconds();

    final id = _processEventId(
      pubkey,
      createdAt,
      kind,
      tags,
      content,
    );

    return Event(
      id,
      pubkey,
      createdAt,
      kind,
      tags,
      content,
      '',
      subscriptionId: subscriptionId,
      currentUser: pubkey,
      seenOn: [],
      verify: verify,
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    String? currentUser,
    List<String>? seenOn,
    bool verify = true,
  }) {
    var tags = (json['tags'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList();

    return Event(
      json['id'],
      json['pubkey'],
      json['created_at'],
      json['kind'],
      tags,
      json['content'],
      json['sig'],
      currentUser: currentUser ?? '',
      seenOn: seenOn ?? [],
      verify: verify,
    );
  }

  /// Serialize an event in JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'pubkey': pubkey,
        'created_at': createdAt,
        'kind': kind,
        'tags': tags,
        'content': content,
        'sig': sig
      };

  Map<String, dynamic> toDetailedJson() => {
        'id': id,
        'pubkey': pubkey,
        'created_at': createdAt,
        'kind': kind,
        'tags': tags,
        'content': content,
        'sig': sig,
        'currentUser': currentUser,
        'lastUpdated': lastUpdated,
        'seenOn': seenOn,
        'subscriptionId': subscriptionId,
      };

  String toJsonString() => jsonEncode(
        {
          'id': id,
          'pubkey': pubkey,
          'created_at': createdAt,
          'kind': kind,
          'tags': tags,
          'content': content,
          'sig': sig
        },
      );

  /// Serialize to nostr event message
  /// - ["EVENT", event JSON as defined above]
  /// - ["EVENT", subscription_id, event JSON as defined above]
  String serialize() {
    if (subscriptionId != null) {
      return jsonEncode(['EVENT', subscriptionId, toJson()]);
    } else {
      return jsonEncode(['EVENT', toJson()]);
    }
  }

  String serializeAuth() {
    if (subscriptionId != null) {
      return jsonEncode(['AUTH', subscriptionId, toJson()]);
    } else {
      return jsonEncode(['AUTH', toJson()]);
    }
  }

  factory Event.deserialize(
    input, {
    String? currentUser,
    List<String>? seenOn,
    bool verify = true,
  }) {
    Map<String, dynamic> json = {};
    String? subscriptionId;

    if (input.length == 2) {
      json = input[1] as Map<String, dynamic>;
    } else if (input.length == 3) {
      json = input[2] as Map<String, dynamic>;
      subscriptionId = input[1] as String;
    } else {
      throw Exception('invalid input');
    }

    var tags = (json['tags'] as List<dynamic>)
        .map((e) => (e as List)
            .map((e) => e.runtimeType == String ? e as String : '')
            .toList())
        .toList();

    return Event(
      json['id'],
      json['pubkey'],
      json['created_at'],
      json['kind'],
      tags,
      json['content'],
      json['sig'],
      currentUser: currentUser ?? '',
      seenOn: seenOn ?? [],
      subscriptionId: subscriptionId,
      verify: verify,
    );
  }

  static Event? fromString(String content) {
    try {
      return Event.fromJson(jsonDecode(content));
    } catch (_) {
      return null;
    }
  }

  // Support for [getEventId]
  static String _processEventId(
    String pubkey,
    int createdAt,
    int kind,
    List<List<String>> tags,
    String content,
  ) {
    List data = [0, pubkey.toLowerCase(), createdAt, kind, tags, content];
    String serializedEvent = json.encode(data);
    Uint8List hash = SHA256Digest()
        .process(Uint8List.fromList(utf8.encode(serializedEvent)));
    return hex.encode(hash);
  }

  DateTime getPublishedAt() {
    DateTime publishedAt =
        DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);

    for (var tag in tags) {
      if (tag.first == 'published_at' && tag.length >= 2) {
        publishedAt = DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(tag[1]) ?? createdAt * 1000,
        );
      }
    }

    return publishedAt;
  }

  bool isAuthor(EventSigner? signer) => pubkey == signer?.getPublicKey();

  static Future<Event?> genEvent({
    int createdAt = 0,
    required int kind,
    required List<List<String>> tags,
    required String content,
    required EventSigner? signer,
    String? subscriptionId,
    bool verify = false,
  }) async {
    try {
      if (signer == null || signer.isGuest()) {
        return null;
      }

      if (createdAt == 0) createdAt = currentUnixTimestampSeconds();

      final id = _processEventId(
        signer.getPublicKey(),
        createdAt,
        kind,
        tags,
        content,
      );

      final ev = Event.partial(
        id: id,
        pubkey: signer.getPublicKey(),
        createdAt: createdAt,
        kind: kind,
        tags: tags,
        content: content,
        subscriptionId: subscriptionId,
        currentUser: signer.getPublicKey(),
        verify: verify,
      );

      await signer.sign(ev);

      if (ev.sig.isNotEmpty) {
        return ev;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
