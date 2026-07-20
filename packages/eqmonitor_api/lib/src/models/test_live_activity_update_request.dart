// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'live_activity_content_state.dart';

part 'test_live_activity_update_request.freezed.dart';
part 'test_live_activity_update_request.g.dart';

@Freezed()
abstract class TestLiveActivityUpdateRequest with _$TestLiveActivityUpdateRequest {
  const factory TestLiveActivityUpdateRequest({
    @JsonKey(name: 'content_state')
    required LiveActivityContentState contentState,
  }) = _TestLiveActivityUpdateRequest;
  
  factory TestLiveActivityUpdateRequest.fromJson(Map<String, Object?> json) => _$TestLiveActivityUpdateRequestFromJson(json);
}
