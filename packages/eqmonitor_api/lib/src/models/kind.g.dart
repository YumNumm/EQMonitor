// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Kind _$KindFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Kind', json, ($checkedConvert) {
      final val = _Kind(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$KindToJson(_Kind instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
