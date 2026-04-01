// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationPayload _$LocationPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LocationPayload', json, ($checkedConvert) {
      final val = _LocationPayload(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$LocationPayloadToJson(_LocationPayload instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
