// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_item.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';

part 'intensity_partial.freezed.dart';
part 'intensity_partial.g.dart';

@Freezed()
abstract class IntensityPartial with _$IntensityPartial {
  const factory IntensityPartial({
    @JsonKey(name: 'max_intensity')
    required JmaIntensity maxIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem> regions,
    @JsonKey(includeIfNull: false,name: 'max_lpgm_intensity')
    JmaLpgmIntensity? maxLpgmIntensity,
  }) = _IntensityPartial;
  
  factory IntensityPartial.fromJson(Map<String, Object?> json) => _$IntensityPartialFromJson(json);
}
