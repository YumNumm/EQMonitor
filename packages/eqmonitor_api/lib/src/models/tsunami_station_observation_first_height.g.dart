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
          isUnidentifiable: $checkedConvert(
            'is_unidentifiable',
            (v) => v as bool,
          ),
          isMissing: $checkedConvert('is_missing', (v) => v as bool),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          initial: $checkedConvert(
            'initial',
            (v) => $enumDecodeNullable(_$WaveInitialEnumMap, v),
          ),
          revise: $checkedConvert(
            'revise',
            (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isUnidentifiable': 'is_unidentifiable',
        'isMissing': 'is_missing',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$TsunamiStationObservationFirstHeightToJson(
  _TsunamiStationObservationFirstHeight instance,
) => <String, dynamic>{
  'is_unidentifiable': instance.isUnidentifiable,
  'is_missing': instance.isMissing,
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'initial': ?instance.initial,
  'revise': ?instance.revise,
};

const _$WaveInitialEnumMap = {
  WaveInitial.push: 'PUSH',
  WaveInitial.pull: 'PULL',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
