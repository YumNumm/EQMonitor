// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'realtime_shake_detection_snapshot_payload_type.dart';
import 'shake_detection_state.dart';

part 'realtime_shake_detection_snapshot_payload.freezed.dart';
part 'realtime_shake_detection_snapshot_payload.g.dart';

@Freezed()
abstract class RealtimeShakeDetectionSnapshotPayload with _$RealtimeShakeDetectionSnapshotPayload {
  const factory RealtimeShakeDetectionSnapshotPayload({
    required RealtimeShakeDetectionSnapshotPayloadType type,
    required int revision,
    required DateTime responseAt,
    required List<ShakeDetectionState> events,
  }) = _RealtimeShakeDetectionSnapshotPayload;

  factory RealtimeShakeDetectionSnapshotPayload.fromJson(Map<String, Object?> json) => _$RealtimeShakeDetectionSnapshotPayloadFromJson(json);
}
