import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/components/core/core.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_early_event.freezed.dart';
part 'earthquake_early_event.g.dart';

@freezed
class EarthquakeEarlyEvent with _$EarthquakeEarlyEvent {
  const factory EarthquakeEarlyEvent({
    required String id,
    required String name,
    required double? latitude,
    required double? longitude,
    required double? depth,
    required DateTime originTime,
    required OriginTimePrecision originTimePrecision,
    required JmaIntensity? maxIntensity,
    required bool maxIntensityIsEarly,
    required List<EarthquakeEarlyEventRegion> regions,
    required List<EarthquakeEarlyEventObservationCity> cities,
  }) = _EarthquakeEarlyEvent;

  factory EarthquakeEarlyEvent.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyEventFromJson(json);
}

@freezed
class EarthquakeEarlyEventRegion with _$EarthquakeEarlyEventRegion {
  const factory EarthquakeEarlyEventRegion({
    required String? name,
    required String? code,
    required JmaIntensity? maxIntensity,
  }) = _EarthquakeEarlyEventRegion;

  factory EarthquakeEarlyEventRegion.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyEventRegionFromJson(json);
}

@freezed
class EarthquakeEarlyEventObservationCity
    with _$EarthquakeEarlyEventObservationCity {
  const factory EarthquakeEarlyEventObservationCity({
    required String name,
    required String? code,
    required JmaIntensity? maxIntensity,
    required List<EarthquakeEarlyEventObservationPoint> observationPoints,
  }) = _EarthquakeEarlyEventObservationCity;

  factory EarthquakeEarlyEventObservationCity.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EarthquakeEarlyEventObservationCityFromJson(json);
}

@freezed
class EarthquakeEarlyEventObservationPoint
    with _$EarthquakeEarlyEventObservationPoint {
  const factory EarthquakeEarlyEventObservationPoint({
    required double lat,
    required double lon,
    required String name,
    required JmaIntensity intensity,
  }) = _EarthquakeEarlyEventObservationPoint;

  factory EarthquakeEarlyEventObservationPoint.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EarthquakeEarlyEventObservationPointFromJson(json);
}
