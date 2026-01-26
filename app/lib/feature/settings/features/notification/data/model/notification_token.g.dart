// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationToken _$NotificationTokenFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationToken',
      json,
      ($checkedConvert) {
        final val = _NotificationToken(
          fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
          apnsToken: $checkedConvert('apns_token', (v) => v as String?),
          apnsPushToStartToken: $checkedConvert(
            'apns_push_to_start_token',
            (v) => v as String?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'fcmToken': 'fcm_token',
        'apnsToken': 'apns_token',
        'apnsPushToStartToken': 'apns_push_to_start_token',
      },
    );

Map<String, dynamic> _$NotificationTokenToJson(_NotificationToken instance) =>
    <String, dynamic>{
      'fcm_token': instance.fcmToken,
      'apns_token': instance.apnsToken,
      'apns_push_to_start_token': instance.apnsPushToStartToken,
    };
