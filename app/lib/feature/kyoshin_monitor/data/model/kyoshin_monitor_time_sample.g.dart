// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_time_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorTimeSample _$KyoshinMonitorTimeSampleFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinMonitorTimeSample',
  json,
  ($checkedConvert) {
    final val = _KyoshinMonitorTimeSample(
      sentAt: $checkedConvert('sent_at', (v) => DateTime.parse(v as String)),
      receivedAt: $checkedConvert(
        'received_at',
        (v) => DateTime.parse(v as String),
      ),
      latestTime: $checkedConvert(
        'latest_time',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'sentAt': 'sent_at',
    'receivedAt': 'received_at',
    'latestTime': 'latest_time',
  },
);

Map<String, dynamic> _$KyoshinMonitorTimeSampleToJson(
  _KyoshinMonitorTimeSample instance,
) => <String, dynamic>{
  'sent_at': instance.sentAt.toIso8601String(),
  'received_at': instance.receivedAt.toIso8601String(),
  'latest_time': instance.latestTime.toIso8601String(),
};
