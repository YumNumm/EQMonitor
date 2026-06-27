// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_events_response.freezed.dart';
part 'telemetry_events_response.g.dart';

@Freezed()
abstract class TelemetryEventsResponse with _$TelemetryEventsResponse {
  const factory TelemetryEventsResponse({
    required int accepted,
    @JsonKey(includeIfNull: false)
    String? warning,
  }) = _TelemetryEventsResponse;
  
  factory TelemetryEventsResponse.fromJson(Map<String, Object?> json) => _$TelemetryEventsResponseFromJson(json);
}
