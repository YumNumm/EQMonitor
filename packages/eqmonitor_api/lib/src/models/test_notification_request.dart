// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_notification_type.dart';

part 'test_notification_request.freezed.dart';
part 'test_notification_request.g.dart';

@Freezed()
abstract class TestNotificationRequest with _$TestNotificationRequest {
  const factory TestNotificationRequest({
    required TestNotificationType type,
  }) = _TestNotificationRequest;

  factory TestNotificationRequest.fromJson(Map<String, Object?> json) =>
      _$TestNotificationRequestFromJson(json);
}
