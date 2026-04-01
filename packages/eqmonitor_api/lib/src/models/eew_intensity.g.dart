// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensity _$EewIntensityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewIntensity',
      json,
      ($checkedConvert) {
        final val = _EewIntensity(
          regions: $checkedConvert(
            'regions',
            (v) => (v as List<dynamic>)
                .map(
                  (e) => EewIntensityItem.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => v == null
                ? null
                : EewIntensityValue.fromJson(v as Map<String, dynamic>),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => v == null
                ? null
                : EewIntensityLpgmValue.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$EewIntensityToJson(_EewIntensity instance) =>
    <String, dynamic>{
      'regions': instance.regions,
      'max_intensity': ?instance.maxIntensity,
      'max_lpgm_intensity': ?instance.maxLpgmIntensity,
    };
