// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names, avoid_print
// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nostr_core/cache/cache_manager.dart';
import 'package:nostr_core/models/contact_list.dart';
import 'package:nostr_core/models/metadata.dart';
import 'package:nostr_core/models/pubkey_mapping.dart';
import 'package:nostr_core/models/relay_info.dart';
import 'package:nostr_core/models/relay_set.dart';
import 'package:nostr_core/models/user_relay_list.dart';
import 'package:nostr_core/nostr/close.dart';
import 'package:nostr_core/nostr/event.dart';
import 'package:nostr_core/nostr/event_signer/event_signer.dart';
import 'package:nostr_core/nostr/filter.dart';
import 'package:nostr_core/nostr/message.dart';
import 'package:nostr_core/nostr/nips/nip_020.dart';
import 'package:nostr_core/nostr/nips/nip_065.dart';
import 'package:nostr_core/nostr/request.dart';
import 'package:nostr_core/nostr/utils.dart';
import 'package:nostr_core/utils/enums.dart';
import 'package:nostr_core/utils/helpers.dart';
import 'package:nostr_core/utils/relay.dart';
import 'package:nostr_core/utils/static_properties.dart';
import 'package:uuid/uuid.dart';

const Duration REFRESH_CONTACT_LIST_DURATION = Duration(minutes: 10);

const int DEFAULT_STREAM_IDLE_TIMEOUT = 5;

const int DEFAULT_BEST_RELAYS_MIN_COUNT = 2;

const int TIMER_TICKS = 10;

const Duration REFRESH_USER_RELAY_DURATION = Duration(minutes: 10);

const List<String> DEFAULT_BOOTSTRAP_RELAYS = [
  "wss://relay.damus.io",
  "wss://nos.lol",
  'wss://nostr-01.yakihonne.com',
  'wss://nostr-02.yakihonne.com',
  'wss://nostr-03.dorafactory.org',
];

class NostrCore {
  CacheManager cacheManager;

  Uuid uuid = const Uuid();

  NoticeCallBack? noticeCallBack;

  ConnectStatusCallBack? connectStatusCallBack;

  Map<String, WebSocket?> webSockets = {};

  Set<String> closedRelays = {};

  Map<String, RelayInfo> relayInfos = {};

  Map<String, int> connectStatus = {};

  Map<String, Requests> requestsMap = {};

  Map<String, Sends> sendsMap = {};

  List<ConnectStatusCallBack> connectStatusListeners = [];

  NostrCore({required this.cacheManager});

  //************************************** Relays connectivity **************************************************************/
  @pragma('vm:entry-point')
  void relaysAutoReconnect() {
    for (final webSocketKey in webSockets.keys) {
      if (webSockets[webSocketKey] == null) {
        connect(webSocketKey);
      }
    }
  }

  void _setConnectStatus(String relay, int status) {
    connectStatus[relay] = status;
    connectStatusCallBack?.call(relay, status);
    for (var callBack in connectStatusListeners) {
      callBack(relay, status);
    }
  }

  void addConnectStatusListener(ConnectStatusCallBack callBack) {
    if (!connectStatusListeners.contains(callBack)) {
      connectStatusListeners.add(callBack);
    }
  }

  void removeConnectStatusListener(ConnectStatusCallBack callBack) {
    if (connectStatusListeners.contains(callBack)) {
      connectStatusListeners.remove(callBack);
    }
  }

  bool isWebSocketOpen(String url) {
    WebSocket? webSocket = webSockets[url];
    return webSocket != null && webSocket.closeCode == null;
  }

  List<String> relays() {
    return webSockets.keys.toList();
  }

  List<String> activeRelays() {
    return webSockets.keys
        .where(
          (key) => webSockets[key] != null,
        )
        .toList();
  }

  Future connect(String relay, {bool? fromIdleState}) async {
    WebSocket? socket;

    if (fromIdleState == null) {
      if ((connectStatus[relay] == 0 && webSockets[relay] != null) ||
          connectStatus[relay] == 1 && webSockets[relay] != null) return;

      if (webSockets.containsKey(relay) && webSockets[relay] != null) {
        socket = webSockets[relay]!;
        _setConnectStatus(relay, socket.readyState);
        printLog('status =  ${connectStatus[relay]}');
        if (connectStatus[relay] != 3) {
          return;
        }
      }
    }

    closedRelays.remove(relay);
    webSockets[relay] = null;
    socket = await _connectWs(relay);

    if (socket != null) {
      socket.done.then((dynamic _) => _onDisconnected(relay));
      _listenEvent(socket, relay);
      webSockets[relay] = socket;
      printLog('$relay socket connection initialized');
      _setConnectStatus(relay, 1);
    } else {
      webSockets[relay] = socket;
    }
  }

