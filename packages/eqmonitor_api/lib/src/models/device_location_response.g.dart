// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationResponse _$DeviceLocationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_DeviceLocationResponse',
  json,
  ($checkedConvert) {
    final val = _DeviceLocationResponse(
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

Map<String, dynamic> _$DeviceLocationResponseToJson(
  _DeviceLocationResponse instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'city_code': instance.cityCode,
  'tsunami_forecast_region_code': instance.tsunamiForecastRegionCode,
};
