// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_setting_response.dart';

part 'shake_detection_settings_response.freezed.dart';
part 'shake_detection_settings_response.g.dart';

@Freezed()
abstract class ShakeDetectionSettingsResponse with _$ShakeDetectionSettingsResponse {
  const factory ShakeDetectionSettingsResponse({
    required List<ShakeDetectionSettingResponse> settings,
    @JsonKey(name: 'requires_reconfiguration')
    required bool requiresReconfiguration,
  }) = _ShakeDetectionSettingsResponse;
  
  factory ShakeDetectionSettingsResponse.fromJson(Map<String, Object?> json) => _$ShakeDetectionSettingsResponseFromJson(json);
}
