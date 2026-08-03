import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_spike_observation.freezed.dart';
part 'scene_spike_observation.g.dart';

enum SceneSpikePlatform { ios, android }

enum SceneSpikeBuildMode { profile, release }

enum SceneSpikeCapabilityStatus { passed, failed, unobserved }

enum SceneSpikeObservationProvenance {
  runtimeSignal,
  compileTimeManifest,
  operatorAttestation,
  unavailablePublicApi,
}

enum SceneSpikeCapability {
  proceduralOrthographicMesh,
  unlitMaterial,
  customMaterial,
  partialPositionAndColorUpdate,
  textPainterOverlay,
  dprAndResize,
  backgroundAndForeground,
  disposeAndRemount,
  explicitResourceDisposal,
  contextResourceRebuild,
  gpuCompletionOrSafeRetirement,
}

class SceneSpikeStrictIntConverter implements JsonConverter<int, num> {
  const SceneSpikeStrictIntConverter();

  @override
  int fromJson(num value) {
    if (value is! int) {
      throw FormatException('Expected an integer, got $value.');
    }
    return value;
  }

  @override
  int toJson(int value) => value;
}

@freezed
sealed class SceneSpikeRunKey with _$SceneSpikeRunKey {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeRunKey({
    required SceneSpikePlatform platform,
    required SceneSpikeBuildMode buildMode,
  }) = _SceneSpikeRunKey;

  factory SceneSpikeRunKey.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeRunKeyFromJson(json);
}

@freezed
sealed class SceneSpikeCapabilityResult with _$SceneSpikeCapabilityResult {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeCapabilityResult({
    required SceneSpikeCapability capability,
    required SceneSpikeCapabilityStatus status,
    required SceneSpikeObservationProvenance provenance,
    required String detail,
    required DateTime observedAtUtc,
  }) = _SceneSpikeCapabilityResult;

  factory SceneSpikeCapabilityResult.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeCapabilityResultFromJson(json);
}

@freezed
sealed class SceneSpikeCustomMaterialRuntimeSuccess
    with _$SceneSpikeCustomMaterialRuntimeSuccess {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeCustomMaterialRuntimeSuccess({
    @SceneSpikeStrictIntConverter() required int controllerGeneration,
    @SceneSpikeStrictIntConverter() required int appResourceGeneration,
    required DateTime observedAtUtc,
  }) = _SceneSpikeCustomMaterialRuntimeSuccess;

  factory SceneSpikeCustomMaterialRuntimeSuccess.fromJson(
    Map<String, dynamic> json,
  ) => _$SceneSpikeCustomMaterialRuntimeSuccessFromJson(json);
}

@freezed
sealed class SceneSpikeCustomMaterialRuntimeFailure
    with _$SceneSpikeCustomMaterialRuntimeFailure {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeCustomMaterialRuntimeFailure({
    @SceneSpikeStrictIntConverter() required int controllerGeneration,
    @SceneSpikeStrictIntConverter() required int appResourceGeneration,
    required String detail,
    required DateTime observedAtUtc,
  }) = _SceneSpikeCustomMaterialRuntimeFailure;

  factory SceneSpikeCustomMaterialRuntimeFailure.fromJson(
    Map<String, dynamic> json,
  ) => _$SceneSpikeCustomMaterialRuntimeFailureFromJson(json);
}

@freezed
sealed class SceneSpikePerformanceSnapshot
    with _$SceneSpikePerformanceSnapshot {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikePerformanceSnapshot({
    @SceneSpikeStrictIntConverter() required int buildDurationCount,
    @SceneSpikeStrictIntConverter() required int buildDurationMaxMicroseconds,
    @SceneSpikeStrictIntConverter() required int buildDurationP50Microseconds,
    @SceneSpikeStrictIntConverter() required int buildDurationP95Microseconds,
    @SceneSpikeStrictIntConverter() required int rasterDurationCount,
    @SceneSpikeStrictIntConverter() required int rasterDurationMaxMicroseconds,
    @SceneSpikeStrictIntConverter() required int rasterDurationP50Microseconds,
    @SceneSpikeStrictIntConverter() required int rasterDurationP95Microseconds,
    @SceneSpikeStrictIntConverter() required int droppedFrameCount,
    @SceneSpikeStrictIntConverter() required int partialUpdateCount,
    @SceneSpikeStrictIntConverter() required int resourceRebuildCount,
    @SceneSpikeStrictIntConverter() required int exceptionCount,
  }) = _SceneSpikePerformanceSnapshot;

  factory SceneSpikePerformanceSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikePerformanceSnapshotFromJson(json);
}

