// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

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
    /// const: "EARTHQUAKE"
    required String type,
    @JsonKey(includeIfNull: false)
    EarthquakeTelegramBodyQuake? earthquake,
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
    /// const: "EEW"
    required String type,
    required Object? eew,
    required List<Object?> eewIntensityRegions,
    required List<Object?> eewWarningZones,
    required List<Object?> eewWarningPrefectures,
    required List<Object?> eewWarningRegions,
  }) = TelegramBodyUnionEewTelegramBody;
  
  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeNoticeTelegramBody({
    /// const: "EARTHQUAKE_NOTICE"
    required String type,
  }) = TelegramBodyUnionEarthquakeNoticeTelegramBody;
  
  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeExplanationTelegramBody({
    /// const: "EARTHQUAKE_EXPLANATION"
    required String type,
    required String text,
  }) = TelegramBodyUnionEarthquakeExplanationTelegramBody;
  
  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeCountsTelegramBody({
    /// const: "EARTHQUAKE_COUNTS"
    required String type,
  }) = TelegramBodyUnionEarthquakeCountsTelegramBody;
  
  @JsonSerializable()
  const factory TelegramBodyUnion.earthquakeNankaiTelegramBody({
    /// const: "EARTHQUAKE_NANKAI"
    required String type,
  }) = TelegramBodyUnionEarthquakeNankaiTelegramBody;
  
  @JsonSerializable()
  const factory TelegramBodyUnion.fallbackTelegramBody({
    required String type,
  }) = TelegramBodyUnionFallbackTelegramBody;
  

  factory TelegramBodyUnion.fromJson(Map<String, Object?> json) =>
      switch (json['type']) {
        'EARTHQUAKE' =>
          TelegramBodyUnionEarthquakeTelegramBody.fromJson(json),
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
