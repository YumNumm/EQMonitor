// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_default_interruption_level.dart';
import 'eew_default_interruption_level.dart';

part 'notification_defaults_response.freezed.dart';
part 'notification_defaults_response.g.dart';

@Freezed()
abstract class NotificationDefaultsResponse with _$NotificationDefaultsResponse {
  const factory NotificationDefaultsResponse({
    @JsonKey(name: 'eew_enabled')
    required bool eewEnabled,
    @JsonKey(name: 'earthquake_enabled')
    required bool earthquakeEnabled,
    @JsonKey(name: 'eew_default_sound')
    required String eewDefaultSound,
    @JsonKey(name: 'eew_default_interruption_level')
    required EewDefaultInterruptionLevel eewDefaultInterruptionLevel,
    @JsonKey(name: 'earthquake_default_sound')
    required String earthquakeDefaultSound,
    @JsonKey(name: 'earthquake_default_interruption_level')
    required EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel,
    @JsonKey(name: 'start_live_activity')
    required bool startLiveActivity,
    @JsonKey(name: 'eew_one_point_enabled')
    required bool eewOnePointEnabled,
    @JsonKey(name: 'eew_collapse_notification')
    required bool eewCollapseNotification,
    @JsonKey(name: 'earthquake_estimated_intensity_enabled')
    required bool earthquakeEstimatedIntensityEnabled,
    @JsonKey(name: 'earthquake_collapse_notification')
    required bool earthquakeCollapseNotification,
    @JsonKey(name: 'is_pro')
    required bool isPro,
  }) = _NotificationDefaultsResponse;
  
  factory NotificationDefaultsResponse.fromJson(Map<String, Object?> json) => _$NotificationDefaultsResponseFromJson(json);
}
