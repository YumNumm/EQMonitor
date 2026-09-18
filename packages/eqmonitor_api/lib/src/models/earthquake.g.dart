// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Earthquake _$EarthquakeFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Earthquake',
  json,
  ($checkedConvert) {
    final val = _Earthquake(
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
      hypocenters: $checkedConvert(
        'hypocenters',
        (v) => (v as List<dynamic>)
            .map(
              (e) => EarthquakeHypocentersUnion.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      datasources: $checkedConvert(
        'datasources',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeDatasourceEnumMap, e))
            .toList(),
      ),
      telegrams: $checkedConvert(
        'telegrams',
        (v) => (v as List<dynamic>)
            .map((e) => EarthquakeTelegram.fromJson(e as Map<String, dynamic>))
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
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null ? null : Intensity.fromJson(v as Map<String, dynamic>),
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
      catalog: $checkedConvert(
        'catalog',
        (v) => v == null ? null : Catalog.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'earthquakeType': 'earthquake_type',
    'originTimePrecision': 'origin_time_precision',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
    'estimatedIntensityTile': 'estimated_intensity_tile',
    'estimatedIntensityTileArchive': 'estimated_intensity_tile_archive',
  },
);

Map<String, dynamic> _$EarthquakeToJson(
  _Earthquake instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'status': instance.status,
  'earthquake_type': instance.earthquakeType,
  'origin_time_precision': instance.originTimePrecision,
  'hypocenters': instance.hypocenters,
  'datasources': instance.datasources,
  'telegrams': instance.telegrams,
  'origin_time': ?instance.originTime?.toIso8601String(),
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'hypocenter': ?instance.hypocenter,
  'intensity': ?instance.intensity,
  'estimated_intensity_tile': ?instance.estimatedIntensityTile,
  'estimated_intensity_tile_archive': ?instance.estimatedIntensityTileArchive,
  'catalog': ?instance.catalog,
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
