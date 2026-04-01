// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'event_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventHypocenter _$EventHypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EventHypocenter', json, ($checkedConvert) {
      final val = _EventHypocenter(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
        depth: $checkedConvert('depth', (v) => v as num),
        name: $checkedConvert('name', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$EventHypocenterToJson(_EventHypocenter instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depth': instance.depth,
      'name': ?instance.name,
    };
