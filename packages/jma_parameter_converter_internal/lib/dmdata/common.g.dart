// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParameterRegionImpl _$$ParameterRegionImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$ParameterRegionImpl', json, ($checkedConvert) {
  final val = _$ParameterRegionImpl(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    kana: $checkedConvert('kana', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$$ParameterRegionImplToJson(
  _$ParameterRegionImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
};

_$ParameterCityImpl _$$ParameterCityImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(r'_$ParameterCityImpl', json, ($checkedConvert) {
      final val = _$ParameterCityImpl(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        kana: $checkedConvert('kana', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$$ParameterCityImplToJson(_$ParameterCityImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
    };
