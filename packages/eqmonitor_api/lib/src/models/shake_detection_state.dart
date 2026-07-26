// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'change_reasons.dart';
import 'correlated_eew.dart';
import 'level.dart';
import 'merged_events.dart';
import 'points.dart';
import 'region.dart';
import 'test.dart';

part 'shake_detection_state.freezed.dart';
part 'shake_detection_state.g.dart';

@Freezed()
abstract class ShakeDetectionState with _$ShakeDetectionState {
  const factory ShakeDetectionState({
    /// const: "shake_detection"
    required String type,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required Level level,
    required List<ChangeReasons> changeReasons,
    required List<MergedEvents> mergedEvents,
    required int pointCount,
    required Region region,
    required List<Points> points,
    @JsonKey(includeIfNull: false)
    Test? test,
    @JsonKey(includeIfNull: false)
    CorrelatedEew? correlatedEew,
  }) = _ShakeDetectionState;
  
  factory ShakeDetectionState.fromJson(Map<String, Object?> json) => _$ShakeDetectionStateFromJson(json);
}
