// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'earthquake_telegram_body_intensity_region.dart';
import 'earthquake_telegram_body_intensity_station.dart';
import 'earthquake_telegram_body_quake.dart';

part 'telegram_body_union.freezed.dart';
part 'telegram_body_union.g.dart';

@Freezed()
sealed class TelegramBodyUnion with _$TelegramBodyUnion {
  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeTelegramBody({
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
  }) = TelegramBodyUnionEarthquakeTelegramBody;

  @JsonSerializable()
  const factory TelegramBodyUnion.eewTelegramBody({
    required dynamic type,
    required dynamic eew,
    required List<dynamic> eewIntensityRegions,
    required List<dynamic> eewWarningZones,
    required List<dynamic> eewWarningPrefectures,
    required List<dynamic> eewWarningRegions,
  }) = TelegramBodyUnionEewTelegramBody;

  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeNoticeTelegramBody({
    required dynamic type,
  }) = TelegramBodyUnionEarthquakeNoticeTelegramBody;

  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeExplanationTelegramBody({
    required dynamic type,
    required String text,
  }) = TelegramBodyUnionEarthquakeExplanationTelegramBody;

  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeCountsTelegramBody({
    required dynamic type,
  }) = TelegramBodyUnionEarthquakeCountsTelegramBody;

  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeNankaiTelegramBody({
    required dynamic type,
  }) = TelegramBodyUnionEarthquakeNankaiTelegramBody;

  factory TelegramBodyUnion.fromJson(Map<String, Object?> json) =>
      switch (json['type']) {
        'EARTHQUAKE' => TelegramBodyUnionEarthquakeTelegramBody.fromJson(json),
        'EEW' => TelegramBodyUnionEewTelegramBody.fromJson(json),
        'EARTHQUAKE_NOTICE' =>
          TelegramBodyUnionEarthquakeNoticeTelegramBody.fromJson(json),
        'EARTHQUAKE_EXPLANATION' =>
          TelegramBodyUnionEarthquakeExplanationTelegramBody.fromJson(json),
        'EARTHQUAKE_COUNTS' =>
          TelegramBodyUnionEarthquakeCountsTelegramBody.fromJson(json),
        'EARTHQUAKE_NANKAI' =>
          TelegramBodyUnionEarthquakeNankaiTelegramBody.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown TelegramBodyUnion type',
        ),
      };
}
