import 'dart:convert';

import 'package:amberflutter/amberflutter.dart';
import 'package:nostr_core/nostr/nostr.dart';
import 'package:nostr_core/utils/static_properties.dart';

class AmberEventSigner implements EventSigner {
  final amber = Amberflutter();

  final String publicKey;

  AmberEventSigner(this.publicKey);

  @override
  Future<void> sign(Event event) async {
    final npub = publicKey.startsWith('npub')
        ? publicKey
        : Nip19.encodePubkey(publicKey);

    Map<dynamic, dynamic> map = await amber.signEvent(
      currentUser: npub,
      eventJson: jsonEncode(event.toJson()),
      id: event.id,
    );

    event.sig = map['signature'];
  }

  @override
  String getPublicKey() {
    return publicKey;
  }

  @override
  Future<String?> decrypt04(String msg, String destPubKey, {String? id}) async {
    final npub = publicKey.startsWith('npub')
        ? publicKey
        : Nip19.encodePubkey(publicKey);

    Map<dynamic, dynamic> map = await amber.nip04Decrypt(
      ciphertext: msg,
      currentUser: npub,
      pubKey: destPubKey,
      id: id,
    );

    return map['signature'];
  }

  @override
  Future<String?> encrypt04(String msg, String destPubKey, {String? id}) async {
    final npub = publicKey.startsWith('npub')
        ? publicKey
        : Nip19.encodePubkey(publicKey);

    Map<dynamic, dynamic> map = await amber.nip04Encrypt(
      plaintext: msg,
      currentUser: npub,
      pubKey: destPubKey,
      id: id,
    );

    return map['signature'];
  }

  @override
  Future<Event?> encrypt04Event(
    String msg,
    String destPubKey, {
    String? id,
    String? replyId,
  }) async {
    final encryption = await encrypt04(msg, destPubKey);

    if (encryption != null) {
      return await Event.genEvent(
        kind: EventKind.DIRECT_MESSAGE,
        tags: Nip4.toTags(destPubKey, replyId ?? '', null),
        content: encryption,
        signer: this,
      );
    }

    return null;
  }

  @override
  Future<String?> decrypt44(String msg, String destPubKey, {String? id}) async {
    final npub = publicKey.startsWith('npub')
        ? publicKey
        : Nip19.encodePubkey(publicKey);

    Map<dynamic, dynamic> map = await amber.nip44Decrypt(
      ciphertext: msg,
      currentUser: npub,
      pubKey: destPubKey,
      id: id,
    );

    return map['event'];
  }

  @override
  Future<String?> encrypt44(String msg, String destPubKey, {String? id}) async {
    final npub = publicKey.startsWith('npub')
        ? publicKey
        : Nip19.encodePubkey(publicKey);

    Map<dynamic, dynamic> map = await amber.nip44Encrypt(
      plaintext: msg,
      currentUser: npub,
      pubKey: destPubKey,
      id: id,
    );

    return map['event'];
  }

  @override
  bool canSign() {
    return publicKey.isNotEmpty;
  }

  @override
  bool isGuest() {
    return false;
  }

  @override
  Future<Event?> decrypt44Event(
    Event event, {
    String? id,
  }) async {
    final sgString = await decrypt44(event.content, event.pubkey);

    if (sgString != null) {
      final sgEvent = Event.fromJson(
        jsonDecode(sgString),
        currentUser: publicKey,
      );

      final decrypt = await decrypt44(sgEvent.content, sgEvent.pubkey);

      if (decrypt != null) {
        return Event.fromJson(
          jsonDecode(decrypt),
          currentUser: publicKey,
        );
      }

      return null;
    }
    return null;
  }

  @override
  Future<Event?> encrypt44Event(
    Event event,
    String destPubKey, {
    String? id,
  }) async {
    final encrypt = await encrypt44(jsonEncode(event.toJson()), destPubKey);

    if (encrypt != null) {
      final npub = publicKey.startsWith('npub')
          ? publicKey
          : Nip19.encodePubkey(publicKey);

      final ev = Event.partial(
        pubkey: npub,
        kind: EventKind.SEALED_EVENT,
        tags: [],
        content: encrypt,
      );

      await sign(ev);

      final sgString = await encrypt44(jsonEncode(ev.toJson()), destPubKey);

      if (sgString != null) {
        final keys = Keychain.generate();

        return Event.partial(
          pubkey: keys.public,
          kind: EventKind.GIFT_WRAP,
          tags: [],
          content: sgString,
          sig: Bip340.sign(event.id, keys.private),
        );
      }
    }

    return null;
  }
}
