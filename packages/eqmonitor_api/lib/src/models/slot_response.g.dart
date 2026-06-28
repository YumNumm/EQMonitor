// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'slot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SlotResponse _$SlotResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_SlotResponse',
      json,
      ($checkedConvert) {
        final val = _SlotResponse(
          id: $checkedConvert('id', (v) => v as String),
          slotType: $checkedConvert(
            'slot_type',
            (v) => $enumDecode(_$SlotTypeEnumMap, v),
          ),
          regionId: $checkedConvert('region_id', (v) => v as num?),
          regionName: $checkedConvert('region_name', (v) => v as String?),
          cityCode: $checkedConvert('city_code', (v) => v as String?),
          cityName: $checkedConvert('city_name', (v) => v as String?),
          displayOrder: $checkedConvert('display_order', (v) => v as num),
          eewEnabled: $checkedConvert('eew_enabled', (v) => v as bool),
          eewMinIntensity: $checkedConvert(
            'eew_min_intensity',
            (v) => $enumDecodeNullable(_$EewMinIntensityEnumMap, v),
          ),
          eewOverrides: $checkedConvert(
            'eew_overrides',
            (v) => (v as List<dynamic>?)
                ?.map((e) => SlotOverride.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          earthquakeEnabled: $checkedConvert(
            'earthquake_enabled',
            (v) => v as bool,
          ),
          earthquakeMinIntensity: $checkedConvert(
            'earthquake_min_intensity',
            (v) => $enumDecodeNullable(_$EarthquakeMinIntensityEnumMap, v),
          ),
          earthquakeOverrides: $checkedConvert(
            'earthquake_overrides',
            (v) => (v as List<dynamic>?)
                ?.map((e) => SlotOverride.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'slotType': 'slot_type',
        'regionId': 'region_id',
        'regionName': 'region_name',
        'cityCode': 'city_code',
        'cityName': 'city_name',
        'displayOrder': 'display_order',
        'eewEnabled': 'eew_enabled',
        'eewMinIntensity': 'eew_min_intensity',
        'eewOverrides': 'eew_overrides',
        'earthquakeEnabled': 'earthquake_enabled',
        'earthquakeMinIntensity': 'earthquake_min_intensity',
        'earthquakeOverrides': 'earthquake_overrides',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$SlotResponseToJson(_SlotResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_type': instance.slotType,
      'region_id': instance.regionId,
      'region_name': instance.regionName,
      'city_code': instance.cityCode,
      'city_name': instance.cityName,
      'display_order': instance.displayOrder,
      'eew_enabled': instance.eewEnabled,
      'eew_min_intensity': instance.eewMinIntensity,
      'eew_overrides': instance.eewOverrides,
      'earthquake_enabled': instance.earthquakeEnabled,
      'earthquake_min_intensity': instance.earthquakeMinIntensity,
      'earthquake_overrides': instance.earthquakeOverrides,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$SlotTypeEnumMap = {
  SlotType.currentLocation: 'current_location',
  SlotType.nationwide: 'nationwide',
  SlotType.region: 'region',
};

const _$EewMinIntensityEnumMap = {
  EewMinIntensity.value0: '0',
  EewMinIntensity.value1: '1',
  EewMinIntensity.value2: '2',
  EewMinIntensity.value3: '3',
  EewMinIntensity.value4: '4',
  EewMinIntensity.value5unknown: '!5-',
  EewMinIntensity.value5minus: '5-',
  EewMinIntensity.value5plus: '5+',
  EewMinIntensity.value6unknown: '!6-',
  EewMinIntensity.value6minus: '6-',
  EewMinIntensity.value6plus: '6+',
  EewMinIntensity.value7: '7',
};

const _$EarthquakeMinIntensityEnumMap = {
  EarthquakeMinIntensity.value0: '0',
  EarthquakeMinIntensity.value1: '1',
  EarthquakeMinIntensity.value2: '2',
  EarthquakeMinIntensity.value3: '3',
  EarthquakeMinIntensity.value4: '4',
  EarthquakeMinIntensity.value5unknown: '!5-',
  EarthquakeMinIntensity.value5minus: '5-',
  EarthquakeMinIntensity.value5plus: '5+',
  EarthquakeMinIntensity.value6unknown: '!6-',
  EarthquakeMinIntensity.value6minus: '6-',
  EarthquakeMinIntensity.value6plus: '6+',
  EarthquakeMinIntensity.value7: '7',
};
