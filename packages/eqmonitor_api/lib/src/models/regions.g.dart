// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'regions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Regions _$RegionsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Regions', json, ($checkedConvert) {
      final val = _Regions(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        intensity: $checkedConvert('intensity', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RegionsToJson(_Regions instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': instance.intensity,
};
