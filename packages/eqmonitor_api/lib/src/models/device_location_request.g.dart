// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationRequest _$DeviceLocationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_DeviceLocationRequest',
  json,
  ($checkedConvert) {
    final val = _DeviceLocationRequest(
      regionId: $checkedConvert('region_id', (v) => v as String),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      tsunamiForecastRegionCode: $checkedConvert(
        'tsunami_forecast_region_code',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'cityCode': 'city_code',
    'tsunamiForecastRegionCode': 'tsunami_forecast_region_code',
  },
);

Map<String, dynamic> _$DeviceLocationRequestToJson(
  _DeviceLocationRequest instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'city_code': ?instance.cityCode,
  'tsunami_forecast_region_code': ?instance.tsunamiForecastRegionCode,
};
