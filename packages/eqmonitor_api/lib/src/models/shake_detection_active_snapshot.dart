// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_active_event.dart';

part 'shake_detection_active_snapshot.freezed.dart';
part 'shake_detection_active_snapshot.g.dart';

@Freezed()
abstract class ShakeDetectionActiveSnapshot with _$ShakeDetectionActiveSnapshot {
  const factory ShakeDetectionActiveSnapshot({
    /// const: "shake_detection"
    required String type,
    required int revision,
    required DateTime responseAt,
    required List<ShakeDetectionActiveEvent> events,
  }) = _ShakeDetectionActiveSnapshot;

  factory ShakeDetectionActiveSnapshot.fromJson(Map<String, Object?> json) => _$ShakeDetectionActiveSnapshotFromJson(json);
}
