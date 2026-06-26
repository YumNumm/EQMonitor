// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shindo_db_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShindoDbStation _$ShindoDbStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShindoDbStation', json, ($checkedConvert) {
      final val = _ShindoDbStation(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ShindoDbStationToJson(_ShindoDbStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
