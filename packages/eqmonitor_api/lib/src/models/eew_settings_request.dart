// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_tiers4.dart';

part 'eew_settings_request.freezed.dart';
part 'eew_settings_request.g.dart';

@Freezed()
abstract class EewSettingsRequest with _$EewSettingsRequest {
  const factory EewSettingsRequest({
    @JsonKey(includeIfNull: false) bool? enabled,
    @JsonKey(name: 'notification_tiers')
    List<NotificationTiers4>? notificationTiers,
    @JsonKey(includeIfNull: false, name: 'start_live_activity')
    bool? startLiveActivity,
    @JsonKey(includeIfNull: false, name: 'one_point_enabled')
    bool? onePointEnabled,
  }) = _EewSettingsRequest;

  factory EewSettingsRequest.fromJson(Map<String, Object?> json) =>
      _$EewSettingsRequestFromJson(json);
}
