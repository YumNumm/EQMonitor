// Expected platform, manifest, and lifecycle failures are recorded fail-closed.
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/spike_frame_timing_collector.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_evidence_collector.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/scene_spike_lifecycle.dart';
import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;
import 'package:vector_math/vector_math_64.dart' as model_math;

class SceneSpikeRuntimeObservationLog
    implements SceneSpikeRuntimeObservationSink {
  final Map<SceneSpikeCapability, SceneSpikeCapabilityResult> observations = {};

  @override
  void record(SceneSpikeRuntimeObservation observation) {
    observations[observation.capability] = SceneSpikeCapabilityResult(
      capability: observation.capability,
      status: observation.status,
      provenance: .runtimeSignal,
      detail: observation.detail,
      observedAtUtc: DateTime.now().toUtc(),
    );
  }

  void clear() {
    observations.clear();
  }
}

class FlutterSceneSpikeController extends ChangeNotifier {
  factory FlutterSceneSpikeController.create() {
    final startedAtUtc = DateTime.now().toUtc();
    final observationLog = SceneSpikeRuntimeObservationLog();
    final initialFrame = SpikeMeshFrame.initial();
    final adapter = FlutterSceneSpikeAdapter(
      initialFrame: initialFrame,
      observationSink: observationLog,
    );
    final projection = EqmonitorOrthographicProjection(worldHalfHeight: 1.2);
    final cameraNode = scene.Node(
      localTransform: scene_math.Matrix4.translationValues(0, 0, -2),
    );
    return FlutterSceneSpikeController._(
      adapter: adapter,
      observationLog: observationLog,
      projection: projection,
      camera: scene.NodeCamera(
        cameraNode,
        FlutterSceneOrthographicProjection(projection: projection),
      ),
      initialFrame: initialFrame,
      startedAtUtc: startedAtUtc,
    );
  }

  FlutterSceneSpikeController._({
    required FlutterSceneSpikeAdapter adapter,
    required SceneSpikeRuntimeObservationLog observationLog,
    required EqmonitorOrthographicProjection projection,
    required this.camera,
    required SpikeMeshFrame initialFrame,
    required DateTime startedAtUtc,
  }) : _adapter = adapter,
       _observationLog = observationLog,
       _projection = projection,
       _frame = initialFrame,
       _startedAtUtc = startedAtUtc;

  final FlutterSceneSpikeAdapter _adapter;
  final SceneSpikeRuntimeObservationLog _observationLog;
  final EqmonitorOrthographicProjection _projection;
  final scene.NodeCamera camera;
  final _lifecycleReducer = const SceneSpikeLifecycleReducer();
  final Map<SceneSpikeCapability, SceneSpikeCapabilityResult>
  _operatorAttestations = {};
  SpikeMeshFrame _frame;
  var _lifecycle = SceneSpikeLifecycleState.initial();
  var _timingCollector = SpikeFrameTimingCollector(
    capacity: 120,
  );
  var _performance = SceneSpikePerformanceAccumulator(sampleCapacity: 120);
  DateTime _startedAtUtc;
  Size? _logicalSize;
  double? _devicePixelRatio;
  String? _renderingBackend;
  String? _runStartFailure;
  SceneSpikeRuntimeIdentity? _runtimeIdentity;
  SceneSpikeBuildManifest? _buildManifest;
  String? _metadataFailure;
  var _partialUpdateCount = 0;
  var _lifecycleResumeCount = 0;
  var _isUpdating = false;
  var _isDisposed = false;

  scene.Scene get sceneGraph => _adapter.sceneGraph;

  SceneSpikeLifecycleState get lifecycle => _lifecycle;

  bool get isUpdating => _isUpdating;

  String? get renderingBackend => _renderingBackend;

  String? get runStartFailure => _runStartFailure;

  SceneSpikeRuntimeIdentity? get runtimeIdentity => _runtimeIdentity;

