import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/nostr/event_signer/event_signer.dart';
import 'package:nostr_core/utils/string_utils.dart';

import '../../utils/lightning_util.dart';
import 'zap.dart';

class ZapAction {
  static Future<void> handleZap(
    num sats,
    Metadata metadata,
    EventSigner signer,
    List<String> relays, {
    String? eventId,
    String? aTag,
    String? pollOption,
    String? comment,
    String? specifiedWallet,
    bool? removeNostrEvent,
    List<List<String>>? extraTags,
    required Function(String) onZapped,
  }) async {
    String invoice = '';
    try {
      var invoiceCode = await _doGenInvoiceCode(
        sats,
        metadata,
        signer,
        relays,
        eventId: eventId,
        pollOption: pollOption,
        comment: comment,
        removeNostrEvent: removeNostrEvent,
        aTag: aTag,
      );

      if (StringUtil.isBlank(invoiceCode)) {
        return;
      }

      invoice = invoiceCode!;

      bool sendWithWallet = false;

      if (!sendWithWallet) {
        await LightningUtil.goToPay(invoiceCode, specifiedWallet!);
      }
    } finally {
      onZapped(invoice);
    }
  }

  static Future<void> handleExternalZap(
    String? invoiceCode, {
    String? specifiedWallet,
  }) async {
    if (StringUtil.isBlank(invoiceCode)) {
      return;
    }

    bool sendWithWallet = false;

    if (!sendWithWallet) {
      await LightningUtil.goToPay(invoiceCode!, specifiedWallet!);
    }
  }

  static Future<String?> genInvoiceCode(
    num sats,
    Metadata user,
    EventSigner signer,
    List<String> relays, {
    String? eventId,
    String? aTag,
    String? pollOption,
    String? comment,
    bool? removeNostrEvent,
    List<List<String>>? extraTags,
  }) async {
    // var cancelFunc = BotToast.showLoading();
    try {
      return await _doGenInvoiceCode(
        sats,
        user,
        signer,
        relays,
        eventId: eventId,
        aTag: aTag,
        pollOption: pollOption,
        comment: comment,
        removeNostrEvent: removeNostrEvent,
      );
    } finally {
      // cancelFunc.call();
    }
  }

  static Future<String?> _doGenInvoiceCode(
    num sats,
    Metadata metadata,
    EventSigner signer,
    List<String> relays, {
    String? eventId,
    String? aTag,
    String? pollOption,
    String? comment,
    bool? removeNostrEvent,
  }) async {
    String? lnurl = metadata.lud06;
    String? lud16Link;

    if (StringUtil.isBlank(lnurl) || !lnurl.toLowerCase().startsWith('lnurl')) {
      if (StringUtil.isNotBlank(metadata.lud16)) {
        lnurl = Zap.getLnurlFromLud16(metadata.lud16);
      } else {
        lnurl = '';
      }
    }

    if (StringUtil.isBlank(lnurl)) {
      return null;
    }

    if (lnurl!.contains('@')) {
      lnurl = Zap.getLnurlFromLud16(metadata.lud06);
    }

    if (StringUtil.isBlank(lud16Link)) {
      if (StringUtil.isNotBlank(metadata.lud16)) {
        lud16Link = Zap.getLud16LinkFromLud16(metadata.lud16);
      }
    }

    if (StringUtil.isBlank(lud16Link)) {
      if (StringUtil.isNotBlank(lnurl)) {
        lud16Link = Zap.decodeLud06Link(lnurl!);
      }
    }

    return await Zap.getInvoiceCode(
      lnurl: lnurl!,
      lud16Link: lud16Link!,
      sats: sats,
      recipientPubkey: metadata.pubkey,
      relays: relays,
      signer: signer,
      eventId: eventId,
      aTag: aTag,
      pollOption: pollOption,
      comment: comment,
      removeNostrEvent: removeNostrEvent,
    );
  }
}