// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Intensity _$IntensityFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Intensity',
  json,
  ($checkedConvert) {
    final val = _Intensity(
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => Intensity.fromJson(v as Map<String, dynamic>),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>)
            .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as List<dynamic>)
            .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
  },
);

Map<String, dynamic> _$IntensityToJson(_Intensity instance) =>
    <String, dynamic>{
      'max_intensity': instance.maxIntensity,
      'prefectures': instance.prefectures,
      'regions': instance.regions,
      'max_lpgm_intensity': ?instance.maxLpgmIntensity,
    };

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
