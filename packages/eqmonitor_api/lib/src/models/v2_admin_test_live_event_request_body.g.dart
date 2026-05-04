// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v2_admin_test_live_event_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2AdminTestLiveEventRequestBody _$V2AdminTestLiveEventRequestBodyFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_V2AdminTestLiveEventRequestBody', json, ($checkedConvert) {
      final val = _V2AdminTestLiveEventRequestBody(
        eventType: $checkedConvert(
          'eventType',
          (v) => $enumDecode(_$EventTypeEnumMap, v),
        ),
        target: $checkedConvert(
          'target',
          (v) => TargetUnion.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$V2AdminTestLiveEventRequestBodyToJson(
  _V2AdminTestLiveEventRequestBody instance,
) => <String, dynamic>{
  'eventType': instance.eventType,
  'target': instance.target,
};

const _$EventTypeEnumMap = {
  EventType.eew: 'eew',
  EventType.shakeDetection: 'shake_detection',
};
