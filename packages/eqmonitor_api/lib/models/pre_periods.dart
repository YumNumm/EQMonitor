// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_lpgm_intensity.dart';

part 'pre_periods.freezed.dart';
part 'pre_periods.g.dart';

@Freezed()
abstract class PrePeriods with _$PrePeriods {
  const factory PrePeriods({
    required num band,
    @JsonKey(name: 'lpgm_intensity') required JmaLpgmIntensity lpgmIntensity,
    required num sva,
  }) = _PrePeriods;

  factory PrePeriods.fromJson(Map<String, Object?> json) =>
      _$PrePeriodsFromJson(json);
}
