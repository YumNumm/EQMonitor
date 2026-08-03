// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_spike_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SceneSpikeRunKey _$SceneSpikeRunKeyFromJson(Map<String, dynamic> json) =>
    _SceneSpikeRunKey(
      platform: $enumDecode(_$SceneSpikePlatformEnumMap, json['platform']),
      buildMode: $enumDecode(_$SceneSpikeBuildModeEnumMap, json['buildMode']),
    );

Map<String, dynamic> _$SceneSpikeRunKeyToJson(_SceneSpikeRunKey instance) =>
    <String, dynamic>{
      'platform': _$SceneSpikePlatformEnumMap[instance.platform]!,
      'buildMode': _$SceneSpikeBuildModeEnumMap[instance.buildMode]!,
    };

const _$SceneSpikePlatformEnumMap = {
  SceneSpikePlatform.ios: 'ios',
  SceneSpikePlatform.android: 'android',
};

const _$SceneSpikeBuildModeEnumMap = {
  SceneSpikeBuildMode.profile: 'profile',
  SceneSpikeBuildMode.release: 'release',
};

_SceneSpikeCapabilityResult _$SceneSpikeCapabilityResultFromJson(
  Map<String, dynamic> json,
) => _SceneSpikeCapabilityResult(
  capability: $enumDecode(_$SceneSpikeCapabilityEnumMap, json['capability']),
  status: $enumDecode(_$SceneSpikeCapabilityStatusEnumMap, json['status']),
  provenance: $enumDecode(
    _$SceneSpikeObservationProvenanceEnumMap,
    json['provenance'],
  ),
  detail: json['detail'] as String,
  observedAtUtc: DateTime.parse(json['observedAtUtc'] as String),
);

Map<String, dynamic> _$SceneSpikeCapabilityResultToJson(
  _SceneSpikeCapabilityResult instance,
) => <String, dynamic>{
  'capability': _$SceneSpikeCapabilityEnumMap[instance.capability]!,
  'status': _$SceneSpikeCapabilityStatusEnumMap[instance.status]!,
  'provenance': _$SceneSpikeObservationProvenanceEnumMap[instance.provenance]!,
  'detail': instance.detail,
  'observedAtUtc': instance.observedAtUtc.toIso8601String(),
};

const _$SceneSpikeCapabilityEnumMap = {
  SceneSpikeCapability.proceduralOrthographicMesh: 'proceduralOrthographicMesh',
  SceneSpikeCapability.unlitMaterial: 'unlitMaterial',
  SceneSpikeCapability.customMaterial: 'customMaterial',
  SceneSpikeCapability.partialPositionAndColorUpdate:
      'partialPositionAndColorUpdate',
  SceneSpikeCapability.textPainterOverlay: 'textPainterOverlay',
  SceneSpikeCapability.dprAndResize: 'dprAndResize',
  SceneSpikeCapability.backgroundAndForeground: 'backgroundAndForeground',
  SceneSpikeCapability.disposeAndRemount: 'disposeAndRemount',
  SceneSpikeCapability.explicitResourceDisposal: 'explicitResourceDisposal',
  SceneSpikeCapability.contextResourceRebuild: 'contextResourceRebuild',
  SceneSpikeCapability.gpuCompletionOrSafeRetirement:
      'gpuCompletionOrSafeRetirement',
};

const _$SceneSpikeCapabilityStatusEnumMap = {
  SceneSpikeCapabilityStatus.passed: 'passed',
  SceneSpikeCapabilityStatus.failed: 'failed',
  SceneSpikeCapabilityStatus.unobserved: 'unobserved',
};

const _$SceneSpikeObservationProvenanceEnumMap = {
  SceneSpikeObservationProvenance.runtimeSignal: 'runtimeSignal',
  SceneSpikeObservationProvenance.compileTimeManifest: 'compileTimeManifest',
  SceneSpikeObservationProvenance.operatorAttestation: 'operatorAttestation',
  SceneSpikeObservationProvenance.unavailablePublicApi: 'unavailablePublicApi',
};

_SceneSpikePerformanceSnapshot _$SceneSpikePerformanceSnapshotFromJson(
  Map<String, dynamic> json,
) => _SceneSpikePerformanceSnapshot(
  buildDurationCount: (json['buildDurationCount'] as num).toInt(),
  buildDurationMaxMicroseconds: (json['buildDurationMaxMicroseconds'] as num)
      .toInt(),
  buildDurationP50Microseconds: (json['buildDurationP50Microseconds'] as num)
      .toInt(),
  buildDurationP95Microseconds: (json['buildDurationP95Microseconds'] as num)
      .toInt(),
  rasterDurationCount: (json['rasterDurationCount'] as num).toInt(),
  rasterDurationMaxMicroseconds: (json['rasterDurationMaxMicroseconds'] as num)
      .toInt(),
  rasterDurationP50Microseconds: (json['rasterDurationP50Microseconds'] as num)
      .toInt(),
  rasterDurationP95Microseconds: (json['rasterDurationP95Microseconds'] as num)
      .toInt(),
  droppedFrameCount: (json['droppedFrameCount'] as num).toInt(),
  partialUpdateCount: (json['partialUpdateCount'] as num).toInt(),
  resourceRebuildCount: (json['resourceRebuildCount'] as num).toInt(),
  exceptionCount: (json['exceptionCount'] as num).toInt(),
);

