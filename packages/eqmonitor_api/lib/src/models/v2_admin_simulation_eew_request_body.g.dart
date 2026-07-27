// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v2_admin_simulation_eew_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2AdminSimulationEewRequestBody _$V2AdminSimulationEewRequestBodyFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_V2AdminSimulationEewRequestBody', json, ($checkedConvert) {
      final val = _V2AdminSimulationEewRequestBody(
        scenario: $checkedConvert(
          'scenario',
          (v) => $enumDecode(_$ScenarioEnumMap, v),
        ),
        targetDeviceId: $checkedConvert('targetDeviceId', (v) => v as String),
        totalReports: $checkedConvert(
          'totalReports',
          (v) => (v as num?)?.toInt() ?? 60,
        ),
        intervalMs: $checkedConvert(
          'intervalMs',
          (v) => (v as num?)?.toInt() ?? 100,
        ),
      );
      return val;
    });

Map<String, dynamic> _$V2AdminSimulationEewRequestBodyToJson(
  _V2AdminSimulationEewRequestBody instance,
) => <String, dynamic>{
  'scenario': instance.scenario,
  'targetDeviceId': instance.targetDeviceId,
  'totalReports': instance.totalReports,
  'intervalMs': instance.intervalMs,
};

const _$ScenarioEnumMap = {
  Scenario.combined: 'combined',
  Scenario.intensityEscalation: 'intensity_escalation',
  Scenario.warningTransition: 'warning_transition',
  Scenario.cancel: 'cancel',
  Scenario.simple: 'simple',
};
