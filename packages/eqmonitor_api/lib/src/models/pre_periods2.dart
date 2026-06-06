// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_lpgm_intensity.dart';

part 'pre_periods2.freezed.dart';
part 'pre_periods2.g.dart';

@Freezed()
abstract class PrePeriods2 with _$PrePeriods2 {
  const factory PrePeriods2({
    required num band,
    @JsonKey(includeIfNull: true)
    required num? sva,
    @JsonKey(includeIfNull: true,name: 'lpgm_intensity')
    required JmaLpgmIntensity? lpgmIntensity,
  }) = _PrePeriods2;
  
  factory PrePeriods2.fromJson(Map<String, Object?> json) => _$PrePeriods2FromJson(json);
}
