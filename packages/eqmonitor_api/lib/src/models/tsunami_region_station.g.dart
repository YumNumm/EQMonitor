// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionStation _$TsunamiRegionStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiRegionStation', json, ($checkedConvert) {
  final val = _TsunamiRegionStation(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    forecast: $checkedConvert(
      'forecast',
      (v) => v == null
          ? null
          : TsunamiStationForecast.fromJson(v as Map<String, dynamic>),
    ),
    observation: $checkedConvert(
      'observation',
      (v) => v == null
          ? null
          : TsunamiStationObservation.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiRegionStationToJson(
  _TsunamiRegionStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'forecast': ?instance.forecast,
  'observation': ?instance.observation,
};
