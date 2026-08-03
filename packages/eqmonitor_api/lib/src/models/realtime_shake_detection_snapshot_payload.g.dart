// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_shake_detection_snapshot_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeShakeDetectionSnapshotPayload
_$RealtimeShakeDetectionSnapshotPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeShakeDetectionSnapshotPayload', json, (
  $checkedConvert,
) {
  final val = _RealtimeShakeDetectionSnapshotPayload(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$RealtimeShakeDetectionSnapshotPayloadTypeEnumMap, v),
    ),
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    responseAt: $checkedConvert(
      'responseAt',
      (v) => DateTime.parse(v as String),
    ),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => ShakeDetectionState.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$RealtimeShakeDetectionSnapshotPayloadToJson(
  _RealtimeShakeDetectionSnapshotPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'revision': instance.revision,
  'responseAt': instance.responseAt.toIso8601String(),
  'events': instance.events,
};

const _$RealtimeShakeDetectionSnapshotPayloadTypeEnumMap = {
  RealtimeShakeDetectionSnapshotPayloadType.shakeDetection: 'shake_detection',
};
