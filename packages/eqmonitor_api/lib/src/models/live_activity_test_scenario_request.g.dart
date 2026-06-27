// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_test_scenario_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveActivityTestScenarioRequest _$LiveActivityTestScenarioRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LiveActivityTestScenarioRequest',
  json,
  ($checkedConvert) {
    final val = _LiveActivityTestScenarioRequest(
      eventType: $checkedConvert(
        'event_type',
        (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
      ),
      scenario: $checkedConvert(
        'scenario',
        (v) => $enumDecodeNullable(_$ScenarioEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'eventType': 'event_type'},
);

Map<String, dynamic> _$LiveActivityTestScenarioRequestToJson(
  _LiveActivityTestScenarioRequest instance,
) => <String, dynamic>{
  'event_type': instance.eventType,
  'scenario': ?instance.scenario,
};

const _$LiveActivityStartTriggerEnumMap = {
  LiveActivityStartTrigger.shakeDetection: 'SHAKE_DETECTION',
  LiveActivityStartTrigger.eew: 'EEW',
};

const _$ScenarioEnumMap = {
  Scenario.noto4reports: 'noto_4reports',
  Scenario.onePointGrowth: 'one_point_growth',
  Scenario.shakeGrowth: 'shake_growth',
  Scenario.shakeWarning: 'shake_warning',
};
