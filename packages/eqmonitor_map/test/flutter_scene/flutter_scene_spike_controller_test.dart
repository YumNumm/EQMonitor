import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_controller.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_remount_owner.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_evidence_collector.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/scene_spike_lifecycle.dart';
import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_test/flutter_test.dart';

void main() {
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
        completeChecklist(
          controller: controller,
          capability: SceneSpikeCapability.customMaterial,
        );

        expect(adapter.customMaterialAppResourceGeneration, 1);
        expect(controller.lifecycle.appResourceGeneration, 1);
        expect(controller.canAttestCapability(.customMaterial), isTrue);
      },
    );

    test(
      'dispose during initialization prevents post-await mutation',
      () async {
        final deviceModel = Completer<String>();
        final adapter = FakeSceneSpikeControllerAdapter();
        final controller = createController(
          adapter: adapter,
          runtimeSource: FakeRuntimeIdentitySource(
            deviceModel: deviceModel.future,
          ),
        );
        var notificationCount = 0;
        controller.addListener(() => notificationCount += 1);

        final initialization = controller.initializeStaticResources();
        controller.dispose();
        deviceModel.complete('Pixel Test');
        await initialization;

        expect(adapter.initializeCustomMaterialCount, 0);
        expect(controller.runtimeIdentity, isNull);
        expect(notificationCount, 0);
      },
    );

    test(
      'detach during initialization cancels the mounted generation',
      () async {
        final deviceModel = Completer<String>();
        final adapter = FakeSceneSpikeControllerAdapter();
        final controller =
            createController(
              adapter: adapter,
              runtimeSource: FakeRuntimeIdentitySource(
                deviceModel: deviceModel.future,
              ),
            )..attach(
              logicalSize: const Size(400, 300),
              devicePixelRatio: 2,
            );
        addTearDown(controller.dispose);

        final initialization = controller.initializeStaticResources();
        controller.detach();
        deviceModel.complete('Pixel Test');
        await initialization;

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.detached);
        expect(adapter.initializeCustomMaterialCount, 0);
        expect(controller.runtimeIdentity, isNull);
      },
    );

    test(
      'dispose during rebuild prevents reducer and listener updates',
      () async {
        final rebuild = Completer<void>();
        final adapter = FakeSceneSpikeControllerAdapter(
          rebuildCompletion: rebuild.future,
        );
        final controller = createController(adapter: adapter);
        controller
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
        expect(controller.performance.resourceRebuildCount, 0);
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
        expect(controller.lifecycle.mayTick, isFalse);
        expect(controller.lifecycle.mayUpload, isFalse);
        expect(adapter.isForeground, isFalse);

        rebuild.complete();
        await completion;

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.background);
        expect(controller.performance.resourceRebuildCount, 0);
        expect(adapter.customMaterialAppResourceGeneration, isNull);

        controller.foreground();
        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.rebuilding);
        expect(controller.lifecycle.appResourceGeneration, 1);
        expect(adapter.requestedAppResourceGenerations, [1, 1]);

        await controller.completePendingAppResourceRebuild();

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.active);
        expect(controller.performance.resourceRebuildCount, 1);
        expect(adapter.customMaterialAppResourceGeneration, 1);
      },
    );

    test(
      'detach and reattach during rebuild preserves the rebuild obligation',
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
        expect(controller.lifecycle.mayTick, isFalse);
        expect(controller.lifecycle.mayUpload, isFalse);
        expect(adapter.customMaterialAppResourceGeneration, isNull);
        expect(adapter.requestedAppResourceGenerations, [1, 1]);
        completeChecklist(
          controller: controller,
          capability: SceneSpikeCapability.customMaterial,
        );
        expect(controller.canAttestCapability(.customMaterial), isFalse);

        final resumedCompletion = controller
            .completePendingAppResourceRebuild();
        rebuild.complete();
        await Future.wait([staleCompletion, resumedCompletion]);

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.active);
        expect(controller.lifecycle.requiresResourceRebuild, isFalse);
        expect(controller.performance.resourceRebuildCount, 1);
        expect(adapter.customMaterialAppResourceGeneration, 1);
        expect(controller.canAttestCapability(.customMaterial), isTrue);
      },
    );
  });

  group('FlutterSceneSpikeController terminal failures', () {
    test('reset preserves a custom material runtime failure', () {
      final runLog = SceneSpikeRunLog(startedAtUtc: DateTime.utc(2026, 8, 2));
      final controllerGeneration = runLog.beginControllerGeneration();
      runLog.recordCustomMaterialRuntimeFailure(
        controllerGeneration: controllerGeneration,
        appResourceGeneration: 0,
        detail: 'Shader compilation failed.',
      );
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
        runLog: runLog,
        controllerGeneration: controllerGeneration,
      );

      controller.resetEvidence();

      final result = controller.capabilityResult(
        SceneSpikeCapability.customMaterial,
      );
      expect(result.status, SceneSpikeCapabilityStatus.failed);
      expect(result.detail, 'Shader compilation failed.');
      expect(
        () => controller.attestCapability(SceneSpikeCapability.customMaterial),
        throwsStateError,
      );
      controller.dispose();
    });

    test(
      'new generation reload supersedes failure without erasing history',
      () async {
        final initializationResult = Completer<bool>();
        final runLog = SceneSpikeRunLog(
          startedAtUtc: DateTime.now().toUtc(),
        );
        final controller =
            createController(
              adapter: FakeSceneSpikeControllerAdapter(
                initializeCompletion: initializationResult.future,
              ),
              runLog: runLog,
            )..attach(
              logicalSize: const Size(400, 300),
              devicePixelRatio: 2,
            );
        addTearDown(controller.dispose);
        final initialization = controller.initializeStaticResources();
        await Future<void>.delayed(Duration.zero);
        initializationResult.completeError(StateError('compile failed'));
        await initialization;
        expect(
          controller.capabilityResult(.customMaterial).status,
          SceneSpikeCapabilityStatus.failed,
        );

        controller.requestAppResourceRebuild();
        await controller.completePendingAppResourceRebuild();
        completeChecklist(
          controller: controller,
          capability: SceneSpikeCapability.customMaterial,
        );

        expect(runLog.customMaterialRuntimeFailures, hasLength(1));
        expect(controller.performance.exceptionCount, 1);
        expect(controller.canAttestCapability(.customMaterial), isTrue);
        controller.attestCapability(.customMaterial);
        expect(
          controller.capabilityResult(.customMaterial).status,
          SceneSpikeCapabilityStatus.passed,
        );
      },
    );

    test('unsubstantiated and stale success proofs cannot recover failure', () {
      final runLog = SceneSpikeRunLog(
        startedAtUtc: DateTime.now().toUtc(),
      );
      final controllerGeneration = runLog.beginControllerGeneration();
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
        runLog: runLog,
        controllerGeneration: controllerGeneration,
      );
      addTearDown(controller.dispose);
      runLog
        ..recordCustomMaterialRuntimeFailure(
          controllerGeneration: controllerGeneration,
          appResourceGeneration: 0,
          detail: 'compile failed',
        )
        ..recordCustomMaterialRuntimeSuccess(
          controllerGeneration: controllerGeneration,
          appResourceGeneration: 0,
        );
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(controller.canAttestCapability(.customMaterial), isFalse);

      runLog.reset(startedAtUtc: DateTime.now().toUtc());
      final replacement = createController(
        adapter: FakeSceneSpikeControllerAdapter()
          ..customMaterialAppResourceGeneration = 0,
        runLog: runLog,
      );
      addTearDown(replacement.dispose);
      runLog.recordCustomMaterialRuntimeSuccess(
        controllerGeneration: controllerGeneration,
        appResourceGeneration: 0,
      );
      expect(runLog.customMaterialRuntimeSuccess, isNull);
      completeChecklist(
        controller: replacement,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(replacement.canAttestCapability(.customMaterial), isFalse);
    });
  });

  group('FlutterSceneSpikeRemountOwner', () {
    test(
      'records remount only after confirmed dispose and new active mount',
      () {
        final owner = FlutterSceneSpikeRemountOwner.withDependencies(
          controllerFactory: (runLog) => createController(
            adapter: FakeSceneSpikeControllerAdapter(),
            runLog: runLog,
          ),
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
        expect(
          replacement
              .capabilityResult(SceneSpikeCapability.disposeAndRemount)
              .status,
          SceneSpikeCapabilityStatus.unobserved,
        );
        owner.confirmMounted(controller: replacement);
        expect(
          replacement
              .capabilityResult(SceneSpikeCapability.disposeAndRemount)
              .status,
          SceneSpikeCapabilityStatus.unobserved,
        );

        replacement.attach(
          logicalSize: const Size(400, 300),
          devicePixelRatio: 2,
        );
        owner.confirmMounted(controller: replacement);

        expect(
          replacement
              .capabilityResult(SceneSpikeCapability.disposeAndRemount)
              .status,
          SceneSpikeCapabilityStatus.passed,
        );
        expect(
          replacement
              .capabilityResult(SceneSpikeCapability.backgroundAndForeground)
              .status,
          SceneSpikeCapabilityStatus.passed,
        );
        expect(replacement.lifecycleResumeCount, 1);
        for (final capability
            in SceneSpikeEvidenceContract.unavailablePublicApiCapabilities) {
          expect(
            replacement.capabilityResult(capability).status,
            SceneSpikeCapabilityStatus.unobserved,
          );
        }
      },
    );

    test('replacement cannot attest an old controller material load', () async {
      final adapters = <FakeSceneSpikeControllerAdapter>[];
      final owner = FlutterSceneSpikeRemountOwner.withDependencies(
        controllerFactory: (runLog) {
          final adapter = FakeSceneSpikeControllerAdapter();
          adapters.add(adapter);
          return createController(adapter: adapter, runLog: runLog);
        },
      );
      addTearDown(owner.dispose);
      final previous = owner.controller;
      await previous.initializeStaticResources();
      completeChecklist(
        controller: previous,
        capability: SceneSpikeCapability.customMaterial,
      );
      expect(previous.canAttestCapability(.customMaterial), isTrue);

      owner.requestRemount();
      final replacement = owner.controller
        ..attach(
          logicalSize: const Size(400, 300),
          devicePixelRatio: 2,
        );
      owner.confirmMounted(controller: replacement);
      completeChecklist(
        controller: replacement,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(adapters, hasLength(2));
      expect(adapters.last.initializeCustomMaterialCount, 0);
      expect(replacement.canAttestCapability(.customMaterial), isFalse);
      expect(
        () => replacement.attestCapability(.customMaterial),
        throwsStateError,
      );
    });
  });

  group('FlutterSceneSpikeController operator checklist', () {
    test('requires every fixed criterion before attestation', () {
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
      );
      addTearDown(controller.dispose);
      const capability = SceneSpikeCapability.proceduralOrthographicMesh;
      final criteria = controller.checklistCriteria(capability);

      expect(criteria, isNotEmpty);
      expect(() => criteria.add(criteria.first), throwsUnsupportedError);
      expect(() => controller.attestCapability(capability), throwsStateError);

      for (final criterion in criteria.take(criteria.length - 1)) {
        controller.setChecklistCriterion(
          capability: capability,
          criterionId: criterion.id,
          isCompleted: true,
        );
      }
      expect(controller.canAttestCapability(capability), isFalse);
      expect(() => controller.attestCapability(capability), throwsStateError);

      controller.setChecklistCriterion(
        capability: capability,
        criterionId: criteria.last.id,
        isCompleted: true,
      );
      expect(controller.canAttestCapability(capability), isTrue);
      controller.attestCapability(capability);
      expect(
        controller.capabilityResult(capability).status,
        SceneSpikeCapabilityStatus.passed,
      );
    });

    test('runtime and unavailable capabilities expose no checklist', () {
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
      );
      addTearDown(controller.dispose);

      expect(
        controller.checklistCriteria(
          SceneSpikeCapability.partialPositionAndColorUpdate,
        ),
        isEmpty,
      );
      expect(
        controller.checklistCriteria(
          SceneSpikeCapability.explicitResourceDisposal,
        ),
        isEmpty,
      );
    });

    test('custom material requires current controller load success', () async {
      final completion = Completer<bool>();
      final adapter = FakeSceneSpikeControllerAdapter(
        initializeCompletion: completion.future,
      );
      final controller = createController(adapter: adapter);
      addTearDown(controller.dispose);
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(controller.canAttestCapability(.customMaterial), isFalse);
      final initialization = controller.initializeStaticResources();
      await Future<void>.delayed(Duration.zero);
      expect(controller.canAttestCapability(.customMaterial), isFalse);

      completion.complete(true);
      await initialization;

      expect(controller.canAttestCapability(.customMaterial), isTrue);
      controller.attestCapability(.customMaterial);
      expect(
        controller.capabilityResult(.customMaterial).status,
        SceneSpikeCapabilityStatus.passed,
      );
    });

    test('failed custom material load cannot be attested', () async {
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(
          initializeCompletion: Future.value(false),
        ),
      );
      addTearDown(controller.dispose);
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );

      await controller.initializeStaticResources();

      expect(controller.canAttestCapability(.customMaterial), isFalse);
      expect(
        () => controller.attestCapability(.customMaterial),
        throwsStateError,
      );
    });

    test('resource generation change requires a successful reload', () async {
      final rebuild = Completer<void>();
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(
          rebuildCompletion: rebuild.future,
        ),
      );
      addTearDown(controller.dispose);
      await controller.initializeStaticResources();
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );
      expect(controller.canAttestCapability(.customMaterial), isTrue);
      controller.attestCapability(.customMaterial);

      controller
        ..attach(
          logicalSize: const Size(400, 300),
          devicePixelRatio: 2,
        )
        ..requestAppResourceRebuild();
      final completion = controller.completePendingAppResourceRebuild();
      expect(
        controller.capabilityResult(.customMaterial).status,
        SceneSpikeCapabilityStatus.unobserved,
      );
      expect(controller.canAttestCapability(.customMaterial), isFalse);

      rebuild.complete();
      await completion;

      expect(controller.lifecycle.appResourceGeneration, 1);
      expect(controller.canAttestCapability(.customMaterial), isFalse);
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );
      expect(controller.canAttestCapability(.customMaterial), isTrue);
    });

    test('reset clears proof unless loaded state is authoritative', () async {
      final adapter = FakeSceneSpikeControllerAdapter();
      final controller = createController(adapter: adapter);
      addTearDown(controller.dispose);
      await controller.initializeStaticResources();
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );
      expect(controller.canAttestCapability(.customMaterial), isTrue);

      adapter.customMaterialAppResourceGeneration = null;
      controller.resetEvidence();
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(controller.canAttestCapability(.customMaterial), isFalse);
    });

    test('reset may reobserve authoritative loaded adapter state', () async {
      final adapter = FakeSceneSpikeControllerAdapter();
      final controller = createController(adapter: adapter);
      addTearDown(controller.dispose);
      await controller.initializeStaticResources();

      controller.resetEvidence();
      completeChecklist(
        controller: controller,
        capability: SceneSpikeCapability.customMaterial,
      );

      expect(adapter.customMaterialAppResourceGeneration, 0);
      expect(controller.canAttestCapability(.customMaterial), isTrue);
    });

    test(
      'adapter authority loss invalidates an existing attestation',
      () async {
        final adapter = FakeSceneSpikeControllerAdapter();
        final controller = createController(adapter: adapter);
        addTearDown(controller.dispose);
        await controller.initializeStaticResources();
        completeChecklist(
          controller: controller,
          capability: SceneSpikeCapability.customMaterial,
        );
        controller.attestCapability(.customMaterial);

        adapter.customMaterialAppResourceGeneration = null;

        expect(
          controller.capabilityResult(.customMaterial).status,
          SceneSpikeCapabilityStatus.unobserved,
        );
      },
    );
  });
}

