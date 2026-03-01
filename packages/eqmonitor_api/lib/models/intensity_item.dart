// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'intensity_item_max_intensity.dart';
import 'intensity_item_max_lpgm_intensity.dart';

part 'intensity_item.freezed.dart';
part 'intensity_item.g.dart';

@Freezed()
abstract class IntensityItem with _$IntensityItem {
  const factory IntensityItem({
    required CodeName value,
    @JsonKey(includeIfNull: false, name: 'max_intensity')
    IntensityItemMaxIntensity? maxIntensity,
    @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')
    IntensityItemMaxLpgmIntensity? maxLpgmIntensity,
  }) = _IntensityItem;

  factory IntensityItem.fromJson(Map<String, Object?> json) =>
      _$IntensityItemFromJson(json);
}
