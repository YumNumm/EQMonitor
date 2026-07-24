// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'top_left3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopLeft3 _$TopLeft3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TopLeft3', json, ($checkedConvert) {
      final val = _TopLeft3(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TopLeft3ToJson(_TopLeft3 instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
