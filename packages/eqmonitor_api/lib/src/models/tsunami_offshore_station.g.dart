// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_offshore_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiOffshoreStation _$TsunamiOffshoreStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiOffshoreStation',
  json,
  ($checkedConvert) {
    final val = _TsunamiOffshoreStation(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
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

Map<String, dynamic> _$TsunamiOffshoreStationToJson(
  _TsunamiOffshoreStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'first_height': instance.firstHeight,
  'sensor': ?instance.sensor,
  'max_height': ?instance.maxHeight,
};