void completeChecklist({
  required FlutterSceneSpikeController controller,
  required SceneSpikeCapability capability,
}) {
  for (final criterion in controller.checklistCriteria(capability)) {
    controller.setChecklistCriterion(
      capability: capability,
      criterionId: criterion.id,
      isCompleted: true,
    );
  }
}

FlutterSceneSpikeController createController({
  required FakeSceneSpikeControllerAdapter adapter,
  SceneSpikeRuntimeIdentitySource? runtimeSource,
  SceneSpikeRunLog? runLog,
  int? controllerGeneration,
}) {
  final projection = EqmonitorOrthographicProjection(
    worldHalfHeight: 1.2,
    depthHalfExtent: 3.2,
  );
  final currentRunLog =
      runLog ?? SceneSpikeRunLog(startedAtUtc: DateTime.utc(2026, 8, 2));
  return FlutterSceneSpikeController.withDependencies(
    adapter: adapter,
    runLog: currentRunLog,
    projection: projection,
    initialFrame: SpikeMeshFrame.initial(),
    runtimeSource: runtimeSource ?? const FakeRuntimeIdentitySource(),
    manifestSource: const FakeBuildManifestSource(),
    initializeSceneStaticResources: () async {},
    controllerGeneration:
        controllerGeneration ?? currentRunLog.beginControllerGeneration(),
  );
}

