// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'operation3.dart';
import 'shake_detection_active_snapshot.dart';
import 'type3.dart';

part 'realtime_shake_detection_snapshot_payload.freezed.dart';
part 'realtime_shake_detection_snapshot_payload.g.dart';

@Freezed()
abstract class RealtimeShakeDetectionSnapshotPayload with _$RealtimeShakeDetectionSnapshotPayload {
  const factory RealtimeShakeDetectionSnapshotPayload({
    required Type3 type,
    required Operation3 operation,
    required ShakeDetectionActiveSnapshot record,
  }) = _RealtimeShakeDetectionSnapshotPayload;

  factory RealtimeShakeDetectionSnapshotPayload.fromJson(Map<String, Object?> json) => _$RealtimeShakeDetectionSnapshotPayloadFromJson(json);
}
