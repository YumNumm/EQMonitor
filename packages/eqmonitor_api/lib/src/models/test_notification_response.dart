// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'framework.dart';

part 'test_notification_response.freezed.dart';
part 'test_notification_response.g.dart';

@Freezed()
abstract class TestNotificationResponse with _$TestNotificationResponse {
  const factory TestNotificationResponse({
    required String message,
    required Framework framework,
  }) = _TestNotificationResponse;
  
  factory TestNotificationResponse.fromJson(Map<String, Object?> json) => _$TestNotificationResponseFromJson(json);
}
