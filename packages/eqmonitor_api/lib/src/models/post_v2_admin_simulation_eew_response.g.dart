// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_v2_admin_simulation_eew_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostV2AdminSimulationEewResponse _$PostV2AdminSimulationEewResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostV2AdminSimulationEewResponse', json, (
  $checkedConvert,
) {
  final val = _PostV2AdminSimulationEewResponse(
    ok: $checkedConvert('ok', (v) => v as bool),
    eventId: $checkedConvert('eventId', (v) => v as String),
    totalReports: $checkedConvert('totalReports', (v) => v as num),
    scenario: $checkedConvert('scenario', (v) => v as String),
    targetDeviceId: $checkedConvert('targetDeviceId', (v) => v as String),
    intervalMs: $checkedConvert('intervalMs', (v) => v as num),
    durationMs: $checkedConvert('durationMs', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$PostV2AdminSimulationEewResponseToJson(
  _PostV2AdminSimulationEewResponse instance,
) => <String, dynamic>{
  'ok': instance.ok,
  'eventId': instance.eventId,
  'totalReports': instance.totalReports,
  'scenario': instance.scenario,
  'targetDeviceId': instance.targetDeviceId,
  'intervalMs': instance.intervalMs,
  'durationMs': instance.durationMs,
};
