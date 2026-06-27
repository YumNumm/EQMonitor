// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_event.freezed.dart';
part 'telemetry_event.g.dart';

@Freezed()
abstract class TelemetryEvent with _$TelemetryEvent {
  const factory TelemetryEvent({
    @JsonKey(name: 'event_type')
    required String eventType,
    @JsonKey(name: 'timestamp_ms')
    required int timestampMs,
    @JsonKey(includeIfNull: true,name: 'event_id')
    required String? eventId,
    @JsonKey(includeIfNull: true)
    required String? payload,
    @JsonKey(name: 'created_at_ms')
    required int createdAtMs,
  }) = _TelemetryEvent;
  
  factory TelemetryEvent.fromJson(Map<String, Object?> json) => _$TelemetryEventFromJson(json);
}
