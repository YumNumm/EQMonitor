// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_item_with_relations.dart';
import 'realtime_eew_upsert_payload_operation.dart';
import 'realtime_eew_upsert_payload_type.dart';

part 'realtime_eew_upsert_payload.freezed.dart';
part 'realtime_eew_upsert_payload.g.dart';

@Freezed()
abstract class RealtimeEewUpsertPayload with _$RealtimeEewUpsertPayload {
  const factory RealtimeEewUpsertPayload({
    required RealtimeEewUpsertPayloadType type,
    required RealtimeEewUpsertPayloadOperation operation,
    @JsonKey(name: 'event_id')
    required String eventId,
    required EewItemWithRelations record,
  }) = _RealtimeEewUpsertPayload;

  factory RealtimeEewUpsertPayload.fromJson(Map<String, Object?> json) => _$RealtimeEewUpsertPayloadFromJson(json);
}
