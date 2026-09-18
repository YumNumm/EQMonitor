import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_time_sync_samples.freezed.dart';
part 'kyoshin_monitor_time_sync_samples.g.dart';

@freezed
abstract class KyoshinMonitorTimeSyncSamples
    with _$KyoshinMonitorTimeSyncSamples {
  const factory({
    @Default([]) List<Duration> roundTripTimes,
    @Default([]) List<Duration> shifts,
  }) = _KyoshinMonitorTimeSyncSamples;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimeSyncSamplesFromJson(json);
}
