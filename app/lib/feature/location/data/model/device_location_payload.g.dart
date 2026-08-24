// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationPayload _$DeviceLocationPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocationPayload', json, ($checkedConvert) {
  final val = _DeviceLocationPayload(
    region: $checkedConvert('region', (v) => v as String),
    city: $checkedConvert('city', (v) => v as String?),
    tsunamiForecastRegion: $checkedConvert(
      'tsunamiForecastRegion',
      (v) => v as String?,
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocationPayloadToJson(
  _DeviceLocationPayload instance,
) => <String, dynamic>{
  'region': instance.region,
  'city': instance.city,
  'tsunamiForecastRegion': instance.tsunamiForecastRegion,
};
