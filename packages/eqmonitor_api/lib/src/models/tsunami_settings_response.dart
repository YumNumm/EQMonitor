// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_notification_tier.dart';

part 'tsunami_settings_response.freezed.dart';
part 'tsunami_settings_response.g.dart';

@Freezed()
abstract class TsunamiSettingsResponse with _$TsunamiSettingsResponse {
  const factory TsunamiSettingsResponse({
    @JsonKey(name: 'notification_tiers')
    required List<TsunamiNotificationTier> notificationTiers,
    @JsonKey(name: 'start_live_activity')
    required bool startLiveActivity,
  }) = _TsunamiSettingsResponse;
  
  factory TsunamiSettingsResponse.fromJson(Map<String, Object?> json) => _$TsunamiSettingsResponseFromJson(json);
}
