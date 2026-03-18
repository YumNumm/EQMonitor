// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_log_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationLogItem _$NotificationLogItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationLogItem',
      json,
      ($checkedConvert) {
        final val = _NotificationLogItem(
          streamId: $checkedConvert('stream_id', (v) => v as String),
          deviceId: $checkedConvert('device_id', (v) => v as String),
          framework: $checkedConvert(
            'framework',
            (v) => $enumDecode(_$NotificationLogItemFrameworkEnumMap, v),
          ),
          result: $checkedConvert(
            'result',
            (v) => $enumDecode(_$NotificationLogItemResultEnumMap, v),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          errorCode: $checkedConvert('error_code', (v) => v as String?),
          errorMessage: $checkedConvert('error_message', (v) => v as String?),
          eventId: $checkedConvert('event_id', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'streamId': 'stream_id',
        'deviceId': 'device_id',
        'createdAt': 'created_at',
        'errorCode': 'error_code',
        'errorMessage': 'error_message',
        'eventId': 'event_id',
      },
    );

Map<String, dynamic> _$NotificationLogItemToJson(
  _NotificationLogItem instance,
) => <String, dynamic>{
  'stream_id': instance.streamId,
  'device_id': instance.deviceId,
  'framework': instance.framework,
  'result': instance.result,
  'created_at': instance.createdAt,
  'error_code': ?instance.errorCode,
  'error_message': ?instance.errorMessage,
  'event_id': ?instance.eventId,
  'title': ?instance.title,
  'body': ?instance.body,
};

const _$NotificationLogItemFrameworkEnumMap = {
  NotificationLogItemFramework.fcm: 'FCM',
  NotificationLogItemFramework.apns: 'APNS',
};

const _$NotificationLogItemResultEnumMap = {
  NotificationLogItemResult.ok: 'OK',
  NotificationLogItemResult.ng: 'NG',
};
