import 'package:freezed_annotation/freezed_annotation.dart';

part 'eqmonitor_ws_status_state.freezed.dart';

enum WsPhase { connecting, connected, disconnected }

@freezed
abstract class EqMonitorWsStatusState with _$EqMonitorWsStatusState {
  const factory({
    @Default(WsPhase.connecting) WsPhase phase,

    DateTime? lastPingAt,

    Duration? serverPingInterval,
  }) = _EqMonitorWsStatusState;
}
