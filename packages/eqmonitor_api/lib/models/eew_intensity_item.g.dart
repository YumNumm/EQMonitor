// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensityItem _$EewIntensityItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewIntensityItem',
      json,
      ($checkedConvert) {
        final val = _EewIntensityItem(
          value: $checkedConvert(
            'value',
            (v) => CodeName.fromJson(v as Map<String, dynamic>),
          ),
          isPlum: $checkedConvert('is_plum', (v) => v as bool),
          isWarning: $checkedConvert('is_warning', (v) => v as bool),
          intensity: $checkedConvert(
            'intensity',
            (v) => EewIntensityValue.fromJson(v as Map<String, dynamic>),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => v == null
                ? null
                : EewIntensityLpgmValue.fromJson(v as Map<String, dynamic>),
          ),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isPlum': 'is_plum',
        'isWarning': 'is_warning',
        'lpgmIntensity': 'lpgm_intensity',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$EewIntensityItemToJson(_EewIntensityItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'is_plum': instance.isPlum,
      'is_warning': instance.isWarning,
      'intensity': instance.intensity,
      'lpgm_intensity': ?instance.lpgmIntensity,
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
    };
