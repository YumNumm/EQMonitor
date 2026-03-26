// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_tiers3.dart';

part 'eew_settings_response.freezed.dart';
part 'eew_settings_response.g.dart';

@Freezed()
abstract class EewSettingsResponse with _$EewSettingsResponse {
  const factory EewSettingsResponse({
    required bool enabled,
    @JsonKey(name: 'notification_tiers')
    required List<NotificationTiers3> notificationTiers,
    @JsonKey(name: 'start_live_activity') required bool startLiveActivity,
  }) = _EewSettingsResponse;

  factory EewSettingsResponse.fromJson(Map<String, Object?> json) =>
      _$EewSettingsResponseFromJson(json);
}
