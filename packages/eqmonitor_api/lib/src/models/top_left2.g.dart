// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'top_left2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopLeft2 _$TopLeft2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TopLeft2', json, ($checkedConvert) {
      final val = _TopLeft2(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TopLeft2ToJson(_TopLeft2 instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
