// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shindo_db_station.dart';
import 'shindo_db_stations_parameter_metadata.dart';

part 'shindo_db_stations_parameter.freezed.dart';
part 'shindo_db_stations_parameter.g.dart';

@Freezed()
abstract class ShindoDbStationsParameter with _$ShindoDbStationsParameter {
  const factory ShindoDbStationsParameter({
    required ShindoDbStationsParameterMetadata metadata,
    required List<ShindoDbStation> stations,
  }) = _ShindoDbStationsParameter;
  
  factory ShindoDbStationsParameter.fromJson(Map<String, Object?> json) => _$ShindoDbStationsParameterFromJson(json);
}
