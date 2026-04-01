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

part 'earthquake_partial.freezed.dart';
part 'earthquake_partial.g.dart';

@Freezed()
abstract class EarthquakePartial with _$EarthquakePartial {
  const factory EarthquakePartial({
    @JsonKey(name: 'event_id') required EventId eventId,
    required TelegramStatus status,
    @JsonKey(name: 'origin_time_precision')
    required OriginTimePrecision originTimePrecision,
    required EarthquakeDatasource datasource,
    @JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
    @JsonKey(includeIfNull: false) Hypocenter? hypocenter,

    /// 推計震度PMTilesのフルURL
    @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')
    String? estimatedIntensityTile,
    @JsonKey(includeIfNull: false, name: 'intensity_map_image')
    IntensityMapImageUrl? intensityMapImage,
    @JsonKey(includeIfNull: false, name: 'intensity_map_images')
    List<IntensityMapImageGroup>? intensityMapImages,
    @JsonKey(includeIfNull: false) Intensity? intensity,
  }) = _EarthquakePartial;

  factory EarthquakePartial.fromJson(Map<String, Object?> json) =>
      _$EarthquakePartialFromJson(json);
}
