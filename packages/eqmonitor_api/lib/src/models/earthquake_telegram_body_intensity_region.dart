// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_datasource.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';

part 'earthquake_telegram_body_intensity_region.freezed.dart';
part 'earthquake_telegram_body_intensity_region.g.dart';

@Freezed()
abstract class EarthquakeTelegramBodyIntensityRegion
    with _$EarthquakeTelegramBodyIntensityRegion {
  const factory EarthquakeTelegramBodyIntensityRegion({
    required String code,
    required String name,
    @JsonKey(includeIfNull: false) String? eventId,
    @JsonKey(includeIfNull: false) JmaIntensity? intensity,
    @JsonKey(includeIfNull: false) JmaLpgmIntensity? lpgmIntensity,
    @JsonKey(includeIfNull: false) EarthquakeDatasource? datasource,
  }) = _EarthquakeTelegramBodyIntensityRegion;

  factory EarthquakeTelegramBodyIntensityRegion.fromJson(
    Map<String, Object?> json,
  ) => _$EarthquakeTelegramBodyIntensityRegionFromJson(json);
}
