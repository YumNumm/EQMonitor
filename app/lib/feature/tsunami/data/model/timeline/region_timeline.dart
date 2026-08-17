import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_timeline.freezed.dart';

/// 地域ごとのタイムライン。
@freezed
abstract class RegionTimeline with _$RegionTimeline {
  const factory({
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
