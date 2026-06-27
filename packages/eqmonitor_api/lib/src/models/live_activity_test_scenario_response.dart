// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_activity_test_scenario_response.freezed.dart';
part 'live_activity_test_scenario_response.g.dart';

@Freezed()
abstract class LiveActivityTestScenarioResponse with _$LiveActivityTestScenarioResponse {
  const factory LiveActivityTestScenarioResponse({
    /// const: true
    required bool ok,
    @JsonKey(name: 'event_id')
    required String eventId,
    @JsonKey(name: 'live_activity_id')
    required String liveActivityId,
    @JsonKey(name: 'reports_planned')
    required num reportsPlanned,
  }) = _LiveActivityTestScenarioResponse;
  
  factory LiveActivityTestScenarioResponse.fromJson(Map<String, Object?> json) => _$LiveActivityTestScenarioResponseFromJson(json);
}
