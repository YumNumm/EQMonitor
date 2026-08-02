// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'earthquake_station_prefecture.dart';
import 'jma_code_table_parameter_code_tables.dart';
import 'jma_code_table_parameter_metadata.dart';
import 'kyoshin_observation_point.dart';
import 'kyoshin_observation_points_parameter_metadata.dart';
import 'parameter_metadata.dart';
import 'shindo_db_station.dart';
import 'shindo_db_stations_parameter_metadata.dart';
import 'tsunami_station_prefecture.dart';
import 'tsunami_stations_parameter_metadata.dart';

part 'parameter_data_response_union.freezed.dart';
part 'parameter_data_response_union.g.dart';

@Freezed()
sealed class ParameterDataResponseUnion with _$ParameterDataResponseUnion {
  @JsonSerializable()
  const factory ParameterDataResponseUnion.jmaCodeTableParameter({
    required JmaCodeTableParameterMetadata metadata,
    @JsonKey(name: 'code_tables')
    required JmaCodeTableParameterCodeTables codeTables,
  }) = ParameterDataResponseUnionJmaCodeTableParameter;

  @JsonSerializable()
  const factory ParameterDataResponseUnion.kyoshinObservationPointsParameter({
    required KyoshinObservationPointsParameterMetadata metadata,
    required List<KyoshinObservationPoint> points,
  }) = ParameterDataResponseUnionKyoshinObservationPointsParameter;

  @JsonSerializable()
  const factory ParameterDataResponseUnion.earthquakeStationsParameter({
    required ParameterMetadata metadata,
    required List<EarthquakeStationPrefecture> prefectures,
  }) = ParameterDataResponseUnionEarthquakeStationsParameter;

  @JsonSerializable()
  const factory ParameterDataResponseUnion.tsunamiStationsParameter({
    required TsunamiStationsParameterMetadata metadata,
    required List<TsunamiStationPrefecture> prefectures,
  }) = ParameterDataResponseUnionTsunamiStationsParameter;

  @JsonSerializable()
  const factory ParameterDataResponseUnion.shindoDbStationsParameter({
    required ShindoDbStationsParameterMetadata metadata,
    required List<ShindoDbStation> stations,
  }) = ParameterDataResponseUnionShindoDbStationsParameter;


  factory ParameterDataResponseUnion.fromJson(Map<String, Object?> json) =>
      switch ((json['metadata'] as Map<String, Object?>?)?['type']) {
        'JMA_CODE_TABLE' =>
          ParameterDataResponseUnionJmaCodeTableParameter.fromJson(json),
        'KYOSHIN_OBSERVATION_POINTS' =>
          ParameterDataResponseUnionKyoshinObservationPointsParameter.fromJson(
            json,
          ),
        'EARTHQUAKE_STATIONS' =>
          ParameterDataResponseUnionEarthquakeStationsParameter.fromJson(json),
        'TSUNAMI_STATIONS' =>
          ParameterDataResponseUnionTsunamiStationsParameter.fromJson(json),
        'SHINDO_DB_STATIONS' =>
          ParameterDataResponseUnionShindoDbStationsParameter.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'metadata.type',
          'Unknown ParameterDataResponseUnion type',
        ),
      };

}
