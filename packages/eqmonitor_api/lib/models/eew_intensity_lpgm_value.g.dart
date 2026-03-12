// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_lpgm_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensityLpgmValue _$EewIntensityLpgmValueFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewIntensityLpgmValue', json, ($checkedConvert) {
  final val = _EewIntensityLpgmValue(
    value: $checkedConvert(
      'value',
      (v) => $enumDecode(_$LpgmIntensityEnumMap, v),
    ),
    isOver: $checkedConvert('is_over', (v) => v as bool),
  );
  return val;
}, fieldKeyMap: const {'isOver': 'is_over'});

Map<String, dynamic> _$EewIntensityLpgmValueToJson(
  _EewIntensityLpgmValue instance,
) => <String, dynamic>{'value': instance.value, 'is_over': instance.isOver};

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
