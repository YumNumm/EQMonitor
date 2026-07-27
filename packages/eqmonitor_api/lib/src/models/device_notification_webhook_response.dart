// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_notification_webhook_response.freezed.dart';
part 'device_notification_webhook_response.g.dart';

@Freezed()
abstract class DeviceNotificationWebhookResponse with _$DeviceNotificationWebhookResponse {
  const factory DeviceNotificationWebhookResponse({
    required String id,
    required DateTime createdAt,
    @JsonKey(includeIfNull: true)
    required DateTime? expiresAt,
    required bool approved,
    @JsonKey(includeIfNull: true)
    required String? webhookUrl,
  }) = _DeviceNotificationWebhookResponse;
  
  factory DeviceNotificationWebhookResponse.fromJson(Map<String, Object?> json) => _$DeviceNotificationWebhookResponseFromJson(json);
}
