// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'trigger_type.dart';

part 'replay_file_trigger.freezed.dart';
part 'replay_file_trigger.g.dart';

@Freezed()
abstract class ReplayFileTrigger with _$ReplayFileTrigger {
  const factory ReplayFileTrigger({
    required String id,
    required String replayFileId,

    /// const: "SHAKE_DETECTION" | const: "EARTHQUAKE"
    required TriggerType triggerType,
    required String eventId,
    required String createdAt,
  }) = _ReplayFileTrigger;
  
  factory ReplayFileTrigger.fromJson(Map<String, Object?> json) => _$ReplayFileTriggerFromJson(json);
}
