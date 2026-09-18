// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationRequest _$DeviceLocationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocationRequest', json, ($checkedConvert) {
  final val = _DeviceLocationRequest(
    region: $checkedConvert('region', (v) => v as String),
    city: $checkedConvert('city', (v) => v as String?),
    tsunamiForecastRegion: $checkedConvert(
      'tsunamiForecastRegion',
      (v) => v as String?,
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocationRequestToJson(
  _DeviceLocationRequest instance,
) => <String, dynamic>{
  'region': instance.region,
  'city': ?instance.city,
  'tsunamiForecastRegion': ?instance.tsunamiForecastRegion,
};
