// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveActivityTokenResponse _$LiveActivityTokenResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LiveActivityTokenResponse',
  json,
  ($checkedConvert) {
    final val = _LiveActivityTokenResponse(
      liveActivityId: $checkedConvert('live_activity_id', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      startTrigger: $checkedConvert(
        'start_trigger',
        (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
      ),
      createdAt: $checkedConvert('created_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'liveActivityId': 'live_activity_id',
    'eventId': 'event_id',
    'startTrigger': 'start_trigger',
    'createdAt': 'created_at',
  },
);

Map<String, dynamic> _$LiveActivityTokenResponseToJson(
  _LiveActivityTokenResponse instance,
) => <String, dynamic>{
  'live_activity_id': instance.liveActivityId,
  'event_id': instance.eventId,
  'start_trigger': instance.startTrigger,
  'created_at': instance.createdAt,
};

const _$LiveActivityStartTriggerEnumMap = {
  LiveActivityStartTrigger.shakeDetection: 'SHAKE_DETECTION',
  LiveActivityStartTrigger.eew: 'EEW',
};
