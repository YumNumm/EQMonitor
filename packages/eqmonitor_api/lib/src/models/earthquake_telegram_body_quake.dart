// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_datasource.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'origin_time_precision.dart';
import 'telegram_status.dart';

part 'earthquake_telegram_body_quake.freezed.dart';
part 'earthquake_telegram_body_quake.g.dart';

@Freezed()
abstract class EarthquakeTelegramBodyQuake with _$EarthquakeTelegramBodyQuake {
  const factory EarthquakeTelegramBodyQuake({
    @JsonKey(includeIfNull: false)
    String? eventId,
    @JsonKey(includeIfNull: false)
    TelegramStatus? status,
    @JsonKey(includeIfNull: false)
    String? magnitude,
    @JsonKey(includeIfNull: false)
    String? magnitudeCondition,
    @JsonKey(includeIfNull: false)
    JmaIntensity? maxIntensity,
    @JsonKey(includeIfNull: false)
    JmaLpgmIntensity? maxLpgmIntensity,
    @JsonKey(includeIfNull: false)
    num? depth,
    @JsonKey(includeIfNull: false)
    String? latitude,
    @JsonKey(includeIfNull: false)
    String? longitude,
    @JsonKey(includeIfNull: false)
    num? epicenterCode,
    @JsonKey(includeIfNull: false)
    String? epicenterName,
    @JsonKey(includeIfNull: false)
    num? epicenterDetailCode,
    @JsonKey(includeIfNull: false)
    String? epicenterDetailName,
    @JsonKey(includeIfNull: false)
    String? arrivalTime,
    @JsonKey(includeIfNull: false)
    String? originTime,
    @JsonKey(includeIfNull: false)
    OriginTimePrecision? originTimePrecision,
    @JsonKey(includeIfNull: false)
    String? estimatedIntensityKey,
    @JsonKey(includeIfNull: false)
    EarthquakeDatasource? datasource,
  }) = _EarthquakeTelegramBodyQuake;
  
  factory EarthquakeTelegramBodyQuake.fromJson(Map<String, Object?> json) => _$EarthquakeTelegramBodyQuakeFromJson(json);
}
