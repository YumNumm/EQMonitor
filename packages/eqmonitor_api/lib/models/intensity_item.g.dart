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
            (v) => $enumDecodeNullable(_$IntensityItemMaxIntensityEnumMap, v),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) =>
                $enumDecodeNullable(_$IntensityItemMaxLpgmIntensityEnumMap, v),
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

const _$IntensityItemMaxIntensityEnumMap = {
  IntensityItemMaxIntensity.value0: 0,
  IntensityItemMaxIntensity.value1: 1,
  IntensityItemMaxIntensity.value2: 2,
  IntensityItemMaxIntensity.value3: 3,
  IntensityItemMaxIntensity.value4: 4,
  IntensityItemMaxIntensity.undefined0: '!5-',
  IntensityItemMaxIntensity.value5: '5-',
  IntensityItemMaxIntensity.value5: '5+',
  IntensityItemMaxIntensity.value6: '6-',
  IntensityItemMaxIntensity.value6: '6+',
  IntensityItemMaxIntensity.value7: 7,
};

const _$IntensityItemMaxLpgmIntensityEnumMap = {
  IntensityItemMaxLpgmIntensity.value0: 0,
  IntensityItemMaxLpgmIntensity.value1: 1,
  IntensityItemMaxLpgmIntensity.value2: 2,
  IntensityItemMaxLpgmIntensity.value3: 3,
  IntensityItemMaxLpgmIntensity.value4: 4,
};
