import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_status_notifier.g.dart';

@Riverpod(keepAlive: true)
class EqMonitorWsStatus extends _$EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() => const EqMonitorWsStatusState();

  void setConnecting() {
    state = state.copyWith(phase: WsPhase.connecting);
  }

  void setConnected({required String url}) {
    state = state.copyWith(
      phase: WsPhase.connected,
      currentUrl: _maskTicket(url),
    );
  }

  void setDisconnected() {
    state = state.copyWith(phase: WsPhase.disconnected);
  }

  void recordPing() {
    final now = DateTime.now();
    final prev = state.lastPingAt;
    state = state.copyWith(
      lastPingAt: now,
      pingRtt: prev != null ? now.difference(prev) : state.pingRtt,
    );
  }

  String _maskTicket(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    final params = Map<String, String>.from(uri.queryParameters);
    if (params.containsKey('ticket')) {
      params['ticket'] = '<masked>';
    }
    return uri.replace(queryParameters: params).toString();
  }
}
