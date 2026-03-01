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
        (v) => $enumDecode(_$MaxIntensityEnumMap, v),
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
        (v) => $enumDecodeNullable(_$MaxLpgmIntensityEnumMap, v),
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

const _$MaxIntensityEnumMap = {
  MaxIntensity.value0: 0,
  MaxIntensity.value1: 1,
  MaxIntensity.value2: 2,
  MaxIntensity.value3: 3,
  MaxIntensity.value4: 4,
  MaxIntensity.value5unknown: '!5-',
  MaxIntensity.value5minus: '5-',
  MaxIntensity.value5plus: '5+',
  MaxIntensity.value6minus: '6-',
  MaxIntensity.value6plus: '6+',
  MaxIntensity.value7: 7,
};

const _$MaxLpgmIntensityEnumMap = {
  MaxLpgmIntensity.value0: 0,
  MaxLpgmIntensity.value1: 1,
  MaxLpgmIntensity.value2: 2,
  MaxLpgmIntensity.value3: 3,
  MaxLpgmIntensity.value4: 4,
};
