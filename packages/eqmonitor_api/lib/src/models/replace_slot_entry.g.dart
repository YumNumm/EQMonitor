// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replace_slot_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplaceSlotEntry _$ReplaceSlotEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ReplaceSlotEntry',
      json,
      ($checkedConvert) {
        final val = _ReplaceSlotEntry(
          slotType: $checkedConvert(
            'slot_type',
            (v) => $enumDecode(_$SlotTypeEnumMap, v),
          ),
          regionId: $checkedConvert('region_id', (v) => v as num?),
          regionName: $checkedConvert('region_name', (v) => v as String?),
          cityCode: $checkedConvert('city_code', (v) => v as String?),
          cityName: $checkedConvert('city_name', (v) => v as String?),
          displayOrder: $checkedConvert('display_order', (v) => v as num?),
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
      },
    );

Map<String, dynamic> _$ReplaceSlotEntryToJson(_ReplaceSlotEntry instance) =>
    <String, dynamic>{
      'slot_type': instance.slotType,
      'region_id': ?instance.regionId,
      'region_name': ?instance.regionName,
      'city_code': ?instance.cityCode,
      'city_name': ?instance.cityName,
      'display_order': ?instance.displayOrder,
      'eew_enabled': ?instance.eewEnabled,
      'eew_min_intensity': ?instance.eewMinIntensity,
      'eew_overrides': ?instance.eewOverrides,
      'earthquake_enabled': ?instance.earthquakeEnabled,
      'earthquake_min_intensity': ?instance.earthquakeMinIntensity,
      'earthquake_overrides': ?instance.earthquakeOverrides,
    };

const _$SlotTypeEnumMap = {
  SlotType.currentLocation: 'current_location',
  SlotType.nationwide: 'nationwide',
  SlotType.region: 'region',
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
