// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity.dart';

part 'eew_intensity_value.freezed.dart';
part 'eew_intensity_value.g.dart';

/// 予想震度の値
@Freezed()
abstract class EewIntensityValue with _$EewIntensityValue {
  const factory EewIntensityValue({
    required Intensity value,
    @JsonKey(name: 'is_over')
    required bool isOver,
  }) = _EewIntensityValue;
  
  factory EewIntensityValue.fromJson(Map<String, Object?> json) => _$EewIntensityValueFromJson(json);
}
