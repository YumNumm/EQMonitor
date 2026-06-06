// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pre_periods2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrePeriods2 _$PrePeriods2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PrePeriods2', json, ($checkedConvert) {
      final val = _PrePeriods2(
        band: $checkedConvert('band', (v) => v as num),
        sva: $checkedConvert('sva', (v) => v as num?),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$PrePeriods2ToJson(_PrePeriods2 instance) =>
    <String, dynamic>{
      'band': instance.band,
      'sva': instance.sva,
      'lpgm_intensity': instance.lpgmIntensity,
    };

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};
