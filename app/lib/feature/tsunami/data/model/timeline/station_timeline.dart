import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_timeline.freezed.dart';

/// 観測点ごとのタイムライン。
@freezed
abstract class StationTimeline with _$StationTimeline {
  const factory StationTimeline({
    required String code,
    required String name,
    required StationForecastTimeline forecast,
    required StationObservationTimeline observation,
  }) = _StationTimeline;
}
