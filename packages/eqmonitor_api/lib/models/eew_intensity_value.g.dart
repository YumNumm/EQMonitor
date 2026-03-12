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
          (v) => Intensity.fromJson(v as Map<String, dynamic>),
        ),
        isOver: $checkedConvert('is_over', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'isOver': 'is_over'});

Map<String, dynamic> _$EewIntensityValueToJson(_EewIntensityValue instance) =>
    <String, dynamic>{'value': instance.value, 'is_over': instance.isOver};
