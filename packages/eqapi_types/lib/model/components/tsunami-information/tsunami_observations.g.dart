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

Map<String, dynamic> _$$TsunamiObservationStationImplToJson(
        _$TsunamiObservationStationImpl instance) =>
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
