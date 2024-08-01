import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_early.freezed.dart';
part 'earthquake_early.g.dart';

@freezed
class EarthquakeEarly with _$EarthquakeEarly {
  const factory EarthquakeEarly({
    required String id,
    required int? depth,
    required double? latitude,
    required double? longitude,
    required double? magnitude,
    required JmaIntensity? maxIntensity,
    required bool maxIntensityIsEarly,
    required String name,
    required DateTime originTime,
    required OriginTimePrecision originTimePrecision,
  }) = _EarthquakeEarly;

  factory EarthquakeEarly.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyFromJson(json);
}

enum OriginTimePrecision {
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  ;
}

@freezed
class EarthquakeEarlyEvent with _$EarthquakeEarlyEvent {
  const factory EarthquakeEarlyEvent({
    required String id,
    required String name,
    required double? latitude,
    required double? longitude,
    required double? depth,
    required double? magnitude,
    required DateTime originTime,
    required OriginTimePrecision originTimePrecision,
    required JmaIntensity? maxIntensity,
    required List<EarthquakeEarlyRegion> regions,
  }) = _EarthquakeEarlyEvent;

  factory EarthquakeEarlyEvent.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyEventFromJson(json);
}

@freezed
class EarthquakeEarlyRegion with _$EarthquakeEarlyRegion {
  const factory EarthquakeEarlyRegion({
    required String name,
    required int code,
    required JmaIntensity maxIntensity,
    required List<EarthquakeEarlyCity> cities,
  }) = _EarthquakeEarlyRegion;

  factory EarthquakeEarlyRegion.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyRegionFromJson(json);
}

@freezed
class EarthquakeEarlyCity with _$EarthquakeEarlyCity {
  const factory EarthquakeEarlyCity({
    required String name,
    required int code,
    required JmaIntensity maxIntensity,
    required List<EarthquakeEarlyObservationPoint> observationPoints,
  }) = _EarthquakeEarlyCity;

  factory EarthquakeEarlyCity.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyCityFromJson(json);
}

@freezed
class EarthquakeEarlyObservationPoint with _$EarthquakeEarlyObservationPoint {
  const factory EarthquakeEarlyObservationPoint({
    required String name,
    required double latitude,
    required double longitude,
    required JmaIntensity intensity,
  }) = _EarthquakeEarlyObservationPoint;

  factory EarthquakeEarlyObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyObservationPointFromJson(json);
}
