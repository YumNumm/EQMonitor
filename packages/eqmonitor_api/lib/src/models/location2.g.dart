// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Location2 _$Location2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Location2', json, ($checkedConvert) {
      final val = _Location2(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$Location2ToJson(_Location2 instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