  SceneSpikeBuildManifest? get buildManifest => _buildManifest;

  String? get metadataFailure => _metadataFailure;

  int get frameCount => _timingCollector.sampleCount;

  int get partialUpdateCount => _partialUpdateCount;

  int get lifecycleResumeCount => _lifecycleResumeCount;

  SceneSpikePerformanceSnapshot get performance => _performance.snapshot();

  model_math.Matrix4 projectionMatrixFor(Size logicalSize) => _projection
      .matrixFor(aspectRatio: logicalSize.width / logicalSize.height);

  Future<void> initializeStaticResources() async {
    try {
      final runtimeSource = SceneSpikeProductionRuntimeIdentitySource();
      final platform = runtimeSource.readPlatform();
      _runtimeIdentity = SceneSpikeRuntimeIdentity(
        run: SceneSpikeRunKey(
          platform: platform,
          buildMode: runtimeSource.readBuildMode(),
        ),
        deviceModel: await runtimeSource.readDeviceModel(platform),
        operatingSystemVersion: runtimeSource.readOperatingSystemVersion(),
        dartVersion: runtimeSource.readDartVersion(),
      );
      _buildManifest = const SceneSpikeEnvironmentBuildManifestSource().read();
      _metadataFailure = null;
    } catch (error) {
      _metadataFailure = '$error';
    }
    await scene.Scene.initializeStaticResources();
    await _adapter.initializeCustomMaterial();
    notifyListeners();
  }

  void attach({required Size logicalSize, required double devicePixelRatio}) {
    if (_lifecycle.phase != .detached) {
      return;
    }
    _adapter.attach(
      logicalSize: logicalSize,
      devicePixelRatio: devicePixelRatio,
    );
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    _logicalSize = logicalSize;
    _devicePixelRatio = devicePixelRatio;
    notifyListeners();
  }

  void background() {
    if (_lifecycle.phase != .active && _lifecycle.phase != .background) {
      return;
    }
    _adapter.setForeground(isForeground: false);
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    _isUpdating = false;
    notifyListeners();
  }

