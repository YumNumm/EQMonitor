// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_station_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityStationItem _$IntensityStationItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationItem',
  json,
  ($checkedConvert) {
    final val = _IntensityStationItem(
      value: $checkedConvert(
        'value',
        (v) => CodeName.fromJson(v as Map<String, dynamic>),
      ),
      sva: $checkedConvert('sva', (v) => v as num),
      prePeriods: $checkedConvert(
        'pre_periods',
        (v) => (v as List<dynamic>)
            .map((e) => PrePeriods.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => v == null ? null : Intensity.fromJson(v as Map<String, dynamic>),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'prePeriods': 'pre_periods',
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
  },
);

Map<String, dynamic> _$IntensityStationItemToJson(
  _IntensityStationItem instance,
) => <String, dynamic>{
  'value': instance.value,
  'sva': instance.sva,
  'pre_periods': instance.prePeriods,
  'max_intensity': ?instance.maxIntensity,
  'max_lpgm_intensity': ?instance.maxLpgmIntensity,
};

const _$LpgmIntensityEnumMap = {
  LpgmIntensity.value0: 0,
  LpgmIntensity.value1: 1,
  LpgmIntensity.value2: 2,
  LpgmIntensity.value3: 3,
  LpgmIntensity.value4: 4,
};
