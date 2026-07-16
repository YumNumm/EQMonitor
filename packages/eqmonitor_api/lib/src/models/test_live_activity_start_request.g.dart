// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_start_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestLiveActivityStartRequest _$TestLiveActivityStartRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestLiveActivityStartRequest',
  json,
  ($checkedConvert) {
    final val = _TestLiveActivityStartRequest(
      startTrigger: $checkedConvert(
        'start_trigger',
        (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
      ),
      contentState: $checkedConvert(
        'content_state',
        (v) => v as Map<String, dynamic>?,
      ),
      alert: $checkedConvert(
        'alert',
        (v) => v == null ? null : Alert.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'startTrigger': 'start_trigger',
    'contentState': 'content_state',
  },
);

Map<String, dynamic> _$TestLiveActivityStartRequestToJson(
  _TestLiveActivityStartRequest instance,
) => <String, dynamic>{
  'start_trigger': instance.startTrigger,
  'content_state': ?instance.contentState,
  'alert': ?instance.alert,
};

const _$LiveActivityStartTriggerEnumMap = {
  LiveActivityStartTrigger.shakeDetection: 'SHAKE_DETECTION',
  LiveActivityStartTrigger.eew: 'EEW',
};
