// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_lpgm_intensity.dart';

part 'eew_intensity_lpgm_value.freezed.dart';
part 'eew_intensity_lpgm_value.g.dart';

/// 予想長周期地震動階級の値
@Freezed()
abstract class EewIntensityLpgmValue with _$EewIntensityLpgmValue {
  const factory EewIntensityLpgmValue({
    required JmaLpgmIntensity value,
    @JsonKey(name: 'is_over')
    required bool isOver,
  }) = _EewIntensityLpgmValue;
  
  factory EewIntensityLpgmValue.fromJson(Map<String, Object?> json) => _$EewIntensityLpgmValueFromJson(json);
}
