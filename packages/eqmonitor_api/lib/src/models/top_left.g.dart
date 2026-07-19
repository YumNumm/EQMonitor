// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'top_left.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopLeft _$TopLeftFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TopLeft', json, ($checkedConvert) {
      final val = _TopLeft(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TopLeftToJson(_TopLeft instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
