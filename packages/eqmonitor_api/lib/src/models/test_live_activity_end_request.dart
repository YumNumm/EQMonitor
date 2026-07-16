// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'live_activity_content_state.dart';

part 'test_live_activity_end_request.freezed.dart';
part 'test_live_activity_end_request.g.dart';

@Freezed()
abstract class TestLiveActivityEndRequest with _$TestLiveActivityEndRequest {
  const factory TestLiveActivityEndRequest({
    @JsonKey(includeIfNull: false,name: 'content_state')
    LiveActivityContentState? contentState,
  }) = _TestLiveActivityEndRequest;
  
  factory TestLiveActivityEndRequest.fromJson(Map<String, Object?> json) => _$TestLiveActivityEndRequestFromJson(json);
}
