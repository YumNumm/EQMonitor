// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_notification_scenario.dart';

part 'test_scenario_type_request.freezed.dart';
part 'test_scenario_type_request.g.dart';

@Freezed()
abstract class TestScenarioTypeRequest with _$TestScenarioTypeRequest {
  const factory TestScenarioTypeRequest({
    required TestNotificationScenario scenario,
  }) = _TestScenarioTypeRequest;
  
  factory TestScenarioTypeRequest.fromJson(Map<String, Object?> json) => _$TestScenarioTypeRequestFromJson(json);
}
