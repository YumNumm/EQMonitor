// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'points2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Points2 _$Points2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Points2', json, ($checkedConvert) {
      final val = _Points2(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        region: $checkedConvert('region', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => Location2.fromJson(v as Map<String, dynamic>),
        ),
        intensity: $checkedConvert('intensity', (v) => v as num?),
        intensityDiff: $checkedConvert('intensityDiff', (v) => v as num? ?? 0),
      );
      return val;
    });

Map<String, dynamic> _$Points2ToJson(_Points2 instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensity': instance.intensity,
  'intensityDiff': instance.intensityDiff,
};
