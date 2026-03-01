// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'region_setting_patch_request_min_jma_intensity.dart';

part 'region_setting_patch_request.freezed.dart';
part 'region_setting_patch_request.g.dart';

@Freezed()
abstract class RegionSettingPatchRequest with _$RegionSettingPatchRequest {
  const factory RegionSettingPatchRequest({
    @JsonKey(name: 'is_current_location') required bool isCurrentLocation,
    @JsonKey(name: 'min_jma_intensity')
    required RegionSettingPatchRequestMinJmaIntensity minJmaIntensity,
    @JsonKey(includeIfNull: false, name: 'region_name') String? regionName,
  }) = _RegionSettingPatchRequest;

  factory RegionSettingPatchRequest.fromJson(Map<String, Object?> json) =>
      _$RegionSettingPatchRequestFromJson(json);
}
