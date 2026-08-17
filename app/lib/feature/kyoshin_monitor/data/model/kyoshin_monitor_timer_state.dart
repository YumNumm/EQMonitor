import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_timer_state.freezed.dart';
part 'kyoshin_monitor_timer_state.g.dart';

@freezed
abstract class KyoshinMonitorTimerState with _$KyoshinMonitorTimerState {
  const factory({
    required Duration delayFromDevice,
    required DateTime? lastSyncedAt,
  }) = _KyoshinMonitorTimerState;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimerStateFromJson(json);
}
