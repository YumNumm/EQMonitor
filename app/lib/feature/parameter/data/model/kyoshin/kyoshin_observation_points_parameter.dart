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
  const factory KyoshinObservationPoint({
    required KyoshinObservationPointType type,
    @JsonKey(name: 'source_type') required String sourceType,
    required String name,
    required String code,
    @JsonKey(name: 'prefecture_code') required String? prefectureCode,
    @JsonKey(name: 'region_code') required String? regionCode,
    @JsonKey(name: 'is_suspended') required bool isSuspended,
    required LatLng location,
    required KyoshinObservationPointMapPoint? point,
    @JsonKey(name: 'arv_400') required double? arv400,
  }) = _KyoshinObservationPoint;

  factory KyoshinObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$KyoshinObservationPointFromJson(json);
}

@JsonEnum()
enum KyoshinObservationPointType {
  @JsonValue('K_NET')
  kNet,
  @JsonValue('KIK_NET')
  kikNet,
  @JsonValue('UNKNOWN')
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
