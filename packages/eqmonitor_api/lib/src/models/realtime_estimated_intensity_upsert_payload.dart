// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'estimated_intensity_event.dart';
import 'operation.dart';
import 'type5.dart';

part 'realtime_estimated_intensity_upsert_payload.freezed.dart';
part 'realtime_estimated_intensity_upsert_payload.g.dart';

@Freezed()
abstract class RealtimeEstimatedIntensityUpsertPayload with _$RealtimeEstimatedIntensityUpsertPayload {
  const factory RealtimeEstimatedIntensityUpsertPayload({
    required Type5 type,
    required Operation operation,
    @JsonKey(name: 'event_id')
    required String eventId,
    required EstimatedIntensityEvent record,
  }) = _RealtimeEstimatedIntensityUpsertPayload;

  factory RealtimeEstimatedIntensityUpsertPayload.fromJson(Map<String, Object?> json) => _$RealtimeEstimatedIntensityUpsertPayloadFromJson(json);
}
