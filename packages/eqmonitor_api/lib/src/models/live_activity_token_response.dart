// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'live_activity_start_trigger.dart';

part 'live_activity_token_response.freezed.dart';
part 'live_activity_token_response.g.dart';

@Freezed()
abstract class LiveActivityTokenResponse with _$LiveActivityTokenResponse {
  const factory LiveActivityTokenResponse({
    @JsonKey(name: 'live_activity_id') required String liveActivityId,
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'start_trigger')
    required LiveActivityStartTrigger startTrigger,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _LiveActivityTokenResponse;

  factory LiveActivityTokenResponse.fromJson(Map<String, Object?> json) =>
      _$LiveActivityTokenResponseFromJson(json);
}
