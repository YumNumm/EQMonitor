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
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecode(_$EarthquakeDatasourceEnumMap, v),
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
      intensityMapImage: $checkedConvert(
        'intensity_map_image',
        (v) => v as String?,
      ),
      intensityMapImages: $checkedConvert(
        'intensity_map_images',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => IntensityMapImageGroup.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
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
    'originTimePrecision': 'origin_time_precision',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
    'estimatedIntensityTile': 'estimated_intensity_tile',
    'intensityMapImage': 'intensity_map_image',
    'intensityMapImages': 'intensity_map_images',
  },
);

Map<String, dynamic> _$EarthquakePartialToJson(_EarthquakePartial instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': instance.status,
      'origin_time_precision': instance.originTimePrecision,
      'datasource': instance.datasource,
      'origin_time': ?instance.originTime?.toIso8601String(),
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
      'hypocenter': ?instance.hypocenter,
      'estimated_intensity_tile': ?instance.estimatedIntensityTile,
      'intensity_map_image': ?instance.intensityMapImage,
      'intensity_map_images': ?instance.intensityMapImages,
      'intensity': ?instance.intensity,
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

const _$EarthquakeDatasourceEnumMap = {
  EarthquakeDatasource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDatasource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};
