// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'pre_periods2.dart';

part 'intensity_station_info.freezed.dart';
part 'intensity_station_info.g.dart';

@Freezed()
abstract class IntensityStationInfo with _$IntensityStationInfo {
  const factory IntensityStationInfo({
    required String code,
    required String name,
    @JsonKey(includeIfNull: true) required JmaIntensity? intensity,
    @JsonKey(includeIfNull: true, name: 'lpgm_intensity')
    required JmaLpgmIntensity? lpgmIntensity,
    @JsonKey(includeIfNull: true) required num? sva,
    @JsonKey(includeIfNull: true, name: 'pre_periods')
    required List<PrePeriods2>? prePeriods,
  }) = _IntensityStationInfo;

  factory IntensityStationInfo.fromJson(Map<String, Object?> json) =>
      _$IntensityStationInfoFromJson(json);
}
