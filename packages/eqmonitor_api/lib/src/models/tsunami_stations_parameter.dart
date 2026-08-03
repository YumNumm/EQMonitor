// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_station_prefecture.dart';
import 'tsunami_stations_parameter_metadata.dart';

part 'tsunami_stations_parameter.freezed.dart';
part 'tsunami_stations_parameter.g.dart';

@Freezed()
abstract class TsunamiStationsParameter with _$TsunamiStationsParameter {
  const factory TsunamiStationsParameter({
    required TsunamiStationsParameterMetadata metadata,
    required List<TsunamiStationPrefecture> prefectures,
  }) = _TsunamiStationsParameter;

  factory TsunamiStationsParameter.fromJson(Map<String, Object?> json) => _$TsunamiStationsParameterFromJson(json);
}
