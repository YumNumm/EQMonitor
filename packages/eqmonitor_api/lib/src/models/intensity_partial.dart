// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_intensity_class.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';

part 'intensity_partial.freezed.dart';
part 'intensity_partial.g.dart';

@Freezed()
abstract class IntensityPartial with _$IntensityPartial {
  const factory IntensityPartial({
    @JsonKey(name: 'max_intensity')
    required JmaIntensity maxIntensity,
    @JsonKey(includeIfNull: false,name: 'max_lpgm_intensity')
    JmaLpgmIntensity? maxLpgmIntensity,
    @JsonKey(includeIfNull: false,name: 'max_intensity_class')
    CatalogIntensityClass? maxIntensityClass,
  }) = _IntensityPartial;
  
  factory IntensityPartial.fromJson(Map<String, Object?> json) => _$IntensityPartialFromJson(json);
}
