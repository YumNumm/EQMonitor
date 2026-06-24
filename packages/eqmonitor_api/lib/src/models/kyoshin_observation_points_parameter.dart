// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'kyoshin_observation_point.dart';
import 'kyoshin_observation_points_parameter_metadata.dart';

part 'kyoshin_observation_points_parameter.freezed.dart';
part 'kyoshin_observation_points_parameter.g.dart';

@Freezed()
abstract class KyoshinObservationPointsParameter with _$KyoshinObservationPointsParameter {
  const factory KyoshinObservationPointsParameter({
    required KyoshinObservationPointsParameterMetadata metadata,
    required List<KyoshinObservationPoint> points,
  }) = _KyoshinObservationPointsParameter;
  
  factory KyoshinObservationPointsParameter.fromJson(Map<String, Object?> json) => _$KyoshinObservationPointsParameterFromJson(json);
}
