// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'operation2.dart';
import 'type.dart';

part 'realtime_earthquake_delete_payload.freezed.dart';
part 'realtime_earthquake_delete_payload.g.dart';

@Freezed()
abstract class RealtimeEarthquakeDeletePayload with _$RealtimeEarthquakeDeletePayload {
  const factory RealtimeEarthquakeDeletePayload({
    required Type type,
    required Operation2 operation,
    @JsonKey(name: 'event_id')
    required String eventId,
  }) = _RealtimeEarthquakeDeletePayload;

  factory RealtimeEarthquakeDeletePayload.fromJson(Map<String, Object?> json) => _$RealtimeEarthquakeDeletePayloadFromJson(json);
}
