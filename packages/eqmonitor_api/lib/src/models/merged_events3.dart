// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'merged_events3.freezed.dart';
part 'merged_events3.g.dart';

@Freezed()
abstract class MergedEvents3 with _$MergedEvents3 {
  const factory MergedEvents3({
    required String eventId,
    required DateTime mergedAt,
  }) = _MergedEvents3;

  factory MergedEvents3.fromJson(Map<String, Object?> json) => _$MergedEvents3FromJson(json);
}
