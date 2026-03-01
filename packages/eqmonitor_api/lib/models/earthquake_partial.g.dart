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
        (v) => $enumDecode(_$EarthquakePartialStatusEnumMap, v),
      ),
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$OriginTimePrecisionEnumEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecode(_$EarthquakeDatasourceEnumEnumMap, v),
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
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null ? null : Intensity.fromJson(v as Map<String, dynamic>),
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
      'intensity': ?instance.intensity,
    };

const _$EarthquakePartialStatusEnumMap = {
  EarthquakePartialStatus.normal: 'NORMAL',
  EarthquakePartialStatus.training: 'TRAINING',
  EarthquakePartialStatus.test: 'TEST',
};

const _$OriginTimePrecisionEnumEnumMap = {
  OriginTimePrecisionEnum.millisecond: 'MILLISECOND',
  OriginTimePrecisionEnum.second: 'SECOND',
  OriginTimePrecisionEnum.minute: 'MINUTE',
  OriginTimePrecisionEnum.hour: 'HOUR',
  OriginTimePrecisionEnum.day: 'DAY',
  OriginTimePrecisionEnum.month: 'MONTH',
};

const _$EarthquakeDatasourceEnumEnumMap = {
  EarthquakeDatasourceEnum.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDatasourceEnum.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};
