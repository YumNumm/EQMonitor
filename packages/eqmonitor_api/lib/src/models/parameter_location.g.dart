// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterLocation _$ParameterLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterLocation', json, ($checkedConvert) {
      final val = _ParameterLocation(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ParameterLocationToJson(_ParameterLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
