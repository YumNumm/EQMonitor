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
        (v) => v == null ? null : Intensity.fromJson(v as Map<String, dynamic>),
      ),
      lpgmIntensity: $checkedConvert(
        'lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityEnumMap, v),
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

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
