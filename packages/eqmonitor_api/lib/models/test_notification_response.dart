// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_notification_response_framework.dart';

part 'test_notification_response.freezed.dart';
part 'test_notification_response.g.dart';

@Freezed()
abstract class TestNotificationResponse with _$TestNotificationResponse {
  const factory TestNotificationResponse({
    required String message,
    required TestNotificationResponseFramework framework,
  }) = _TestNotificationResponse;

  factory TestNotificationResponse.fromJson(Map<String, Object?> json) =>
      _$TestNotificationResponseFromJson(json);
}
