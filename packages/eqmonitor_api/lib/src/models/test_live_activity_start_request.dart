// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'alert.dart';
import 'live_activity_content_state.dart';
import 'live_activity_start_trigger.dart';

part 'test_live_activity_start_request.freezed.dart';
part 'test_live_activity_start_request.g.dart';

@Freezed()
abstract class TestLiveActivityStartRequest with _$TestLiveActivityStartRequest {
  const factory TestLiveActivityStartRequest({
    @JsonKey(name: 'start_trigger')
    required LiveActivityStartTrigger startTrigger,
    @JsonKey(includeIfNull: false,name: 'content_state')
    LiveActivityContentState? contentState,
    @JsonKey(includeIfNull: false)
    Alert? alert,
  }) = _TestLiveActivityStartRequest;
  
  factory TestLiveActivityStartRequest.fromJson(Map<String, Object?> json) => _$TestLiveActivityStartRequestFromJson(json);
}
