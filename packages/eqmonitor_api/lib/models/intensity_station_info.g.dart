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
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      lpgmIntensity: $checkedConvert(
        'lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
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

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: 0,
  JmaIntensity.value1: 1,
  JmaIntensity.value2: 2,
  JmaIntensity.value3: 3,
  JmaIntensity.value4: 4,
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: 7,
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: 0,
  JmaLpgmIntensity.value1: 1,
  JmaLpgmIntensity.value2: 2,
  JmaLpgmIntensity.value3: 3,
  JmaLpgmIntensity.value4: 4,
};
