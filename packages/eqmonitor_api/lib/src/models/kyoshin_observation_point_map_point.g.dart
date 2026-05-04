// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_observation_point_map_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinObservationPointMapPoint _$KyoshinObservationPointMapPointFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_KyoshinObservationPointMapPoint', json, ($checkedConvert) {
      final val = _KyoshinObservationPointMapPoint(
        center: $checkedConvert(
          'center',
          (v) => ParameterPoint.fromJson(v as Map<String, dynamic>),
        ),
        offset: $checkedConvert(
          'offset',
          (v) => ParameterPoint.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$KyoshinObservationPointMapPointToJson(
  _KyoshinObservationPointMapPoint instance,
) => <String, dynamic>{'center': instance.center, 'offset': instance.offset};
