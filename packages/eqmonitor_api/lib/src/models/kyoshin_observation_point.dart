// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'kyoshin_observation_point_map_point.dart';
import 'kyoshin_observation_point_type.dart';
import 'parameter_location.dart';

part 'kyoshin_observation_point.freezed.dart';
part 'kyoshin_observation_point.g.dart';

@Freezed()
abstract class KyoshinObservationPoint with _$KyoshinObservationPoint {
  const factory KyoshinObservationPoint({
    required KyoshinObservationPointType type,
    @JsonKey(name: 'source_type') required String sourceType,
    required String name,
    required String code,
    @JsonKey(includeIfNull: true, name: 'prefecture_code')
    required String? prefectureCode,
    @JsonKey(includeIfNull: true, name: 'region_code')
    required String? regionCode,
    @JsonKey(name: 'is_suspended') required bool isSuspended,
    required ParameterLocation location,
    @JsonKey(includeIfNull: true)
    required KyoshinObservationPointMapPoint? point,
    @JsonKey(includeIfNull: true, name: 'arv_400') required num? arv400,
  }) = _KyoshinObservationPoint;

  factory KyoshinObservationPoint.fromJson(Map<String, Object?> json) =>
      _$KyoshinObservationPointFromJson(json);
}
