// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_type.dart';
import 'target_union.dart';

part 'v2_admin_test_live_event_request_body.freezed.dart';
part 'v2_admin_test_live_event_request_body.g.dart';

@Freezed()
abstract class V2AdminTestLiveEventRequestBody
    with _$V2AdminTestLiveEventRequestBody {
  const factory V2AdminTestLiveEventRequestBody({
    required EventType eventType,
    required TargetUnion target,
  }) = _V2AdminTestLiveEventRequestBody;

  factory V2AdminTestLiveEventRequestBody.fromJson(Map<String, Object?> json) =>
      _$V2AdminTestLiveEventRequestBodyFromJson(json);
}
