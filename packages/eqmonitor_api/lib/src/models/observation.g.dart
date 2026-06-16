// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Observation _$ObservationFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Observation',
  json,
  ($checkedConvert) {
    final val = _Observation(
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  TsunamiObservationStation.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$ObservationToJson(_Observation instance) =>
    <String, dynamic>{'stations': instance.stations};
