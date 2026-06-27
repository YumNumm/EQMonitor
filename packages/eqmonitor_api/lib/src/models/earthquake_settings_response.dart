// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_tier.dart';

part 'earthquake_settings_response.freezed.dart';
part 'earthquake_settings_response.g.dart';

@Freezed()
abstract class EarthquakeSettingsResponse with _$EarthquakeSettingsResponse {
  const factory EarthquakeSettingsResponse({
    required bool enabled,
    @JsonKey(name: 'notification_tiers')
    required List<NotificationTier> notificationTiers,
    @JsonKey(name: 'estimated_intensity_enabled')
    required bool estimatedIntensityEnabled,
  }) = _EarthquakeSettingsResponse;
  
  factory EarthquakeSettingsResponse.fromJson(Map<String, Object?> json) => _$EarthquakeSettingsResponseFromJson(json);
}
