import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    ref.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
      next.whenData((message) {
        if (message is WsPingMessage) {
          _handleServerPing();
        }
      });
    });
    return EqMonitorWsStatusState(
      phase: _phaseOf(ref.read(eqmonitorWebSocketProvider)),
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

  static WsPhase _phaseOf(AsyncValue<Object?> value) => value.when(
    data: (_) => WsPhase.connected,
    loading: () => WsPhase.connecting,
    error: (e, s) => WsPhase.disconnected,
  );
}
