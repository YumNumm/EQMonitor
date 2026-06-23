// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_datasource.dart';
import 'earthquake_telegram_type.dart';
import 'earthquake_type.dart';
import 'hypocenter.dart';
import 'intensity_partial.dart';
import 'origin_time_precision.dart';
import 'telegram_status.dart';

part 'earthquake_partial.freezed.dart';
part 'earthquake_partial.g.dart';

@Freezed()
abstract class EarthquakePartial with _$EarthquakePartial {
  const factory EarthquakePartial({
    /// yyyyMMddHHmmss形式のイベントID
    @JsonKey(name: 'event_id') required String eventId,
    required TelegramStatus status,
    @JsonKey(name: 'origin_time_precision')
    required OriginTimePrecision originTimePrecision,
    required EarthquakeDatasource datasource,

    /// この地震イベントに紐づく電文タイプの配列
    @JsonKey(name: 'telegram_types')
    required List<EarthquakeTelegramType> telegramTypes,
    @JsonKey(name: 'earthquake_type') required EarthquakeType earthquakeType,
    @JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
    @JsonKey(includeIfNull: false) Hypocenter? hypocenter,

    /// 推計震度PMTilesのフルURL
    @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')
    String? estimatedIntensityTile,
    @JsonKey(includeIfNull: false) IntensityPartial? intensity,
  }) = _EarthquakePartial;

  factory EarthquakePartial.fromJson(Map<String, Object?> json) =>
      _$EarthquakePartialFromJson(json);
}
