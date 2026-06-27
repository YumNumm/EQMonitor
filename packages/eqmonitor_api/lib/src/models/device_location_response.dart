// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_response.freezed.dart';
part 'device_location_response.g.dart';

@Freezed()
abstract class DeviceLocationResponse with _$DeviceLocationResponse {
  const factory DeviceLocationResponse({
    @JsonKey(name: 'region_id')
    required String regionId,
    @JsonKey(includeIfNull: true,name: 'city_code')
    required String? cityCode,
    @JsonKey(includeIfNull: true,name: 'tsunami_forecast_region_code')
    required String? tsunamiForecastRegionCode,
  }) = _DeviceLocationResponse;
  
  factory DeviceLocationResponse.fromJson(Map<String, Object?> json) => _$DeviceLocationResponseFromJson(json);
}
