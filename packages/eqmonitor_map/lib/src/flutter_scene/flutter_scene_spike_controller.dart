// Expected platform, manifest, and lifecycle failures are recorded fail-closed.
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/scene_spike_operator_checklist.dart';
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

class SceneSpikeRunLog implements SceneSpikeRuntimeObservationSink {
  SceneSpikeRunLog({required this.startedAtUtc})
    : timingCollector = SpikeFrameTimingCollector(capacity: 120),
      performance = SceneSpikePerformanceAccumulator(sampleCapacity: 120);

  final Map<SceneSpikeCapability, SceneSpikeCapabilityResult> observations = {};
  SpikeFrameTimingCollector timingCollector;
  SceneSpikePerformanceAccumulator performance;
  DateTime startedAtUtc;
  var _partialUpdateCount = 0;
  var _lifecycleResumeCount = 0;
  var _disposeAndRemountCount = 0;
  var _latestControllerGeneration = -1;

  SceneSpikeCustomMaterialRuntimeSuccess? customMaterialRuntimeSuccess;
  final List<SceneSpikeCustomMaterialRuntimeFailure>
  _customMaterialRuntimeFailures = [];

  List<SceneSpikeCustomMaterialRuntimeFailure>
  get customMaterialRuntimeFailures =>
      List.unmodifiable(_customMaterialRuntimeFailures);

  int get disposeAndRemountCount => _disposeAndRemountCount;

  int get partialUpdateCount => _partialUpdateCount;

  int get lifecycleResumeCount => _lifecycleResumeCount;

  int beginControllerGeneration() => _latestControllerGeneration += 1;

  void recordCustomMaterialRuntimeSuccess({
    required int controllerGeneration,
    required int appResourceGeneration,
  }) {
    if (controllerGeneration != _latestControllerGeneration) {
      return;
    }
    customMaterialRuntimeSuccess = SceneSpikeCustomMaterialRuntimeSuccess(
      controllerGeneration: controllerGeneration,
      appResourceGeneration: appResourceGeneration,
      observedAtUtc: DateTime.now().toUtc(),
    );
  }

  void recordCustomMaterialRuntimeFailure({
    required int controllerGeneration,
    required int appResourceGeneration,
    required String detail,
  }) {
    if (controllerGeneration != _latestControllerGeneration) {
      return;
    }
    _customMaterialRuntimeFailures.add(
      SceneSpikeCustomMaterialRuntimeFailure(
        controllerGeneration: controllerGeneration,
        appResourceGeneration: appResourceGeneration,
        detail: detail,
        observedAtUtc: DateTime.now().toUtc(),
      ),
    );
  }

  SceneSpikeCustomMaterialRuntimeFailure? currentCustomMaterialRuntimeFailure({
    required int controllerGeneration,
    required int appResourceGeneration,
  }) {
    final matchingFailures = _customMaterialRuntimeFailures.where(
      (failure) =>
          failure.controllerGeneration == controllerGeneration &&
          failure.appResourceGeneration == appResourceGeneration,
    );
    if (matchingFailures.isEmpty) {
      return null;
    }
    final latestFailure = matchingFailures.last;
    final success = customMaterialRuntimeSuccess;
    if (success != null &&
        success.controllerGeneration == controllerGeneration &&
        success.appResourceGeneration == appResourceGeneration &&
        success.observedAtUtc.isAfter(latestFailure.observedAtUtc)) {
      return null;
    }
    return latestFailure;
  }

  void recordPartialUpdate() {
    _partialUpdateCount += 1;
    performance.recordPartialUpdate();
  }

  void recordLifecycleResume() {
    _lifecycleResumeCount += 1;
  }

  @override
  void record(SceneSpikeRuntimeObservation observation) {
    final existing = observations[observation.capability];
    if (existing?.status == .failed) {
      return;
    }
    observations[observation.capability] = SceneSpikeCapabilityResult(
      capability: observation.capability,
      status: observation.status,
      provenance: .runtimeSignal,
      detail: observation.detail,
      observedAtUtc: DateTime.now().toUtc(),
    );
  }

