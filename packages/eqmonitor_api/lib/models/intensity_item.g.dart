// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityItem _$IntensityItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityItem',
      json,
      ($checkedConvert) {
        final val = _IntensityItem(
          value: $checkedConvert(
            'value',
            (v) => CodeName.fromJson(v as Map<String, dynamic>),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => v == null
                ? null
                : Intensity.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$IntensityItemToJson(_IntensityItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'max_intensity': ?instance.maxIntensity,
      'max_lpgm_intensity': ?instance.maxLpgmIntensity,
    };

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
