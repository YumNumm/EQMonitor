// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_body_quake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramBodyQuake _$EarthquakeTelegramBodyQuakeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeTelegramBodyQuake', json, ($checkedConvert) {
  final val = _EarthquakeTelegramBodyQuake(
    eventId: $checkedConvert('eventId', (v) => v as String?),
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$TelegramStatusEnumMap, v),
    ),
    magnitude: $checkedConvert('magnitude', (v) => v as String?),
    magnitudeCondition: $checkedConvert(
      'magnitudeCondition',
      (v) => v as String?,
    ),
    maxIntensity: $checkedConvert(
      'maxIntensity',
      (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
    ),
    maxLpgmIntensity: $checkedConvert(
      'maxLpgmIntensity',
      (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
    ),
    depth: $checkedConvert('depth', (v) => v as num?),
    latitude: $checkedConvert('latitude', (v) => v as String?),
    longitude: $checkedConvert('longitude', (v) => v as String?),
    epicenterCode: $checkedConvert('epicenterCode', (v) => v as num?),
    epicenterName: $checkedConvert('epicenterName', (v) => v as String?),
    epicenterDetailCode: $checkedConvert(
      'epicenterDetailCode',
      (v) => v as num?,
    ),
    epicenterDetailName: $checkedConvert(
      'epicenterDetailName',
      (v) => v as String?,
    ),
    arrivalTime: $checkedConvert('arrivalTime', (v) => v as String?),
    originTime: $checkedConvert('originTime', (v) => v as String?),
    originTimePrecision: $checkedConvert(
      'originTimePrecision',
      (v) => $enumDecodeNullable(_$OriginTimePrecisionEnumMap, v),
    ),
    estimatedIntensityKey: $checkedConvert(
      'estimatedIntensityKey',
      (v) => v as String?,
    ),
    datasource: $checkedConvert(
      'datasource',
      (v) => $enumDecodeNullable(_$EarthquakeDatasourceEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeTelegramBodyQuakeToJson(
  _EarthquakeTelegramBodyQuake instance,
) => <String, dynamic>{
  'eventId': ?instance.eventId,
  'status': ?instance.status,
  'magnitude': ?instance.magnitude,
  'magnitudeCondition': ?instance.magnitudeCondition,
  'maxIntensity': ?instance.maxIntensity,
  'maxLpgmIntensity': ?instance.maxLpgmIntensity,
  'depth': ?instance.depth,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'epicenterCode': ?instance.epicenterCode,
  'epicenterName': ?instance.epicenterName,
  'epicenterDetailCode': ?instance.epicenterDetailCode,
  'epicenterDetailName': ?instance.epicenterDetailName,
  'arrivalTime': ?instance.arrivalTime,
  'originTime': ?instance.originTime,
  'originTimePrecision': ?instance.originTimePrecision,
  'estimatedIntensityKey': ?instance.estimatedIntensityKey,
  'datasource': ?instance.datasource,
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
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
  JmaIntensity.undefined1: '!6-',
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

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.millisecond: 'MILLISECOND',
  OriginTimePrecision.second: 'SECOND',
  OriginTimePrecision.minute: 'MINUTE',
  OriginTimePrecision.hour: 'HOUR',
  OriginTimePrecision.day: 'DAY',
  OriginTimePrecision.month: 'MONTH',
};

const _$EarthquakeDatasourceEnumMap = {
  EarthquakeDatasource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDatasource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};
