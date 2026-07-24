// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Location3 _$Location3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Location3', json, ($checkedConvert) {
      final val = _Location3(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$Location3ToJson(_Location3 instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
