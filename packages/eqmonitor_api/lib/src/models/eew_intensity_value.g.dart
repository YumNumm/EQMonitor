// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensityValue _$EewIntensityValueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewIntensityValue', json, ($checkedConvert) {
      final val = _EewIntensityValue(
        value: $checkedConvert(
          'value',
          (v) => $enumDecode(_$JmaIntensityEnumMap, v),
        ),
        isOver: $checkedConvert('is_over', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'isOver': 'is_over'});

Map<String, dynamic> _$EewIntensityValueToJson(_EewIntensityValue instance) =>
    <String, dynamic>{'value': instance.value, 'is_over': instance.isOver};

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
