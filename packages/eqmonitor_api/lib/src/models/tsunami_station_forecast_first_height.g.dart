// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_forecast_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationForecastFirstHeight _$TsunamiStationForecastFirstHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiStationForecastFirstHeight', json, (
  $checkedConvert,
) {
  final val = _TsunamiStationForecastFirstHeight(
    arrivalTime: $checkedConvert(
      'arrival_time',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    condition: $checkedConvert(
      'condition',
      (v) => $enumDecodeNullable(_$FirstHeightConditionEnumMap, v),
    ),
    revise: $checkedConvert(
      'revise',
      (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
    ),
  );
  return val;
}, fieldKeyMap: const {'arrivalTime': 'arrival_time'});

Map<String, dynamic> _$TsunamiStationForecastFirstHeightToJson(
  _TsunamiStationForecastFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'condition': ?instance.condition,
  'revise': ?instance.revise,
};

const _$FirstHeightConditionEnumMap = {
  FirstHeightCondition.arriving: 'ARRIVING',
  FirstHeightCondition.firstWaveConfirmed: 'FIRST_WAVE_CONFIRMED',
  FirstHeightCondition.imminent: 'IMMINENT',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
