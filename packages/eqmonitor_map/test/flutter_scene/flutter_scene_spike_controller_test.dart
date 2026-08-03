import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_controller.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_remount_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/scene_spike_metrics.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/scene_spike_lifecycle.dart';
import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('metrics records only the six manual smoke counters', () {
    final metrics = SceneSpikeMetrics()
      ..recordFrame()
      ..recordPartialUpdate()
      ..recordLifecycleResume()
      ..recordDisposeAndRemount()
      ..recordResourceRebuild()
      ..recordException();

    expect(metrics.frameCount, 1);
    expect(metrics.partialUpdateCount, 1);
    expect(metrics.lifecycleResumeCount, 1);
    expect(metrics.disposeAndRemountCount, 1);
    expect(metrics.resourceRebuildCount, 1);
    expect(metrics.exceptionCount, 1);
  });

  group('SceneSpikeMeshUpdateValidator', () {
    test('rejects updates while uploading is unavailable', () {
      final frame = SpikeMeshFrame.initial().moveVertex(
        vertexIndex: 0,
        position: Vector3(-0.4, -0.5, 0),
      );

      expect(
        () => SceneSpikeMeshUpdateValidator.validate(
          frame: frame,
          expectedVertexCount: 6,
          mayUpload: false,
        ),
        throwsA(isA<SceneSpikeMeshUpdateException>()),
      );
    });

    test('rejects updates that change the fixed vertex count', () {
      final frame = SpikeMeshFrame.initial().moveVertex(
        vertexIndex: 0,
        position: Vector3(-0.4, -0.5, 0),
      );

      expect(
        () => SceneSpikeMeshUpdateValidator.validate(
          frame: frame,
          expectedVertexCount: 5,
          mayUpload: true,
        ),
        throwsA(isA<SceneSpikeMeshUpdateException>()),
      );
    });
  });

  group('FlutterSceneSpikeController async lifecycle', () {
    test(
      'older initialization cannot overwrite a newer resource rebuild',
      () async {
        final initializationResult = Completer<bool>();
        final adapter = FakeSceneSpikeControllerAdapter(
          initializeCompletion: initializationResult.future,
        );
        final controller = createController(adapter: adapter)
          ..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          );
        addTearDown(controller.dispose);

        final initialization = controller.initializeStaticResources();
        await Future<void>.delayed(Duration.zero);
        expect(adapter.initializeCustomMaterialCount, 1);

        controller.requestAppResourceRebuild();
        await controller.completePendingAppResourceRebuild();
        expect(adapter.customMaterialAppResourceGeneration, 1);

        initializationResult.complete(true);
        await initialization;

        expect(adapter.customMaterialAppResourceGeneration, 1);
        expect(controller.lifecycle.appResourceGeneration, 1);
        expect(controller.resourceRebuildCount, 1);
      },
    );

    test(
      'dispose during initialization prevents post-await mutation',
      () async {
        final staticResources = Completer<void>();
        final adapter = FakeSceneSpikeControllerAdapter();
        final controller = createController(
          adapter: adapter,
          initializeSceneStaticResources: () => staticResources.future,
        );
        var notificationCount = 0;
        controller.addListener(() => notificationCount += 1);

        final initialization = controller.initializeStaticResources();
        controller.dispose();
        staticResources.complete();
        await initialization;

        expect(adapter.initializeCustomMaterialCount, 0);
        expect(controller.exceptionCount, 0);
        expect(notificationCount, 0);
      },
    );

    test('detach during initialization cancels mounted generation', () async {
      final staticResources = Completer<void>();
      final adapter = FakeSceneSpikeControllerAdapter();
      final controller =
          createController(
            adapter: adapter,
            initializeSceneStaticResources: () => staticResources.future,
          )..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          );
      addTearDown(controller.dispose);

      final initialization = controller.initializeStaticResources();
      controller.detach();
      staticResources.complete();
      await initialization;

      expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.detached);
      expect(adapter.initializeCustomMaterialCount, 0);
      expect(controller.exceptionCount, 0);
    });

    test(
      'static resource and material failures increment exceptions',
      () async {
        final staticFailureController = createController(
          adapter: FakeSceneSpikeControllerAdapter(),
          initializeSceneStaticResources: () => Future<void>.error(
            StateError('static resources failed'),
          ),
        );
        addTearDown(staticFailureController.dispose);

        await staticFailureController.initializeStaticResources();
        expect(staticFailureController.exceptionCount, 1);

        final materialFailure = Completer<bool>();
        final materialFailureController = createController(
          adapter: FakeSceneSpikeControllerAdapter(
            initializeCompletion: materialFailure.future,
          ),
        );
        addTearDown(materialFailureController.dispose);

        final initialization = materialFailureController
            .initializeStaticResources();
        await Future<void>.delayed(Duration.zero);
        materialFailure.completeError(StateError('material failed'));
        await initialization;
        expect(materialFailureController.exceptionCount, 1);
      },
    );

    test(
      'dispose during rebuild prevents reducer and counter updates',
      () async {
        final rebuild = Completer<void>();
        final adapter = FakeSceneSpikeControllerAdapter(
          rebuildCompletion: rebuild.future,
        );
        final controller = createController(adapter: adapter)
          ..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          )
          ..requestAppResourceRebuild();
        var notificationCount = 0;
        controller.addListener(() => notificationCount += 1);

        final completion = controller.completePendingAppResourceRebuild();
        controller.dispose();
        rebuild.complete();
        await completion;

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.disposed);
        expect(controller.resourceRebuildCount, 0);
        expect(notificationCount, 0);
      },
    );

    test(
      'background during rebuild rejects stale completion until resumed',
      () async {
        final rebuild = Completer<void>();
        final adapter = FakeSceneSpikeControllerAdapter(
          rebuildCompletion: rebuild.future,
        );
        final controller = createController(adapter: adapter)
          ..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          )
          ..requestAppResourceRebuild();
        addTearDown(controller.dispose);

        final completion = controller.completePendingAppResourceRebuild();
        controller.background();

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.background);
        expect(controller.lifecycle.requiresResourceRebuild, isTrue);
        expect(controller.lifecycle.mayUpload, isFalse);
        expect(adapter.isForeground, isFalse);

        rebuild.complete();
        await completion;

        expect(controller.resourceRebuildCount, 0);
        expect(adapter.customMaterialAppResourceGeneration, isNull);

        controller.foreground();
        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.rebuilding);
        expect(controller.lifecycleResumeCount, 1);
        expect(adapter.requestedAppResourceGenerations, [1, 1]);

        await controller.completePendingAppResourceRebuild();

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.active);
        expect(controller.resourceRebuildCount, 1);
        expect(adapter.customMaterialAppResourceGeneration, 1);
      },
    );

    test(
      'detach and reattach during rebuild preserves rebuild obligation',
      () async {
        final rebuild = Completer<void>();
        final adapter = FakeSceneSpikeControllerAdapter(
          rebuildCompletion: rebuild.future,
        );
        final controller = createController(adapter: adapter)
          ..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          )
          ..requestAppResourceRebuild();
        addTearDown(controller.dispose);

        final staleCompletion = controller.completePendingAppResourceRebuild();
        controller
          ..detach()
          ..attach(
            logicalSize: const Size(400, 300),
            devicePixelRatio: 2,
          );

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.rebuilding);
        expect(controller.lifecycle.requiresResourceRebuild, isTrue);
        expect(controller.lifecycle.mayUpload, isFalse);
        expect(adapter.customMaterialAppResourceGeneration, isNull);
        expect(adapter.requestedAppResourceGenerations, [1, 1]);

        final resumedCompletion = controller
            .completePendingAppResourceRebuild();
        rebuild.complete();
        await Future.wait([staleCompletion, resumedCompletion]);

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.active);
        expect(controller.lifecycle.requiresResourceRebuild, isFalse);
        expect(controller.resourceRebuildCount, 1);
        expect(adapter.customMaterialAppResourceGeneration, 1);
      },
    );

    test(
      'rebuild failure records exception and keeps rebuild pending',
      () async {
        final controller =
            createController(
                adapter: FakeSceneSpikeControllerAdapter(
                  rebuildCompletion: Future<void>.error(
                    StateError('rebuild failed'),
                  ),
                ),
              )
              ..attach(
                logicalSize: const Size(400, 300),
                devicePixelRatio: 2,
              )
              ..requestAppResourceRebuild();
        addTearDown(controller.dispose);

        await controller.completePendingAppResourceRebuild();

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.rebuilding);
        expect(controller.resourceRebuildCount, 0);
        expect(controller.exceptionCount, 1);
      },
    );
  });

  group('FlutterSceneSpikeController updates', () {
    test('start and stop require an active uploadable lifecycle', () {
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
      );
      addTearDown(controller.dispose);

      controller.startUpdates();
      expect(controller.isUpdating, isFalse);

      controller.attach(
        logicalSize: const Size(400, 300),
        devicePixelRatio: 2,
      );
      controller.startUpdates();
      expect(controller.isUpdating, isTrue);

      controller.stopUpdates();
      expect(controller.isUpdating, isFalse);

      controller.requestAppResourceRebuild();
      controller.startUpdates();
      expect(controller.isUpdating, isFalse);
    });

    test('successful partial update increments counter', () {
      final adapter = FakeSceneSpikeControllerAdapter();
      final controller = createController(adapter: adapter)
        ..attach(
          logicalSize: const Size(400, 300),
          devicePixelRatio: 2,
        )
        ..startUpdates()
        ..updatePartialMesh();
      addTearDown(controller.dispose);

      expect(adapter.updateMeshCount, 1);
      expect(controller.partialUpdateCount, 1);
      expect(controller.exceptionCount, 0);
      expect(controller.isUpdating, isTrue);
    });

    test('partial update exception increments counter and stops updates', () {
      final controller =
          createController(
              adapter: FakeSceneSpikeControllerAdapter(
                updateMeshError: StateError('upload failed'),
              ),
            )
            ..attach(
              logicalSize: const Size(400, 300),
              devicePixelRatio: 2,
            )
            ..startUpdates()
            ..updatePartialMesh();
      addTearDown(controller.dispose);

      expect(controller.partialUpdateCount, 0);
      expect(controller.exceptionCount, 1);
      expect(controller.isUpdating, isFalse);
    });

    test('frame callback records every delivered frame timing', () {
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
      );
      addTearDown(controller.dispose);

      controller.recordFrameTimings([
        createFrameTiming(vsyncStart: 0),
        createFrameTiming(vsyncStart: 100000),
      ]);

      expect(controller.frameCount, 2);
    });
  });

  test('remount owner shares counters with replacement controller', () {
    final seenMetrics = <SceneSpikeMetrics>[];
    final owner = FlutterSceneSpikeRemountOwner.withDependencies(
      controllerFactory: (metrics) {
        seenMetrics.add(metrics);
        return createController(
          adapter: FakeSceneSpikeControllerAdapter(),
          metrics: metrics,
        );
      },
    );
    addTearDown(owner.dispose);
    final previous = owner.controller
      ..attach(
        logicalSize: const Size(400, 300),
        devicePixelRatio: 2,
      )
      ..background()
      ..foreground();

    owner.requestRemount();
    final replacement = owner.controller;

    expect(previous.lifecycle.phase, SceneSpikeLifecyclePhase.disposed);
    expect(replacement, isNot(same(previous)));
    expect(seenMetrics, hasLength(2));
    expect(seenMetrics.last, same(seenMetrics.first));
    expect(replacement.lifecycleResumeCount, 1);
    expect(replacement.disposeAndRemountCount, 0);

    owner.confirmMounted(controller: replacement);
    expect(replacement.disposeAndRemountCount, 0);

    replacement.attach(
      logicalSize: const Size(400, 300),
      devicePixelRatio: 2,
    );
    owner.confirmMounted(controller: replacement);

    expect(replacement.lifecycleResumeCount, 1);
    expect(replacement.disposeAndRemountCount, 1);
  });
}

