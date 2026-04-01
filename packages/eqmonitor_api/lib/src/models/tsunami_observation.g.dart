// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiObservation _$TsunamiObservationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiObservation', json, ($checkedConvert) {
      final val = _TsunamiObservation(
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TsunamiObservationStation.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
        code: $checkedConvert('code', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiObservationToJson(_TsunamiObservation instance) =>
    <String, dynamic>{
      'stations': instance.stations,
      'code': ?instance.code,
      'name': ?instance.name,
    };
