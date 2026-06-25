// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_body_intensity_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramBodyIntensityStation
_$EarthquakeTelegramBodyIntensityStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeTelegramBodyIntensityStation', json, (
      $checkedConvert,
    ) {
      final val = _EarthquakeTelegramBodyIntensityStation(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        eventId: $checkedConvert('eventId', (v) => v as String?),
        intensity: $checkedConvert(
          'intensity',
          (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
        ),
        lpgmIntensity: $checkedConvert(
          'lpgmIntensity',
          (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
        ),
        sva: $checkedConvert('sva', (v) => v as String?),
        prePeriods: $checkedConvert(
          'prePeriods',
          (v) => (v as List<dynamic>?)
              ?.map((e) => PrePeriods2.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        datasource: $checkedConvert(
          'datasource',
          (v) => $enumDecodeNullable(_$EarthquakeDatasourceEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeTelegramBodyIntensityStationToJson(
  _EarthquakeTelegramBodyIntensityStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'eventId': ?instance.eventId,
  'intensity': ?instance.intensity,
  'lpgmIntensity': ?instance.lpgmIntensity,
  'sva': ?instance.sva,
  'prePeriods': ?instance.prePeriods,
  'datasource': ?instance.datasource,
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

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};

const _$EarthquakeDatasourceEnumMap = {
  EarthquakeDatasource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDatasource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};
