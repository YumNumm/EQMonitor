// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_body_intensity_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramBodyIntensityRegion
_$EarthquakeTelegramBodyIntensityRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeTelegramBodyIntensityRegion', json, (
      $checkedConvert,
    ) {
      final val = _EarthquakeTelegramBodyIntensityRegion(
        eventId: $checkedConvert('eventId', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        intensity: $checkedConvert(
          'intensity',
          (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
        ),
        lpgmIntensity: $checkedConvert(
          'lpgmIntensity',
          (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
        ),
        datasource: $checkedConvert('datasource', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeTelegramBodyIntensityRegionToJson(
  _EarthquakeTelegramBodyIntensityRegion instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'code': instance.code,
  'name': instance.name,
  'intensity': instance.intensity,
  'lpgmIntensity': instance.lpgmIntensity,
  'datasource': instance.datasource,
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
