// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_partial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakePartial _$EarthquakePartialFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakePartial',
  json,
  ($checkedConvert) {
    final val = _EarthquakePartial(
      eventId: $checkedConvert('event_id', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecode(_$EarthquakeTypeEnumMap, v),
      ),
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v),
      ),
      datasources: $checkedConvert(
        'datasources',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeDatasourceEnumMap, e))
            .toList(),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) =>
            v == null ? null : Hypocenter.fromJson(v as Map<String, dynamic>),
      ),
      estimatedIntensityTile: $checkedConvert(
        'estimated_intensity_tile',
        (v) => v as String?,
      ),
      estimatedIntensityTileArchive: $checkedConvert(
        'estimated_intensity_tile_archive',
        (v) => v == null
            ? null
            : EstimatedIntensityTileArchive.fromJson(v as Map<String, dynamic>),
      ),
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null
            ? null
            : IntensityPartial.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'earthquakeType': 'earthquake_type',
    'originTimePrecision': 'origin_time_precision',
    'telegramTypes': 'telegram_types',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
    'estimatedIntensityTile': 'estimated_intensity_tile',
    'estimatedIntensityTileArchive': 'estimated_intensity_tile_archive',
  },
);

Map<String, dynamic> _$EarthquakePartialToJson(
  _EarthquakePartial instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'status': instance.status,
  'earthquake_type': instance.earthquakeType,
  'origin_time_precision': instance.originTimePrecision,
  'datasources': instance.datasources,
  'telegram_types': instance.telegramTypes,
  'origin_time': ?instance.originTime?.toIso8601String(),
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'hypocenter': ?instance.hypocenter,
  'estimated_intensity_tile': ?instance.estimatedIntensityTile,
  'estimated_intensity_tile_archive': ?instance.estimatedIntensityTileArchive,
  'intensity': ?instance.intensity,
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$EarthquakeTypeEnumMap = {
  EarthquakeType.normal: 'NORMAL',
  EarthquakeType.distant: 'DISTANT',
  EarthquakeType.volcano: 'VOLCANO',
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

const _$EarthquakeTelegramTypeEnumMap = {
  EarthquakeTelegramType.vxse51: 'VXSE51',
  EarthquakeTelegramType.vxse52: 'VXSE52',
  EarthquakeTelegramType.vxse53: 'VXSE53',
  EarthquakeTelegramType.vxse61: 'VXSE61',
  EarthquakeTelegramType.vxse62: 'VXSE62',
  EarthquakeTelegramType.vxse45Forecast: 'VXSE45_FORECAST',
  EarthquakeTelegramType.vxse45Warning: 'VXSE45_WARNING',
};
