// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'merged_events2.freezed.dart';
part 'merged_events2.g.dart';

@Freezed()
abstract class MergedEvents2 with _$MergedEvents2 {
  const factory MergedEvents2({
    required String eventId,
    required DateTime mergedAt,
  }) = _MergedEvents2;

  factory MergedEvents2.fromJson(Map<String, Object?> json) => _$MergedEvents2FromJson(json);
}
