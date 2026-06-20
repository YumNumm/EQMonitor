// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_partial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityPartial _$IntensityPartialFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityPartial',
      json,
      ($checkedConvert) {
        final val = _IntensityPartial(
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => $enumDecode(_$JmaIntensityEnumMap, v),
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

Map<String, dynamic> _$IntensityPartialToJson(_IntensityPartial instance) =>
    <String, dynamic>{
      'max_intensity': instance.maxIntensity,
      'max_lpgm_intensity': ?instance.maxLpgmIntensity,
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6unknown: '!6-',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};
