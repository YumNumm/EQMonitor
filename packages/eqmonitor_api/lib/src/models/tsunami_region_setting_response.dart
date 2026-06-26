// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_warning_kind.dart';

part 'tsunami_region_setting_response.freezed.dart';
part 'tsunami_region_setting_response.g.dart';

@Freezed()
abstract class TsunamiRegionSettingResponse with _$TsunamiRegionSettingResponse {
  const factory TsunamiRegionSettingResponse({
    required String id,
    @JsonKey(name: 'forecast_region_code')
    required String forecastRegionCode,
    @JsonKey(includeIfNull: true,name: 'forecast_region_name')
    required String? forecastRegionName,
    @JsonKey(name: 'is_current_location')
    required bool isCurrentLocation,
    @JsonKey(name: 'min_warning_kind')
    required TsunamiWarningKind minWarningKind,
    @JsonKey(name: 'created_at')
    required String createdAt,
    @JsonKey(name: 'updated_at')
    required String updatedAt,
  }) = _TsunamiRegionSettingResponse;
  
  factory TsunamiRegionSettingResponse.fromJson(Map<String, Object?> json) => _$TsunamiRegionSettingResponseFromJson(json);
}
