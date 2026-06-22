// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeStation _$EarthquakeStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeStation',
      json,
      ($checkedConvert) {
        final val = _EarthquakeStation(
          code: $checkedConvert('code', (v) => v as String),
          noCode: $checkedConvert('no_code', (v) => v as String),
          name: $checkedConvert(
            'name',
            (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
          ),
          kana: $checkedConvert('kana', (v) => v as String?),
          status: $checkedConvert(
            'status',
            (v) => $enumDecode(_$EarthquakeStationStatusEnumMap, v),
          ),
          sourceStatus: $checkedConvert('source_status', (v) => v as String),
          owner: $checkedConvert('owner', (v) => v as String),
          location: $checkedConvert(
            'location',
            (v) => ParameterLocation.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'noCode': 'no_code', 'sourceStatus': 'source_status'},
    );

Map<String, dynamic> _$EarthquakeStationToJson(_EarthquakeStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'no_code': instance.noCode,
      'name': instance.name,
      'kana': instance.kana,
      'status': instance.status,
      'source_status': instance.sourceStatus,
      'owner': instance.owner,
      'location': instance.location,
    };

const _$EarthquakeStationStatusEnumMap = {
  EarthquakeStationStatus.operating: 'OPERATING',
  EarthquakeStationStatus.changed: 'CHANGED',
  EarthquakeStationStatus.valueNew: 'NEW',
  EarthquakeStationStatus.abolished: 'ABOLISHED',
  EarthquakeStationStatus.unknown: 'UNKNOWN',
};
