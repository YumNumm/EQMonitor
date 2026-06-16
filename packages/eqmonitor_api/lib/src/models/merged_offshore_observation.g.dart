// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'merged_offshore_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MergedOffshoreObservation _$MergedOffshoreObservationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_MergedOffshoreObservation',
  json,
  ($checkedConvert) {
    final val = _MergedOffshoreObservation(
      stationCode: $checkedConvert('station_code', (v) => v as String),
      stationName: $checkedConvert('station_name', (v) => v as String),
      sensor: $checkedConvert('sensor', (v) => v as String?),
      firstHeight: $checkedConvert(
        'first_height',
        (v) => v == null
            ? null
            : TsunamiObservationStationFirstHeight.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => v == null
            ? null
            : TsunamiObservationStationMaxHeight.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'stationCode': 'station_code',
    'stationName': 'station_name',
    'firstHeight': 'first_height',
    'maxHeight': 'max_height',
  },
);

Map<String, dynamic> _$MergedOffshoreObservationToJson(
  _MergedOffshoreObservation instance,
) => <String, dynamic>{
  'station_code': instance.stationCode,
  'station_name': instance.stationName,
  'sensor': ?instance.sensor,
  'first_height': ?instance.firstHeight,
  'max_height': ?instance.maxHeight,
};