FrameTiming createFrameTiming({required int vsyncStart}) => FrameTiming(
  vsyncStart: vsyncStart,
  buildStart: vsyncStart + 1000,
  buildFinish: vsyncStart + 2000,
  rasterStart: vsyncStart + 2500,
  rasterFinish: vsyncStart + 3500,
  rasterFinishWallTime: vsyncStart + 3500,
);

FlutterSceneSpikeController createController({
  required FakeSceneSpikeControllerAdapter adapter,
  SceneSpikeMetrics? metrics,
  Future<void> Function()? initializeSceneStaticResources,
}) => FlutterSceneSpikeController.withDependencies(
  adapter: adapter,
  metrics: metrics ?? SceneSpikeMetrics(),
  projection: EqmonitorOrthographicProjection(
    worldHalfHeight: 1.2,
    depthHalfExtent: 3.2,
  ),
  initialFrame: SpikeMeshFrame.initial(),
  initializeSceneStaticResources: initializeSceneStaticResources ?? () async {},
);

class FakeSceneSpikeControllerAdapter implements SceneSpikeControllerAdapter {
  FakeSceneSpikeControllerAdapter({
    Future<void>? rebuildCompletion,
    Future<bool>? initializeCompletion,
    this.updateMeshError,
  }) : _rebuildCompletion = rebuildCompletion ?? Future<void>.value(),
       _initializeCompletion = initializeCompletion ?? Future.value(true);

