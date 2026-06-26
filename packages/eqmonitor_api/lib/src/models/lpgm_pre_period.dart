// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_lpgm_intensity.dart';

part 'lpgm_pre_period.freezed.dart';
part 'lpgm_pre_period.g.dart';

@Freezed()
abstract class LpgmPrePeriod with _$LpgmPrePeriod {
  const factory LpgmPrePeriod({
    required num band,
    @JsonKey(name: 'lpgm_intensity')
    required JmaLpgmIntensity lpgmIntensity,
    required num sva,
  }) = _LpgmPrePeriod;
  
  factory LpgmPrePeriod.fromJson(Map<String, Object?> json) => _$LpgmPrePeriodFromJson(json);
}
