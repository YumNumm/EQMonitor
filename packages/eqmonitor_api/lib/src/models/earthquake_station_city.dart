// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_station.dart';
import 'localized_name.dart';

part 'earthquake_station_city.freezed.dart';
part 'earthquake_station_city.g.dart';

@Freezed()
abstract class EarthquakeStationCity with _$EarthquakeStationCity {
  const factory EarthquakeStationCity({
    required String code,
    required LocalizedName name,
    @JsonKey(includeIfNull: true)
    required String? kana,
    required List<EarthquakeStation> stations,
  }) = _EarthquakeStationCity;
  
  factory EarthquakeStationCity.fromJson(Map<String, Object?> json) => _$EarthquakeStationCityFromJson(json);
}
