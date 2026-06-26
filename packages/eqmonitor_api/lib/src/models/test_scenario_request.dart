// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_scenario_request.freezed.dart';
part 'test_scenario_request.g.dart';

@Freezed()
abstract class TestScenarioRequest with _$TestScenarioRequest {
  const factory TestScenarioRequest({
    @JsonKey(name: 'event_id')
    required String eventId,
  }) = _TestScenarioRequest;
  
  factory TestScenarioRequest.fromJson(Map<String, Object?> json) => _$TestScenarioRequestFromJson(json);
}
