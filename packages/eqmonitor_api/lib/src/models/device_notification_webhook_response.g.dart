// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_notification_webhook_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceNotificationWebhookResponse _$DeviceNotificationWebhookResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceNotificationWebhookResponse', json, (
  $checkedConvert,
) {
  final val = _DeviceNotificationWebhookResponse(
    id: $checkedConvert('id', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    expiresAt: $checkedConvert(
      'expiresAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    approved: $checkedConvert('approved', (v) => v as bool),
    webhookUrl: $checkedConvert('webhookUrl', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DeviceNotificationWebhookResponseToJson(
  _DeviceNotificationWebhookResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'approved': instance.approved,
  'webhookUrl': instance.webhookUrl,
};
