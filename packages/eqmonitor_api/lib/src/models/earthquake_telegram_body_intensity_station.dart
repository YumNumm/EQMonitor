// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'pre_periods2.dart';

part 'earthquake_telegram_body_intensity_station.freezed.dart';
part 'earthquake_telegram_body_intensity_station.g.dart';

@Freezed()
abstract class EarthquakeTelegramBodyIntensityStation with _$EarthquakeTelegramBodyIntensityStation {
  const factory EarthquakeTelegramBodyIntensityStation({
    required String eventId,
    required String code,
    required String name,
    @JsonKey(includeIfNull: true)
    required JmaIntensity? intensity,
    @JsonKey(includeIfNull: true)
    required JmaLpgmIntensity? lpgmIntensity,
    @JsonKey(includeIfNull: true)
    required num? sva,
    @JsonKey(includeIfNull: true)
    required List<PrePeriods2>? prePeriods,
  }) = _EarthquakeTelegramBodyIntensityStation;
  
  factory EarthquakeTelegramBodyIntensityStation.fromJson(Map<String, Object?> json) => _$EarthquakeTelegramBodyIntensityStationFromJson(json);
}
