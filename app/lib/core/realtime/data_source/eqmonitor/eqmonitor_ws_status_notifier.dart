import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_status_notifier.g.dart';

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する
@Riverpod(keepAlive: true)
class EqMonitorWsStatus extends _$EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() {
    ref.listen(eqmonitorWebSocketProvider, (_, next) {
      state = EqMonitorWsStatusState(
        phase: _phaseOf(next),
      );
    });

    // 切断後の再接続待ちの間、eqmonitorWebSocketProvider は閉じたソケットを
    // data として保持し続けるため、close の受信で切断を判定する。
    ref.listen(eqmonitorWsEventStreamProvider, (_, next) {
      if (_isClosed(next)) {
        state = state.copyWith(phase: WsPhase.disconnected);
      }
    });

    ref.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
      next.whenData((message) {
        if (message is WsPingMessage) {
          _handleServerPing();
        }
      });
    });
    return EqMonitorWsStatusState(
      phase: _isClosed(ref.read(eqmonitorWsEventStreamProvider))
          ? WsPhase.disconnected
          : _phaseOf(ref.read(eqmonitorWebSocketProvider)),
    );
  }

  void _handleServerPing() {
    final now = DateTime.now();
    final prev = state.lastPingAt;
    state = state.copyWith(
      lastPingAt: now,
      serverPingInterval: prev != null
          ? now.difference(prev)
          : state.serverPingInterval,
    );
  }

  // 再接続の開始後は、前回接続の close が loading の前回値として残る。
  static bool _isClosed(AsyncValue<WebSocketEvent> event) =>
      !event.isLoading && event.value is CloseReceived;

  static WsPhase _phaseOf(AsyncValue<Object?> value) => value.when(
    data: (_) => WsPhase.connected,
    loading: () => WsPhase.connecting,
    error: (e, s) => WsPhase.disconnected,
  );
}
