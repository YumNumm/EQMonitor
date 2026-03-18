// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_intensity_item.dart';
import 'eew_intensity_lpgm_value.dart';
import 'eew_intensity_value.dart';

part 'eew_intensity.freezed.dart';
part 'eew_intensity.g.dart';

/// 予想震度に関する情報
@Freezed()
abstract class EewIntensity with _$EewIntensity {
  const factory EewIntensity({
    required List<EewIntensityItem> regions,
    @JsonKey(includeIfNull: false, name: 'max_intensity')
    EewIntensityValue? maxIntensity,
    @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')
    EewIntensityLpgmValue? maxLpgmIntensity,
  }) = _EewIntensity;

  factory EewIntensity.fromJson(Map<String, Object?> json) =>
      _$EewIntensityFromJson(json);
}
