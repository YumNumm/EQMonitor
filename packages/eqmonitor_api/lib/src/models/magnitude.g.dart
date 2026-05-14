// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'magnitude.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Magnitude _$MagnitudeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Magnitude', json, ($checkedConvert) {
      final val = _Magnitude(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$MagnitudeTypeEnumMap, v),
        ),
        value: $checkedConvert('value', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$MagnitudeToJson(_Magnitude instance) =>
    <String, dynamic>{'type': instance.type, 'value': ?instance.value};

const _$MagnitudeTypeEnumMap = {
  MagnitudeType.normal: 'NORMAL',
  MagnitudeType.unknown: 'UNKNOWN',
  MagnitudeType.overM8: 'OVER_M8',
};
