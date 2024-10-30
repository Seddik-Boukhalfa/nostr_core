// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nostr_core/nostr/nostr.dart';
import 'package:nostr_core/nostr/remote_cache_event.dart';

import '../utils/utils.dart';

typedef RemoteEventCallBack = void Function(BaseEvent event);

typedef RemoteEOSECallBack = void Function(
  String requestId,
  OKEvent ok,
);

class RemoteCacheService {
  String cacheUrl;
  WebSocket? cacheSocket;
  int connectionStatus = 0;
  Set<String> subscriptionIds = {};
  Map<String, RemoteCacheRequest> requestsMap = {};

  RemoteCacheService({
    required this.cacheUrl,
  });

  Future<void> connectCache() async {
    try {
      cacheSocket = await WebSocket.connect(cacheUrl).timeout(
        const Duration(seconds: 1),
      );

      connectionStatus = 1;

      _listenEvent();
    } catch (e) {
      logger.i(e);
      return;
    }
  }

  Future<void> reconnect() async {
    await closeConnect();
    await connectCache();
  }

  Future closeConnect() async {
    await cacheSocket?.close();
  }

  bool isWebSocketOpen() {
    return cacheSocket != null && cacheSocket!.closeCode == null;
  }

  void _listenEvent() {
    cacheSocket!.listen((message) {
      _handleMessage(message);
    }, onDone: () {
      connectionStatus = 3;
      connectCache();
    }, onError: (e) {
      connectionStatus = 3; // closed
      connectCache();
    });
  }

  void _handleMessage(String message) {
    try {
      var m = RemoteCacheMessage.deserialize(message);

      switch (m.type) {
        case 'EVENT':
          _handleEvent(m.message);
          break;
        case 'EOSE':
          _handleEOSE(m.message);
          break;
        default:
          printLog('Received message not supported: $message');
          break;
      }
    } catch (e, stack) {
      logger.i(stack);
      printLog('Received message not supported: $message');
    }
  }

  void _handleEvent(BaseEvent e) {
    String? subscriptionId;
    RemoteEventCallBack? callBack;

    if (e is RemoteCacheEvent) {
      subscriptionId = e.subscriptionId;
      callBack = requestsMap[e.subscriptionId]?.eventCallBack;
    } else if (e is Event) {
      subscriptionId = e.subscriptionId;
      callBack = requestsMap[e.subscriptionId]?.eventCallBack;
    }

    if (subscriptionId != null && subscriptionId.isNotEmpty) {
      if (callBack != null) {
        callBack(e);
      }
    }
  }

  void _handleEOSE(String eose) {
    printLog('receive EOSE: $eose');
    String subscriptionId = jsonDecode(eose)[0];
    String requestsMapKey = subscriptionId;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      RemoteEOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
      OKEvent ok = OKEvent(subscriptionId, true, '');
      if (callBack != null) callBack(subscriptionId, ok);
    }
  }

  void printLog(String log) {
    if (kDebugMode) {
      print(log);
    }
  }

  Future<String> doQuery({
    required RemoteCacheFilter filter,
    int timeOut = 5,
    RemoteEventCallBack? eventCallBack,
    RemoteEOSECallBack? eoseCallBack,
  }) async {
    final completer = Completer<String>();

    String id = '';

    id = addSubscription(
      filter,
      eoseCallBack: (requestId, ok) {
        completer.complete(id);
      },
      eventCallBack: eventCallBack,
    );

    return completer.future;
  }

  String addSubscription(
    RemoteCacheFilter filter, {
    RemoteEventCallBack? eventCallBack,
    RemoteEOSECallBack? eoseCallBack,
  }) {
    final requestWithFilter = RemoteCacheRequest(
      subscriptionId: generate64RandomHexChars(),
      remoteCacheFilter: filter,
      requestTime: DateTime.now().millisecondsSinceEpoch,
      eventCallBack: eventCallBack,
      eoseCallBack: eoseCallBack,
    );

    requestsMap[requestWithFilter.subscriptionId] = requestWithFilter;

    String subscriptionString = requestWithFilter.serialize();

    send(subscriptionString);

    return requestWithFilter.subscriptionId;
  }

  void send(String data) {
    if (connectionStatus == 1 && cacheSocket != null) {
      cacheSocket!.add(data);
    }
  }
}

class RemoteCacheRequest {
  late String subscriptionId;
  late RemoteCacheFilter remoteCacheFilter;
  late int requestTime;
  RemoteEventCallBack? eventCallBack;
  RemoteEOSECallBack? eoseCallBack;

  RemoteCacheRequest({
    required this.subscriptionId,
    required this.remoteCacheFilter,
    required this.requestTime,
    this.eventCallBack,
    this.eoseCallBack,
  });

  String serialize() {
    var header = jsonEncode(['REQ', subscriptionId, remoteCacheFilter.toMap()]);

    return header;
  }

  RemoteCacheRequest.deserialize(input) {
    assert(input.length >= 3);
    subscriptionId = input[1];

    for (var i = 2; i < input.length; i++) {
      remoteCacheFilter = RemoteCacheFilter.fromString(input[i]);
    }
  }
}
