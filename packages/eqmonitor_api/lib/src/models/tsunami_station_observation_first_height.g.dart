// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_observation_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationObservationFirstHeight
_$TsunamiStationObservationFirstHeightFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiStationObservationFirstHeight',
      json,
      ($checkedConvert) {
        final val = _TsunamiStationObservationFirstHeight(
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          initial: $checkedConvert('initial', (v) => v as String?),
          isUnidentifiable: $checkedConvert(
            'is_unidentifiable',
            (v) => v as bool?,
          ),
          isMissing: $checkedConvert('is_missing', (v) => v as bool?),
          revise: $checkedConvert('revise', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'arrivalTime': 'arrival_time',
        'isUnidentifiable': 'is_unidentifiable',
        'isMissing': 'is_missing',
      },
    );

Map<String, dynamic> _$TsunamiStationObservationFirstHeightToJson(
  _TsunamiStationObservationFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'initial': ?instance.initial,
  'is_unidentifiable': ?instance.isUnidentifiable,
  'is_missing': ?instance.isMissing,
  'revise': ?instance.revise,
};
