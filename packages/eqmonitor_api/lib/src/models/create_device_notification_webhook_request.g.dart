// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'create_device_notification_webhook_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateDeviceNotificationWebhookRequest
_$CreateDeviceNotificationWebhookRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CreateDeviceNotificationWebhookRequest', json, (
      $checkedConvert,
    ) {
      final val = _CreateDeviceNotificationWebhookRequest(
        expiresInDays: $checkedConvert(
          'expiresInDays',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CreateDeviceNotificationWebhookRequestToJson(
  _CreateDeviceNotificationWebhookRequest instance,
) => <String, dynamic>{'expiresInDays': ?instance.expiresInDays};
