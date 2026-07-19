// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'merged_events.freezed.dart';
part 'merged_events.g.dart';

@Freezed()
abstract class MergedEvents with _$MergedEvents {
  const factory MergedEvents({
    required String eventId,
    required DateTime mergedAt,
  }) = _MergedEvents;

  factory MergedEvents.fromJson(Map<String, Object?> json) => _$MergedEventsFromJson(json);
}
