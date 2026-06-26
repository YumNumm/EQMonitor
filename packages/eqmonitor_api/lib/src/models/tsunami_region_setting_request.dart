// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_warning_kind.dart';

part 'tsunami_region_setting_request.freezed.dart';
part 'tsunami_region_setting_request.g.dart';

@Freezed()
abstract class TsunamiRegionSettingRequest with _$TsunamiRegionSettingRequest {
  const factory TsunamiRegionSettingRequest({
    @JsonKey(name: 'forecast_region_code')
    required String forecastRegionCode,
    @JsonKey(name: 'is_current_location')
    required bool isCurrentLocation,
    @JsonKey(name: 'min_warning_kind')
    required TsunamiWarningKind minWarningKind,
    @JsonKey(includeIfNull: false,name: 'forecast_region_name')
    String? forecastRegionName,
  }) = _TsunamiRegionSettingRequest;
  
  factory TsunamiRegionSettingRequest.fromJson(Map<String, Object?> json) => _$TsunamiRegionSettingRequestFromJson(json);
}
