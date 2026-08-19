import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_provider.g.dart';

@Riverpod(keepAlive: true)
Future<WebSocket> eqmonitorWebSocket(Ref ref) async {
  final ticket = await ref.read(eqmonitorWebSocketTicketProvider.future);
  final ws = await WebSocket.connect(Uri.parse(ticket.url));
  ref.onDispose(() => ws.close().ignore());
  return ws;
}

/// WebSocket イベントストリーム。
///
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
/// アプリ resume 時はバックオフをリセットして即座に再接続する。
@Riverpod(keepAlive: true)
class EqmonitorWsEventStream extends _$EqmonitorWsEventStream {
  var _retryCount = 0;

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
    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        _retryCount = 0;
        ref.invalidate(eqmonitorWebSocketTicketProvider, asReload: true);
        ref.invalidate(eqmonitorWebSocketProvider, asReload: true);
      }
    });

    try {
      final websocket = await ref.watch(eqmonitorWebSocketProvider.future);
      const heartbeatResponder = WsHeartbeatResponder();
      _retryCount = 0;

      await for (final event in websocket.events) {
        if (event case TextDataReceived(:final text)) {
          final response = heartbeatResponder.buildResponse(text);
          if (response != null) {
            websocket.sendText(response);
          }
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
    }

    final delaySeconds = math.min(math.pow(2, _retryCount).toInt(), 60);
    _retryCount++;
    talker.info(
      'EQMonitor WebSocket: reconnecting in ${delaySeconds}s '
      '(attempt $_retryCount)',
    );

    final timer = Timer(Duration(seconds: delaySeconds), () {
      ref.invalidate(eqmonitorWebSocketTicketProvider, asReload: true);
      ref.invalidate(eqmonitorWebSocketProvider, asReload: true);
    });
    ref.onDispose(timer.cancel);
  }
}

@riverpod
Future<RealtimeTicketResponse> eqmonitorWebSocketTicket(Ref ref) async {
  try {
    final api = await ref.read(apiClientProvider.future);
    final response = await api.realtime.getV2RealtimeTicket();
    return response.data;
  } on Exception catch (e) {
    talker.error('Failed to get WebSocket ticket', e);
    rethrow;
  }
}
