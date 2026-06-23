// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_tree.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'lpgm_intensity_tree.dart';

part 'intensity.freezed.dart';
part 'intensity.g.dart';

/// 震度に関する情報
@Freezed()
abstract class Intensity with _$Intensity {
  const factory Intensity({
    @JsonKey(name: 'max_intensity')
    required JmaIntensity maxIntensity,
    @JsonKey(name: 'intensity_tree')
    required List<IntensityTree> intensityTree,
    @JsonKey(includeIfNull: false,name: 'max_lpgm_intensity')
    JmaLpgmIntensity? maxLpgmIntensity,
    @JsonKey(includeIfNull: false,name: 'lpgm_intensity_tree')
    List<LpgmIntensityTree>? lpgmIntensityTree,
  }) = _Intensity;
  
  factory Intensity.fromJson(Map<String, Object?> json) => _$IntensityFromJson(json);
}
