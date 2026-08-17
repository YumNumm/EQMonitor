// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_slot_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSlotDraft _$NotificationSlotDraftFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSlotDraft',
  json,
  ($checkedConvert) {
    final val = _NotificationSlotDraft(
      slotType: $checkedConvert(
        'slot_type',
        (v) => $enumDecode(_$NotificationSlotTypeEnumMap, v),
      ),
      eewEnabled: $checkedConvert('eew_enabled', (v) => v as bool),
      earthquakeEnabled: $checkedConvert(
        'earthquake_enabled',
        (v) => v as bool,
      ),
      regionId: $checkedConvert('region_id', (v) => (v as num?)?.toInt()),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      cityName: $checkedConvert('city_name', (v) => v as String?),
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      eewMinIntensity: $checkedConvert(
        'eew_min_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      eewOverrides: $checkedConvert(
        'eew_overrides',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => NotificationOverride.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      earthquakeMinIntensity: $checkedConvert(
        'earthquake_min_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      earthquakeOverrides: $checkedConvert(
        'earthquake_overrides',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => NotificationOverride.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'slotType': 'slot_type',
    'eewEnabled': 'eew_enabled',
    'earthquakeEnabled': 'earthquake_enabled',
    'regionId': 'region_id',
    'regionName': 'region_name',
    'cityCode': 'city_code',
    'cityName': 'city_name',
    'displayOrder': 'display_order',
    'eewMinIntensity': 'eew_min_intensity',
    'eewOverrides': 'eew_overrides',
    'earthquakeMinIntensity': 'earthquake_min_intensity',
    'earthquakeOverrides': 'earthquake_overrides',
  },
);

Map<String, dynamic> _$NotificationSlotDraftToJson(
  _NotificationSlotDraft instance,
) => <String, dynamic>{
  'slot_type': _$NotificationSlotTypeEnumMap[instance.slotType]!,
  'eew_enabled': instance.eewEnabled,
  'earthquake_enabled': instance.earthquakeEnabled,
  'region_id': instance.regionId,
  'region_name': instance.regionName,
  'city_code': instance.cityCode,
  'city_name': instance.cityName,
  'display_order': instance.displayOrder,
  'eew_min_intensity': _$JmaIntensityEnumMap[instance.eewMinIntensity],
  'eew_overrides': instance.eewOverrides,
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
