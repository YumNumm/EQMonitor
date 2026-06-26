// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_scenario_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestScenarioResponse _$TestScenarioResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestScenarioResponse',
  json,
  ($checkedConvert) {
    final val = _TestScenarioResponse(
      eventId: $checkedConvert('event_id', (v) => v as String),
      stepsPlanned: $checkedConvert('steps_planned', (v) => v as num),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'stepsPlanned': 'steps_planned',
    'telegramTypes': 'telegram_types',
  },
);

Map<String, dynamic> _$TestScenarioResponseToJson(
  _TestScenarioResponse instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'steps_planned': instance.stepsPlanned,
  'telegram_types': instance.telegramTypes,
};
