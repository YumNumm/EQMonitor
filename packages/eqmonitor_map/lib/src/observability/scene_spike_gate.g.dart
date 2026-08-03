// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_spike_gate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SceneSpikeCapabilityFinding _$SceneSpikeCapabilityFindingFromJson(
  Map<String, dynamic> json,
) => _SceneSpikeCapabilityFinding(
  run: SceneSpikeRunKey.fromJson(json['run'] as Map<String, dynamic>),
  result: SceneSpikeCapabilityResult.fromJson(
    json['result'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SceneSpikeCapabilityFindingToJson(
  _SceneSpikeCapabilityFinding instance,
) => <String, dynamic>{
  'run': instance.run.toJson(),
  'result': instance.result.toJson(),
};

_SceneSpikeGateDecision _$SceneSpikeGateDecisionFromJson(
  Map<String, dynamic> json,
) => _SceneSpikeGateDecision(
  isPass: json['isPass'] as bool,
  missingRuns: (json['missingRuns'] as List<dynamic>)
      .map((e) => SceneSpikeRunKey.fromJson(e as Map<String, dynamic>))
      .toList(),
  failedCapabilities: (json['failedCapabilities'] as List<dynamic>)
      .map(
        (e) => SceneSpikeCapabilityFinding.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  unobservedCapabilities: (json['unobservedCapabilities'] as List<dynamic>)
      .map(
        (e) => SceneSpikeCapabilityFinding.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  validationErrors: (json['validationErrors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  revisionMismatches: (json['revisionMismatches'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SceneSpikeGateDecisionToJson(
  _SceneSpikeGateDecision instance,
) => <String, dynamic>{
  'isPass': instance.isPass,
  'missingRuns': instance.missingRuns.map((e) => e.toJson()).toList(),
  'failedCapabilities': instance.failedCapabilities
      .map((e) => e.toJson())
      .toList(),
  'unobservedCapabilities': instance.unobservedCapabilities
      .map((e) => e.toJson())
      .toList(),
  'validationErrors': instance.validationErrors,
  'revisionMismatches': instance.revisionMismatches,
};
