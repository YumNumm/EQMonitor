// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
              'showCalculatedRegionIntensity', (v) => v as bool? ?? false),
          showCalculatedCityIntensity: $checkedConvert(
              'showCalculatedCityIntensity', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewSetitngsImplToJson(_$EewSetitngsImpl instance) =>
    <String, dynamic>{
      'showCalculatedRegionIntensity': instance.showCalculatedRegionIntensity,
      'showCalculatedCityIntensity': instance.showCalculatedCityIntensity,
    };
