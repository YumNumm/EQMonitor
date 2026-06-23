// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_telegram_body_intensity_region.dart';
import 'earthquake_telegram_body_intensity_station.dart';
import 'earthquake_telegram_body_quake.dart';

part 'earthquake_telegram_body.freezed.dart';
part 'earthquake_telegram_body.g.dart';

@Freezed()
abstract class EarthquakeTelegramBody with _$EarthquakeTelegramBody {
  const factory EarthquakeTelegramBody({
    required dynamic type,
    @JsonKey(includeIfNull: false) EarthquakeTelegramBodyQuake? earthquake,
    @JsonKey(includeIfNull: false)
    List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions,
    @JsonKey(includeIfNull: false)
    List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures,
    @JsonKey(includeIfNull: false)
    List<EarthquakeTelegramBodyIntensityRegion>? intensityCities,
    @JsonKey(includeIfNull: false)
    List<EarthquakeTelegramBodyIntensityStation>? intensityStations,
  }) = _EarthquakeTelegramBody;

  factory EarthquakeTelegramBody.fromJson(Map<String, Object?> json) =>
      _$EarthquakeTelegramBodyFromJson(json);
}
