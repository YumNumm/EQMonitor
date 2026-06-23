import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_timeline_entry.freezed.dart';

typedef StationForecastTimeline = List<StationForecastTimelineEntry>;
typedef StationObservationTimeline = List<StationObservationTimelineEntry>;

/// 観測点予報のタイムライン行。
@freezed
abstract class StationForecastTimelineEntry
    with _$StationForecastTimelineEntry {
  const factory StationForecastTimelineEntry({
    // 追跡項目のフィールド
    required DateTime? highTideAt,
    required DateTime? firstHeightArrivalTime,
    required FirstHeightCondition? firstHeightCondition,
    required Revise? firstHeightRevise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _StationForecastTimelineEntry;
}

/// 観測点観測のタイムライン行。
@freezed
abstract class StationObservationTimelineEntry
    with _$StationObservationTimelineEntry {
  const factory StationObservationTimelineEntry({
    // 追跡項目のフィールド
    required String? sensor,
    // first_height フィールド
    required DateTime? firstHeightArrivalTime,
    required WaveInitial? firstHeightInitial,
    required bool? firstHeightIsUnidentifiable,
    required bool? firstHeightIsMissing,
    required Revise? firstHeightRevise,
    // max_height フィールド (null = 未観測)
    required DateTime? maxHeightDateTime,
    required double? maxHeightValue,
    required bool? maxHeightIsOver,
    required bool? maxHeightIsRising,
    required ObservationMaxHeightCondition? maxHeightCondition,
    required bool? maxHeightIsMissing,
    required Revise? maxHeightRevise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _StationObservationTimelineEntry;
}
