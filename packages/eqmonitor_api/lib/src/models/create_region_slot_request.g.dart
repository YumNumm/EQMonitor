// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'create_region_slot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateRegionSlotRequest _$CreateRegionSlotRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CreateRegionSlotRequest',
  json,
  ($checkedConvert) {
    final val = _CreateRegionSlotRequest(
      regionId: $checkedConvert('region_id', (v) => v as num),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      cityName: $checkedConvert('city_name', (v) => v as String?),
      eewEnabled: $checkedConvert('eew_enabled', (v) => v as bool?),
      eewMinIntensity: $checkedConvert(
        'eew_min_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      eewOverrides: $checkedConvert(
        'eew_overrides',
        (v) => (v as List<dynamic>?)
            ?.map((e) => SlotOverride.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      earthquakeEnabled: $checkedConvert(
        'earthquake_enabled',
        (v) => v as bool?,
      ),
      earthquakeMinIntensity: $checkedConvert(
        'earthquake_min_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      earthquakeOverrides: $checkedConvert(
        'earthquake_overrides',
        (v) => (v as List<dynamic>?)
            ?.map((e) => SlotOverride.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'regionName': 'region_name',
    'cityCode': 'city_code',
    'cityName': 'city_name',
    'eewEnabled': 'eew_enabled',
    'eewMinIntensity': 'eew_min_intensity',
    'eewOverrides': 'eew_overrides',
    'earthquakeEnabled': 'earthquake_enabled',
    'earthquakeMinIntensity': 'earthquake_min_intensity',
    'earthquakeOverrides': 'earthquake_overrides',
  },
);

Map<String, dynamic> _$CreateRegionSlotRequestToJson(
  _CreateRegionSlotRequest instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'region_name': ?instance.regionName,
  'city_code': ?instance.cityCode,
  'city_name': ?instance.cityName,
  'eew_enabled': ?instance.eewEnabled,
  'eew_min_intensity': ?instance.eewMinIntensity,
  'eew_overrides': ?instance.eewOverrides,
  'earthquake_enabled': ?instance.earthquakeEnabled,
  'earthquake_min_intensity': ?instance.earthquakeMinIntensity,
  'earthquake_overrides': ?instance.earthquakeOverrides,
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
  JmaIntensity.value6unknown: '!6-',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};