  Future connectRelays(List<String> relays, {bool? fromIdleState}) async {
    List<String> toBeStopped = [];
    final nostrConnectRelays = this.relays();

    for (final relay in nostrConnectRelays) {
      if (!relays.contains(relay)) {
        toBeStopped.add(relay);
      }
    }

    if (toBeStopped.isNotEmpty) {
      closeConnect(toBeStopped);
    }

    Future.wait(
      relays.map((e) => connect(e, fromIdleState: fromIdleState)).toList(),
    );
  }

  Future closeConnect(List<String> relays) async {
    for (final relay in relays) {
      if (webSockets.containsKey(relay)) {
        closedRelays.add(relay);
        final socket = webSockets.remove(relay);
        await socket?.close();
      }
    }
  }

  //************************************** Queries & subcriptions **************************************************************/
  void setTimerAndApply({
    required Timer? timer,
    required int timeOut,
    required bool shouldClose,
    required Function() onClose,
  }) {
    if (timer != null) {
      timer.cancel();
    }

    if (shouldClose) {
      onClose.call();
    } else {
      timer = Timer(
        Duration(seconds: timeOut),
        onClose,
      );
    }
  }

  Future<String> doQuery(
    List<Filter> filters,
    List<String> relays, {
    int timeOut = 5,
    void Function()? onFinished,
    void Function(Event, String)? eventCallBack,
    void Function(String, OKEvent, String, List<String>)? eoseCallBack,
  }) async {
    final completer = Completer<String>();
    Timer? timer;
    String id = '';
    id = addSubscription(
      filters,
      relays,
      eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
        closeSubscription(requestId, relay);

        setTimerAndApply(
          timer: timer,
          timeOut: timeOut,
          shouldClose: unCompletedRelays.isEmpty,
          onClose: () {
            completer.complete(id);
          },
        );

        if (eoseCallBack != null) {
          eoseCallBack.call(requestId, ok, relay, unCompletedRelays);
        }
      },
      eventCallBack: (event, relay) {
        if (eventCallBack != null) {
          eventCallBack.call(event, relay);
        }
      },
    );

