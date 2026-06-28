// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_scenario_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestScenarioTypeResponse _$TestScenarioTypeResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TestScenarioTypeResponse', json, ($checkedConvert) {
  final val = _TestScenarioTypeResponse(
    message: $checkedConvert('message', (v) => v as String),
    scenario: $checkedConvert('scenario', (v) => v as String),
    eventId: $checkedConvert('event_id', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$TestScenarioTypeResponseToJson(
  _TestScenarioTypeResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'scenario': instance.scenario,
  'event_id': instance.eventId,
};
