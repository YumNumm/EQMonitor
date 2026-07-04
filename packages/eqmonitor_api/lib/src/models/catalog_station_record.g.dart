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
      intensityRaw: $checkedConvert('intensity_raw', (v) => v as String?),
      instrumentalIntensity: $checkedConvert(
        'instrumental_intensity',
        (v) => v as num?,
      ),
      maxAccelSynthesizedGal: $checkedConvert(
        'max_accel_synthesized_gal',
        (v) => v as num?,
      ),
      maxAccelNsGal: $checkedConvert('max_accel_ns_gal', (v) => v as num?),
      maxAccelEwGal: $checkedConvert('max_accel_ew_gal', (v) => v as num?),
      maxAccelUdGal: $checkedConvert('max_accel_ud_gal', (v) => v as num?),
      maxAccelPeriodNs: $checkedConvert(
        'max_accel_period_ns',
        (v) => v as num?,
      ),
      predominantPeriodNs: $checkedConvert(
        'predominant_period_ns',
        (v) => v as num?,
      ),
      maxAccelPeriodEw: $checkedConvert(
        'max_accel_period_ew',
        (v) => v as num?,
      ),
      predominantPeriodEw: $checkedConvert(
        'predominant_period_ew',
        (v) => v as num?,
      ),
      maxAccelPeriodUd: $checkedConvert(
        'max_accel_period_ud',
        (v) => v as num?,
      ),
      predominantPeriodUd: $checkedConvert(
        'predominant_period_ud',
        (v) => v as num?,
      ),
      occurrenceTime: $checkedConvert(
        'occurrence_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'stationCode': 'station_code',
    'intensityRaw': 'intensity_raw',
    'instrumentalIntensity': 'instrumental_intensity',
    'maxAccelSynthesizedGal': 'max_accel_synthesized_gal',
    'maxAccelNsGal': 'max_accel_ns_gal',
    'maxAccelEwGal': 'max_accel_ew_gal',
    'maxAccelUdGal': 'max_accel_ud_gal',
    'maxAccelPeriodNs': 'max_accel_period_ns',
    'predominantPeriodNs': 'predominant_period_ns',
    'maxAccelPeriodEw': 'max_accel_period_ew',
    'predominantPeriodEw': 'predominant_period_ew',
    'maxAccelPeriodUd': 'max_accel_period_ud',
    'predominantPeriodUd': 'predominant_period_ud',
    'occurrenceTime': 'occurrence_time',
  },
);

Map<String, dynamic> _$CatalogStationRecordToJson(
  _CatalogStationRecord instance,
) => <String, dynamic>{
  'station_code': instance.stationCode,
  'intensity_raw': instance.intensityRaw,
  'instrumental_intensity': instance.instrumentalIntensity,
  'max_accel_synthesized_gal': instance.maxAccelSynthesizedGal,
  'max_accel_ns_gal': instance.maxAccelNsGal,
  'max_accel_ew_gal': instance.maxAccelEwGal,
  'max_accel_ud_gal': instance.maxAccelUdGal,
  'max_accel_period_ns': instance.maxAccelPeriodNs,
  'predominant_period_ns': instance.predominantPeriodNs,
  'max_accel_period_ew': instance.maxAccelPeriodEw,
  'predominant_period_ew': instance.predominantPeriodEw,
  'max_accel_period_ud': instance.maxAccelPeriodUd,
  'predominant_period_ud': instance.predominantPeriodUd,
  'occurrence_time': ?instance.occurrenceTime?.toIso8601String(),
};
