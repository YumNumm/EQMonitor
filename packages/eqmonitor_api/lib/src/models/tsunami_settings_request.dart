// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_notification_tier.dart';

part 'tsunami_settings_request.freezed.dart';
part 'tsunami_settings_request.g.dart';

@Freezed()
abstract class TsunamiSettingsRequest with _$TsunamiSettingsRequest {
  const factory TsunamiSettingsRequest({
    @JsonKey(includeIfNull: false,name: 'notification_tiers')
    List<TsunamiNotificationTier>? notificationTiers,
    @JsonKey(includeIfNull: false,name: 'start_live_activity')
    bool? startLiveActivity,
  }) = _TsunamiSettingsRequest;
  
  factory TsunamiSettingsRequest.fromJson(Map<String, Object?> json) => _$TsunamiSettingsRequestFromJson(json);
}
