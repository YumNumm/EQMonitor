import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_connection_provider.g.dart';

enum WsConnectionState {
  connecting,
  connected,
  disconnected,
}

@Riverpod(keepAlive: true)
class WsConnectionStatus extends _$WsConnectionStatus {
  @override
  WsConnectionState build() => WsConnectionState.connecting;

  void update(WsConnectionState s) => state = s;
}

@Riverpod(keepAlive: true)
class WsCurrentUrl extends _$WsCurrentUrl {
  @override
  String? build() => null;

  void update(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      state = url;
      return;
    }
    final params = Map<String, String>.from(uri.queryParameters);
    if (params.containsKey('ticket')) {
      params['ticket'] = '<masked>';
    }
    state = uri.replace(queryParameters: params).toString();
  }
}

@Riverpod(keepAlive: true)
class WsLastPingAt extends _$WsLastPingAt {
  @override
  DateTime? build() => null;

  void update() => state = DateTime.now();
}

@Riverpod(keepAlive: true)
class WsConnection extends _$WsConnection {
  WebSocket? _ws;
  var _disposed = false;

  @override
  Stream<WsMessage> build() async* {
    final controller = StreamController<WsMessage>();
    _disposed = false;
    _ws = null;

    ref.onDispose(() {
      _disposed = true;
      unawaited(
        _ws?.close(WebSocketStatus.normalClosure, 'disposed') ??
            Future<void>.value(),
      );
      unawaited(controller.close());
    });

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.paused) {
        unawaited(
          _ws?.close(WebSocketStatus.normalClosure, 'paused') ??
              Future<void>.value(),
        );
        talker.debug('WS: closed (paused)');
      }
      if (next == AppLifecycleState.resumed) {
        ref.invalidateSelf();
      }
    });

    unawaited(_connectWithRetry(controller));
    yield* controller.stream;
  }

  Future<void> _connectWithRetry(StreamController<WsMessage> controller) async {
    var retryCount = 0;
    while (!_disposed && !controller.isClosed) {
      try {
        await _connect(controller);
        retryCount = 0;
      } on Exception catch (e, st) {
        if (_disposed || controller.isClosed) {
          break;
        }
        final delay = min(pow(2, retryCount).toInt(), 60);
        retryCount = min(retryCount + 1, 6);
        talker.warning('WS: reconnect in ${delay}s (attempt $retryCount)\n$e\n$st');
        ref.read(wsConnectionStatusProvider.notifier).update(
          WsConnectionState.disconnected,
        );
        await Future<void>.delayed(Duration(seconds: delay));
      }
    }
    if (!controller.isClosed) {
      unawaited(controller.close());
    }
  }

  Future<void> _connect(StreamController<WsMessage> controller) async {
    ref.read(wsConnectionStatusProvider.notifier).update(
      WsConnectionState.connecting,
    );

    final api = await ref.read(apiClientProvider.future);
    final ticketResponse = await api.realtime.getV2RealtimeTicket();
    final url = ticketResponse.data.url;
    ref.read(wsCurrentUrlProvider.notifier).update(url);

    talker.debug('WS: connecting');
    _ws = await WebSocket.connect(url);
    ref.read(wsConnectionStatusProvider.notifier).update(
      WsConnectionState.connected,
    );
    talker.info('WS: connected');

    try {
      await for (final rawMessage in _ws!) {
        if (_disposed || controller.isClosed) {
          break;
        }
        if (rawMessage is! String) {
          continue;
        }

        Map<String, dynamic> decoded;
        try {
          decoded = jsonDecode(rawMessage) as Map<String, dynamic>;
        } on FormatException catch (e) {
          talker.warning('WS: invalid JSON: $e');
          continue;
        }

        final type = decoded['type'] as String?;
        if (type == 'ping') {
          ref.read(wsLastPingAtProvider.notifier).update();
          _ws?.add(jsonEncode({'type': 'pong'}));
          continue;
        }

        WsMessage message;
        try {
          message = WsMessage.fromJson(decoded);
        } on Exception catch (e) {
          talker.warning('WS: failed to parse message (type=$type): $e');
          continue;
        }

        talker.log('WS message ($type)');
        controller.add(message);
      }
    } finally {
      ref.read(wsConnectionStatusProvider.notifier).update(
        WsConnectionState.disconnected,
      );
    }
  }
}
