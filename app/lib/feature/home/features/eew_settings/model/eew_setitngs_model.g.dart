// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_setitngs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewSetitngsImpl _$$EewSetitngsImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewSetitngsImpl',
      json,
      ($checkedConvert) {
        final val = _$EewSetitngsImpl(
          showCalculatedRegionIntensity: $checkedConvert(
              'show_calculated_region_intensity', (v) => v as bool? ?? false),
          showCalculatedCityIntensity: $checkedConvert(
              'show_calculated_city_intensity', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'showCalculatedRegionIntensity': 'show_calculated_region_intensity',
        'showCalculatedCityIntensity': 'show_calculated_city_intensity'
      },
    );

Map<String, dynamic> _$$EewSetitngsImplToJson(_$EewSetitngsImpl instance) =>
    <String, dynamic>{
      'show_calculated_region_intensity':
          instance.showCalculatedRegionIntensity,
      'show_calculated_city_intensity': instance.showCalculatedCityIntensity,
    };
