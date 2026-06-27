// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_warning_kind.dart';

part 'tsunami_region_setting_patch_request.freezed.dart';
part 'tsunami_region_setting_patch_request.g.dart';

@Freezed()
abstract class TsunamiRegionSettingPatchRequest with _$TsunamiRegionSettingPatchRequest {
  const factory TsunamiRegionSettingPatchRequest({
    @JsonKey(includeIfNull: false,name: 'forecast_region_name')
    String? forecastRegionName,
    @JsonKey(includeIfNull: false,name: 'is_current_location')
    bool? isCurrentLocation,
    @JsonKey(includeIfNull: false,name: 'min_warning_kind')
    TsunamiWarningKind? minWarningKind,
  }) = _TsunamiRegionSettingPatchRequest;
  
  factory TsunamiRegionSettingPatchRequest.fromJson(Map<String, Object?> json) => _$TsunamiRegionSettingPatchRequestFromJson(json);
}
