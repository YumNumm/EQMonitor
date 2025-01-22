import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_state.freezed.dart';
part 'kyoshin_monitor_state.g.dart';

@freezed
class KyoshinMonitorTimerState with _$KyoshinMonitorTimerState {
  const factory KyoshinMonitorTimerState({
    required Duration delayFromDevice,
    required DateTime? lastSyncedAt,
  }) = _KyoshinMonitorTimerState;

  factory KyoshinMonitorTimerState.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimerStateFromJson(json);
}

enum KyoshinMonitorStatus {
  /// リアルタイム
  realtime,

  /// 遅延
  delayed,

  /// playback
  playback,

  /// 停止
  stopped,

  // 初期化中
  initializing,
  ;
}
