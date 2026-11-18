// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSlot _$NotificationSlotFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationSlot',
      json,
      ($checkedConvert) {
        final val = _NotificationSlot(
          id: $checkedConvert('id', (v) => v as String),
          slotType: $checkedConvert(
            'slot_type',
            (v) => $enumDecode(_$NotificationSlotTypeEnumMap, v),
          ),
          regionId: $checkedConvert('region_id', (v) => (v as num?)?.toInt()),
          regionName: $checkedConvert('region_name', (v) => v as String?),
          cityCode: $checkedConvert('city_code', (v) => v as String?),
          cityName: $checkedConvert('city_name', (v) => v as String?),
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num).toInt(),
          ),
          eewEnabled: $checkedConvert('eew_enabled', (v) => v as bool),
          eewMinIntensity: $checkedConvert(
            'eew_min_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          eewOverrides: $checkedConvert(
            'eew_overrides',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      NotificationOverride.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          earthquakeEnabled: $checkedConvert(
            'earthquake_enabled',
            (v) => v as bool,
          ),
          earthquakeMinIntensity: $checkedConvert(
            'earthquake_min_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          earthquakeOverrides: $checkedConvert(
            'earthquake_overrides',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      NotificationOverride.fromJson(e as Map<String, dynamic>),
                )
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

Map<String, dynamic> _$NotificationSlotToJson(_NotificationSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_type': _$NotificationSlotTypeEnumMap[instance.slotType]!,
      'region_id': instance.regionId,
      'region_name': instance.regionName,
      'city_code': instance.cityCode,
      'city_name': instance.cityName,
      'display_order': instance.displayOrder,
      'eew_enabled': instance.eewEnabled,
      'eew_min_intensity': _$JmaIntensityEnumMap[instance.eewMinIntensity],
      'eew_overrides': instance.eewOverrides,
      'earthquake_enabled': instance.earthquakeEnabled,
      'earthquake_min_intensity':
          _$JmaIntensityEnumMap[instance.earthquakeMinIntensity],
      'earthquake_overrides': instance.earthquakeOverrides,
    };

const _$NotificationSlotTypeEnumMap = {
  NotificationSlotType.currentLocation: 'currentLocation',
  NotificationSlotType.nationwide: 'nationwide',
  NotificationSlotType.region: 'region',
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixUnknown: 'sixUnknown',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};
