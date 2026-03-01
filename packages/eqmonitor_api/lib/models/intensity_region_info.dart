// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_region_info_intensity.dart';
import 'intensity_region_info_lpgm_intensity.dart';

part 'intensity_region_info.freezed.dart';
part 'intensity_region_info.g.dart';

@Freezed()
abstract class IntensityRegionInfo with _$IntensityRegionInfo {
  const factory IntensityRegionInfo({
    required String code,
    required String name,
    @JsonKey(includeIfNull: true)
    required IntensityRegionInfoIntensity? intensity,
    @JsonKey(includeIfNull: true, name: 'lpgm_intensity')
    required IntensityRegionInfoLpgmIntensity? lpgmIntensity,
  }) = _IntensityRegionInfo;

  factory IntensityRegionInfo.fromJson(Map<String, Object?> json) =>
      _$IntensityRegionInfoFromJson(json);
}
