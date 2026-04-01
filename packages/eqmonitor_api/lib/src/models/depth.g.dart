// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'depth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Depth _$DepthFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Depth',
  json,
  ($checkedConvert) {
    final val = _Depth(
      type: $checkedConvert('type', (v) => $enumDecode(_$DepthTypeEnumMap, v)),
      value: $checkedConvert('value', (v) => v as num?),
    );
    return val;
  },
);

Map<String, dynamic> _$DepthToJson(_Depth instance) => <String, dynamic>{
  'type': instance.type,
  'value': ?instance.value,
};

const _$DepthTypeEnumMap = {
  DepthType.shallow: 'SHALLOW',
  DepthType.normal: 'NORMAL',
  DepthType.over700: 'OVER_700',
  DepthType.unknown: 'UNKNOWN',
};