class FakeSceneSpikeControllerAdapter implements SceneSpikeControllerAdapter {
  FakeSceneSpikeControllerAdapter({
    Future<void>? rebuildCompletion,
    Future<bool>? initializeCompletion,
  }) : _rebuildCompletion = rebuildCompletion ?? Future<void>.value(),
       _initializeCompletion = initializeCompletion ?? Future.value(true);

  final Future<void> _rebuildCompletion;
  final Future<bool> _initializeCompletion;
  final List<int> requestedAppResourceGenerations = [];
  var _initializeCustomMaterialCount = 0;
  var _isForeground = false;

  bool get isForeground => _isForeground;

  @override
  int? customMaterialAppResourceGeneration;

  int get initializeCustomMaterialCount => _initializeCustomMaterialCount;

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
  void updateMesh({required SpikeMeshFrame frame}) {}
}

class FakeRuntimeIdentitySource implements SceneSpikeRuntimeIdentitySource {
  const FakeRuntimeIdentitySource({this.deviceModel});

  final Future<String>? deviceModel;

  @override
  SceneSpikeBuildMode readBuildMode() => .profile;

  @override
  Future<String> readDeviceModel(SceneSpikePlatform platform) =>
      deviceModel ?? Future.value('Pixel Test');

  @override
  String readDartVersion() => 'Dart Test';

  @override
  String readOperatingSystemVersion() => 'Android Test';

  @override
  SceneSpikePlatform readPlatform() => .android;
}

class FakeBuildManifestSource implements SceneSpikeBuildManifestSource {
  const FakeBuildManifestSource();

  @override
  SceneSpikeBuildManifest read() => const SceneSpikeBuildManifest(
    flutterFrameworkRevision:
        SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
    flutterEngineRevision:
        SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
    flutterEngineContentHash:
        SceneSpikeEvidenceContract.expectedFlutterEngineContentHash,
    dartSourceRevision: SceneSpikeEvidenceContract.expectedDartSourceRevision,
    flutterSceneRevision:
        SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
    eqmonitorMapRendererRevision: '0123456789abcdef0123456789abcdef01234567',
    eqmonitorMapRendererCheckoutDirty: false,
  );
}
