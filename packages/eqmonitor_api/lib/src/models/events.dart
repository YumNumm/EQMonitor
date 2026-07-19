// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'level.dart';
import 'change_reasons.dart';
import 'merged_events.dart';
import 'region.dart';
import 'points.dart';
import 'test.dart';
import 'correlated_eew.dart';

part 'events.freezed.dart';
part 'events.g.dart';

@Freezed()
abstract class Events with _$Events {
  const factory Events({
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
  }) = _Events;

  factory Events.fromJson(Map<String, Object?> json) => _$EventsFromJson(json);
}
