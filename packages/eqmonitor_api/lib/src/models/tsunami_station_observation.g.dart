// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationObservation _$TsunamiStationObservationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiStationObservation',
  json,
  ($checkedConvert) {
    final val = _TsunamiStationObservation(
      firstHeight: $checkedConvert(
        'first_height',
        (v) => TsunamiStationObservationFirstHeight.fromJson(
          v as Map<String, dynamic>,
        ),
      ),
      sensor: $checkedConvert('sensor', (v) => v as String?),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => v == null
            ? null
            : TsunamiStationObservationMaxHeight.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'firstHeight': 'first_height', 'maxHeight': 'max_height'},
);

Map<String, dynamic> _$TsunamiStationObservationToJson(
  _TsunamiStationObservation instance,
) => <String, dynamic>{
  'first_height': instance.firstHeight,
  'sensor': ?instance.sensor,
  'max_height': ?instance.maxHeight,
};
