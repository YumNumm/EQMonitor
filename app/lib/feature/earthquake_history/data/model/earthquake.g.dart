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
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      dataSource: $checkedConvert(
        'data_source',
        (v) => $enumDecode(_$EarthquakeDataSourceEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => v == null
            ? null
            : EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null
            ? null
            : EarthquakeIntensity.fromJson(v as Map<String, dynamic>),
      ),
      estimatedIntensityTileUrl: $checkedConvert(
        'estimated_intensity_tile_url',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'originTime': 'origin_time',
    'originTimePrecision': 'origin_time_precision',
    'arrivalTime': 'arrival_time',
    'dataSource': 'data_source',
    'telegramTypes': 'telegram_types',
    'estimatedIntensityTileUrl': 'estimated_intensity_tile_url',
  },
);

Map<String, dynamic> _$EarthquakeToJson(_Earthquake instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': _$TelegramStatusEnumMap[instance.status]!,
      'origin_time': instance.originTime?.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'data_source': _$EarthquakeDataSourceEnumMap[instance.dataSource]!,
      'telegram_types': instance.telegramTypes
          .map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
          .toList(),
      'hypocenter': instance.hypocenter,
      'intensity': instance.intensity,
      'estimated_intensity_tile_url': instance.estimatedIntensityTileUrl,
    };

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.millisecond: 'MILLISECOND',
  OriginTimePrecision.second: 'SECOND',
  OriginTimePrecision.minute: 'MINUTE',
  OriginTimePrecision.hour: 'HOUR',
  OriginTimePrecision.day: 'DAY',
  OriginTimePrecision.month: 'MONTH',
};

const _$EarthquakeDataSourceEnumMap = {
  EarthquakeDataSource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDataSource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};

const _$EarthquakeTelegramTypeEnumMap = {
  EarthquakeTelegramType.vxse51: 'vxse51',
  EarthquakeTelegramType.vxse52: 'vxse52',
  EarthquakeTelegramType.vxse53: 'vxse53',
  EarthquakeTelegramType.vxse61: 'vxse61',
  EarthquakeTelegramType.vxse62: 'vxse62',
  EarthquakeTelegramType.vxse45Forecast: 'vxse45Forecast',
  EarthquakeTelegramType.vxse45Warning: 'vxse45Warning',
};
