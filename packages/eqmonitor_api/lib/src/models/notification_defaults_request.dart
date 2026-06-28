// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_default_interruption_level.dart';
import 'eew_default_interruption_level.dart';

part 'notification_defaults_request.freezed.dart';
part 'notification_defaults_request.g.dart';

@Freezed()
abstract class NotificationDefaultsRequest with _$NotificationDefaultsRequest {
  const factory NotificationDefaultsRequest({
    @JsonKey(includeIfNull: false,name: 'eew_default_sound')
    String? eewDefaultSound,
    @JsonKey(includeIfNull: false,name: 'eew_default_interruption_level')
    EewDefaultInterruptionLevel? eewDefaultInterruptionLevel,
    @JsonKey(includeIfNull: false,name: 'earthquake_default_sound')
    String? earthquakeDefaultSound,
    @JsonKey(includeIfNull: false,name: 'earthquake_default_interruption_level')
    EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel,
    @JsonKey(includeIfNull: false,name: 'start_live_activity')
    bool? startLiveActivity,
    @JsonKey(includeIfNull: false,name: 'eew_one_point_enabled')
    bool? eewOnePointEnabled,
    @JsonKey(includeIfNull: false,name: 'eew_collapse_notification')
    bool? eewCollapseNotification,
    @JsonKey(includeIfNull: false,name: 'earthquake_estimated_intensity_enabled')
    bool? earthquakeEstimatedIntensityEnabled,
    @JsonKey(includeIfNull: false,name: 'earthquake_collapse_notification')
    bool? earthquakeCollapseNotification,
  }) = _NotificationDefaultsRequest;
  
  factory NotificationDefaultsRequest.fromJson(Map<String, Object?> json) => _$NotificationDefaultsRequestFromJson(json);
}
