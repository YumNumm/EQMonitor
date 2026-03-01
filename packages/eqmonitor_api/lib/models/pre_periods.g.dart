// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pre_periods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrePeriods _$PrePeriodsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PrePeriods', json, ($checkedConvert) {
      final val = _PrePeriods(
        band: $checkedConvert('band', (v) => v as num),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecode(_$LpgmIntensityEnumMap, v),
        ),
        sva: $checkedConvert('sva', (v) => v as num),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$PrePeriodsToJson(_PrePeriods instance) =>
    <String, dynamic>{
      'band': instance.band,
      'lpgm_intensity': instance.lpgmIntensity,
      'sva': instance.sva,
    };

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
