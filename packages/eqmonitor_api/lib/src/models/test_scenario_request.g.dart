// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_scenario_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestScenarioRequest _$TestScenarioRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TestScenarioRequest', json, ($checkedConvert) {
      final val = _TestScenarioRequest(
        eventId: $checkedConvert('event_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$TestScenarioRequestToJson(
  _TestScenarioRequest instance,
) => <String, dynamic>{'event_id': instance.eventId};
