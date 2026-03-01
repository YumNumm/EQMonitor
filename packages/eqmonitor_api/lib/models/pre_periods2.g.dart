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
        lpgmIntensity: $checkedConvert('lpgm_intensity', (v) => v as String),
        sva: $checkedConvert('sva', (v) => v as num),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$PrePeriods2ToJson(_PrePeriods2 instance) =>
    <String, dynamic>{
      'band': instance.band,
      'lpgm_intensity': instance.lpgmIntensity,
      'sva': instance.sva,
    };