@freezed
@JsonSerializable(explicitToJson: true)
class SceneSpikeEvidence with _$SceneSpikeEvidence {
  SceneSpikeEvidence({
    required this.schemaVersion,
    required this.run,
    required this.deviceModel,
    required this.operatingSystemVersion,
    required this.flutterFrameworkRevision,
    required this.flutterEngineRevision,
    required this.dartVersion,
    required this.dartSourceRevision,
    required this.flutterSceneRevision,
    required this.eqmonitorMapRendererRevision,
    required this.eqmonitorMapRendererCheckoutDirty,
    required this.revisionProvenance,
    required this.renderingBackend,
    required this.renderingBackendProvenance,
    required this.startedAtUtc,
    required this.elapsedMicroseconds,
    required this.frameCount,
    required this.partialUpdateCount,
    required this.lifecycleResumeCount,
    required this.disposeAndRemountCount,
    required this.controllerGeneration,
    required this.appResourceGeneration,
    required this.customMaterialRuntimeSuccess,
    required List<SceneSpikeCustomMaterialRuntimeFailure>
    customMaterialRuntimeFailures,
    required List<SceneSpikeCapabilityResult> capabilities,
    required this.performance,
  }) : customMaterialRuntimeFailures = List.unmodifiable(
         customMaterialRuntimeFailures,
       ),
       capabilities = List.unmodifiable(capabilities);

  factory SceneSpikeEvidence.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeEvidenceFromJson(json);

  @SceneSpikeStrictIntConverter()
  @override
  final int schemaVersion;
  @override
  final SceneSpikeRunKey run;
  @override
  final String deviceModel;
  @override
  final String operatingSystemVersion;
  @override
  final String flutterFrameworkRevision;
  @override
  final String flutterEngineRevision;
  @override
  final String dartVersion;
  @override
  final String dartSourceRevision;
  @override
  final String flutterSceneRevision;
  @override
  final String eqmonitorMapRendererRevision;
  @override
  final bool eqmonitorMapRendererCheckoutDirty;
  @override
  final SceneSpikeObservationProvenance revisionProvenance;
  @override
  final String renderingBackend;
  @override
  final SceneSpikeObservationProvenance renderingBackendProvenance;
  @override
  final DateTime startedAtUtc;
  @SceneSpikeStrictIntConverter()
  @override
  final int elapsedMicroseconds;
  @SceneSpikeStrictIntConverter()
  @override
  final int frameCount;
  @SceneSpikeStrictIntConverter()
  @override
  final int partialUpdateCount;
  @SceneSpikeStrictIntConverter()
  @override
  final int lifecycleResumeCount;
  @SceneSpikeStrictIntConverter()
  @override
  final int disposeAndRemountCount;
  @SceneSpikeStrictIntConverter()
  @override
  final int controllerGeneration;
  @SceneSpikeStrictIntConverter()
  @override
  final int appResourceGeneration;
  @override
  final SceneSpikeCustomMaterialRuntimeSuccess? customMaterialRuntimeSuccess;
  @override
  final List<SceneSpikeCustomMaterialRuntimeFailure>
  customMaterialRuntimeFailures;
  @override
  final List<SceneSpikeCapabilityResult> capabilities;
  @override
  final SceneSpikePerformanceSnapshot performance;

  Map<String, dynamic> toJson() => _$SceneSpikeEvidenceToJson(this);
}

abstract interface class SceneSpikePerformanceSink {
  void recordFrameTiming({
    required int buildDurationMicroseconds,
    required int rasterDurationMicroseconds,
    required bool wasDropped,
  });

  void recordPartialUpdate();

  void recordResourceRebuild();

  void recordException();

  SceneSpikePerformanceSnapshot snapshot();
}

class SceneSpikePerformanceAccumulator implements SceneSpikePerformanceSink {
  SceneSpikePerformanceAccumulator({required int sampleCapacity})
    : _buildDurations = SceneSpikeDurationAccumulator(
        sampleCapacity: sampleCapacity,
      ),
      _rasterDurations = SceneSpikeDurationAccumulator(
        sampleCapacity: sampleCapacity,
      );

