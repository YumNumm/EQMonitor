// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';

part 'eew_telegram_body_intensity_region.freezed.dart';
part 'eew_telegram_body_intensity_region.g.dart';

@Freezed()
abstract class EewTelegramBodyIntensityRegion with _$EewTelegramBodyIntensityRegion {
  const factory EewTelegramBodyIntensityRegion({
    required String eventId,
    required num serialNo,
    required String code,
    required String name,
    required bool isPlum,
    required bool isWarning,
    required JmaIntensity intensity,
    required bool intensityIsOver,
    @JsonKey(includeIfNull: false)
    JmaLpgmIntensity? lpgmIntensity,
    @JsonKey(includeIfNull: false)
    bool? lpgmIntensityIsOver,
    @JsonKey(includeIfNull: false)
    String? arrivalTime,
  }) = _EewTelegramBodyIntensityRegion;
  
  factory EewTelegramBodyIntensityRegion.fromJson(Map<String, Object?> json) => _$EewTelegramBodyIntensityRegionFromJson(json);
}
