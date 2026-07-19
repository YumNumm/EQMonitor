// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_v2_shake_detection_active_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetV2ShakeDetectionActiveResponse _$GetV2ShakeDetectionActiveResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetV2ShakeDetectionActiveResponse', json, (
  $checkedConvert,
) {
  final val = _GetV2ShakeDetectionActiveResponse(
    type: $checkedConvert('type', (v) => v as String),
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    responseAt: $checkedConvert(
      'responseAt',
      (v) => DateTime.parse(v as String),
    ),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => Events.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$GetV2ShakeDetectionActiveResponseToJson(
  _GetV2ShakeDetectionActiveResponse instance,
) => <String, dynamic>{
  'type': instance.type,
  'revision': instance.revision,
  'responseAt': instance.responseAt.toIso8601String(),
  'events': instance.events,
};
