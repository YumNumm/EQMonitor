// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_snapshot_type.dart';
import 'shake_detection_state.dart';

part 'shake_detection_snapshot.freezed.dart';
part 'shake_detection_snapshot.g.dart';

@Freezed()
abstract class ShakeDetectionSnapshot with _$ShakeDetectionSnapshot {
  const factory ShakeDetectionSnapshot({
    required ShakeDetectionSnapshotType type,
    required int revision,
    required DateTime responseAt,
    required List<ShakeDetectionState> events,
  }) = _ShakeDetectionSnapshot;
  
  factory ShakeDetectionSnapshot.fromJson(Map<String, Object?> json) => _$ShakeDetectionSnapshotFromJson(json);
}
