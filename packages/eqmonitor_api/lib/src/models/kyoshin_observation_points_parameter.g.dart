// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_observation_points_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinObservationPointsParameter _$KyoshinObservationPointsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinObservationPointsParameter', json, (
  $checkedConvert,
) {
  final val = _KyoshinObservationPointsParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => KyoshinObservationPointsParameterMetadata.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map(
            (e) => KyoshinObservationPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$KyoshinObservationPointsParameterToJson(
  _KyoshinObservationPointsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'points': instance.points,
};
