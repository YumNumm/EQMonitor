import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_status_notifier.g.dart';

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に最終 ping 時刻と ping 受信間隔を記録する。
///
/// ここが持つのはサーバー起因 ping の観測値だけで、ネットワーク RTT ではない。
/// RTT はクライアント起因 ping を送出する `eqmonitorWsPingProbeProvider` が持つ。
@Riverpod(keepAlive: true)
class EqMonitorWsStatus extends _$EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() {
    ref.listen(eqmonitorWebSocketProvider, (_, next) {
      // ping の観測値は接続単位。ソケットが張り直されたら必ず捨てる。
      // そうしないと再接続後の最初の ping で「切断していた時間」が
      // 受信間隔として記録されてしまう。
      state = EqMonitorWsStatusState(
        phase: _phaseOf(next),
        currentUrl: state.currentUrl,
      );
    });

    ref.listen(eqmonitorWebSocketTicketProvider, (_, next) {
      next.whenData(
        (ticket) => state = state.copyWith(currentUrl: _maskTicket(ticket.url)),
      );
    });

    ref.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
      next.whenData((message) {
        if (message is WsPingMessage) {
          _handleServerPing();
        }
      });
    });

    final initialTicket = switch (ref.read(eqmonitorWebSocketTicketProvider)) {
      AsyncData(:final value) => value,
      _ => null,
    };

    return EqMonitorWsStatusState(
      phase: _phaseOf(ref.read(eqmonitorWebSocketProvider)),
      currentUrl: initialTicket != null ? _maskTicket(initialTicket.url) : null,
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

  static String _maskTicket(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return url;
    }
    final params = Map<String, String>.from(uri.queryParameters);
    if (params.containsKey('ticket')) {
      params['ticket'] = '<masked>';
    }
    return uri.replace(queryParameters: params).toString();
  }
}
