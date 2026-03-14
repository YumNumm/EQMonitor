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
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
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
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
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

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: 0,
  JmaIntensity.value1: 1,
  JmaIntensity.value2: 2,
  JmaIntensity.value3: 3,
  JmaIntensity.value4: 4,
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: 7,
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: 0,
  JmaLpgmIntensity.value1: 1,
  JmaLpgmIntensity.value2: 2,
  JmaLpgmIntensity.value3: 3,
  JmaLpgmIntensity.value4: 4,
};
