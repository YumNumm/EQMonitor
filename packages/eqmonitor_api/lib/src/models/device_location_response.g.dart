// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationResponse _$DeviceLocationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocationResponse', json, ($checkedConvert) {
  final val = _DeviceLocationResponse(
    region: $checkedConvert('region', (v) => v as String),
    city: $checkedConvert('city', (v) => v as String?),
    tsunamiForecastRegion: $checkedConvert(
      'tsunamiForecastRegion',
      (v) => v as String?,
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocationResponseToJson(
  _DeviceLocationResponse instance,
) => <String, dynamic>{
  'region': instance.region,
  'city': instance.city,
  'tsunamiForecastRegion': instance.tsunamiForecastRegion,
};
