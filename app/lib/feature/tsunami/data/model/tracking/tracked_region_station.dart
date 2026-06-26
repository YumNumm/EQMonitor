import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_forecast.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_observation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_region_station.freezed.dart';

@freezed
abstract class TrackedRegionStation with _$TrackedRegionStation {
  const factory TrackedRegionStation({
    required String code,
    required String name,
    required Tracked<TsunamiStationForecast?> forecast,
    required Tracked<TsunamiStationObservation?> observation,
  }) = _TrackedRegionStation;
}
