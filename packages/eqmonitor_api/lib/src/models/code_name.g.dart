// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'code_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CodeName _$CodeNameFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CodeName', json, ($checkedConvert) {
      final val = _CodeName(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CodeNameToJson(_CodeName instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
