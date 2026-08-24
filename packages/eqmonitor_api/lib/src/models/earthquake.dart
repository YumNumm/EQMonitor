// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog.dart';
import 'earthquake_datasource.dart';
import 'earthquake_hypocenters_union.dart';
import 'earthquake_telegram.dart';
import 'earthquake_type.dart';
import 'hypocenter.dart';
import 'intensity.dart';
import 'origin_time_precision.dart';
import 'telegram_status.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@Freezed()
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    /// yyyyMMddHHmmss形式のイベントID
    @JsonKey(name: 'event_id')
    required String eventId,
    required TelegramStatus status,
    @JsonKey(name: 'earthquake_type')
    required EarthquakeType earthquakeType,
    @JsonKey(name: 'origin_time_precision')
    required OriginTimePrecision originTimePrecision,
    required List<EarthquakeHypocentersUnion> hypocenters,

    /// 地震データのソースの配列
    required List<EarthquakeDatasource> datasources,
    required List<EarthquakeTelegram> telegrams,
    @JsonKey(includeIfNull: false,name: 'origin_time')
    DateTime? originTime,
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
    @JsonKey(includeIfNull: false)
    Hypocenter? hypocenter,
    @JsonKey(includeIfNull: false)
    Intensity? intensity,

    /// 推計震度PMTilesのフルURL
    @JsonKey(includeIfNull: false,name: 'estimated_intensity_tile')
    String? estimatedIntensityTile,
    @JsonKey(includeIfNull: false)
    Catalog? catalog,
  }) = _Earthquake;
  
  factory Earthquake.fromJson(Map<String, Object?> json) => _$EarthquakeFromJson(json);
}
