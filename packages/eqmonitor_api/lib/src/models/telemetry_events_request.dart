// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telemetry_event.dart';

part 'telemetry_events_request.freezed.dart';
part 'telemetry_events_request.g.dart';

@Freezed()
abstract class TelemetryEventsRequest with _$TelemetryEventsRequest {
  const factory TelemetryEventsRequest({
    required List<TelemetryEvent> events,
  }) = _TelemetryEventsRequest;
  
  factory TelemetryEventsRequest.fromJson(Map<String, Object?> json) => _$TelemetryEventsRequestFromJson(json);
}
