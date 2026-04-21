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
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => EewIntensityRegionArrivalTimeTime.fromJson(
              v as Map<String, dynamic>,
            ),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => v == null
                ? null
                : EewIntensityLpgmValue.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isPlum': 'is_plum',
        'isWarning': 'is_warning',
        'arrivalTime': 'arrival_time',
        'lpgmIntensity': 'lpgm_intensity',
      },
    );

Map<String, dynamic> _$EewIntensityItemToJson(_EewIntensityItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'is_plum': instance.isPlum,
      'is_warning': instance.isWarning,
      'intensity': instance.intensity,
      'arrival_time': instance.arrivalTime,
      'lpgm_intensity': ?instance.lpgmIntensity,
    };
