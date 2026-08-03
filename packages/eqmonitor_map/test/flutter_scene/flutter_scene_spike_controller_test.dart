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
      'detach during rebuild prevents completion state mutation',
      () async {
        final rebuild = Completer<void>();
        final controller =
            createController(
                adapter: FakeSceneSpikeControllerAdapter(
                  rebuildCompletion: rebuild.future,
                ),
              )
              ..attach(
                logicalSize: const Size(400, 300),
                devicePixelRatio: 2,
              )
              ..requestAppResourceRebuild();
        addTearDown(controller.dispose);

        final completion = controller.completePendingAppResourceRebuild();
        controller.detach();
        rebuild.complete();
        await completion;

        expect(controller.lifecycle.phase, SceneSpikeLifecyclePhase.detached);
        expect(controller.performance.resourceRebuildCount, 0);
      },
    );
  });

  group('FlutterSceneSpikeController terminal failures', () {
    test('reset preserves a custom material runtime failure', () {
      final runLog = SceneSpikeRunLog(startedAtUtc: DateTime.utc(2026, 8, 2))
        ..record(
          const SceneSpikeRuntimeObservation(
            capability: .customMaterial,
            status: .failed,
            detail: 'Shader compilation failed.',
          ),
        );
      final controller = createController(
        adapter: FakeSceneSpikeControllerAdapter(),
        runLog: runLog,
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
  });
}

FlutterSceneSpikeController createController({
  required FakeSceneSpikeControllerAdapter adapter,
  SceneSpikeRuntimeIdentitySource? runtimeSource,
  SceneSpikeRunLog? runLog,
}) {
  final projection = EqmonitorOrthographicProjection(worldHalfHeight: 1.2);
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
  );
}

class FakeSceneSpikeControllerAdapter implements SceneSpikeControllerAdapter {
  FakeSceneSpikeControllerAdapter({Future<void>? rebuildCompletion})
    : _rebuildCompletion = rebuildCompletion ?? Future<void>.value();

  final Future<void> _rebuildCompletion;
  var _initializeCustomMaterialCount = 0;

  int get initializeCustomMaterialCount => _initializeCustomMaterialCount;

  @override
  scene.Scene? get sceneGraph => null;

  @override
  void attach({required Size logicalSize, required double devicePixelRatio}) {}

  @override
  void completeAppResourceRebuild({required int appResourceGeneration}) {}

  @override
  void detach() {}

  @override
  void dispose() {}

  @override
  Future<bool> initializeCustomMaterial({
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    if (!token.isCurrent) {
      return false;
    }
    _initializeCustomMaterialCount += 1;
    return true;
  }

  @override
  Future<bool> rebuildApplicationResources({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    await _rebuildCompletion;
    return token.isCurrent;
  }

  @override
  void requestAppResourceRebuild({required int appResourceGeneration}) {}

  @override
  void setForeground({required bool isForeground}) {}

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
    dartSourceRevision: SceneSpikeEvidenceContract.expectedDartSourceRevision,
    flutterSceneRevision:
        SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
    eqmonitorMapRendererRevision: '0123456789abcdef0123456789abcdef01234567',
    eqmonitorMapRendererCheckoutDirty: false,
  );
}
