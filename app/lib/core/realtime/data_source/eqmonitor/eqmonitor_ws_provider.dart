import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/connectivity/connectivity_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_provider.g.dart';

@Riverpod(keepAlive: true)
Future<WebSocket> eqmonitorWebSocket(Ref ref) async {
  final ticket = await ref.watch(eqmonitorWebSocketTicketProvider.future);
  final ticketUri = Uri.parse(ticket.url);
  final ws = await WebSocket.connect(
    ticketUri.replace(
      queryParameters: {
        ...ticketUri.queryParametersAll,
        'heartbeat': ['fixed-v1'],
      },
    ),
  );
  if (!ref.mounted) {
    await ws.close();
    throw StateError('WebSocket connection was replaced');
  }
  ref.onDispose(() => ws.close().ignore());
  return ws;
}

/// WebSocket イベントストリーム。
///
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
/// background 中も接続は閉じない。background からの復帰時は接続を維持したまま
/// heartbeat を送り、[resumeProbeTimeout] 以内に pong が返らなければ再接続する。
/// ネットワークの変化 (オフライン→オンライン、Wi-Fi↔モバイル回線) でも
/// バックオフをリセットし、全端末が同時に接続しないよう 1〜2 秒の
/// ジッタを入れて再接続する。
@Riverpod(keepAlive: true)
class EqmonitorWsEventStream extends _$EqmonitorWsEventStream {
  /// 受信が途絶えたら接続が死んでいるとみなすまでの時間。
  ///
  /// 15 秒間隔の固定 ping への pong、または既存サーバーの ping で更新する。
  /// 送信しただけでは更新せず、30 秒間受信できなければ再接続する。
  static const silenceTimeout = Duration(seconds: 30);
  static const heartbeatInterval = Duration(seconds: 15);
  static const resumeProbeTimeout = Duration(seconds: 5);

  // Durable Objects の自動応答は文字列全体に一致するため、順序・空白も固定。
  // RTT probe の連番 pingId と分離し、固定 pong を RTT に計上しない。
  static const heartbeatMessage = '{"type":"ping","pingId":"heartbeat"}';
  static const heartbeatPong = WsHeartbeatPongMatcher(pingId: 'heartbeat');

  var _retryDelaySeconds = 1;
  var _wasPaused = false;
  final _random = math.Random();

  /// これは状態ではなくイベント列なので、同じ値でも必ず通知する。
  ///
  /// 既定では前回の state と `==` のとき listener に通知されない。
  /// [TextDataReceived] は text の値等価なので、`{"type":"ping"}` のように
  /// 内容が完全に同じフレームが連続すると 2 回目以降が観測できなくなる。
  @override
  bool updateShouldNotify(
    AsyncValue<WebSocketEvent> previous,
    AsyncValue<WebSocketEvent> next,
  ) => true;

