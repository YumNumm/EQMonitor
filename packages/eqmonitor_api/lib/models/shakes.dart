// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'level.dart';
import 'region.dart';
import 'points.dart';

part 'shakes.freezed.dart';
part 'shakes.g.dart';

@Freezed()
abstract class Shakes with _$Shakes {
  const factory Shakes({
    required dynamic type,
    required String eventId,
    required String createdAt,
    required Level level,
    required List<String> changeReasons,
    required bool isReplay,
    required num pointCount,
    required Region region,
    required List<Points> points,
  }) = _Shakes;

  factory Shakes.fromJson(Map<String, Object?> json) => _$ShakesFromJson(json);
}
