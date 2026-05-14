// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_test_scenario_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveActivityTestScenarioResponse _$LiveActivityTestScenarioResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LiveActivityTestScenarioResponse',
  json,
  ($checkedConvert) {
    final val = _LiveActivityTestScenarioResponse(
      ok: $checkedConvert('ok', (v) => v),
      eventId: $checkedConvert('event_id', (v) => v as String),
      liveActivityId: $checkedConvert('live_activity_id', (v) => v as String),
      reportsPlanned: $checkedConvert('reports_planned', (v) => v as num),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'liveActivityId': 'live_activity_id',
    'reportsPlanned': 'reports_planned',
  },
);

Map<String, dynamic> _$LiveActivityTestScenarioResponseToJson(
  _LiveActivityTestScenarioResponse instance,
) => <String, dynamic>{
  'ok': instance.ok,
  'event_id': instance.eventId,
  'live_activity_id': instance.liveActivityId,
  'reports_planned': instance.reportsPlanned,
};
