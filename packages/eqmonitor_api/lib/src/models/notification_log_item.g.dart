// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_log_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationLogItem _$NotificationLogItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationLogItem',
  json,
  ($checkedConvert) {
    final val = _NotificationLogItem(
      streamId: $checkedConvert('stream_id', (v) => v as String),
      deviceId: $checkedConvert('device_id', (v) => v as String),
      framework: $checkedConvert(
        'framework',
        (v) => $enumDecode(_$FrameworkEnumMap, v),
      ),
      result: $checkedConvert('result', (v) => $enumDecode(_$ResultEnumMap, v)),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      errorCode: $checkedConvert('error_code', (v) => v as String?),
      errorMessage: $checkedConvert('error_message', (v) => v as String?),
      eventId: $checkedConvert('event_id', (v) => v as String?),
      title: $checkedConvert('title', (v) => v as String?),
      body: $checkedConvert('body', (v) => v as String?),
      androidPriority: $checkedConvert('android_priority', (v) => v as String?),
      androidNotificationPriority: $checkedConvert(
        'android_notification_priority',
        (v) => v as String?,
      ),
      channelId: $checkedConvert('channel_id', (v) => v as String?),
      apnsPriority: $checkedConvert('apns_priority', (v) => v as String?),
      interruptionLevel: $checkedConvert(
        'interruption_level',
        (v) => v as String?,
      ),
      liveActivityEvent: $checkedConvert(
        'live_activity_event',
        (v) => $enumDecodeNullable(_$LiveActivityEventEnumMap, v),
      ),
      startTrigger: $checkedConvert(
        'start_trigger',
        (v) => $enumDecodeNullable(_$StartTriggerEnumMap, v),
      ),
      serialNo: $checkedConvert('serial_no', (v) => v as num?),
      eventType: $checkedConvert('event_type', (v) => v as String?),
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
    'androidPriority': 'android_priority',
    'androidNotificationPriority': 'android_notification_priority',
    'channelId': 'channel_id',
    'apnsPriority': 'apns_priority',
    'interruptionLevel': 'interruption_level',
    'liveActivityEvent': 'live_activity_event',
    'startTrigger': 'start_trigger',
    'serialNo': 'serial_no',
    'eventType': 'event_type',
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
  'android_priority': ?instance.androidPriority,
  'android_notification_priority': ?instance.androidNotificationPriority,
  'channel_id': ?instance.channelId,
  'apns_priority': ?instance.apnsPriority,
  'interruption_level': ?instance.interruptionLevel,
  'live_activity_event': ?instance.liveActivityEvent,
  'start_trigger': ?instance.startTrigger,
  'serial_no': ?instance.serialNo,
  'event_type': ?instance.eventType,
};

const _$FrameworkEnumMap = {Framework.fcm: 'FCM', Framework.apns: 'APNS'};

const _$ResultEnumMap = {Result.ok: 'OK', Result.ng: 'NG'};

const _$LiveActivityEventEnumMap = {
  LiveActivityEvent.start: 'START',
  LiveActivityEvent.update: 'UPDATE',
  LiveActivityEvent.end: 'END',
};

const _$StartTriggerEnumMap = {
  StartTrigger.eew: 'EEW',
  StartTrigger.shakeDetection: 'SHAKE_DETECTION',
};
