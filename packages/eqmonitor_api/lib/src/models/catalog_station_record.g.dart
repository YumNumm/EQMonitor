// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_station_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogStationRecord _$CatalogStationRecordFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CatalogStationRecord',
  json,
  ($checkedConvert) {
    final val = _CatalogStationRecord(
      stationCode: $checkedConvert('station_code', (v) => v as String),
      intensity: $checkedConvert(
        'intensity',
        (v) => CatalogStationIntensity.fromJson(v as Map<String, dynamic>),
      ),
      observedAt: $checkedConvert(
        'observed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      maxAcceleration: $checkedConvert(
        'max_acceleration',
        (v) => v == null
            ? null
            : CatalogStationMaxAcceleration.fromJson(v as Map<String, dynamic>),
      ),
      maxAccelTime: $checkedConvert(
        'max_accel_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      periods: $checkedConvert(
        'periods',
        (v) => v == null
            ? null
            : CatalogStationPeriods.fromJson(v as Map<String, dynamic>),
      ),
      observationCount: $checkedConvert(
        'observation_count',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'stationCode': 'station_code',
    'observedAt': 'observed_at',
    'maxAcceleration': 'max_acceleration',
    'maxAccelTime': 'max_accel_time',
    'observationCount': 'observation_count',
  },
);

Map<String, dynamic> _$CatalogStationRecordToJson(
  _CatalogStationRecord instance,
) => <String, dynamic>{
  'station_code': instance.stationCode,
  'intensity': instance.intensity,
  'observed_at': ?instance.observedAt?.toIso8601String(),
  'max_acceleration': ?instance.maxAcceleration,
  'max_accel_time': ?instance.maxAccelTime?.toIso8601String(),
  'periods': ?instance.periods,
  'observation_count': ?instance.observationCount,
};
