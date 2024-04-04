import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@freezed
class EarthquakeV1 with _$EarthquakeV1 implements V1Database {
  const factory EarthquakeV1({
    DateTime? arrivalTime,
    int? depth,
    int? epicenterCode,
    int? epicenterDetailCode,
    required int eventId,
    String? headline,
    List<ObservedRegionIntensity>? intensityCities,
    List<ObservedRegionIntensity>? intensityPrefectures,
    List<ObservedRegionIntensity>? intensityRegions,
    List<ObservedRegionIntensity>? intensityStations,
    double? latitude,
    double? longitude,
    List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures,
    List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions,
    List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations,
    double? magnitude,
    String? magnitudeCondition,
    JmaIntensity? maxIntensity,
    List<int>? maxIntensityRegionIds,
    JmaLgIntensity? maxLpgmIntensity,
    DateTime? originTime,
    required String status,
    String? text,
  }) = _EarthquakeV1;

  factory EarthquakeV1.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeV1FromJson(json);
}

/// `/v1/earthquake/region` の `$.[*].earthquake` で利用
@freezed
class EarthquakeV1Base with _$EarthquakeV1Base {
  const factory EarthquakeV1Base({
    DateTime? arrivalTime,
    int? depth,
    int? epicenterCode,
    int? epicenterDetailCode,
    required int eventId,
    String? headline,
    double? latitude,
    double? longitude,
    double? magnitude,
    String? magnitudeCondition,
    JmaIntensity? maxIntensity,
    List<int>? maxIntensityRegionIds,
    JmaLgIntensity? maxLpgmIntensity,
    DateTime? originTime,
    required String status,
    String? text,
  }) = _EarthquakeV1Base;

  factory EarthquakeV1Base.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeV1BaseFromJson(json);
}

@freezed
class ObservedRegionIntensity with _$ObservedRegionIntensity {
  const factory ObservedRegionIntensity({
    required String code,
    required String name,
    @JsonKey(name: 'maxInt') required JmaIntensity? intensity,
  }) = _ObservedRegionIntensity;

  factory ObservedRegionIntensity.fromJson(Map<String, dynamic> json) =>
      _$ObservedRegionIntensityFromJson(json);
}

@freezed
class ObservedRegionLpgmIntensity with _$ObservedRegionLpgmIntensity {
  const factory ObservedRegionLpgmIntensity({
    required String code,
    required String name,
    @JsonKey(name: 'maxInt') required JmaIntensity? intensity,
    @JsonKey(name: 'maxLgInt') required JmaLgIntensity? lpgmIntensity,
  }) = _ObservedRegionLpgmIntensity;

  factory ObservedRegionLpgmIntensity.fromJson(Map<String, dynamic> json) =>
      _$ObservedRegionLpgmIntensityFromJson(json);
}
