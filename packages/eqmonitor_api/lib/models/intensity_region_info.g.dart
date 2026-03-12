// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_region_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityRegionInfo _$IntensityRegionInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityRegionInfo',
      json,
      ($checkedConvert) {
        final val = _IntensityRegionInfo(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          intensity: $checkedConvert(
            'intensity',
            (v) => v == null
                ? null
                : Intensity.fromJson(v as Map<String, dynamic>),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => $enumDecodeNullable(_$LpgmIntensityEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'},
    );

Map<String, dynamic> _$IntensityRegionInfoToJson(
  _IntensityRegionInfo instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': instance.intensity,
  'lpgm_intensity': instance.lpgmIntensity,
};

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
