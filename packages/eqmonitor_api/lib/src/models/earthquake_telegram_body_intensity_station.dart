// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_datasource.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'pre_periods2.dart';

part 'earthquake_telegram_body_intensity_station.freezed.dart';
part 'earthquake_telegram_body_intensity_station.g.dart';

@Freezed()
abstract class EarthquakeTelegramBodyIntensityStation with _$EarthquakeTelegramBodyIntensityStation {
  const factory EarthquakeTelegramBodyIntensityStation({
    required String code,
    required String name,
    @JsonKey(includeIfNull: false)
    String? eventId,
    @JsonKey(includeIfNull: false)
    JmaIntensity? intensity,
    @JsonKey(includeIfNull: false)
    JmaLpgmIntensity? lpgmIntensity,
    @JsonKey(includeIfNull: false)
    String? sva,
    @JsonKey(includeIfNull: false)
    List<PrePeriods2>? prePeriods,
    @JsonKey(includeIfNull: false)
    EarthquakeDatasource? datasource,
  }) = _EarthquakeTelegramBodyIntensityStation;
  
  factory EarthquakeTelegramBodyIntensityStation.fromJson(Map<String, Object?> json) => _$EarthquakeTelegramBodyIntensityStationFromJson(json);
}
