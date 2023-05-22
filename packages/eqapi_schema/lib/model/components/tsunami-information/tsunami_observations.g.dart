// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tsunami_observations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TsunamiObservation _$$_TsunamiObservationFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiObservation',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiObservation(
          code: $checkedConvert('code', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          stations: $checkedConvert(
              'stations',
              (v) => (v as List<dynamic>)
                  .map((e) => TsunamiObservationStation.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiObservationToJson(
        _$_TsunamiObservation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'stations': instance.stations,
    };

_$_TsunamiObservationStation _$$_TsunamiObservationStationFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiObservationStation',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiObservationStation(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          firstHeightArrivalTime: $checkedConvert('firstHeightArrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightInitial: $checkedConvert(
              'firstHeightInitial',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationFirstHeightInitialEnumMap, v)),
          maxHeightTime: $checkedConvert('maxHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue:
              $checkedConvert('maxHeightValue', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('maxHeightIsOver', (v) => v as bool?),
          maxHeightIsRising:
              $checkedConvert('maxHeightIsRising', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationStationConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiObservationStationToJson(
        _$_TsunamiObservationStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'firstHeightArrivalTime':
          instance.firstHeightArrivalTime?.toIso8601String(),
      'firstHeightInitial': _$TsunamiObservationFirstHeightInitialEnumMap[
          instance.firstHeightInitial],
      'maxHeightTime': instance.maxHeightTime?.toIso8601String(),
      'maxHeightValue': instance.maxHeightValue,
      'maxHeightIsOver': instance.maxHeightIsOver,
      'maxHeightIsRising': instance.maxHeightIsRising,
      'condition':
          _$TsunamiObservationStationConditionEnumMap[instance.condition],
    };

const _$TsunamiObservationFirstHeightInitialEnumMap = {
  TsunamiObservationFirstHeightInitial.push: '押し',
  TsunamiObservationFirstHeightInitial.pull: '引き',
};

const _$TsunamiObservationStationConditionEnumMap = {
  TsunamiObservationStationCondition.weak: '微弱',
  TsunamiObservationStationCondition.observing: '観測中',
  TsunamiObservationStationCondition.important: '重要',
};
