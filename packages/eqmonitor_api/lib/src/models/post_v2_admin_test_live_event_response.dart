// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_v2_admin_test_live_event_response.freezed.dart';
part 'post_v2_admin_test_live_event_response.g.dart';

@Freezed()
abstract class PostV2AdminTestLiveEventResponse with _$PostV2AdminTestLiveEventResponse {
  const factory PostV2AdminTestLiveEventResponse({
    /// const: true
    required bool ok,
  }) = _PostV2AdminTestLiveEventResponse;

  factory PostV2AdminTestLiveEventResponse.fromJson(Map<String, Object?> json) => _$PostV2AdminTestLiveEventResponseFromJson(json);
}
