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
            (v) =>
                $enumDecodeNullable(_$IntensityRegionInfoIntensityEnumMap, v),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => $enumDecodeNullable(
              _$IntensityRegionInfoLpgmIntensityEnumMap,
              v,
            ),
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

const _$IntensityRegionInfoIntensityEnumMap = {
  IntensityRegionInfoIntensity.value0: 0,
  IntensityRegionInfoIntensity.value1: 1,
  IntensityRegionInfoIntensity.value2: 2,
  IntensityRegionInfoIntensity.value3: 3,
  IntensityRegionInfoIntensity.value4: 4,
  IntensityRegionInfoIntensity.value5unknown: '!5-',
  IntensityRegionInfoIntensity.value5minus: '5-',
  IntensityRegionInfoIntensity.value5plus: '5+',
  IntensityRegionInfoIntensity.value6minus: '6-',
  IntensityRegionInfoIntensity.value6plus: '6+',
  IntensityRegionInfoIntensity.value7: 7,
};

const _$IntensityRegionInfoLpgmIntensityEnumMap = {
  IntensityRegionInfoLpgmIntensity.value0: 0,
  IntensityRegionInfoLpgmIntensity.value1: 1,
  IntensityRegionInfoLpgmIntensity.value2: 2,
  IntensityRegionInfoLpgmIntensity.value3: 3,
  IntensityRegionInfoLpgmIntensity.value4: 4,
};
