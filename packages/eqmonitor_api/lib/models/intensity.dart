// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity.dart';
import 'lpgm_intensity.dart';
import 'intensity_item.dart';

part 'intensity.freezed.dart';
part 'intensity.g.dart';

@Freezed()
abstract class Intensity with _$Intensity {
  const factory Intensity({
    @JsonKey(name: 'max_intensity')
    required Intensity maxIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem> regions,
    @JsonKey(includeIfNull: false,name: 'max_lpgm_intensity')
    LpgmIntensity? maxLpgmIntensity,
  }) = _Intensity;
  
  factory Intensity.fromJson(Map<String, Object?> json) => _$IntensityFromJson(json);
}
