import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_timer_state.freezed.dart';
part 'kyoshin_monitor_timer_state.g.dart';

@freezed
class KyoshinMonitorTimerState with _$KyoshinMonitorTimerState {
  const factory KyoshinMonitorTimerState({
    required Duration delayFromDevice,
    required DateTime? lastSyncedAt,
  }) = _KyoshinMonitorTimerState;

  factory KyoshinMonitorTimerState.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimerStateFromJson(json);
}
