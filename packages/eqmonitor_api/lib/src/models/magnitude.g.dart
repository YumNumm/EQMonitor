// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'magnitude.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Magnitude _$MagnitudeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Magnitude', json, ($checkedConvert) {
      final val = _Magnitude(
        type: $checkedConvert('type', (v) => $enumDecode(_$Type3EnumMap, v)),
        value: $checkedConvert('value', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$MagnitudeToJson(_Magnitude instance) =>
    <String, dynamic>{'type': instance.type, 'value': ?instance.value};

const _$Type3EnumMap = {
  Type3.normal: 'NORMAL',
  Type3.unknown: 'UNKNOWN',
  Type3.overM8: 'OVER_M8',
};