  void reset({required DateTime startedAtUtc}) {
    final terminalFailures = observations.map(
      (capability, result) => MapEntry(
        capability,
        result.copyWith(observedAtUtc: startedAtUtc),
      ),
    )..removeWhere((_, result) => result.status != .failed);
    observations
      ..clear()
      ..addAll(terminalFailures);
    this.startedAtUtc = startedAtUtc;
    timingCollector = SpikeFrameTimingCollector(capacity: 120);
    performance = SceneSpikePerformanceAccumulator(sampleCapacity: 120);
    _partialUpdateCount = 0;
    _lifecycleResumeCount = 0;
    _disposeAndRemountCount = 0;
    customMaterialRuntimeSuccess = null;
    final preservedFailures = _customMaterialRuntimeFailures
        .map((failure) => failure.copyWith(observedAtUtc: startedAtUtc))
        .toList();
    _customMaterialRuntimeFailures
      ..clear()
      ..addAll(preservedFailures);
  }

  void recordConfirmedDisposeAndRemount() {
    _disposeAndRemountCount += 1;
    record(
      const SceneSpikeRuntimeObservation(
        capability: .disposeAndRemount,
        status: .passed,
        detail: 'Previous controller disposed and replacement mounted.',
      ),
    );
  }
}

class FlutterSceneSpikeController extends ChangeNotifier {
  factory FlutterSceneSpikeController.create({
    SceneSpikeRunLog? runLog,
  }) {
    final startedAtUtc = DateTime.now().toUtc();
    final currentRunLog =
        runLog ?? SceneSpikeRunLog(startedAtUtc: startedAtUtc);
    final initialFrame = SpikeMeshFrame.initial();
    final adapter = FlutterSceneSpikeAdapter(
      initialFrame: initialFrame,
      observationSink: currentRunLog,
    );
    final projection = EqmonitorOrthographicProjection(worldHalfHeight: 1.2);
    final cameraNode = scene.Node(
      localTransform: scene_math.Matrix4.translationValues(0, 0, -2),
    );
    return FlutterSceneSpikeController.withDependencies(
      adapter: adapter,
      runLog: currentRunLog,
      projection: projection,
      camera: scene.NodeCamera(
        cameraNode,
        FlutterSceneOrthographicProjection(projection: projection),
      ),
      initialFrame: initialFrame,
      runtimeSource: SceneSpikeProductionRuntimeIdentitySource(),
      manifestSource: const SceneSpikeEnvironmentBuildManifestSource(),
      initializeSceneStaticResources: scene.Scene.initializeStaticResources,
      controllerGeneration: currentRunLog.beginControllerGeneration(),
    );
  }

  FlutterSceneSpikeController.withDependencies({
    required SceneSpikeControllerAdapter adapter,
    required SceneSpikeRunLog runLog,
    required EqmonitorOrthographicProjection projection,
    required SpikeMeshFrame initialFrame,
    required SceneSpikeRuntimeIdentitySource runtimeSource,
    required SceneSpikeBuildManifestSource manifestSource,
    required Future<void> Function() initializeSceneStaticResources,
    required int controllerGeneration,
    scene.NodeCamera? camera,
  }) : _adapter = adapter,
       _runLog = runLog,
       _projection = projection,
       _camera = camera,
       _frame = initialFrame,
       _runtimeSource = runtimeSource,
       _manifestSource = manifestSource,
       _controllerGeneration = controllerGeneration,
       _initializeSceneStaticResources = initializeSceneStaticResources;

  final SceneSpikeControllerAdapter _adapter;
  final SceneSpikeRunLog _runLog;
  final EqmonitorOrthographicProjection _projection;
  final SceneSpikeRuntimeIdentitySource _runtimeSource;
  final SceneSpikeBuildManifestSource _manifestSource;
  final int _controllerGeneration;
  final Future<void> Function() _initializeSceneStaticResources;
  final scene.NodeCamera? _camera;
  final _lifecycleReducer = const SceneSpikeLifecycleReducer();
  final _materialOperationGeneration = SceneSpikeAsyncGenerationOwner();
  final Map<SceneSpikeCapability, SceneSpikeCapabilityResult>
  _operatorAttestations = {};
  final Map<SceneSpikeCapability, Set<String>> _completedChecklistCriteria = {};
  SpikeMeshFrame _frame;
  var _lifecycle = SceneSpikeLifecycleState.initial();
  Size? _logicalSize;
  double? _devicePixelRatio;
  String? _renderingBackend;
  String? _runStartFailure;
  SceneSpikeRuntimeIdentity? _runtimeIdentity;
  SceneSpikeBuildManifest? _buildManifest;
  String? _metadataFailure;
  var _isUpdating = false;
  var _isDisposed = false;

