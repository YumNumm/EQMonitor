// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';

part 'region_setting_response.freezed.dart';
part 'region_setting_response.g.dart';

@Freezed()
abstract class RegionSettingResponse with _$RegionSettingResponse {
  const factory RegionSettingResponse({
    @JsonKey(name: 'region_id')
    required num regionId,
    @JsonKey(includeIfNull: true,name: 'region_name')
    required String? regionName,
    @JsonKey(includeIfNull: true,name: 'city_code')
    required String? cityCode,
    @JsonKey(includeIfNull: true,name: 'city_name')
    required String? cityName,
    @JsonKey(name: 'is_current_location')
    required bool isCurrentLocation,
    @JsonKey(name: 'min_jma_intensity')
    required JmaIntensity minJmaIntensity,
    @JsonKey(name: 'created_at')
    required String createdAt,
    @JsonKey(name: 'updated_at')
    required String updatedAt,
  }) = _RegionSettingResponse;
  
  factory RegionSettingResponse.fromJson(Map<String, Object?> json) => _$RegionSettingResponseFromJson(json);
}