  @override
  Stream<WebSocketEvent> build() async* {
    WebSocket? openSocket;
    var isWaitingRetry = false;
    // iOS は suspend 中に Dart の timer が進まないため、経過は壁時計で測る。
    final startedAt = DateTime.now();

    Timer? silenceWatchdog;
    Timer? heartbeatTimer;
    Timer? resumeProbe;
    ref.onDispose(() {
      silenceWatchdog?.cancel();
      heartbeatTimer?.cancel();
      resumeProbe?.cancel();
    });
    // suspend 中に溜まった frame は接続が今も生きている証拠にならないため、
    // heartbeat の pong だけで解除する。
    void probe(WebSocket socket) {
      resumeProbe?.cancel();
      silenceWatchdog?.cancel();
      try {
        socket.sendText(heartbeatMessage);
      } on WebSocketConnectionClosed {
        _reconnect();
        return;
      }
      resumeProbe = Timer(resumeProbeTimeout, () {
        talker.warning(
          'EQMonitor WebSocket: no pong received for '
          '${resumeProbeTimeout.inSeconds}s after resume, reconnecting',
        );
        _reconnect();
      });
    }

    void armSilenceWatchdog() {
      silenceWatchdog?.cancel();
      silenceWatchdog = Timer(silenceTimeout, () {
        final socket = openSocket;
        // suspend で止まっていた timer が復帰の通知より先に満了することがある。
        if (_wasPaused && socket != null) {
          probe(socket);
          return;
        }
        talker.warning(
          'EQMonitor WebSocket: no frame received for '
          '${silenceTimeout.inSeconds}s, reconnecting',
        );
        _reconnect();
      });
    }

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.paused) {
        _wasPaused = true;
        return;
      }
      if (next != AppLifecycleState.resumed || !_wasPaused) {
        return;
      }
      _wasPaused = false;
      final socket = openSocket;
      if (socket == null) {
        if (isWaitingRetry ||
            DateTime.now().difference(startedAt) >= resumeProbeTimeout) {
          _retryDelaySeconds = 1;
          _reconnect();
        }
        return;
      }
      probe(socket);
    });

    Timer? connectivityReconnectTimer;
    ref.onDispose(() => connectivityReconnectTimer?.cancel());
    ref.listen(connectivityStreamProvider, (previous, next) {
      final previousResults = previous?.value;
      final results = next.value;
      // 初回の通知 (起動時の状態) は変化ではないので無視する。
      if (previousResults == null || results == null) {
        return;
      }
      if (const SetEquality<ConnectivityResult>().equals(
        previousResults.toSet(),
        results.toSet(),
      )) {
        return;
      }
      if (results.every((r) => r == ConnectivityResult.none)) {
        return;
      }
      final jitter = Duration(milliseconds: 1000 + _random.nextInt(1001));
      talker.info(
        'EQMonitor WebSocket: network changed, reconnecting in '
        '${jitter.inMilliseconds}ms',
      );
      connectivityReconnectTimer?.cancel();
      connectivityReconnectTimer = Timer(jitter, () {
        _retryDelaySeconds = 1;
        _reconnect();
      });
    });

    var didConnect = false;
    var didReceiveClose = false;
    try {
      final websocket = await ref.watch(eqmonitorWebSocketProvider.future);
      const heartbeatResponder = WsHeartbeatResponder();
      _retryDelaySeconds = 1;
      didConnect = true;
      openSocket = websocket;
      armSilenceWatchdog();
      websocket.sendText(heartbeatMessage);
      heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
        try {
          websocket.sendText(heartbeatMessage);
        } on WebSocketConnectionClosed {
          timer.cancel();
          _reconnect();
        }
      });

      await for (final event in websocket.events) {
        armSilenceWatchdog();
        if (event case TextDataReceived(:final text)) {
          if (resumeProbe != null && heartbeatPong.matches(text)) {
            resumeProbe?.cancel();
            resumeProbe = null;
          }
          final response = heartbeatResponder.buildResponse(text);
          if (response != null) {
            websocket.sendText(response);
          }
        }
        if (event is CloseReceived) {
          didReceiveClose = true;
          openSocket = null;
        }
        yield event;
        if (event case CloseReceived(:final code, :final reason)) {
          talker.warning(
            'EQMonitor WebSocket: closed with code=$code reason=$reason',
          );
          break;
        }
      }
    } on Exception catch (e) {
      talker.error('EQMonitor WebSocket: connection failed', e);
    } finally {
      openSocket = null;
      silenceWatchdog?.cancel();
      heartbeatTimer?.cancel();
      resumeProbe?.cancel();
    }
    isWaitingRetry = true;

    // 失敗回数のべき乗は整数オーバーフローで 0 になるため、待ち時間自体を制限する。
    final delaySeconds = _retryDelaySeconds;
    _retryDelaySeconds = math.min(_retryDelaySeconds * 2, 60);
    talker.info(
      'EQMonitor WebSocket: reconnecting in ${delaySeconds}s',
    );

    final timer = Timer(Duration(seconds: delaySeconds), _reconnect);
    ref.onDispose(timer.cancel);

    // close frame なしで終わった接続も、下流が切断として扱えるようにする。
    if (didConnect && !didReceiveClose) {
      yield CloseReceived(1006, 'connection lost');
    }
  }

  void _reconnect() {
    ref.invalidate(eqmonitorWebSocketTicketProvider, asReload: true);
    ref.invalidate(eqmonitorWebSocketProvider, asReload: true);
  }
}

@riverpod
Future<RealtimeTicketResponse> eqmonitorWebSocketTicket(Ref ref) async {
  try {
    final api = await ref.watch(apiClientProvider.future);
    final response = await api.realtime.getV2RealtimeTicket();
    return response.data;
  } on Exception catch (e) {
    talker.error('Failed to get WebSocket ticket', e);
    rethrow;
  }
}
