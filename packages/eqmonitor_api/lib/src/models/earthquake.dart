// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_datasource.dart';
import 'event_id.dart';
import 'hypocenter.dart';
import 'intensity.dart';
import 'intensity_map_image_group.dart';
import 'intensity_map_image_url.dart';
import 'origin_time_precision.dart';
import 'telegram_status.dart';
import 'telegrams.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@Freezed()
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    @JsonKey(name: 'event_id') required EventId eventId,
    required TelegramStatus status,
    @JsonKey(name: 'origin_time_precision')
    required OriginTimePrecision originTimePrecision,
    required EarthquakeDatasource datasource,
    required List<Telegrams> telegrams,
    @JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
    @JsonKey(includeIfNull: false) Hypocenter? hypocenter,
    @JsonKey(includeIfNull: false) Intensity? intensity,

    /// 推計震度PMTilesのフルURL
    @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')
    String? estimatedIntensityTile,
    @JsonKey(includeIfNull: false, name: 'intensity_map_image')
    IntensityMapImageUrl? intensityMapImage,
    @JsonKey(includeIfNull: false, name: 'intensity_map_images')
    List<IntensityMapImageGroup>? intensityMapImages,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, Object?> json) =>
      _$EarthquakeFromJson(json);
}
