// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hypocenter _$HypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Hypocenter', json, ($checkedConvert) {
      final val = _Hypocenter(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
        depth: $checkedConvert('depth', (v) => v as num),
        name: $checkedConvert('name', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$HypocenterToJson(_Hypocenter instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depth': instance.depth,
      'name': ?instance.name,
    };
