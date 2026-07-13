import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_status_notifier.g.dart';

/// WebSocket の接続状態・ping 情報を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に最終 ping 時刻とサーバーの ping 送出間隔を [EqMonitorWsStatusState.pingRtt] に記録する。
/// なお pingRtt はネットワーク RTT ではなくサーバーからの ping 受信間隔である点に注意。
@Riverpod(keepAlive: true)
class EqMonitorWsStatus extends _$EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() {
    ref.listen(eqmonitorWebSocketProvider, (_, next) {
      state = state.copyWith(
        phase: next.when(
          data: (_) => WsPhase.connected,
          loading: () => WsPhase.connecting,
          error: (e, s) => WsPhase.disconnected,
        ),
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
          _handlePing();
        }
      });
    });

    final initialPhase = ref
        .read(eqmonitorWebSocketProvider)
        .when(
          data: (_) => WsPhase.connected,
          loading: () => WsPhase.connecting,
          error: (e, s) => WsPhase.disconnected,
        );
    final initialTicket = switch (ref.read(eqmonitorWebSocketTicketProvider)) {
      AsyncData(:final value) => value,
      _ => null,
    };

    return EqMonitorWsStatusState(
      phase: initialPhase,
      currentUrl: initialTicket != null ? _maskTicket(initialTicket.url) : null,
    );
  }

  void _handlePing() {
    final now = DateTime.now();
    final prev = state.lastPingAt;
    state = state.copyWith(
      lastPingAt: now,
      pingRtt: prev != null ? now.difference(prev) : state.pingRtt,
    );
  }

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
