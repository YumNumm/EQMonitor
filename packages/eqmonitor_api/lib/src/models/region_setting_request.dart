// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';

part 'region_setting_request.freezed.dart';
part 'region_setting_request.g.dart';

@Freezed()
abstract class RegionSettingRequest with _$RegionSettingRequest {
  const factory RegionSettingRequest({
    @JsonKey(name: 'region_id')
    required num regionId,
    @JsonKey(name: 'is_current_location')
    required bool isCurrentLocation,
    @JsonKey(name: 'min_jma_intensity')
    required JmaIntensity minJmaIntensity,
    @JsonKey(includeIfNull: false,name: 'region_name')
    String? regionName,
  }) = _RegionSettingRequest;
  
  factory RegionSettingRequest.fromJson(Map<String, Object?> json) => _$RegionSettingRequestFromJson(json);
}
