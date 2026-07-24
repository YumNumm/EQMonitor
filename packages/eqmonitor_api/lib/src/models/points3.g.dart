// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'points3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Points3 _$Points3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Points3', json, ($checkedConvert) {
      final val = _Points3(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        region: $checkedConvert('region', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => Location3.fromJson(v as Map<String, dynamic>),
        ),
        intensity: $checkedConvert('intensity', (v) => v as num?),
        intensityDiff: $checkedConvert('intensityDiff', (v) => v as num? ?? 0),
      );
      return val;
    });

Map<String, dynamic> _$Points3ToJson(_Points3 instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensity': instance.intensity,
  'intensityDiff': instance.intensityDiff,
};