  void foreground() {
    if (_lifecycle.phase != .background) {
      return;
    }
    _adapter.setForeground(isForeground: true);
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.foregrounded(),
    );
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    _lifecycleResumeCount += 1;
    _observationLog.record(
      const SceneSpikeRuntimeObservation(
        capability: .backgroundAndForeground,
        status: .passed,
        detail: 'Background and foreground lifecycle events were observed.',
      ),
    );
    notifyListeners();
  }

  void resize({required Size logicalSize, required double devicePixelRatio}) {
    final previousSize = _logicalSize;
    final previousRatio = _devicePixelRatio;
    _logicalSize = logicalSize;
    _devicePixelRatio = devicePixelRatio;
    if (_lifecycle.phase != .active ||
        (previousSize == logicalSize && previousRatio == devicePixelRatio)) {
      return;
    }
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration + 1,
    );
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    _observationLog.record(
      const SceneSpikeRuntimeObservation(
        capability: .dprAndResize,
        status: .passed,
        detail: 'Logical size or device pixel ratio changed.',
      ),
    );
    notifyListeners();
  }

  void requestAppResourceRebuild() {
    if (_lifecycle.phase != .active) {
      return;
    }
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration + 1,
    );
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    notifyListeners();
  }

  Future<void> completePendingAppResourceRebuild() async {
    if (_lifecycle.phase != .rebuilding) {
      return;
    }
    final generation = _lifecycle.appResourceGeneration;
    try {
      await _adapter.rebuildApplicationResources(
        appResourceGeneration: generation,
      );
      _lifecycle = _lifecycleReducer.reduce(
        state: _lifecycle,
        event: const SceneSpikeLifecycleEvent.rebuildCompleted(),
      );
      _performance.recordResourceRebuild();
    } catch (_) {
      _performance.recordException();
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void updatePartialMesh() {
    if (!_isUpdating || !_lifecycle.mayUpload) {
      return;
    }
    final vertexIndex = _partialUpdateCount % 6;
    final phase = _partialUpdateCount.isEven ? 1.0 : -1.0;
    final nextFrame = _frame.updateVertex(
      vertexIndex: vertexIndex,
      position: model_math.Vector3(
        _frame.positions[vertexIndex * 3] + 0.02 * phase,
        _frame.positions[vertexIndex * 3 + 1],
        0,
      ),
      color: model_math.Vector4(
        _partialUpdateCount.isEven ? 1 : 0.2,
        _partialUpdateCount.isEven ? 0.2 : 1,
        0.4,
        1,
      ),
    );
    try {
      _adapter.updateMesh(frame: nextFrame);
      _frame = nextFrame;
      _partialUpdateCount += 1;
      _performance.recordPartialUpdate();
    } catch (_) {
      _performance.recordException();
      _isUpdating = false;
    }
    notifyListeners();
  }

  void recordFrameTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      _timingCollector.add(
        buildDuration: timing.buildDuration,
        rasterDuration: timing.rasterDuration,
      );
      _performance.recordFrameTiming(
        buildDurationMicroseconds: timing.buildDuration.inMicroseconds,
        rasterDurationMicroseconds: timing.rasterDuration.inMicroseconds,
        wasDropped: timing.totalSpan > const Duration(microseconds: 16667),
      );
    }
    notifyListeners();
  }

  void recordTextPainterOverlay() {
    _observationLog.record(
      const SceneSpikeRuntimeObservation(
        capability: .textPainterOverlay,
        status: .passed,
        detail: 'TextPainter overlay was composed above SceneView.',
      ),
    );
  }

  void attestRenderingBackend(String backend) {
    if (!backendAttestationOptions().contains(backend)) {
      throw ArgumentError.value(backend, 'backend');
    }
    _renderingBackend = backend;
    notifyListeners();
  }

  List<String> backendAttestationOptions() =>
      switch (_runtimeIdentity?.run.platform) {
        .ios => const ['Impeller Metal'],
        .android => const ['Impeller Vulkan', 'Impeller OpenGLES'],
        null => const [],
      };

  void attestCapability(SceneSpikeCapability capability) {
    if (SceneSpikeEvidenceContract.requiredProvenance(capability) !=
        .operatorAttestation) {
      throw StateError('Capability does not allow operator attestation.');
    }
    final runtimeObservation = _observationLog.observations[capability];
    if (runtimeObservation?.status == .failed) {
      throw StateError('A failed runtime observation cannot be attested.');
    }
    _operatorAttestations[capability] = SceneSpikeCapabilityResult(
      capability: capability,
      status: .passed,
      provenance: .operatorAttestation,
      detail: 'Operator completed the fixed visual checklist.',
      observedAtUtc: DateTime.now().toUtc(),
    );
    notifyListeners();
  }

  String? validateRunStart() {
    try {
      final runtimeSource = SceneSpikeProductionRuntimeIdentitySource();
      runtimeSource
        ..readPlatform()
        ..readBuildMode();
      final manifest = const SceneSpikeEnvironmentBuildManifestSource().read();
      SceneSpikeTrustedInputValidator.validateManifest(manifest);
      return null;
    } catch (error) {
      return '$error';
    }
  }

  void startUpdates() {
    final failure = validateRunStart();
    if (failure != null || _renderingBackend == null) {
      _runStartFailure = failure ?? 'Renderer backend attestation is required.';
      _isUpdating = false;
      notifyListeners();
      return;
    }
    _runStartFailure = null;
    _isUpdating = true;
    notifyListeners();
  }

  void stopUpdates() {
    _isUpdating = false;
    notifyListeners();
  }

  List<SceneSpikeCapabilityResult> capabilityResults() => [
    for (final capability in SceneSpikeEvidenceContract.requiredCapabilities)
      capabilityResult(capability),
  ];

  SceneSpikeCapabilityResult capabilityResult(
    SceneSpikeCapability capability,
  ) {
    final requiredProvenance = SceneSpikeEvidenceContract.requiredProvenance(
      capability,
    );
    if (requiredProvenance == .unavailablePublicApi) {
      return SceneSpikeCapabilityResult(
        capability: capability,
        status: .unobserved,
        provenance: .unavailablePublicApi,
        detail: 'Flutter Scene public API is unavailable.',
        observedAtUtc: _startedAtUtc,
      );
    }
    if (requiredProvenance == .runtimeSignal) {
      return _observationLog.observations[capability] ??
          SceneSpikeCapabilityResult(
            capability: capability,
            status: .unobserved,
            provenance: .runtimeSignal,
            detail: 'Runtime event has not been observed.',
            observedAtUtc: _startedAtUtc,
          );
    }
    final runtimeFailure = _observationLog.observations[capability];
    if (runtimeFailure?.status == .failed) {
      return SceneSpikeCapabilityResult(
        capability: capability,
        status: .failed,
        provenance: .operatorAttestation,
        detail: runtimeFailure?.detail ?? 'Runtime capability failed.',
        observedAtUtc: runtimeFailure?.observedAtUtc ?? _startedAtUtc,
      );
    }
    return _operatorAttestations[capability] ??
        SceneSpikeCapabilityResult(
          capability: capability,
          status: .unobserved,
          provenance: .operatorAttestation,
          detail: 'Fixed operator checklist has not been completed.',
          observedAtUtc: _startedAtUtc,
        );
  }

  Future<String> canonicalEvidenceJson() async {
    final backend = _renderingBackend;
    if (backend == null) {
      throw StateError('Renderer backend attestation is required.');
    }
    final evidence =
        await SceneSpikeEvidenceCollector(
          runtimeSource: SceneSpikeProductionRuntimeIdentitySource(),
          manifestSource: const SceneSpikeEnvironmentBuildManifestSource(),
        ).collect(
          renderingBackend: backend,
          startedAtUtc: _startedAtUtc,
          elapsedMicroseconds: DateTime.now()
              .toUtc()
              .difference(_startedAtUtc)
              .inMicroseconds,
          frameCount: frameCount,
          partialUpdateCount: _partialUpdateCount,
          lifecycleResumeCount: _lifecycleResumeCount,
          appResourceGeneration: _lifecycle.appResourceGeneration,
          capabilities: capabilityResults(),
          performance: _performance.snapshot(),
        );
    return jsonEncode(evidence.toJson());
  }

  void resetEvidence() {
    _startedAtUtc = DateTime.now().toUtc();
    _timingCollector = SpikeFrameTimingCollector(capacity: 120);
    _performance = SceneSpikePerformanceAccumulator(sampleCapacity: 120);
    _partialUpdateCount = 0;
    _lifecycleResumeCount = 0;
    _renderingBackend = null;
    _runStartFailure = null;
    _operatorAttestations.clear();
    _observationLog.clear();
    _observationLog
      ..record(
        const SceneSpikeRuntimeObservation(
          capability: .proceduralOrthographicMesh,
          status: .passed,
          detail: 'Procedural updatable quad remains mounted.',
        ),
      )
      ..record(
        const SceneSpikeRuntimeObservation(
          capability: .unlitMaterial,
          status: .passed,
          detail: 'Unlit vertex-color material remains mounted.',
        ),
      );
    _isUpdating = false;
    notifyListeners();
  }

  void detach() {
    if (_lifecycle.phase == .detached || _lifecycle.phase == .disposed) {
      return;
    }
    _adapter.detach();
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.detached(),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _adapter.dispose();
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.disposed(),
    );
    _isDisposed = true;
    super.dispose();
  }
}
