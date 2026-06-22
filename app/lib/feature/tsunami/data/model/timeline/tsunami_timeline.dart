import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_timeline.freezed.dart';

/// 津波タイムライン公開ルート型（UI が参照）。
@freezed
abstract class TsunamiTimeline with _$TsunamiTimeline {
  const factory TsunamiTimeline({
    required List<TsunamiTelegramMeta> telegrams,
    required List<RegionTimeline> regions,
    required List<OffshoreStationTimeline> offshoreStations,
  }) = _TsunamiTimeline;
}

/// 地域ごとのタイムライン。
@freezed
abstract class RegionTimeline with _$RegionTimeline {
  const factory RegionTimeline({
    required String code,
    required String name,
    required KindTimeline kind,
    required KindTimeline lastKind,
    required FirstHeightTimeline forecastFirstHeight,
    required MaxHeightTimeline forecastMaxHeight,
    required EstimationFirstHeightTimeline estimationFirstHeight,
    required EstimationMaxHeightTimeline estimationMaxHeight,
    required List<StationTimeline> stations,
  }) = _RegionTimeline;
}

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

/// 沖合観測局ごとのタイムライン。
@freezed
abstract class OffshoreStationTimeline with _$OffshoreStationTimeline {
  const factory OffshoreStationTimeline({
    required String code,
    required String name,
    required ObservationFirstHeightTimeline firstHeight,
    required ObservationMaxHeightTimeline maxHeight,
  }) = _OffshoreStationTimeline;
}
