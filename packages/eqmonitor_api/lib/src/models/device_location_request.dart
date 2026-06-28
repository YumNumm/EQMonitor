// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_request.freezed.dart';
part 'device_location_request.g.dart';

@Freezed()
abstract class DeviceLocationRequest with _$DeviceLocationRequest {
  const factory DeviceLocationRequest({
    @JsonKey(name: 'region_id')
    required String regionId,
    @JsonKey(includeIfNull: false,name: 'city_code')
    String? cityCode,
    @JsonKey(includeIfNull: false,name: 'tsunami_forecast_region_code')
    String? tsunamiForecastRegionCode,
  }) = _DeviceLocationRequest;
  
  factory DeviceLocationRequest.fromJson(Map<String, Object?> json) => _$DeviceLocationRequestFromJson(json);
}