Map<String, dynamic> _$SceneSpikePerformanceSnapshotToJson(
  _SceneSpikePerformanceSnapshot instance,
) => <String, dynamic>{
  'buildDurationCount': instance.buildDurationCount,
  'buildDurationMaxMicroseconds': instance.buildDurationMaxMicroseconds,
  'buildDurationP50Microseconds': instance.buildDurationP50Microseconds,
  'buildDurationP95Microseconds': instance.buildDurationP95Microseconds,
  'rasterDurationCount': instance.rasterDurationCount,
  'rasterDurationMaxMicroseconds': instance.rasterDurationMaxMicroseconds,
  'rasterDurationP50Microseconds': instance.rasterDurationP50Microseconds,
  'rasterDurationP95Microseconds': instance.rasterDurationP95Microseconds,
  'droppedFrameCount': instance.droppedFrameCount,
  'partialUpdateCount': instance.partialUpdateCount,
  'resourceRebuildCount': instance.resourceRebuildCount,
  'exceptionCount': instance.exceptionCount,
};

_SceneSpikeEvidence _$SceneSpikeEvidenceFromJson(Map<String, dynamic> json) =>
    _SceneSpikeEvidence(
      schemaVersion: (json['schemaVersion'] as num).toInt(),
      run: SceneSpikeRunKey.fromJson(json['run'] as Map<String, dynamic>),
      deviceModel: json['deviceModel'] as String,
      operatingSystemVersion: json['operatingSystemVersion'] as String,
      flutterFrameworkRevision: json['flutterFrameworkRevision'] as String,
      flutterEngineRevision: json['flutterEngineRevision'] as String,
      dartVersion: json['dartVersion'] as String,
      flutterSceneRevision: json['flutterSceneRevision'] as String,
      eqmonitorMapRendererRevision:
          json['eqmonitorMapRendererRevision'] as String,
      eqmonitorMapRendererCheckoutDirty:
          json['eqmonitorMapRendererCheckoutDirty'] as bool,
      revisionProvenance: $enumDecode(
        _$SceneSpikeObservationProvenanceEnumMap,
        json['revisionProvenance'],
      ),
      renderingBackend: json['renderingBackend'] as String,
      renderingBackendProvenance: $enumDecode(
        _$SceneSpikeObservationProvenanceEnumMap,
        json['renderingBackendProvenance'],
      ),
      startedAtUtc: DateTime.parse(json['startedAtUtc'] as String),
      elapsedMicroseconds: (json['elapsedMicroseconds'] as num).toInt(),
      frameCount: (json['frameCount'] as num).toInt(),
      partialUpdateCount: (json['partialUpdateCount'] as num).toInt(),
      lifecycleResumeCount: (json['lifecycleResumeCount'] as num).toInt(),
      appResourceGeneration: (json['appResourceGeneration'] as num).toInt(),
      capabilities: (json['capabilities'] as List<dynamic>)
          .map(
            (e) =>
                SceneSpikeCapabilityResult.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      performance: SceneSpikePerformanceSnapshot.fromJson(
        json['performance'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SceneSpikeEvidenceToJson(
  _SceneSpikeEvidence instance,
) => <String, dynamic>{
  'schemaVersion': instance.schemaVersion,
  'run': instance.run.toJson(),
  'deviceModel': instance.deviceModel,
  'operatingSystemVersion': instance.operatingSystemVersion,
  'flutterFrameworkRevision': instance.flutterFrameworkRevision,
  'flutterEngineRevision': instance.flutterEngineRevision,
  'dartVersion': instance.dartVersion,
  'flutterSceneRevision': instance.flutterSceneRevision,
  'eqmonitorMapRendererRevision': instance.eqmonitorMapRendererRevision,
  'eqmonitorMapRendererCheckoutDirty':
      instance.eqmonitorMapRendererCheckoutDirty,
  'revisionProvenance':
      _$SceneSpikeObservationProvenanceEnumMap[instance.revisionProvenance]!,
  'renderingBackend': instance.renderingBackend,
  'renderingBackendProvenance':
      _$SceneSpikeObservationProvenanceEnumMap[instance
          .renderingBackendProvenance]!,
  'startedAtUtc': instance.startedAtUtc.toIso8601String(),
  'elapsedMicroseconds': instance.elapsedMicroseconds,
  'frameCount': instance.frameCount,
  'partialUpdateCount': instance.partialUpdateCount,
  'lifecycleResumeCount': instance.lifecycleResumeCount,
  'appResourceGeneration': instance.appResourceGeneration,
  'capabilities': instance.capabilities.map((e) => e.toJson()).toList(),
  'performance': instance.performance.toJson(),
};
