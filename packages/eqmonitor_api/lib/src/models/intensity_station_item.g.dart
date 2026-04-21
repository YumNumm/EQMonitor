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
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      sva: $checkedConvert('sva', (v) => v as num?),
      prePeriods: $checkedConvert(
        'prePeriods',
        (v) => (v as List<dynamic>?)
            ?.map((e) => PrePeriods.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
  },
);

Map<String, dynamic> _$IntensityStationItemToJson(
  _IntensityStationItem instance,
) => <String, dynamic>{
  'value': instance.value,
  'max_intensity': ?instance.maxIntensity,
  'max_lpgm_intensity': ?instance.maxLpgmIntensity,
  'sva': ?instance.sva,
  'prePeriods': ?instance.prePeriods,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};
