// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';

part 'region_setting_patch_request.freezed.dart';
part 'region_setting_patch_request.g.dart';

@Freezed()
abstract class RegionSettingPatchRequest with _$RegionSettingPatchRequest {
  const factory RegionSettingPatchRequest({
    @JsonKey(includeIfNull: false, name: 'region_name') String? regionName,
    @JsonKey(includeIfNull: false, name: 'city_code') String? cityCode,
    @JsonKey(includeIfNull: false, name: 'city_name') String? cityName,
    @JsonKey(includeIfNull: false, name: 'is_current_location')
    bool? isCurrentLocation,
    @JsonKey(includeIfNull: false, name: 'min_jma_intensity')
    JmaIntensity? minJmaIntensity,
  }) = _RegionSettingPatchRequest;

  factory RegionSettingPatchRequest.fromJson(Map<String, Object?> json) =>
      _$RegionSettingPatchRequestFromJson(json);
}
