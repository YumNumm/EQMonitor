import 'package:freezed_annotation/freezed_annotation.dart';

part 'eqmonitor_ws_status_state.freezed.dart';

enum WsPhase { connecting, connected, disconnected }

@freezed
abstract class EqMonitorWsStatusState with _$EqMonitorWsStatusState {
  const factory({
    @Default(WsPhase.connecting) WsPhase phase,
    String? currentUrl,

    /// 直近にサーバー起因 ping を受信した時刻。
    DateTime? lastPingAt,

    /// サーバー起因 ping の受信間隔（サーバー実装では 15 秒）。
    ///
    /// ネットワーク RTT ではない。RTT はクライアント起因 ping で計測する
    /// `eqmonitorWsPingProbeProvider` 側が持つ。
    Duration? serverPingInterval,
  }) = _EqMonitorWsStatusState;
}
