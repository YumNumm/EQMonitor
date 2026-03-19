// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_observation_station_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiObservationStationFirstHeight
_$TsunamiObservationStationFirstHeightFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiObservationStationFirstHeight',
      json,
      ($checkedConvert) {
        final val = _TsunamiObservationStationFirstHeight(
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => DateTime.parse(v as String),
          ),
          initial: $checkedConvert(
            'initial',
            (v) => $enumDecode(_$WaveInitialEnumMap, v),
          ),
          isUnidentifiable: $checkedConvert(
            'is_unidentifiable',
            (v) => v as bool,
          ),
          isMissing: $checkedConvert('is_missing', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'arrivalTime': 'arrival_time',
        'isUnidentifiable': 'is_unidentifiable',
        'isMissing': 'is_missing',
      },
    );

Map<String, dynamic> _$TsunamiObservationStationFirstHeightToJson(
  _TsunamiObservationStationFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': instance.arrivalTime.toIso8601String(),
  'initial': instance.initial,
  'is_unidentifiable': instance.isUnidentifiable,
  'is_missing': instance.isMissing,
};

const _$WaveInitialEnumMap = {
  WaveInitial.push: 'PUSH',
  WaveInitial.pull: 'PULL',
};
