// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_scenario_type_response.freezed.dart';
part 'test_scenario_type_response.g.dart';

@Freezed()
abstract class TestScenarioTypeResponse with _$TestScenarioTypeResponse {
  const factory TestScenarioTypeResponse({
    required String message,
    required String scenario,
    @JsonKey(name: 'event_id')
    required String eventId,
  }) = _TestScenarioTypeResponse;
  
  factory TestScenarioTypeResponse.fromJson(Map<String, Object?> json) => _$TestScenarioTypeResponseFromJson(json);
}