  scene.Scene get sceneGraph =>
      _adapter.sceneGraph ??
      (throw StateError('Scene graph is unavailable for this controller.'));

  scene.NodeCamera get camera =>
      _camera ??
      (throw StateError('Scene camera is unavailable for this controller.'));

  SceneSpikeLifecycleState get lifecycle => _lifecycle;

  bool get isUpdating => _isUpdating;

  String? get renderingBackend => _renderingBackend;

  String? get runStartFailure => _runStartFailure;

  SceneSpikeRuntimeIdentity? get runtimeIdentity => _runtimeIdentity;

  SceneSpikeBuildManifest? get buildManifest => _buildManifest;

  String? get metadataFailure => _metadataFailure;

  int get frameCount => _runLog.timingCollector.sampleCount;

  int get partialUpdateCount => _runLog.partialUpdateCount;

  int get lifecycleResumeCount => _runLog.lifecycleResumeCount;

  int get disposeAndRemountCount => _runLog.disposeAndRemountCount;

  SceneSpikePerformanceSnapshot get performance =>
      _runLog.performance.snapshot();

  model_math.Matrix4 projectionMatrixFor(Size logicalSize) => _projection
      .matrixFor(aspectRatio: logicalSize.width / logicalSize.height);

  Future<void> initializeStaticResources() async {
    if (_isDisposed) {
      return;
    }
    final token = _materialOperationGeneration.begin();
    SceneSpikeRuntimeIdentity? runtimeIdentity;
    SceneSpikeBuildManifest? buildManifest;
    String? metadataFailure;
    try {
      final platform = _runtimeSource.readPlatform();
      final deviceModel = await _runtimeSource.readDeviceModel(platform);
      if (!token.isCurrent || _isDisposed) {
        return;
      }
      runtimeIdentity = SceneSpikeRuntimeIdentity(
        run: SceneSpikeRunKey(
          platform: platform,
          buildMode: _runtimeSource.readBuildMode(),
        ),
        deviceModel: deviceModel,
        operatingSystemVersion: _runtimeSource.readOperatingSystemVersion(),
        dartVersion: _runtimeSource.readDartVersion(),
      );
      buildManifest = _manifestSource.read();
    } catch (error) {
      if (!token.isCurrent || _isDisposed) {
        return;
      }
      metadataFailure = '$error';
    }
    if (!token.isCurrent || _isDisposed) {
      return;
    }
    _runtimeIdentity = runtimeIdentity;
    _buildManifest = buildManifest;
    _metadataFailure = metadataFailure;
    try {
      await _initializeSceneStaticResources();
    } catch (_) {
      if (token.isCurrent && !_isDisposed) {
        _runLog.performance.recordException();
        notifyListeners();
      }
      return;
    }
    if (!token.isCurrent || _isDisposed) {
      return;
    }
    late bool materialInitialized;
    final appResourceGeneration = _lifecycle.appResourceGeneration;
    try {
      materialInitialized = await _adapter.initializeCustomMaterial(
        appResourceGeneration: appResourceGeneration,
        token: token,
      );
    } catch (error) {
      if (token.isCurrent && !_isDisposed) {
        _runLog.recordCustomMaterialRuntimeFailure(
          controllerGeneration: _controllerGeneration,
          appResourceGeneration: appResourceGeneration,
          detail: 'Custom material load failed: $error',
        );
        _runLog.performance.recordException();
        notifyListeners();
      }
      return;
    }
    if (!token.isCurrent ||
        _isDisposed ||
        !materialInitialized ||
        _lifecycle.appResourceGeneration != appResourceGeneration ||
        _adapter.customMaterialAppResourceGeneration != appResourceGeneration) {
      return;
    }
    _runLog.recordCustomMaterialRuntimeSuccess(
      controllerGeneration: _controllerGeneration,
      appResourceGeneration: appResourceGeneration,
    );
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
    _materialOperationGeneration.cancel();
    _adapter.setForeground(isForeground: true);
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.foregrounded(),
    );
    _operatorAttestations.remove(SceneSpikeCapability.customMaterial);
    _completedChecklistCriteria.remove(SceneSpikeCapability.customMaterial);
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    _runLog.recordLifecycleResume();
    _runLog.record(
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
    _materialOperationGeneration.cancel();
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration + 1,
    );
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    _operatorAttestations.remove(SceneSpikeCapability.customMaterial);
    _completedChecklistCriteria.remove(SceneSpikeCapability.customMaterial);
    _runLog.record(
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
    _materialOperationGeneration.cancel();
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration + 1,
    );
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    _operatorAttestations.remove(SceneSpikeCapability.customMaterial);
    _completedChecklistCriteria.remove(SceneSpikeCapability.customMaterial);
    notifyListeners();
  }

  Future<void> completePendingAppResourceRebuild() async {
    if (_lifecycle.phase != .rebuilding || _isDisposed) {
      return;
    }
    final generation = _lifecycle.appResourceGeneration;
    final token = _materialOperationGeneration.begin();
    try {
      final rebuilt = await _adapter.rebuildApplicationResources(
        appResourceGeneration: generation,
        token: token,
      );
      if (!token.isCurrent ||
          _isDisposed ||
          !rebuilt ||
          _adapter.customMaterialAppResourceGeneration != generation) {
        return;
      }
      _lifecycle = _lifecycleReducer.reduce(
        state: _lifecycle,
        event: const SceneSpikeLifecycleEvent.rebuildCompleted(),
      );
      _runLog.recordCustomMaterialRuntimeSuccess(
        controllerGeneration: _controllerGeneration,
        appResourceGeneration: generation,
      );
      _runLog.performance.recordResourceRebuild();
    } catch (error) {
      if (!token.isCurrent || _isDisposed) {
        return;
      }
      _runLog.recordCustomMaterialRuntimeFailure(
        controllerGeneration: _controllerGeneration,
        appResourceGeneration: generation,
        detail: 'Custom material reload failed: $error',
      );
      _runLog.performance.recordException();
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void updatePartialMesh() {
    if (!_isUpdating || !_lifecycle.mayUpload) {
      return;
    }
    final vertexIndex = _runLog.partialUpdateCount % 6;
    final phase = _runLog.partialUpdateCount.isEven ? 1.0 : -1.0;
    final nextFrame = _frame.updateVertex(
      vertexIndex: vertexIndex,
      position: model_math.Vector3(
        _frame.positions[vertexIndex * 3] + 0.02 * phase,
        _frame.positions[vertexIndex * 3 + 1],
        0,
      ),
      color: model_math.Vector4(
        _runLog.partialUpdateCount.isEven ? 1 : 0.2,
        _runLog.partialUpdateCount.isEven ? 0.2 : 1,
        0.4,
        1,
      ),
    );
    try {
      _adapter.updateMesh(frame: nextFrame);
      _frame = nextFrame;
      _runLog.recordPartialUpdate();
    } catch (_) {
      _runLog.performance.recordException();
      _isUpdating = false;
    }
    notifyListeners();
  }

  void recordFrameTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      _runLog.timingCollector.add(
        buildDuration: timing.buildDuration,
        rasterDuration: timing.rasterDuration,
      );
      _runLog.performance.recordFrameTiming(
        buildDurationMicroseconds: timing.buildDuration.inMicroseconds,
        rasterDurationMicroseconds: timing.rasterDuration.inMicroseconds,
        wasDropped: timing.totalSpan > const Duration(microseconds: 16667),
      );
    }
    notifyListeners();
  }

  void recordTextPainterOverlay() {
    _runLog.record(
      const SceneSpikeRuntimeObservation(
        capability: .textPainterOverlay,
        status: .passed,
        detail: 'TextPainter overlay was composed above SceneView.',
      ),
    );
  }

  void recordConfirmedDisposeAndRemount() {
    if (_isDisposed || _lifecycle.phase != .active) {
      return;
    }
    _runLog.recordConfirmedDisposeAndRemount();
    notifyListeners();
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

  List<SceneSpikeOperatorCriterion> checklistCriteria(
    SceneSpikeCapability capability,
  ) => SceneSpikeOperatorChecklistContract.criteriaFor(capability);

  bool isChecklistCriterionCompleted({
    required SceneSpikeCapability capability,
    required String criterionId,
  }) => _completedChecklistCriteria[capability]?.contains(criterionId) ?? false;

  void setChecklistCriterion({
    required SceneSpikeCapability capability,
    required String criterionId,
    required bool isCompleted,
  }) {
    if (SceneSpikeEvidenceContract.requiredProvenance(capability) !=
        .operatorAttestation) {
      throw StateError('Capability does not have an operator checklist.');
    }
    if (_operatorAttestations.containsKey(capability)) {
      throw StateError('An attested checklist is immutable.');
    }
    final criteria = checklistCriteria(capability);
    if (!criteria.any((criterion) => criterion.id == criterionId)) {
      throw ArgumentError.value(criterionId, 'criterionId');
    }
    final completed = _completedChecklistCriteria.putIfAbsent(
      capability,
      () => <String>{},
    );
    if (isCompleted) {
      completed.add(criterionId);
    } else {
      completed.remove(criterionId);
    }
    notifyListeners();
  }

  bool canAttestCapability(SceneSpikeCapability capability) {
    if (_isDisposed ||
        SceneSpikeEvidenceContract.requiredProvenance(capability) !=
            .operatorAttestation) {
      return false;
    }
    final customMaterialFailure = _runLog.currentCustomMaterialRuntimeFailure(
      controllerGeneration: _controllerGeneration,
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    if ((capability == .customMaterial && customMaterialFailure != null) ||
        _runLog.observations[capability]?.status == .failed ||
        _operatorAttestations.containsKey(capability)) {
      return false;
    }
    final customMaterialProof = _runLog.customMaterialRuntimeSuccess;
    if (capability == .customMaterial &&
        (customMaterialProof == null ||
            customMaterialProof.controllerGeneration != _controllerGeneration ||
            customMaterialProof.appResourceGeneration !=
                _lifecycle.appResourceGeneration ||
            _adapter.customMaterialAppResourceGeneration !=
                _lifecycle.appResourceGeneration)) {
      return false;
    }
    final criteria = checklistCriteria(capability);
    final completed = _completedChecklistCriteria[capability] ?? const {};
    return criteria.isNotEmpty &&
        criteria.every((criterion) => completed.contains(criterion.id));
  }

  void attestCapability(SceneSpikeCapability capability) {
    if (SceneSpikeEvidenceContract.requiredProvenance(capability) !=
        .operatorAttestation) {
      throw StateError('Capability does not allow operator attestation.');
    }
    final runtimeObservation = _runLog.observations[capability];
    final customMaterialFailure = _runLog.currentCustomMaterialRuntimeFailure(
      controllerGeneration: _controllerGeneration,
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    if (runtimeObservation?.status == .failed ||
        (capability == .customMaterial && customMaterialFailure != null)) {
      throw StateError('A failed runtime observation cannot be attested.');
    }
    if (!canAttestCapability(capability)) {
      throw StateError('Every fixed checklist criterion must be completed.');
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
        observedAtUtc: _runLog.startedAtUtc,
      );
    }
    if (requiredProvenance == .runtimeSignal) {
      return _runLog.observations[capability] ??
          SceneSpikeCapabilityResult(
            capability: capability,
            status: .unobserved,
            provenance: .runtimeSignal,
            detail: 'Runtime event has not been observed.',
            observedAtUtc: _runLog.startedAtUtc,
          );
    }
    final customMaterialFailure = _runLog.currentCustomMaterialRuntimeFailure(
      controllerGeneration: _controllerGeneration,
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    if (capability == .customMaterial && customMaterialFailure != null) {
      return SceneSpikeCapabilityResult(
        capability: capability,
        status: .failed,
        provenance: .operatorAttestation,
        detail: customMaterialFailure.detail,
        observedAtUtc: customMaterialFailure.observedAtUtc,
      );
    }
    final runtimeFailure = _runLog.observations[capability];
    if (runtimeFailure?.status == .failed) {
      return SceneSpikeCapabilityResult(
        capability: capability,
        status: .failed,
        provenance: .operatorAttestation,
        detail: runtimeFailure?.detail ?? 'Runtime capability failed.',
        observedAtUtc: runtimeFailure?.observedAtUtc ?? _runLog.startedAtUtc,
      );
    }
    final operatorAttestation = _operatorAttestations[capability];
    if (capability == .customMaterial &&
        operatorAttestation != null &&
        _adapter.customMaterialAppResourceGeneration !=
            _lifecycle.appResourceGeneration) {
      return SceneSpikeCapabilityResult(
        capability: capability,
        status: .unobserved,
        provenance: .operatorAttestation,
        detail: 'Current adapter material generation is not authoritative.',
        observedAtUtc: _runLog.startedAtUtc,
      );
    }
    return operatorAttestation ??
        SceneSpikeCapabilityResult(
          capability: capability,
          status: .unobserved,
          provenance: .operatorAttestation,
          detail: 'Fixed operator checklist has not been completed.',
          observedAtUtc: _runLog.startedAtUtc,
        );
  }

  Future<String> canonicalEvidenceJson() async {
    final backend = _renderingBackend;
    if (backend == null) {
      throw StateError('Renderer backend attestation is required.');
    }
    final authoritativeCustomMaterialSuccess =
        _adapter.customMaterialAppResourceGeneration ==
            _lifecycle.appResourceGeneration
        ? _runLog.customMaterialRuntimeSuccess
        : null;
    final evidence =
        await SceneSpikeEvidenceCollector(
          runtimeSource: SceneSpikeProductionRuntimeIdentitySource(),
          manifestSource: const SceneSpikeEnvironmentBuildManifestSource(),
        ).collect(
          renderingBackend: backend,
          startedAtUtc: _runLog.startedAtUtc,
          elapsedMicroseconds: DateTime.now()
              .toUtc()
              .difference(_runLog.startedAtUtc)
              .inMicroseconds,
          frameCount: frameCount,
          partialUpdateCount: _runLog.partialUpdateCount,
          lifecycleResumeCount: _runLog.lifecycleResumeCount,
          disposeAndRemountCount: _runLog.disposeAndRemountCount,
          controllerGeneration: _controllerGeneration,
          appResourceGeneration: _lifecycle.appResourceGeneration,
          customMaterialRuntimeSuccess: authoritativeCustomMaterialSuccess,
          customMaterialRuntimeFailures: _runLog.customMaterialRuntimeFailures,
          capabilities: capabilityResults(),
          performance: _runLog.performance.snapshot(),
        );
    return jsonEncode(evidence.toJson());
  }

  void resetEvidence() {
    final startedAtUtc = DateTime.now().toUtc();
    _materialOperationGeneration.cancel();
    _renderingBackend = null;
    _runStartFailure = null;
    _operatorAttestations.clear();
    _completedChecklistCriteria.clear();
    _runLog.reset(startedAtUtc: startedAtUtc);
    _runLog
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
    if (_adapter.customMaterialAppResourceGeneration ==
        _lifecycle.appResourceGeneration) {
      _runLog.recordCustomMaterialRuntimeSuccess(
        controllerGeneration: _controllerGeneration,
        appResourceGeneration: _lifecycle.appResourceGeneration,
      );
    }
    _isUpdating = false;
    notifyListeners();
  }

  void detach() {
    if (_lifecycle.phase == .detached || _lifecycle.phase == .disposed) {
      return;
    }
    _materialOperationGeneration.cancel();
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
    _isDisposed = true;
    _materialOperationGeneration.dispose();
    _adapter.dispose();
    _lifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.disposed(),
    );
    super.dispose();
  }
}
