// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'tsunami_observations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiObservationImpl _$$TsunamiObservationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiObservationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiObservationImpl(
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

Map<String, dynamic> _$$TsunamiObservationImplToJson(
        _$TsunamiObservationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'stations': instance.stations,
    };

_$TsunamiObservationStationImpl _$$TsunamiObservationStationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiObservationStationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiObservationStationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          firstHeightArrivalTime: $checkedConvert('first_height_arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightInitial: $checkedConvert(
              'first_height_initial',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationFirstHeightInitialEnumMap, v)),
          maxHeightTime: $checkedConvert('max_height_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue: $checkedConvert(
              'max_height_value', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('max_height_is_over', (v) => v as bool?),
          maxHeightIsRising:
              $checkedConvert('max_height_is_rising', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiObservationStationConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'firstHeightArrivalTime': 'first_height_arrival_time',
        'firstHeightInitial': 'first_height_initial',
        'maxHeightTime': 'max_height_time',
        'maxHeightValue': 'max_height_value',
        'maxHeightIsOver': 'max_height_is_over',
        'maxHeightIsRising': 'max_height_is_rising'
      },
    );

Map<String, dynamic> _$$TsunamiObservationStationImplToJson(
        _$TsunamiObservationStationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'first_height_arrival_time':
          instance.firstHeightArrivalTime?.toIso8601String(),
      'first_height_initial': _$TsunamiObservationFirstHeightInitialEnumMap[
          instance.firstHeightInitial],
      'max_height_time': instance.maxHeightTime?.toIso8601String(),
      'max_height_value': instance.maxHeightValue,
      'max_height_is_over': instance.maxHeightIsOver,
      'max_height_is_rising': instance.maxHeightIsRising,
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