  final SceneSpikeDurationAccumulator _buildDurations;
  final SceneSpikeDurationAccumulator _rasterDurations;
  var _droppedFrameCount = 0;
  var _partialUpdateCount = 0;
  var _resourceRebuildCount = 0;
  var _exceptionCount = 0;

  @override
  void recordFrameTiming({
    required int buildDurationMicroseconds,
    required int rasterDurationMicroseconds,
    required bool wasDropped,
  }) {
    if (buildDurationMicroseconds < 0 || rasterDurationMicroseconds < 0) {
      throw RangeError('Frame durations must be non-negative.');
    }
    _buildDurations.add(buildDurationMicroseconds);
    _rasterDurations.add(rasterDurationMicroseconds);
    if (wasDropped) {
      _droppedFrameCount += 1;
    }
  }

  @override
  void recordPartialUpdate() {
    _partialUpdateCount += 1;
  }

  @override
  void recordResourceRebuild() {
    _resourceRebuildCount += 1;
  }

  @override
  void recordException() {
    _exceptionCount += 1;
  }

  @override
  SceneSpikePerformanceSnapshot snapshot() {
    final build = _buildDurations.statistics();
    final raster = _rasterDurations.statistics();
    return SceneSpikePerformanceSnapshot(
      buildDurationCount: build.count,
      buildDurationMaxMicroseconds: build.max,
      buildDurationP50Microseconds: build.p50,
      buildDurationP95Microseconds: build.p95,
      rasterDurationCount: raster.count,
      rasterDurationMaxMicroseconds: raster.max,
      rasterDurationP50Microseconds: raster.p50,
      rasterDurationP95Microseconds: raster.p95,
      droppedFrameCount: _droppedFrameCount,
      partialUpdateCount: _partialUpdateCount,
      resourceRebuildCount: _resourceRebuildCount,
      exceptionCount: _exceptionCount,
    );
  }
}

class SceneSpikeDurationAccumulator {
  SceneSpikeDurationAccumulator({required int sampleCapacity})
    : _sampleCapacity = sampleCapacity,
      _samples = List<int>.filled(sampleCapacity > 0 ? sampleCapacity : 1, 0) {
    if (sampleCapacity <= 0) {
      throw ArgumentError.value(
        sampleCapacity,
        'sampleCapacity',
        'Must be greater than zero.',
      );
    }
  }

  final int _sampleCapacity;
  final List<int> _samples;
  var _totalCount = 0;
  var _retainedCount = 0;
  var _nextIndex = 0;
  var _globalMax = 0;

  void add(int sampleMicroseconds) {
    if (sampleMicroseconds < 0) {
      throw RangeError.value(
        sampleMicroseconds,
        'sampleMicroseconds',
        'Must be non-negative.',
      );
    }
    _samples[_nextIndex] = sampleMicroseconds;
    _nextIndex = (_nextIndex + 1) % _sampleCapacity;
    _retainedCount = math.min(_retainedCount + 1, _sampleCapacity);
    _totalCount += 1;
    _globalMax = math.max(_globalMax, sampleMicroseconds);
  }

  ({int count, int max, int p50, int p95}) statistics() {
    if (_retainedCount == 0) {
      return (count: _totalCount, max: _globalMax, p50: 0, p95: 0);
    }
    final retained = _samples.take(_retainedCount).toList()..sort();
    return (
      count: _totalCount,
      max: _globalMax,
      p50: SceneSpikePercentileCalculator.calculate(
        sortedSamples: retained,
        percentile: 50,
      ),
      p95: SceneSpikePercentileCalculator.calculate(
        sortedSamples: retained,
        percentile: 95,
      ),
    );
  }
}

class SceneSpikePercentileCalculator {
  const SceneSpikePercentileCalculator._();

  static int calculate({
    required List<int> sortedSamples,
    required int percentile,
  }) {
    if (sortedSamples.isEmpty) {
      return 0;
    }
    if (percentile < 1 || percentile > 100) {
      throw RangeError.range(percentile, 1, 100, 'percentile');
    }
    final rank = (percentile * sortedSamples.length + 99) ~/ 100;
    return sortedSamples[rank - 1];
  }
}
