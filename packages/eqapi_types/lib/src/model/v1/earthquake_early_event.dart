import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_early_event.freezed.dart';
part 'earthquake_early_event.g.dart';

@freezed
class EarthquakeEarlyEvent with _$EarthquakeEarlyEvent {
  const factory EarthquakeEarlyEvent({
    required String id,
    required String name,
    required double? lat,
    required double? lon,
    required double? depth,
    required double? magnitude,
    required DateTime originTime,
    required OriginTimePrecision originTimePrecision,
    required JmaForecastIntensity? maxIntensity,
    required bool maxIntensityIsEarly,
    required List<EarthquakeEarlyRegion> regions,
    required List<EarthquakeEarlyCity> cities,
  }) = _EarthquakeEarlyEvent;

  factory EarthquakeEarlyEvent.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyEventFromJson(json);
}

@freezed
class EarthquakeEarlyRegion with _$EarthquakeEarlyRegion {
  const factory EarthquakeEarlyRegion({
    required String name,
    required String code,
    required JmaForecastIntensity maxIntensity,
  }) = _EarthquakeEarlyRegion;

  factory EarthquakeEarlyRegion.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyRegionFromJson(json);
}

@freezed
class EarthquakeEarlyCity with _$EarthquakeEarlyCity {
  const factory EarthquakeEarlyCity({
    required String name,
    required String? code,
    required JmaForecastIntensity maxIntensity,
    required List<EarthquakeEarlyObservationPoint> observationPoints,
  }) = _EarthquakeEarlyCity;

  factory EarthquakeEarlyCity.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyCityFromJson(json);
}

@freezed
class EarthquakeEarlyObservationPoint with _$EarthquakeEarlyObservationPoint {
  const factory EarthquakeEarlyObservationPoint({
    required String name,
    required double lat,
    required double lon,
    required JmaForecastIntensity intensity,
  }) = _EarthquakeEarlyObservationPoint;

  factory EarthquakeEarlyObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyObservationPointFromJson(json);
}
