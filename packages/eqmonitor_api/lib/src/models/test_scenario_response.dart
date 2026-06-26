// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_scenario_response.freezed.dart';
part 'test_scenario_response.g.dart';

@Freezed()
abstract class TestScenarioResponse with _$TestScenarioResponse {
  const factory TestScenarioResponse({
    @JsonKey(name: 'event_id')
    required String eventId,
    @JsonKey(name: 'steps_planned')
    required num stepsPlanned,
    @JsonKey(name: 'telegram_types')
    required List<String> telegramTypes,
  }) = _TestScenarioResponse;
  
  factory TestScenarioResponse.fromJson(Map<String, Object?> json) => _$TestScenarioResponseFromJson(json);
}
