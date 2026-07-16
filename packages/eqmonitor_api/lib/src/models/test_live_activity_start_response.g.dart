// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestLiveActivityStartResponse _$TestLiveActivityStartResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestLiveActivityStartResponse',
  json,
  ($checkedConvert) {
    final val = _TestLiveActivityStartResponse(
      liveActivityId: $checkedConvert('live_activity_id', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      startTrigger: $checkedConvert(
        'start_trigger',
        (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'liveActivityId': 'live_activity_id',
    'eventId': 'event_id',
    'startTrigger': 'start_trigger',
  },
);

Map<String, dynamic> _$TestLiveActivityStartResponseToJson(
  _TestLiveActivityStartResponse instance,
) => <String, dynamic>{
  'live_activity_id': instance.liveActivityId,
  'event_id': instance.eventId,
  'start_trigger': instance.startTrigger,
};

const _$LiveActivityStartTriggerEnumMap = {
  LiveActivityStartTrigger.shakeDetection: 'SHAKE_DETECTION',
  LiveActivityStartTrigger.eew: 'EEW',
};
