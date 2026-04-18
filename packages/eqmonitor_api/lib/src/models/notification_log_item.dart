// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'framework.dart';
import 'result.dart';

part 'notification_log_item.freezed.dart';
part 'notification_log_item.g.dart';

@Freezed()
abstract class NotificationLogItem with _$NotificationLogItem {
  const factory NotificationLogItem({
    @JsonKey(name: 'stream_id') required String streamId,
    @JsonKey(name: 'device_id') required String deviceId,
    required Framework framework,
    required Result result,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(includeIfNull: false, name: 'error_code') String? errorCode,
    @JsonKey(includeIfNull: false, name: 'error_message') String? errorMessage,
    @JsonKey(includeIfNull: false, name: 'event_id') String? eventId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) String? body,
    @JsonKey(includeIfNull: false, name: 'android_priority')
    String? androidPriority,
    @JsonKey(includeIfNull: false, name: 'android_notification_priority')
    String? androidNotificationPriority,
    @JsonKey(includeIfNull: false, name: 'channel_id') String? channelId,
    @JsonKey(includeIfNull: false, name: 'apns_priority') String? apnsPriority,
    @JsonKey(includeIfNull: false, name: 'interruption_level')
    String? interruptionLevel,
  }) = _NotificationLogItem;

  factory NotificationLogItem.fromJson(Map<String, Object?> json) =>
      _$NotificationLogItemFromJson(json);
}
