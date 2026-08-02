// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStation _$TsunamiStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiStation', json, ($checkedConvert) {
      final val = _TsunamiStation(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
        ),
        kana: $checkedConvert('kana', (v) => v as String?),
        owner: $checkedConvert('owner', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => ParameterLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiStationToJson(_TsunamiStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
      'owner': instance.owner,
      'location': instance.location,
    };
