import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'offshore_station_timeline.freezed.dart';

/// 沖合観測局ごとのタイムライン。
@freezed
abstract class OffshoreStationTimeline with _$OffshoreStationTimeline {
  const factory({
    required String code,
    required String name,
    required ObservationFirstHeightTimeline firstHeight,
    required ObservationMaxHeightTimeline maxHeight,
  }) = _OffshoreStationTimeline;
}
