// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake.dart';
import 'operation.dart';
import 'type.dart';

part 'realtime_earthquake_upsert_payload.freezed.dart';
part 'realtime_earthquake_upsert_payload.g.dart';

@Freezed()
abstract class RealtimeEarthquakeUpsertPayload with _$RealtimeEarthquakeUpsertPayload {
  const factory RealtimeEarthquakeUpsertPayload({
    required Type type,
    required Operation operation,
    @JsonKey(name: 'event_id')
    required String eventId,
    required Earthquake record,
  }) = _RealtimeEarthquakeUpsertPayload;

  factory RealtimeEarthquakeUpsertPayload.fromJson(Map<String, Object?> json) => _$RealtimeEarthquakeUpsertPayloadFromJson(json);
}
