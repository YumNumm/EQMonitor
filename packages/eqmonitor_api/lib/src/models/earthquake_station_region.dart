// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_station_city.dart';
import 'localized_name.dart';

part 'earthquake_station_region.freezed.dart';
part 'earthquake_station_region.g.dart';

@Freezed()
abstract class EarthquakeStationRegion with _$EarthquakeStationRegion {
  const factory EarthquakeStationRegion({
    required String code,
    required LocalizedName name,
    @JsonKey(includeIfNull: true) required String? kana,
    required List<EarthquakeStationCity> cities,
  }) = _EarthquakeStationRegion;

  factory EarthquakeStationRegion.fromJson(Map<String, Object?> json) =>
      _$EarthquakeStationRegionFromJson(json);
}