    return completer.future;
  }

  String doSubscribe(
    List<Filter> filters,
    List<String> relays, {
    void Function(Event, String)? eventCallBack,
    void Function(String, OKEvent, String, List<String>)? eoseCallBack,
  }) {
    return addSubscription(
      filters,
      relays,
      eoseCallBack: eoseCallBack,
      eventCallBack: eventCallBack,
    );
  }

  String addSubscription(
    List<Filter> filters,
    List<String> relays, {
    EventCallBack? eventCallBack,
    EOSECallBack? eoseCallBack,
  }) {
    Map<String, List<Filter>> result = {};

    final webSocketRelays = this.relays();
    for (var relay in webSocketRelays) {
      if (relays.isNotEmpty && relays.contains(relay) || relays.isEmpty) {
        if (webSockets[relay] != null) {
          result[relay] = filters;
        }
      }
    }

    return addSubscriptions(
      result,
      relays,
      eventCallBack: eventCallBack,
      eoseCallBack: eoseCallBack,
    );
  }

  String addSubscriptions(
    Map<String, List<Filter>> filters,
    List<String> relays, {
    EventCallBack? eventCallBack,
    EOSECallBack? eoseCallBack,
  }) {
    String requestsId = generate64RandomHexChars();

    Requests requests = Requests(
      requestsId,
      filters.keys.toList(),
      DateTime.now().millisecondsSinceEpoch,
      {},
      eventCallBack,
      eoseCallBack,
    );

    for (String relay in filters.keys) {
      Request requestWithFilter = Request(
        generate64RandomHexChars(),
        filters[relay]!,
      );

      String subscriptionString = requestWithFilter.serialize();

      requests.subscriptions[relay] = requestWithFilter.subscriptionId;

      requestsMap[requestWithFilter.subscriptionId + relay] = requests;

      _send(subscriptionString, chosenRelays: [relay]);
    }

    return requestsId;
  }

  closeSubscriptions(String subscriptionId) {
    for (var relay in relays()) {
      if (subscriptionId.isNotEmpty) {
        _send(Close(subscriptionId).serialize(), chosenRelays: [relay]);
        requestsMap.remove(subscriptionId + relay);
        printLog('close $subscriptionId');
      }
    }
  }

  closeSubscription(String subscriptionId, String relay) {
    if (subscriptionId.isNotEmpty) {
      String close = Close(subscriptionId).serialize();
      _send(close, chosenRelays: [relay]);
      requestsMap.remove(subscriptionId + relay);
      printLog('close $subscriptionId');
    }
  }

  Future closeRequests(List<String> requestsIds) async {
    Iterable<String> requestsMapKeys = List<String>.from(requestsMap.keys);

    for (var key in requestsMapKeys) {
      var requests = requestsMap[key];

      if (requestsIds.contains(requests!.requestId)) {
        for (var relay in relays()) {
          if (requests.subscriptions[relay] != null) {
            closeSubscription(requests.subscriptions[relay]!, relay);
          }
        }

        return;
      }
    }
  }

  //******************************************* Events publish *****************************************************************/
  Future<bool> publish(
    Event event,
    List<String> relays, {
    Function(List<String>, List<String>)? onProgress,
  }) {
    final completer = Completer<bool>();
    bool isSuccessful = false;

    sendEvent(
      event,
      relays,
      sendCallBack: (ok, relay, unCompletedRelays) {
        if (onProgress != null) {
          onProgress.call(relays, unCompletedRelays);
        }

        if (ok.status && !isSuccessful) {
          isSuccessful = true;
        }
      },
    );

    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (isSuccessful || timer.tick > TIMER_TICKS) {
          completer.complete(isSuccessful);
          timer.cancel();
        }
      },
    );

    return completer.future;
  }

  void sendEvent(
    Event event,
    List<String> selectedRelays, {
    OKCallBack? sendCallBack,
  }) {
    Sends sends = Sends(
      generate64RandomHexChars(),
      selectedRelays.isNotEmpty ? selectedRelays : relays(),
      DateTime.now().millisecondsSinceEpoch,
      event.id,
      sendCallBack,
    );

    sendsMap[event.id] = sends;

    _send(
      event.serialize(),
      chosenRelays: selectedRelays.isNotEmpty ? selectedRelays : null,
    );
  }

  void _send(String data, {List<String>? chosenRelays}) {
    if (chosenRelays != null) {
      for (final relay in chosenRelays) {
        if (webSockets.containsKey(relay)) {
          var socket = webSockets[relay];
          if (connectStatus[relay] == 1 && socket != null) {
            socket.add(data);
          }
        }
      }
    } else {
      webSockets.forEach((url, socket) {
        if (connectStatus[url] == 1 && socket != null) {
          socket.add(data);
        }
      });
    }
  }

  //*********************************** Messages and events handling ***********************************************************/
  void _handleMessage(String message, String relay) {
    try {
      var m = Message.deserialize(message);
      switch (m.type) {
        case 'EVENT':
          _handleEvent(m.message, relay);
          break;
        case 'EOSE':
          _handleEOSE(m.message, relay);
          break;
        case 'NOTICE':
          _handleNotice(m.message, relay);
          break;
        case 'OK':
          _handleOk(message, relay);
          break;
        default:
          printLog('Received message not supported: $message');
          break;
      }
    } catch (_) {
      printLog('Received message not supported: $message');
    }
  }

  void _handleEvent(Event event, String relay) {
    // printLog('Received event: ${event.serialize()}');
    String? subscriptionId = event.subscriptionId;
    if (subscriptionId != null) {
      String requestsMapKey = subscriptionId + relay;
      if (subscriptionId.isNotEmpty &&
          requestsMap.containsKey(requestsMapKey)) {
        EventCallBack? callBack = requestsMap[requestsMapKey]!.eventCallBack;
        if (callBack != null) callBack(event, relay);
      }
    }
  }

  void _handleEOSE(String eose, String relay) {
    printLog('receive EOSE: $eose in $relay');
    String subscriptionId = jsonDecode(eose)[0];
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      var relays = requestsMap[requestsMapKey]!.relays;
      relays.remove(relay);
      // all relays have EOSE
      EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
      OKEvent ok = OKEvent(subscriptionId, true, '');
      if (callBack != null) callBack(subscriptionId, ok, relay, relays);
    }
  }

  void _handleNotice(String notice, String relay) {
    printLog('receive notice: $notice');
    String n = jsonDecode(notice)[0];
    noticeCallBack?.call(n, relay);
  }

  void _handleOk(String message, String relay) {
    printLog('receive ok: $message');
    OKEvent? ok = Nip20.getOk(message);
    if (ok != null && sendsMap.containsKey(ok.eventId)) {
      if (sendsMap[ok.eventId]!.okCallBack != null) {
        List<String> relays = List.from(sendsMap[ok.eventId]!.relays)
          ..remove(relay);

        sendsMap[ok.eventId]!.relays = relays;
        sendsMap[ok.eventId]!.okCallBack!(ok, relay, relays);
        if (relays.isEmpty) sendsMap.remove(ok.eventId);
      }
    }
  }

  void _listenEvent(WebSocket socket, String relay) {
    socket.listen((message) {
      _handleMessage(message, relay);
    }, onDone: () {
      printLog('connect aborted');
      _setConnectStatus(relay, 3); // closed
      if (!closedRelays.contains(relay)) {
        connect(relay);
      }
    }, onError: (e) {
      printLog('Server error: $e');
      _setConnectStatus(relay, 3); // closed
      connect(relay);
    });
  }

  Future _connectWs(String relay) async {
    try {
      _setConnectStatus(relay, 0); // connecting
      return await WebSocket.connect(relay).timeout(
        const Duration(seconds: 5),
      );
    } catch (e) {
      _setConnectStatus(relay, 3);
      printLog('Error! can not connect WS connectWs $e');
      // closed
      // _retryWs(relay);
      return null;
    }
  }

  Future<void> _onDisconnected(String relay) async {
    printLog('_onDisconnected');
    _setConnectStatus(relay, 3);
    if (!closedRelays.contains(relay)) {
      await Future.delayed(const Duration(milliseconds: 1000));
      connect(relay);
    }
  }

  void printLog(String log) {
    if (kDebugMode) {
      print(log);
    }
  }

  //************************************************ Relays info **************************************************************/
  Future<RelayInfo?> getRelayInfo(String url) async {
    if (relayInfos[url] != null) {
      final info = await RelayInfo.get(url);

      if (info != null) {
        relayInfos[url] = info;
      }

      return relayInfos[url];
    }
    return null;
  }

  //********************************************** Contacts lists **************************************************************/
  Future<ContactList> ensureUpToDateContactListOrEmpty(
    EventSigner signer,
  ) async {
    ContactList? contactList = cacheManager.loadContactList(
      signer.getPublicKey(),
    );

    int sometimeAgo = DateTime.now()
            .subtract(REFRESH_CONTACT_LIST_DURATION)
            .millisecondsSinceEpoch ~/
        1000;

    bool refresh = contactList == null ||
        contactList.loadedTimestamp == null ||
        contactList.loadedTimestamp! < sometimeAgo;

    if (refresh) {
      contactList =
          await loadContactList(signer.getPublicKey(), forceRefresh: true);
    }

    contactList ??= ContactList(pubkey: signer.getPublicKey(), contacts: []);

    return contactList;
  }

  Future<ContactList?> loadContactList(
    String pubkey, {
    bool forceRefresh = false,
    int idleTimeout = DEFAULT_STREAM_IDLE_TIMEOUT,
  }) async {
    final completer = Completer<ContactList?>();

    ContactList? contactList = cacheManager.loadContactList(pubkey);

    if (contactList == null || forceRefresh) {
      ContactList? loadedContactList;

      final id = await doQuery(
        [
          Filter(
            kinds: [EventKind.CONTACT_LIST],
            authors: [pubkey],
            limit: 1,
          ),
        ],
        [],
        eventCallBack: (event, relay) {
          if (loadedContactList == null ||
              loadedContactList!.createdAt < event.createdAt) {
            loadedContactList = ContactList.fromEvent(event);
          }
        },
        eoseCallBack: (requestId, ok, relay, unCompletedRelays) {},
      );

      closeRequests([id]);

      if (loadedContactList != null &&
          (contactList == null ||
              contactList.createdAt < loadedContactList!.createdAt)) {
        loadedContactList!.loadedTimestamp =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await cacheManager.saveContactList(loadedContactList!);
        contactList = loadedContactList;
        completer.complete(contactList);
      }
    } else {
      completer.complete(contactList);
    }

    return completer.future;
  }

  Future<ContactList?> publishRemoveContacts(
    List<String> toRemove,
    List<String> relays,
    EventSigner signer,
  ) async {
    ContactList? contactList = await ensureUpToDateContactListOrEmpty(signer);
    toRemove.removeWhere((element) => contactList.contacts.contains(element));

    if (toRemove.isNotEmpty) {
      for (final p in toRemove) {
        contactList.contacts.remove(p);
        contactList.loadedTimestamp = Helpers.now;
        contactList.createdAt = Helpers.now;
      }

      final isSuccessful = await publish(contactList.toEvent(), relays);

      if (isSuccessful) {
        await cacheManager.saveContactList(contactList);
      }
    }

    return contactList;
  }

  Future<ContactList> publishAddContacts(
    List<String> toAdd,
    List<String> relays,
    EventSigner signer,
  ) async {
    ContactList contactList = await ensureUpToDateContactListOrEmpty(signer);

    if (toAdd.isNotEmpty) {
      for (final p in toAdd) {
        if (!contactList.contacts.contains(p)) {
          contactList.contacts.add(p);
          contactList.loadedTimestamp = Helpers.now;
          contactList.createdAt = Helpers.now;
        }
      }

      final isSuccessful = await publish(contactList.toEvent(), relays);

      if (isSuccessful) {
        await cacheManager.saveContactList(contactList);
      }
    }

    return contactList;
  }

  Future<ContactList> publishUpdateContacts(
    List<String> pubkeys,
    List<String> relays,
    EventSigner signer,
  ) async {
    ContactList contactList = await ensureUpToDateContactListOrEmpty(signer);

    if (pubkeys.isNotEmpty) {
      for (final p in pubkeys) {
        if (!contactList.contacts.contains(p)) {
          contactList.contacts.add(p);
          contactList.loadedTimestamp = Helpers.now;
          contactList.createdAt = Helpers.now;
        } else {
          contactList.contacts.remove(p);
          contactList.loadedTimestamp = Helpers.now;
          contactList.createdAt = Helpers.now;
        }
      }

      final isSuccessful = await publish(
        contactList.toEvent(),
        relays,
      );

      if (isSuccessful) {
        await cacheManager.saveContactList(contactList);
      }
    }

    return contactList;
  }

  //********************************************** Metadata handling ***********************************************************/
  Future<List<Metadata>> loadMissingMetadatas(
    List<String> pubKeys,
    List<String> relays,
  ) async {
    List<String> missingPubKeys = [];

    for (var pubKey in pubKeys) {
      Metadata? userMetadata = cacheManager.loadMetadata(pubKey);
      if (userMetadata == null) {
        missingPubKeys.add(pubKey);
      }
    }

    Map<String, Metadata> metadatas = {};

    if (missingPubKeys.isNotEmpty) {
      final id = await doQuery(
        [
          Filter(authors: missingPubKeys, kinds: [EventKind.METADATA])
        ],
        relays,
        eventCallBack: (event, relay) async {
          if (metadatas[event.pubkey] == null ||
              metadatas[event.pubkey]!.createdAt < event.createdAt) {
            metadatas[event.pubkey] = Metadata.fromEvent(event);
            metadatas[event.pubkey]!.refreshedTimestamp = Helpers.now;
            await cacheManager.saveMetadata(metadatas[event.pubkey]!);
          }
        },
        eoseCallBack: (p0, p1, p2, p3) {},
      );

      closeRequests([id]);
    }

    return metadatas.values.toList();
  }

  Future<Metadata?> broadcastMetadata(
    Metadata metadata,
    List<String> relays,
    EventSigner signer,
    Function(List<String>, List<String>)? onProgress,
  ) async {
    final event = await metadata.toEvent(signer);

    if (event != null) {
      final isSuccessful = await publish(event, relays, onProgress: onProgress);

      if (isSuccessful) {
        metadata.createdAt = Helpers.now;
        metadata.refreshedTimestamp = Helpers.now;
        await cacheManager.saveMetadata(metadata);

        return metadata;
      }

      return null;
    }

    return null;
  }

  //********************************************** User relay list *************************************************************/
  RelaySet? getRelaySet(String name, String pubKey) {
    return cacheManager.loadRelaySet(name, pubKey);
  }

  Future<void> saveRelaySet(RelaySet relaySet) async {
    return cacheManager.saveRelaySet(relaySet);
  }

  Future<RelaySet> calculateRelaySet({
    required String name,
    required String ownerPubKey,
    required List<String> pubKeys,
    required RelayDirection direction,
    required int relayMinCountPerPubKey,
    Function(String, int, int)? onProgress,
  }) async {
    RelaySet byScore = await _relaysByPopularity(
      name: name,
      ownerPubKey: ownerPubKey,
      pubKeys: pubKeys,
      direction: direction,
      relayMinCountPerPubKey: relayMinCountPerPubKey,
      onProgress: onProgress,
    );

    if (byScore.relaysMap.isNotEmpty) {
      return byScore;
    }

    return RelaySet(
      name: name,
      pubKey: ownerPubKey,
      relayMinCountPerPubkey: relayMinCountPerPubKey,
      direction: direction,
      relaysMap: _allConnectedRelays(pubKeys),
      notCoveredPubkeys: [],
    );
  }

  Map<String, List<PubkeyMapping>> _allConnectedRelays(List<String> pubKeys) {
    Map<String, List<PubkeyMapping>> map = {};
    for (var relay in relays()) {
      if (isWebSocketOpen(relay)) {
        map[relay] = pubKeys
            .map(
              (pubKey) => PubkeyMapping(
                  pubKey: pubKey, rwMarker: ReadWriteMarker.readWrite),
            )
            .toList();
      }
    }
    return map;
  }

  Future<RelaySet> _relaysByPopularity({
    required String name,
    required String ownerPubKey,
    required List<String> pubKeys,
    required RelayDirection direction,
    required int relayMinCountPerPubKey,
    Function(String stepName, int count, int total)? onProgress,
  }) async {
    await loadMissingRelayListsFromNip65OrNip02(
      pubKeys,
      onProgress: onProgress,
    );

    Map<String, Set<PubkeyMapping>> pubKeysByRelayUrl =
        await _buildPubKeysMapFromRelayLists(pubKeys, direction);

    Map<String, Set<String>> minimumRelaysCoverageByPubkey = {};
    Map<String, List<PubkeyMapping>> bestRelays = {};

    if (onProgress != null) {
      if (kDebugMode) {
        print("Calculating best relays...");
      }
      onProgress.call("Calculating best relays",
          minimumRelaysCoverageByPubkey.length, pubKeysByRelayUrl.length);
    }

    Map<String, int> notCoveredPubkeys = {};

    for (var pubKey in pubKeys) {
      notCoveredPubkeys[pubKey] = relayMinCountPerPubKey;
    }

    for (String url in pubKeysByRelayUrl.keys) {
      if (!pubKeysByRelayUrl[url]!.any((pubKey) =>
          minimumRelaysCoverageByPubkey[pubKey.pubKey] == null ||
          minimumRelaysCoverageByPubkey[pubKey.pubKey]!.length <
              relayMinCountPerPubKey)) {
        continue;
      }

      bool connectable = await connect(url);

      if (kDebugMode) {
        print("tried to reconnect to $url = $connectable");
      }

      if (!connectable) {
        continue;
      }

      if (bestRelays[url] == null) {
        bestRelays[url] = [];
      }

      for (PubkeyMapping pubKey in pubKeysByRelayUrl[url]!) {
        Set<String>? relays = minimumRelaysCoverageByPubkey[pubKey.pubKey];
        if (relays == null) {
          relays = {};
          minimumRelaysCoverageByPubkey[pubKey.pubKey] = relays;
        }

        relays.add(url);

        if (!bestRelays[url]!.contains(pubKey)) {
          bestRelays[url]!.add(pubKey);
          int count =
              notCoveredPubkeys[pubKey.pubKey] ?? relayMinCountPerPubKey;
          notCoveredPubkeys[pubKey.pubKey] = count - 1;
        }
      }

      if (onProgress != null) {
        onProgress.call(
          "Calculating best relays",
          minimumRelaysCoverageByPubkey.length,
          pubKeys.length,
        );
      }
    }

    notCoveredPubkeys.removeWhere((key, value) => value <= 0);

    return RelaySet(
      name: name,
      pubKey: ownerPubKey,
      relayMinCountPerPubkey: relayMinCountPerPubKey,
      direction: direction,
      relaysMap: bestRelays,
      notCoveredPubkeys: notCoveredPubkeys.entries
          .map(
            (entry) => NotCoveredPubKey(entry.key, entry.value),
          )
          .toList(),
    );
  }

  _buildPubKeysMapFromRelayLists(
    List<String> pubKeys,
    RelayDirection direction,
  ) async {
    Map<String, Set<PubkeyMapping>> pubKeysByRelayUrl = {};
    int foundCount = 0;
    for (String pubKey in pubKeys) {
      UserRelayList? userRelayList = cacheManager.loadUserRelayList(pubKey);
      if (userRelayList != null) {
        if (userRelayList.relays.isNotEmpty) {
          foundCount++;
        }

        for (var entry in userRelayList.relays.entries) {
          _handleRelayUrlForPubKey(
            pubKey,
            direction,
            entry.key,
            entry.value,
            pubKeysByRelayUrl,
          );
        }
      } else {
        int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        await cacheManager.saveUserRelayList(
          UserRelayList(
            pubkey: pubKey,
            relays: {},
            createdAt: now,
            refreshedTimestamp: now,
          ),
        );
      }
    }

    print(
      "Have lists of relays for $foundCount/${pubKeys.length} pubKeys ${foundCount < pubKeys.length ? "(missing ${pubKeys.length - foundCount})" : ""}",
    );

    List<MapEntry<String, Set<PubkeyMapping>>> sortedEntries =
        pubKeysByRelayUrl.entries.toList()
          ..sort((a, b) {
            int rr = b.value.length.compareTo(a.value.length);
            if (rr == 0) {
              bool aC = isWebSocketOpen(a.key);
              bool bC = isWebSocketOpen(b.key);

              if (aC != bC) {
                return aC ? -1 : 1;
              }
              return 0;
            }
            return rr;
          });

    return Map<String, Set<PubkeyMapping>>.fromEntries(sortedEntries);
  }

  _handleRelayUrlForPubKey(
      String pubKey,
      RelayDirection direction,
      String url,
      ReadWriteMarker marker,
      Map<String, Set<PubkeyMapping>> pubKeysByRelayUrl) {
    String? cleanUrl = Relay.clean(url);

    if (cleanUrl != null) {
      if (direction.matchesMarker(marker)) {
        Set<PubkeyMapping>? set = pubKeysByRelayUrl[cleanUrl];
        if (set == null) {
          pubKeysByRelayUrl[cleanUrl] = {};
        }
        pubKeysByRelayUrl[cleanUrl]!
            .add(PubkeyMapping(pubKey: pubKey, rwMarker: marker));
      }
    }
  }

  Future<UserRelayList?> ensureUpToDateUserRelayList(EventSigner signer) async {
    UserRelayList? userRelayList = cacheManager.loadUserRelayList(
      signer.getPublicKey(),
    );

    int sometimeAgo = DateTime.now()
            .subtract(REFRESH_USER_RELAY_DURATION)
            .millisecondsSinceEpoch ~/
        1000;

    bool refresh =
        userRelayList == null || userRelayList.refreshedTimestamp < sometimeAgo;

    if (refresh) {
      userRelayList = await getSingleUserRelayList(signer.getPublicKey(),
          forceRefresh: true);
    }

    return userRelayList;
  }

  Future<UserRelayList?> getSingleUserRelayList(
    String pubKey, {
    bool forceRefresh = false,
  }) async {
    UserRelayList? userRelayList = cacheManager.loadUserRelayList(pubKey);

    if (userRelayList == null || forceRefresh) {
      await loadMissingRelayListsFromNip65OrNip02(
        [pubKey],
        forceRefresh: forceRefresh,
      );

      userRelayList = cacheManager.loadUserRelayList(pubKey);
    }
    return userRelayList;
  }

  Future<UserRelayList?> setNip65Relays(
    Map<String, ReadWriteMarker> newRelays,
    List<String> relays,
    EventSigner signer,
    OKCallBack okCallBack,
  ) async {
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final userRelayList = UserRelayList(
      pubkey: signer.getPublicKey(),
      relays: newRelays,
      createdAt: now,
      refreshedTimestamp: now,
    );

    final event = await userRelayList.toNip65().toEvent(signer);

    if (event != null) {
      final isSuccessful = await publish(
        event,
        relays,
      );

      if (isSuccessful) {
        await cacheManager.saveUserRelayList(userRelayList);
        return userRelayList;
      }

      return null;
    }

    return null;
  }

  Future<void> loadMissingRelayListsFromNip65OrNip02(
    List<String> pubKeys, {
    Function(String stepName, int count, int total)? onProgress,
    bool forceRefresh = false,
  }) async {
    List<String> missingPubKeys = [];

    for (var pubKey in pubKeys) {
      UserRelayList? userRelayList = cacheManager.loadUserRelayList(pubKey);
      if (userRelayList == null || forceRefresh) {
        missingPubKeys.add(pubKey);
      }
    }

    Map<String, UserRelayList> fromNip65s = {};
    Map<String, UserRelayList> fromNip02Contacts = {};
    Set<ContactList> contactLists = {};
    Set<String> found = {};

    if (missingPubKeys.isNotEmpty) {
      print("loading missing relay lists ${missingPubKeys.length}");
      if (onProgress != null) {
        onProgress.call(
            "loading missing relay lists", 0, missingPubKeys.length);
      }

      final id = await doQuery(
        [
          Filter(
            authors: missingPubKeys,
            kinds: [
              EventKind.RELAY_LIST_METADATA,
              EventKind.CONTACT_LIST,
            ],
          ),
        ],
        DEFAULT_BOOTSTRAP_RELAYS,
        eventCallBack: (event, relay) {
          switch (event.kind) {
            case EventKind.RELAY_LIST_METADATA:
              Nip65 nip65 = Nip65.fromEvent(event);
              if (nip65.relays.isNotEmpty) {
                UserRelayList fromNip65 = UserRelayList.fromNip65(nip65);
                if (fromNip65s[event.pubkey] == null ||
                    fromNip65s[event.pubkey]!.createdAt < event.createdAt) {
                  fromNip65s[event.pubkey] = fromNip65;
                }
                if (onProgress != null) {
                  found.add(event.pubkey);
                  onProgress.call("loading missing relay lists", found.length,
                      missingPubKeys.length);
                }
              }
            case EventKind.CONTACT_LIST:
              ContactList contactList = ContactList.fromEvent(event);
              contactLists.add(contactList);
              if (event.content.isNotEmpty) {
                if (fromNip02Contacts[event.pubkey] == null ||
                    fromNip02Contacts[event.pubkey]!.createdAt <
                        event.createdAt) {
                  fromNip02Contacts[event.pubkey] =
                      UserRelayList.fromNip02EventContent(event);
                }
                if (onProgress != null) {
                  found.add(event.pubkey);
                  onProgress.call("loading missing relay lists", found.length,
                      missingPubKeys.length);
                }
              }
          }
        },
      );

      closeRequests([id]);

      Set<UserRelayList> relayLists = Set.of(fromNip65s.values);

      for (MapEntry<String, UserRelayList> entry in fromNip02Contacts.entries) {
        if (!fromNip65s.containsKey(entry.key)) {
          relayLists.add(entry.value);
        }
      }

      await cacheManager.saveUserRelayLists(relayLists.toList());

      List<ContactList> contactListsSave = [];

      for (ContactList contactList in contactLists) {
        ContactList? existing =
            cacheManager.loadContactList(contactList.pubkey);
        if (existing == null || existing.createdAt < contactList.createdAt) {
          contactListsSave.add(contactList);
        }
      }

      await cacheManager.saveContactLists(contactListsSave);

      if (onProgress != null) {
        onProgress.call(
            "loading missing relay lists", found.length, missingPubKeys.length);
      }
    }
  }
}

typedef NoticeCallBack = void Function(String notice, String relay);

typedef OKCallBack = void Function(
  OKEvent ok,
  String relay,
  List<String> unCompletedRelays,
);

typedef EventCallBack = void Function(Event event, String relay);

typedef EOSECallBack = void Function(
    String requestId, OKEvent ok, String relay, List<String> unCompletedRelays);

typedef ConnectStatusCallBack = void Function(String relay, int status);

class Sends {
  String sendsId;
  List<String> relays;
  int sendsTime;
  String eventId;
  OKCallBack? okCallBack;

  Sends(
      this.sendsId, this.relays, this.sendsTime, this.eventId, this.okCallBack);
}

class Requests {
  String requestId;
  List<String> relays;
  int requestTime;
  Map<String, String> subscriptions;
  EventCallBack? eventCallBack;
  EOSECallBack? eoseCallBack;

  Requests(
    this.requestId,
    this.relays,
    this.requestTime,
    this.subscriptions,
    this.eventCallBack,
    this.eoseCallBack,
  );
}
