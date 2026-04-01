// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'triggers.freezed.dart';
part 'triggers.g.dart';

@Freezed()
abstract class Triggers with _$Triggers {
  const factory Triggers({
    required String id,
    required String replayFileId,
    required dynamic triggerType,
    required String eventId,
    required String createdAt,
  }) = _Triggers;

  factory Triggers.fromJson(Map<String, Object?> json) =>
      _$TriggersFromJson(json);
}
