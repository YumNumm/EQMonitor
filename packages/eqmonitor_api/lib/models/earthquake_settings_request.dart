// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_tiers2.dart';

part 'earthquake_settings_request.freezed.dart';
part 'earthquake_settings_request.g.dart';

@Freezed()
abstract class EarthquakeSettingsRequest with _$EarthquakeSettingsRequest {
  const factory EarthquakeSettingsRequest({
    required bool enabled,
    @JsonKey(name: 'notification_tiers')
    required List<NotificationTiers2> notificationTiers,
    @JsonKey(name: 'estimated_intensity_enabled')
    required bool estimatedIntensityEnabled,
  }) = _EarthquakeSettingsRequest;
  
  factory EarthquakeSettingsRequest.fromJson(Map<String, Object?> json) => _$EarthquakeSettingsRequestFromJson(json);
}
