// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'event.dart';

part 'test_live_activity_send_response.freezed.dart';
part 'test_live_activity_send_response.g.dart';

@Freezed()
abstract class TestLiveActivitySendResponse with _$TestLiveActivitySendResponse {
  const factory TestLiveActivitySendResponse({
    @JsonKey(name: 'live_activity_id')
    required String liveActivityId,
    required Event event,
    required String message,
  }) = _TestLiveActivitySendResponse;
  
  factory TestLiveActivitySendResponse.fromJson(Map<String, Object?> json) => _$TestLiveActivitySendResponseFromJson(json);
}
