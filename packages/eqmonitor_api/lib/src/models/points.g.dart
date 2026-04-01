// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Points _$PointsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Points', json, ($checkedConvert) {
      final val = _Points(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        region: $checkedConvert('region', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => Location.fromJson(v as Map<String, dynamic>),
        ),
        intensity: $checkedConvert('intensity', (v) => v as num?),
        intensityDiff: $checkedConvert('intensityDiff', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$PointsToJson(_Points instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensity': instance.intensity,
  'intensityDiff': instance.intensityDiff,
};
