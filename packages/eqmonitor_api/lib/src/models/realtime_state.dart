// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'event_message.dart';
import 'shake_detected_payload.dart';
import 'tsunami_list_item.dart';

part 'realtime_state.freezed.dart';
part 'realtime_state.g.dart';

@Freezed()
abstract class RealtimeState with _$RealtimeState {
  const factory RealtimeState({
    required num revision,
    required DateTime updatedAt,
    required List<ShakeDetectedPayload> shakes,
    required List<EventMessage> eews,
    required List<EarthquakePartial> earthquakes,
    required List<TsunamiListItem> tsunamis,
  }) = _RealtimeState;
  
  factory RealtimeState.fromJson(Map<String, Object?> json) => _$RealtimeStateFromJson(json);
}
