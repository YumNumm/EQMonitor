// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_station_status.dart';
import 'localized_name.dart';
import 'parameter_location.dart';

part 'earthquake_station.freezed.dart';
part 'earthquake_station.g.dart';

@Freezed()
abstract class EarthquakeStation with _$EarthquakeStation {
  const factory EarthquakeStation({
    required String code,
    @JsonKey(name: 'no_code')
    required String noCode,
    required LocalizedName name,
    @JsonKey(includeIfNull: true)
    required String? kana,
    required EarthquakeStationStatus status,
    @JsonKey(name: 'source_status')
    required String sourceStatus,
    required String owner,
    required ParameterLocation location,
    @JsonKey(includeIfNull: true,name: 'arv_400')
    required num? arv400,
  }) = _EarthquakeStation;
  
  factory EarthquakeStation.fromJson(Map<String, Object?> json) => _$EarthquakeStationFromJson(json);
}
