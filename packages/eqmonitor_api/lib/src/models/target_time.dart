// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_time.freezed.dart';
part 'target_time.g.dart';

@Freezed()
abstract class TargetTime with _$TargetTime {
  const factory TargetTime({
    required String start,
    required String end,
  }) = _TargetTime;

  factory TargetTime.fromJson(Map<String, Object?> json) =>
      _$TargetTimeFromJson(json);
}
