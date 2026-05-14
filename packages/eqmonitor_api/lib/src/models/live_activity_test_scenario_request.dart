// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'live_activity_start_trigger.dart';
import 'scenario.dart';

part 'live_activity_test_scenario_request.freezed.dart';
part 'live_activity_test_scenario_request.g.dart';

@Freezed()
abstract class LiveActivityTestScenarioRequest with _$LiveActivityTestScenarioRequest {
  const factory LiveActivityTestScenarioRequest({
    @JsonKey(name: 'event_type')
    required LiveActivityStartTrigger eventType,
    @JsonKey(includeIfNull: false)
    Scenario? scenario,
  }) = _LiveActivityTestScenarioRequest;
  
  factory LiveActivityTestScenarioRequest.fromJson(Map<String, Object?> json) => _$LiveActivityTestScenarioRequestFromJson(json);
}
