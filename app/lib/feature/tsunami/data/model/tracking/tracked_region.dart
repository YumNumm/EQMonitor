import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_region.freezed.dart';

@freezed
abstract class TrackedRegion with _$TrackedRegion {
  const factory TrackedRegion({
    required String code,
    required String name,
    required Tracked<TsunamiWarningKind> kind,
    required Tracked<TsunamiWarningKind> lastKind,
    required Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight,
    required Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight,
    required Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight,
    required Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight,
    required List<TrackedRegionStation> stations,
  }) = _TrackedRegion;
}
