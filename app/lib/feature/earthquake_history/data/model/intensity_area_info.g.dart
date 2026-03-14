// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_area_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityAreaInfo _$IntensityAreaInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_IntensityAreaInfo', json, ($checkedConvert) {
      final val = _IntensityAreaInfo(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        intensity: $checkedConvert(
          'intensity',
          (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
        ),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$IntensityAreaInfoToJson(_IntensityAreaInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'intensity': _$JmaIntensityEnumMap[instance.intensity],
      'lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.lpgmIntensity],
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};
