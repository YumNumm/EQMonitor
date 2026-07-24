// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type3.dart';
import 'level.dart';
import 'change_reasons.dart';
import 'merged_events3.dart';
import 'region3.dart';
import 'points3.dart';
import 'test3.dart';
import 'correlated_eew3.dart';

part 'events3.freezed.dart';
part 'events3.g.dart';

@Freezed()
abstract class Events3 with _$Events3 {
  const factory Events3({
    required Type3 type,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required Level level,
    required List<ChangeReasons> changeReasons,
    required List<MergedEvents3> mergedEvents,
    required int pointCount,
    required Region3 region,
    required List<Points3> points,
    @JsonKey(includeIfNull: false)
    Test3? test,
    @JsonKey(includeIfNull: false)
    CorrelatedEew3? correlatedEew,
  }) = _Events3;

  factory Events3.fromJson(Map<String, Object?> json) => _$Events3FromJson(json);
}
