// Flutter Scene and adapter failures are counted by the manual smoke harness.
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/scene_spike_metrics.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/scene_spike_lifecycle.dart';
import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;
import 'package:vector_math/vector_math_64.dart' as model_math;

class FlutterSceneSpikeController extends ChangeNotifier {
  factory FlutterSceneSpikeController.create({SceneSpikeMetrics? metrics}) {
    final currentMetrics = metrics ?? SceneSpikeMetrics();
    final initialFrame = SpikeMeshFrame.initial();
    final adapter = FlutterSceneSpikeAdapter(initialFrame: initialFrame);
    const worldHalfHeight = 1.2;
    // The camera stands off the drawn plane, so the depth range has to reach
    // past that standoff or every quad is clipped before rasterization.
    const cameraStandoff = 2.0;
    final projection = EqmonitorOrthographicProjection(
      worldHalfHeight: worldHalfHeight,
      depthHalfExtent: cameraStandoff + worldHalfHeight,
    );
    final cameraNode = scene.Node(
      localTransform: scene_math.Matrix4.translationValues(
        0,
        0,
        -cameraStandoff,
      ),
    );
    return FlutterSceneSpikeController.withDependencies(
      adapter: adapter,
      metrics: currentMetrics,
      projection: projection,
      camera: scene.NodeCamera(
        cameraNode,
        FlutterSceneOrthographicProjection(projection: projection),
      ),
      initialFrame: initialFrame,
      initializeSceneStaticResources: scene.Scene.initializeStaticResources,
    );
  }

  FlutterSceneSpikeController.withDependencies({
    required SceneSpikeControllerAdapter adapter,
    required SceneSpikeMetrics metrics,
    required EqmonitorOrthographicProjection projection,
    required SpikeMeshFrame initialFrame,
    required Future<void> Function() initializeSceneStaticResources,
    scene.NodeCamera? camera,
  }) : _adapter = adapter,
       _metrics = metrics,
       _projection = projection,
       _camera = camera,
       _frame = initialFrame,
       _initializeSceneStaticResources = initializeSceneStaticResources;

  final SceneSpikeControllerAdapter _adapter;
  final SceneSpikeMetrics _metrics;
  final EqmonitorOrthographicProjection _projection;
  final Future<void> Function() _initializeSceneStaticResources;
  final scene.NodeCamera? _camera;
  final _lifecycleReducer = const SceneSpikeLifecycleReducer();
  final _materialOperationGeneration = SceneSpikeAsyncGenerationOwner();
  SpikeMeshFrame _frame;
  var _lifecycle = SceneSpikeLifecycleState.initial();
  Size? _logicalSize;
  double? _devicePixelRatio;
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

  int get frameCount => _metrics.frameCount;

  int get partialUpdateCount => _metrics.partialUpdateCount;

  int get lifecycleResumeCount => _metrics.lifecycleResumeCount;

  int get disposeAndRemountCount => _metrics.disposeAndRemountCount;

  int get resourceRebuildCount => _metrics.resourceRebuildCount;

  int get exceptionCount => _metrics.exceptionCount;

  model_math.Matrix4 projectionMatrixFor(Size logicalSize) => _projection
      .matrixFor(aspectRatio: logicalSize.width / logicalSize.height);

  Future<void> initializeStaticResources() async {
    if (_isDisposed) {
      return;
    }
    final token = _materialOperationGeneration.begin();
    try {
      await _initializeSceneStaticResources();
      if (!token.isCurrent || _isDisposed) {
        return;
      }
      final appResourceGeneration = _lifecycle.appResourceGeneration;
      final initialized = await _adapter.initializeCustomMaterial(
        appResourceGeneration: appResourceGeneration,
        token: token,
      );
      if (!token.isCurrent ||
          _isDisposed ||
          !initialized ||
          _lifecycle.appResourceGeneration != appResourceGeneration ||
          _adapter.customMaterialAppResourceGeneration !=
              appResourceGeneration) {
        return;
      }
    } catch (_) {
      if (token.isCurrent && !_isDisposed) {
        _metrics.recordException();
        notifyListeners();
      }
      return;
    }
    notifyListeners();
  }

  void attach({required Size logicalSize, required double devicePixelRatio}) {
    if (_lifecycle.phase != .detached) {
      return;
    }
    final attachedLifecycle = _lifecycleReducer.reduce(
      state: _lifecycle,
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    _adapter.attach(
      logicalSize: logicalSize,
      devicePixelRatio: devicePixelRatio,
    );
    if (attachedLifecycle.requiresResourceRebuild) {
      _adapter.requestAppResourceRebuild(
        appResourceGeneration: attachedLifecycle.appResourceGeneration,
      );
    }
    _lifecycle = attachedLifecycle;
    _logicalSize = logicalSize;
    _devicePixelRatio = devicePixelRatio;
    notifyListeners();
  }

  void background() {
    if (_lifecycle.phase != .active &&
        _lifecycle.phase != .background &&
        _lifecycle.phase != .rebuilding) {
      return;
    }
    _materialOperationGeneration.cancel();
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
    _adapter.requestAppResourceRebuild(
      appResourceGeneration: _lifecycle.appResourceGeneration,
    );
    _metrics.recordLifecycleResume();
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
          _lifecycle.phase != .rebuilding ||
          !_lifecycle.requiresResourceRebuild ||
          _lifecycle.appResourceGeneration != generation ||
          _adapter.customMaterialAppResourceGeneration != generation) {
        return;
      }
      _lifecycle = _lifecycleReducer.reduce(
        state: _lifecycle,
        event: const SceneSpikeLifecycleEvent.rebuildCompleted(),
      );
      _metrics.recordResourceRebuild();
    } catch (_) {
      if (!token.isCurrent || _isDisposed) {
        return;
      }
      _metrics.recordException();
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void updatePartialMesh() {
    if (!_isUpdating || !_lifecycle.mayUpload) {
      return;
    }
    final vertexIndex = _metrics.partialUpdateCount % 6;
    final phase = _metrics.partialUpdateCount.isEven ? 1.0 : -1.0;
    final nextFrame = _frame.updateVertex(
      vertexIndex: vertexIndex,
      position: model_math.Vector3(
        _frame.positions[vertexIndex * 3] + 0.02 * phase,
        _frame.positions[vertexIndex * 3 + 1],
        0,
      ),
      color: model_math.Vector4(
        _metrics.partialUpdateCount.isEven ? 1 : 0.2,
        _metrics.partialUpdateCount.isEven ? 0.2 : 1,
        0.4,
        1,
      ),
    );
    try {
      _adapter.updateMesh(frame: nextFrame);
      _frame = nextFrame;
      _metrics.recordPartialUpdate();
    } catch (_) {
      _metrics.recordException();
      _isUpdating = false;
    }
    notifyListeners();
  }

  void recordFrameTimings(List<FrameTiming> timings) {
    for (var index = 0; index < timings.length; index += 1) {
      _metrics.recordFrame();
    }
    notifyListeners();
  }

  void recordConfirmedDisposeAndRemount() {
    if (_isDisposed || _lifecycle.phase != .active) {
      return;
    }
    _metrics.recordDisposeAndRemount();
    notifyListeners();
  }

  void startUpdates() {
    if (_lifecycle.phase != .active || !_lifecycle.mayUpload) {
      _isUpdating = false;
      notifyListeners();
      return;
    }
    _isUpdating = true;
    notifyListeners();
  }

  void stopUpdates() {
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
    _isUpdating = false;
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
