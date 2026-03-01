// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_station_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityStationInfo _$IntensityStationInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationInfo',
  json,
  ($checkedConvert) {
    final val = _IntensityStationInfo(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      intensity: $checkedConvert(
        'intensity',
        (v) => $enumDecodeNullable(_$IntensityStationInfoIntensityEnumMap, v),
      ),
      lpgmIntensity: $checkedConvert(
        'lpgm_intensity',
        (v) =>
            $enumDecodeNullable(_$IntensityStationInfoLpgmIntensityEnumMap, v),
      ),
      sva: $checkedConvert('sva', (v) => v as num?),
      prePeriods: $checkedConvert(
        'pre_periods',
        (v) => (v as List<dynamic>?)
            ?.map((e) => PrePeriods2.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'lpgmIntensity': 'lpgm_intensity',
    'prePeriods': 'pre_periods',
  },
);

Map<String, dynamic> _$IntensityStationInfoToJson(
  _IntensityStationInfo instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': instance.intensity,
  'lpgm_intensity': instance.lpgmIntensity,
  'sva': instance.sva,
  'pre_periods': instance.prePeriods,
};

const _$IntensityStationInfoIntensityEnumMap = {
  IntensityStationInfoIntensity.value0: 0,
  IntensityStationInfoIntensity.value1: 1,
  IntensityStationInfoIntensity.value2: 2,
  IntensityStationInfoIntensity.value3: 3,
  IntensityStationInfoIntensity.value4: 4,
  IntensityStationInfoIntensity.undefined0: '!5-',
  IntensityStationInfoIntensity.value5: '5-',
  IntensityStationInfoIntensity.value5: '5+',
  IntensityStationInfoIntensity.value6: '6-',
  IntensityStationInfoIntensity.value6: '6+',
  IntensityStationInfoIntensity.value7: 7,
};

const _$IntensityStationInfoLpgmIntensityEnumMap = {
  IntensityStationInfoLpgmIntensity.value0: 0,
  IntensityStationInfoLpgmIntensity.value1: 1,
  IntensityStationInfoLpgmIntensity.value2: 2,
  IntensityStationInfoLpgmIntensity.value3: 3,
  IntensityStationInfoLpgmIntensity.value4: 4,
};
