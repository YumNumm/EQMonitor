// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_notification_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PushNotificationHistory _$PushNotificationHistoryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PushNotificationHistory', json, ($checkedConvert) {
  final val = _PushNotificationHistory(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map(
            (e) => PushNotificationLogEntry.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    nextCursor: $checkedConvert('next_cursor', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'nextCursor': 'next_cursor'});

Map<String, dynamic> _$PushNotificationHistoryToJson(
  _PushNotificationHistory instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_cursor': instance.nextCursor,
};

_PushNotificationLogEntry _$PushNotificationLogEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PushNotificationLogEntry',
  json,
  ($checkedConvert) {
    final val = _PushNotificationLogEntry(
      streamId: $checkedConvert('stream_id', (v) => v as String),
      deviceId: $checkedConvert('device_id', (v) => v as String),
      framework: $checkedConvert(
        'framework',
        (v) => $enumDecode(_$PushNotificationDeliveryFrameworkEnumMap, v),
      ),
      result: $checkedConvert(
        'result',
        (v) => $enumDecode(_$PushNotificationDeliveryResultEnumMap, v),
      ),
      createdAtIso: $checkedConvert('created_at_iso', (v) => v as String),
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
    );
    return val;
  },
  fieldKeyMap: const {
    'streamId': 'stream_id',
    'deviceId': 'device_id',
    'createdAtIso': 'created_at_iso',
    'errorCode': 'error_code',
    'errorMessage': 'error_message',
    'eventId': 'event_id',
    'androidPriority': 'android_priority',
    'androidNotificationPriority': 'android_notification_priority',
    'channelId': 'channel_id',
    'apnsPriority': 'apns_priority',
    'interruptionLevel': 'interruption_level',
  },
);

Map<String, dynamic> _$PushNotificationLogEntryToJson(
  _PushNotificationLogEntry instance,
) => <String, dynamic>{
  'stream_id': instance.streamId,
  'device_id': instance.deviceId,
  'framework': _$PushNotificationDeliveryFrameworkEnumMap[instance.framework]!,
  'result': _$PushNotificationDeliveryResultEnumMap[instance.result]!,
  'created_at_iso': instance.createdAtIso,
  'error_code': instance.errorCode,
  'error_message': instance.errorMessage,
  'event_id': instance.eventId,
  'title': instance.title,
  'body': instance.body,
  'android_priority': instance.androidPriority,
  'android_notification_priority': instance.androidNotificationPriority,
  'channel_id': instance.channelId,
  'apns_priority': instance.apnsPriority,
  'interruption_level': instance.interruptionLevel,
};

const _$PushNotificationDeliveryFrameworkEnumMap = {
  PushNotificationDeliveryFramework.fcm: 'fcm',
  PushNotificationDeliveryFramework.apns: 'apns',
};

const _$PushNotificationDeliveryResultEnumMap = {
  PushNotificationDeliveryResult.ok: 'ok',
  PushNotificationDeliveryResult.ng: 'ng',
};
