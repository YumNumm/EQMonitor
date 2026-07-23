// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_shake_detection_snapshot_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeShakeDetectionSnapshotPayload
_$RealtimeShakeDetectionSnapshotPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RealtimeShakeDetectionSnapshotPayload', json, (
      $checkedConvert,
    ) {
      final val = _RealtimeShakeDetectionSnapshotPayload(
        type: $checkedConvert('type', (v) => $enumDecode(_$Type3EnumMap, v)),
        operation: $checkedConvert(
          'operation',
          (v) => $enumDecode(_$Operation3EnumMap, v),
        ),
        record: $checkedConvert(
          'record',
          (v) =>
              ShakeDetectionActiveSnapshot.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RealtimeShakeDetectionSnapshotPayloadToJson(
  _RealtimeShakeDetectionSnapshotPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'record': instance.record,
};

const _$Type3EnumMap = {Type3.shakeDetection: 'shake_detection'};

const _$Operation3EnumMap = {Operation3.snapshot: 'snapshot'};
