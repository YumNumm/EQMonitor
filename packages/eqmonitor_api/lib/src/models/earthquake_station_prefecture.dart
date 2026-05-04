// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_station_region.dart';
import 'localized_name.dart';

part 'earthquake_station_prefecture.freezed.dart';
part 'earthquake_station_prefecture.g.dart';

@Freezed()
abstract class EarthquakeStationPrefecture with _$EarthquakeStationPrefecture {
  const factory EarthquakeStationPrefecture({
    required String code,
    required LocalizedName name,
    required List<EarthquakeStationRegion> regions,
  }) = _EarthquakeStationPrefecture;
  
  factory EarthquakeStationPrefecture.fromJson(Map<String, Object?> json) => _$EarthquakeStationPrefectureFromJson(json);
}
