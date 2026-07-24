// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type3.dart';
import 'level.dart';
import 'change_reasons.dart';
import 'merged_events2.dart';
import 'region2.dart';
import 'points2.dart';
import 'test2.dart';
import 'correlated_eew2.dart';

part 'events2.freezed.dart';
part 'events2.g.dart';

@Freezed()
abstract class Events2 with _$Events2 {
  const factory Events2({
    required Type3 type,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required Level level,
    required List<ChangeReasons> changeReasons,
    required List<MergedEvents2> mergedEvents,
    required int pointCount,
    required Region2 region,
    required List<Points2> points,
    @JsonKey(includeIfNull: false)
    Test2? test,
    @JsonKey(includeIfNull: false)
    CorrelatedEew2? correlatedEew,
  }) = _Events2;

  factory Events2.fromJson(Map<String, Object?> json) => _$Events2FromJson(json);
}
