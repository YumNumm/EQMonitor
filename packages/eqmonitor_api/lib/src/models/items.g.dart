// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Items _$ItemsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Items',
  json,
  ($checkedConvert) {
    final val = _Items(
      correlationKey: $checkedConvert('correlation_key', (v) => v as String),
      eventType: $checkedConvert('event_type', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      serialNo: $checkedConvert('serial_no', (v) => v as num),
      jmaReportTime: $checkedConvert('jma_report_time', (v) => v as String),
      targetDevices: $checkedConvert('target_devices', (v) => v as num),
      enqueuedFcm: $checkedConvert('enqueued_fcm', (v) => v as num),
      enqueuedApns: $checkedConvert('enqueued_apns', (v) => v as num),
      enqueuedBroadcast: $checkedConvert('enqueued_broadcast', (v) => v as num),
      successFcm: $checkedConvert('success_fcm', (v) => v as num),
      failedFcm: $checkedConvert('failed_fcm', (v) => v as num),
      successApns: $checkedConvert('success_apns', (v) => v as num),
      failedApns: $checkedConvert('failed_apns', (v) => v as num),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
      headline: $checkedConvert('headline', (v) => v as String?),
      resolverDelayMs: $checkedConvert('resolver_delay_ms', (v) => v as num?),
    );
    return val;
  },
  fieldKeyMap: const {
    'correlationKey': 'correlation_key',
    'eventType': 'event_type',
    'eventId': 'event_id',
    'serialNo': 'serial_no',
    'jmaReportTime': 'jma_report_time',
    'targetDevices': 'target_devices',
    'enqueuedFcm': 'enqueued_fcm',
    'enqueuedApns': 'enqueued_apns',
    'enqueuedBroadcast': 'enqueued_broadcast',
    'successFcm': 'success_fcm',
    'failedFcm': 'failed_fcm',
    'successApns': 'success_apns',
    'failedApns': 'failed_apns',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'resolverDelayMs': 'resolver_delay_ms',
  },
);

Map<String, dynamic> _$ItemsToJson(_Items instance) => <String, dynamic>{
  'correlation_key': instance.correlationKey,
  'event_type': instance.eventType,
  'event_id': instance.eventId,
  'serial_no': instance.serialNo,
  'jma_report_time': instance.jmaReportTime,
  'target_devices': instance.targetDevices,
  'enqueued_fcm': instance.enqueuedFcm,
  'enqueued_apns': instance.enqueuedApns,
  'enqueued_broadcast': instance.enqueuedBroadcast,
  'success_fcm': instance.successFcm,
  'failed_fcm': instance.failedFcm,
  'success_apns': instance.successApns,
  'failed_apns': instance.failedApns,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'headline': ?instance.headline,
  'resolver_delay_ms': ?instance.resolverDelayMs,
};
