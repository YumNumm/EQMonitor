// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'earthquake_station_prefecture.dart';
import 'jma_code_table_parameter_code_tables.dart';
import 'jma_code_table_parameter_metadata.dart';
import 'kyoshin_observation_point.dart';
import 'kyoshin_observation_points_parameter_metadata.dart';
import 'parameter_metadata.dart';
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
  

  factory ParameterDataResponseUnion.fromJson(Map<String, Object?> json) =>
      // TODO: No discriminator in OpenAPI spec - you must implement this manually.
      //
      // Inspect the JSON and return the matching variant. Each variant has a fromJson:
      //   ParameterDataResponseUnionVariantName.fromJson(json)
      //
      // Example pattern (check for unique fields):
      //   json.containsKey('uniqueFieldA') ? ParameterDataResponseUnionTypeA.fromJson(json) :
      //   json.containsKey('uniqueFieldB') ? ParameterDataResponseUnionTypeB.fromJson(json) :
      //   ParameterDataResponseUnionDefault.fromJson(json);
      //
      // IMPORTANT: Keep the => arrow syntax. Converting to a { } body will cause
      // freezed to skip generating toJson/fromJson for this class.
      throw UnimplementedError();

}
