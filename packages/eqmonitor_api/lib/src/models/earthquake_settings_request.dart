// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'default_interruption_level.dart';

part 'earthquake_settings_request.freezed.dart';
part 'earthquake_settings_request.g.dart';

@Freezed()
abstract class EarthquakeSettingsRequest with _$EarthquakeSettingsRequest {
  const factory EarthquakeSettingsRequest({
    @JsonKey(includeIfNull: false)
    bool? enabled,
    @JsonKey(includeIfNull: false,name: 'default_sound')
    String? defaultSound,
    @JsonKey(includeIfNull: false,name: 'default_interruption_level')
    DefaultInterruptionLevel? defaultInterruptionLevel,
    @JsonKey(includeIfNull: false,name: 'estimated_intensity_enabled')
    bool? estimatedIntensityEnabled,
    @JsonKey(includeIfNull: false,name: 'collapse_notification')
    bool? collapseNotification,
  }) = _EarthquakeSettingsRequest;
  
  factory EarthquakeSettingsRequest.fromJson(Map<String, Object?> json) => _$EarthquakeSettingsRequestFromJson(json);
}
