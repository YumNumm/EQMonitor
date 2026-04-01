// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefectures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Prefectures _$PrefecturesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Prefectures', json, ($checkedConvert) {
      final val = _Prefectures(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        intensity: $checkedConvert('intensity', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$PrefecturesToJson(_Prefectures instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'intensity': instance.intensity,
    };
