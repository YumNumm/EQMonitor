// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'upsert_singleton_slot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpsertSingletonSlotRequest _$UpsertSingletonSlotRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_UpsertSingletonSlotRequest',
  json,
  ($checkedConvert) {
    final val = _UpsertSingletonSlotRequest(
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
    'eewEnabled': 'eew_enabled',
    'eewMinIntensity': 'eew_min_intensity',
    'eewOverrides': 'eew_overrides',
    'earthquakeEnabled': 'earthquake_enabled',
    'earthquakeMinIntensity': 'earthquake_min_intensity',
    'earthquakeOverrides': 'earthquake_overrides',
  },
);

Map<String, dynamic> _$UpsertSingletonSlotRequestToJson(
  _UpsertSingletonSlotRequest instance,
) => <String, dynamic>{
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
