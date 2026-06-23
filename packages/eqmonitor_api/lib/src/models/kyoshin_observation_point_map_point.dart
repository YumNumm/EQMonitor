// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'parameter_point.dart';

part 'kyoshin_observation_point_map_point.freezed.dart';
part 'kyoshin_observation_point_map_point.g.dart';

@Freezed()
abstract class KyoshinObservationPointMapPoint
    with _$KyoshinObservationPointMapPoint {
  const factory KyoshinObservationPointMapPoint({
    required ParameterPoint center,
    required ParameterPoint offset,
  }) = _KyoshinObservationPointMapPoint;

  factory KyoshinObservationPointMapPoint.fromJson(Map<String, Object?> json) =>
      _$KyoshinObservationPointMapPointFromJson(json);
}
