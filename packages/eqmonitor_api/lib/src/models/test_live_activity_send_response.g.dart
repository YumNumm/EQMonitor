// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_send_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestLiveActivitySendResponse _$TestLiveActivitySendResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestLiveActivitySendResponse',
  json,
  ($checkedConvert) {
    final val = _TestLiveActivitySendResponse(
      liveActivityId: $checkedConvert('live_activity_id', (v) => v as String),
      event: $checkedConvert('event', (v) => $enumDecode(_$EventEnumMap, v)),
      message: $checkedConvert('message', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'liveActivityId': 'live_activity_id'},
);

Map<String, dynamic> _$TestLiveActivitySendResponseToJson(
  _TestLiveActivitySendResponse instance,
) => <String, dynamic>{
  'live_activity_id': instance.liveActivityId,
  'event': instance.event,
  'message': instance.message,
};

const _$EventEnumMap = {Event.update: 'update', Event.end: 'end'};
