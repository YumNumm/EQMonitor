// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'epicenter_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpicenterInfo _$EpicenterInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EpicenterInfo', json, ($checkedConvert) {
      final val = _EpicenterInfo(
        code: $checkedConvert('code', (v) => v as num),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EpicenterInfoToJson(_EpicenterInfo instance) =>
    <String, dynamic>{'code': instance.code, 'name': instance.name};
