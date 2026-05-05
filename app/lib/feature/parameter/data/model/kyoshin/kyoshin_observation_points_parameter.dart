import 'dart:math';

import 'package:eqmonitor/feature/parameter/data/model/common/parameter_json_converters.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'kyoshin_observation_points_parameter.freezed.dart';
part 'kyoshin_observation_points_parameter.g.dart';

@freezed
abstract class KyoshinObservationPointsParameter
    with _$KyoshinObservationPointsParameter {
  const factory KyoshinObservationPointsParameter({
    required ParameterMetadata metadata,
    required List<KyoshinObservationPoint> points,
  }) = _KyoshinObservationPointsParameter;

  factory KyoshinObservationPointsParameter.fromJson(
    Map<String, dynamic> json,
  ) => _$KyoshinObservationPointsParameterFromJson(json);
}

@freezed
abstract class KyoshinObservationPoint with _$KyoshinObservationPoint {
  @JsonSerializable(fieldRename: .snake)
  const factory KyoshinObservationPoint({
    required KyoshinObservationPointType type,
    required String sourceType,
    required String name,
    required String code,
    required String? prefectureCode,
    required String? regionCode,
    required bool isSuspended,
    required LatLng location,
    required KyoshinObservationPointMapPoint? point,
    required double? arv400,
  }) = _KyoshinObservationPoint;

  factory KyoshinObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$KyoshinObservationPointFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum KyoshinObservationPointType {
  kNet,
  kikNet,
  unknown,
}

@freezed
abstract class KyoshinObservationPointMapPoint
    with _$KyoshinObservationPointMapPoint {
  const factory KyoshinObservationPointMapPoint({
    @ParameterPointConverter() required Point<double> center,
    @ParameterPointConverter() required Point<double> offset,
  }) = _KyoshinObservationPointMapPoint;

  factory KyoshinObservationPointMapPoint.fromJson(
    Map<String, dynamic> json,
  ) => _$KyoshinObservationPointMapPointFromJson(json);
}