  final Future<void> _rebuildCompletion;
  final Future<bool> _initializeCompletion;
  final Error? updateMeshError;
  final List<int> requestedAppResourceGenerations = [];
  var _initializeCustomMaterialCount = 0;
  var _updateMeshCount = 0;
  var _isForeground = false;

  bool get isForeground => _isForeground;

  @override
  int? customMaterialAppResourceGeneration;

  int get initializeCustomMaterialCount => _initializeCustomMaterialCount;

  int get updateMeshCount => _updateMeshCount;

  @override
  scene.Scene? get sceneGraph => null;

  @override
  void attach({required Size logicalSize, required double devicePixelRatio}) {
    _isForeground = true;
  }

  @override
  void completeAppResourceRebuild({required int appResourceGeneration}) {}

  @override
  void detach() {
    _isForeground = false;
  }

  @override
  void dispose() {}

  @override
  Future<bool> initializeCustomMaterial({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    if (!token.isCurrent) {
      return false;
    }
    _initializeCustomMaterialCount += 1;
    final initialized = await _initializeCompletion;
    if (!token.isCurrent || !initialized) {
      return false;
    }
    customMaterialAppResourceGeneration = appResourceGeneration;
    return true;
  }

  @override
  Future<bool> rebuildApplicationResources({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    await _rebuildCompletion;
    if (!token.isCurrent) {
      return false;
    }
    customMaterialAppResourceGeneration = appResourceGeneration;
    return true;
  }

  @override
  void requestAppResourceRebuild({required int appResourceGeneration}) {
    requestedAppResourceGenerations.add(appResourceGeneration);
  }

  @override
  void setForeground({required bool isForeground}) {
    _isForeground = isForeground;
  }

  @override
  void updateMesh({required SpikeMeshFrame frame}) {
    final error = updateMeshError;
    if (error != null) {
      throw error;
    }
    _updateMeshCount += 1;
  }
}
