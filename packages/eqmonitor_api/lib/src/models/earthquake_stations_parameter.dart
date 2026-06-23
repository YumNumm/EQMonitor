// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_station_prefecture.dart';
import 'parameter_metadata.dart';

part 'earthquake_stations_parameter.freezed.dart';
part 'earthquake_stations_parameter.g.dart';

@Freezed()
abstract class EarthquakeStationsParameter with _$EarthquakeStationsParameter {
  const factory EarthquakeStationsParameter({
    required ParameterMetadata metadata,
    required List<EarthquakeStationPrefecture> prefectures,
  }) = _EarthquakeStationsParameter;

  factory EarthquakeStationsParameter.fromJson(Map<String, Object?> json) =>
      _$EarthquakeStationsParameterFromJson(json);
}
