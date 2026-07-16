// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'live_activity_start_trigger.dart';

part 'test_live_activity_start_response.freezed.dart';
part 'test_live_activity_start_response.g.dart';

@Freezed()
abstract class TestLiveActivityStartResponse with _$TestLiveActivityStartResponse {
  const factory TestLiveActivityStartResponse({
    @JsonKey(name: 'live_activity_id')
    required String liveActivityId,
    @JsonKey(name: 'event_id')
    required String eventId,
    @JsonKey(name: 'start_trigger')
    required LiveActivityStartTrigger startTrigger,
  }) = _TestLiveActivityStartResponse;
  
  factory TestLiveActivityStartResponse.fromJson(Map<String, Object?> json) => _$TestLiveActivityStartResponseFromJson(json);
}
