// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'operation.dart';
import 'type4.dart';

part 'realtime_tsunami_upsert_payload.freezed.dart';
part 'realtime_tsunami_upsert_payload.g.dart';

@Freezed()
abstract class RealtimeTsunamiUpsertPayload with _$RealtimeTsunamiUpsertPayload {
  const factory RealtimeTsunamiUpsertPayload({
    required Type4 type,
    required Operation operation,
    @JsonKey(name: 'event_id')
    required String eventId,
    @JsonKey(includeIfNull: false,name: 'group_id')
    String? groupId,
  }) = _RealtimeTsunamiUpsertPayload;

  factory RealtimeTsunamiUpsertPayload.fromJson(Map<String, Object?> json) => _$RealtimeTsunamiUpsertPayloadFromJson(json);
}
