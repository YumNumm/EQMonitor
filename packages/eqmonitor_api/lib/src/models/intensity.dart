// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_item.dart';
import 'intensity_station_item.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';

part 'intensity.freezed.dart';
part 'intensity.g.dart';

/// 震度に関する情報
@Freezed()
abstract class Intensity with _$Intensity {
  const factory Intensity({
    @JsonKey(name: 'max_intensity')
    required JmaIntensity maxIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem> regions,
    @JsonKey(includeIfNull: false,name: 'max_lpgm_intensity')
    JmaLpgmIntensity? maxLpgmIntensity,
    @JsonKey(includeIfNull: false)
    List<IntensityItem>? cities,
    @JsonKey(includeIfNull: false)
    List<IntensityStationItem>? stations,
  }) = _Intensity;
  
  factory Intensity.fromJson(Map<String, Object?> json) => _$IntensityFromJson(json);
}
