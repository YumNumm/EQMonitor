// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'items3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Items3 _$Items3FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Items3',
  json,
  ($checkedConvert) {
    final val = _Items3(
      correlationKey: $checkedConvert('correlationKey', (v) => v as String),
      eventType: $checkedConvert('eventType', (v) => v as String),
      eventId: $checkedConvert('eventId', (v) => v as String),
      serialNo: $checkedConvert('serialNo', (v) => v as num),
      jmaReportTime: $checkedConvert('jmaReportTime', (v) => v as String),
      targetDevices: $checkedConvert('targetDevices', (v) => v as num),
      enqueuedFcm: $checkedConvert('enqueuedFcm', (v) => v as num),
      enqueuedApns: $checkedConvert('enqueuedApns', (v) => v as num),
      enqueuedBroadcast: $checkedConvert('enqueuedBroadcast', (v) => v as num),
      successFcm: $checkedConvert('successFcm', (v) => v as num),
      failedFcm: $checkedConvert('failedFcm', (v) => v as num),
      successApns: $checkedConvert('successApns', (v) => v as num),
      failedApns: $checkedConvert('failedApns', (v) => v as num),
      headline: $checkedConvert('headline', (v) => v as String?),
      resolverDelayMs: $checkedConvert('resolverDelayMs', (v) => v as num?),
      proxyReceivedAt: $checkedConvert('proxyReceivedAt', (v) => v as String?),
      resolverDoneAt: $checkedConvert('resolverDoneAt', (v) => v as String?),
      sendStartedAt: $checkedConvert('sendStartedAt', (v) => v as String?),
      sendCompletedAt: $checkedConvert('sendCompletedAt', (v) => v as String?),
    );
    return val;
  },
);

Map<String, dynamic> _$Items3ToJson(_Items3 instance) => <String, dynamic>{
  'correlationKey': instance.correlationKey,
  'eventType': instance.eventType,
  'eventId': instance.eventId,
  'serialNo': instance.serialNo,
  'jmaReportTime': instance.jmaReportTime,
  'targetDevices': instance.targetDevices,
  'enqueuedFcm': instance.enqueuedFcm,
  'enqueuedApns': instance.enqueuedApns,
  'enqueuedBroadcast': instance.enqueuedBroadcast,
  'successFcm': instance.successFcm,
  'failedFcm': instance.failedFcm,
  'successApns': instance.successApns,
  'failedApns': instance.failedApns,
  'headline': ?instance.headline,
  'resolverDelayMs': ?instance.resolverDelayMs,
  'proxyReceivedAt': ?instance.proxyReceivedAt,
  'resolverDoneAt': ?instance.resolverDoneAt,
  'sendStartedAt': ?instance.sendStartedAt,
  'sendCompletedAt': ?instance.sendCompletedAt,
};
