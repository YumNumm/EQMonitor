// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_device_notification_webhook_request.freezed.dart';
part 'create_device_notification_webhook_request.g.dart';

/// 通知Webhook作成リクエスト
@Freezed()
abstract class CreateDeviceNotificationWebhookRequest with _$CreateDeviceNotificationWebhookRequest {
  const factory CreateDeviceNotificationWebhookRequest({
    /// Webhookの有効期限（日数）。nullまたは省略時は無期限
    @JsonKey(includeIfNull: false)
    int? expiresInDays,
  }) = _CreateDeviceNotificationWebhookRequest;

  factory CreateDeviceNotificationWebhookRequest.fromJson(Map<String, Object?> json) => _$CreateDeviceNotificationWebhookRequestFromJson(json);
}
