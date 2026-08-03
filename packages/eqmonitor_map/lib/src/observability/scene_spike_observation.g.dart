// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_spike_observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneSpikeEvidence _$SceneSpikeEvidenceFromJson(Map<String, dynamic> json) =>
    SceneSpikeEvidence(
      schemaVersion: const SceneSpikeStrictIntConverter().fromJson(
        json['schemaVersion'] as num,
      ),
      run: SceneSpikeRunKey.fromJson(json['run'] as Map<String, dynamic>),
      deviceModel: json['deviceModel'] as String,
      operatingSystemVersion: json['operatingSystemVersion'] as String,
      flutterFrameworkRevision: json['flutterFrameworkRevision'] as String,
      flutterEngineRevision: json['flutterEngineRevision'] as String,
      dartVersion: json['dartVersion'] as String,
      dartSourceRevision: json['dartSourceRevision'] as String,
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
      elapsedMicroseconds: const SceneSpikeStrictIntConverter().fromJson(
        json['elapsedMicroseconds'] as num,
      ),
      frameCount: const SceneSpikeStrictIntConverter().fromJson(
        json['frameCount'] as num,
      ),
      partialUpdateCount: const SceneSpikeStrictIntConverter().fromJson(
        json['partialUpdateCount'] as num,
      ),
      lifecycleResumeCount: const SceneSpikeStrictIntConverter().fromJson(
        json['lifecycleResumeCount'] as num,
      ),
      disposeAndRemountCount: const SceneSpikeStrictIntConverter().fromJson(
        json['disposeAndRemountCount'] as num,
      ),
      appResourceGeneration: const SceneSpikeStrictIntConverter().fromJson(
        json['appResourceGeneration'] as num,
      ),
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
  SceneSpikeEvidence instance,
) => <String, dynamic>{
  'schemaVersion': const SceneSpikeStrictIntConverter().toJson(
    instance.schemaVersion,
  ),
  'run': instance.run.toJson(),
  'deviceModel': instance.deviceModel,
  'operatingSystemVersion': instance.operatingSystemVersion,
  'flutterFrameworkRevision': instance.flutterFrameworkRevision,
  'flutterEngineRevision': instance.flutterEngineRevision,
  'dartVersion': instance.dartVersion,
  'dartSourceRevision': instance.dartSourceRevision,
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
  'elapsedMicroseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.elapsedMicroseconds,
  ),
  'frameCount': const SceneSpikeStrictIntConverter().toJson(
    instance.frameCount,
  ),
  'partialUpdateCount': const SceneSpikeStrictIntConverter().toJson(
    instance.partialUpdateCount,
  ),
  'lifecycleResumeCount': const SceneSpikeStrictIntConverter().toJson(
    instance.lifecycleResumeCount,
  ),
  'disposeAndRemountCount': const SceneSpikeStrictIntConverter().toJson(
    instance.disposeAndRemountCount,
  ),
  'appResourceGeneration': const SceneSpikeStrictIntConverter().toJson(
    instance.appResourceGeneration,
  ),
  'capabilities': instance.capabilities.map((e) => e.toJson()).toList(),
  'performance': instance.performance.toJson(),
};

const _$SceneSpikeObservationProvenanceEnumMap = {
  SceneSpikeObservationProvenance.runtimeSignal: 'runtimeSignal',
  SceneSpikeObservationProvenance.compileTimeManifest: 'compileTimeManifest',
  SceneSpikeObservationProvenance.operatorAttestation: 'operatorAttestation',
  SceneSpikeObservationProvenance.unavailablePublicApi: 'unavailablePublicApi',
};

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

_SceneSpikePerformanceSnapshot _$SceneSpikePerformanceSnapshotFromJson(
  Map<String, dynamic> json,
) => _SceneSpikePerformanceSnapshot(
  buildDurationCount: const SceneSpikeStrictIntConverter().fromJson(
    json['buildDurationCount'] as num,
  ),
  buildDurationMaxMicroseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['buildDurationMaxMicroseconds'] as num,
  ),
  buildDurationP50Microseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['buildDurationP50Microseconds'] as num,
  ),
  buildDurationP95Microseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['buildDurationP95Microseconds'] as num,
  ),
  rasterDurationCount: const SceneSpikeStrictIntConverter().fromJson(
    json['rasterDurationCount'] as num,
  ),
  rasterDurationMaxMicroseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['rasterDurationMaxMicroseconds'] as num,
  ),
  rasterDurationP50Microseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['rasterDurationP50Microseconds'] as num,
  ),
  rasterDurationP95Microseconds: const SceneSpikeStrictIntConverter().fromJson(
    json['rasterDurationP95Microseconds'] as num,
  ),
  droppedFrameCount: const SceneSpikeStrictIntConverter().fromJson(
    json['droppedFrameCount'] as num,
  ),
  partialUpdateCount: const SceneSpikeStrictIntConverter().fromJson(
    json['partialUpdateCount'] as num,
  ),
  resourceRebuildCount: const SceneSpikeStrictIntConverter().fromJson(
    json['resourceRebuildCount'] as num,
  ),
  exceptionCount: const SceneSpikeStrictIntConverter().fromJson(
    json['exceptionCount'] as num,
  ),
);

Map<String, dynamic> _$SceneSpikePerformanceSnapshotToJson(
  _SceneSpikePerformanceSnapshot instance,
) => <String, dynamic>{
  'buildDurationCount': const SceneSpikeStrictIntConverter().toJson(
    instance.buildDurationCount,
  ),
  'buildDurationMaxMicroseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.buildDurationMaxMicroseconds,
  ),
  'buildDurationP50Microseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.buildDurationP50Microseconds,
  ),
  'buildDurationP95Microseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.buildDurationP95Microseconds,
  ),
  'rasterDurationCount': const SceneSpikeStrictIntConverter().toJson(
    instance.rasterDurationCount,
  ),
  'rasterDurationMaxMicroseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.rasterDurationMaxMicroseconds,
  ),
  'rasterDurationP50Microseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.rasterDurationP50Microseconds,
  ),
  'rasterDurationP95Microseconds': const SceneSpikeStrictIntConverter().toJson(
    instance.rasterDurationP95Microseconds,
  ),
  'droppedFrameCount': const SceneSpikeStrictIntConverter().toJson(
    instance.droppedFrameCount,
  ),
  'partialUpdateCount': const SceneSpikeStrictIntConverter().toJson(
    instance.partialUpdateCount,
  ),
  'resourceRebuildCount': const SceneSpikeStrictIntConverter().toJson(
    instance.resourceRebuildCount,
  ),
  'exceptionCount': const SceneSpikeStrictIntConverter().toJson(
    instance.exceptionCount,
  ),
};
