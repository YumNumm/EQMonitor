// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Points _$PointsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Points',
  json,
  ($checkedConvert) {
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
      prefectureCode: $checkedConvert('prefecture_code', (v) => v as String?),
      regionCode: $checkedConvert('region_code', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      intensityDiff: $checkedConvert('intensityDiff', (v) => v as num? ?? 0),
    );
    return val;
  },
  fieldKeyMap: const {
    'prefectureCode': 'prefecture_code',
    'regionCode': 'region_code',
    'cityCode': 'city_code',
  },
);

Map<String, dynamic> _$PointsToJson(_Points instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensity': instance.intensity,
  'prefecture_code': instance.prefectureCode,
  'region_code': instance.regionCode,
  'city_code': instance.cityCode,
  'intensityDiff': instance.intensityDiff,
};
