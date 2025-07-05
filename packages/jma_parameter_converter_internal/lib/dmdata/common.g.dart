// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterRegion _$ParameterRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterRegion', json, ($checkedConvert) {
      final val = _ParameterRegion(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        kana: $checkedConvert('kana', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ParameterRegionToJson(_ParameterRegion instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
    };

_ParameterCity _$ParameterCityFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterCity', json, ($checkedConvert) {
      final val = _ParameterCity(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        kana: $checkedConvert('kana', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ParameterCityToJson(_ParameterCity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
    };
