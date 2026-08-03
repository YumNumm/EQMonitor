import 'package:eqmonitor_map/src/observability/scene_spike_evidence_collector.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SceneSpikeEvidenceCollector trusted identity', () {
    test('fixes runtime manifest and attestation provenance', () async {
      final collector = SceneSpikeEvidenceCollector(
        runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(),
        manifestSource: FakeSceneSpikeBuildManifestSource(
          manifest: sceneSpikeCollectorFixture.manifest(),
        ),
      );

      final evidence = await collector.collect(
        renderingBackend: 'Impeller Vulkan from verbose device log',
        startedAtUtc: DateTime.utc(2026, 8, 2),
        elapsedMicroseconds: 2000000,
        frameCount: 2,
        partialUpdateCount: 2,
        lifecycleResumeCount: 1,
        appResourceGeneration: 1,
        capabilities: sceneSpikeCollectorFixture.capabilities(),
        performance: sceneSpikeCollectorFixture.performance(),
      );

      expect(
        evidence.run,
        const SceneSpikeRunKey(platform: .android, buildMode: .release),
      );
      expect(evidence.deviceModel, 'Pixel Test');
      expect(evidence.operatingSystemVersion, 'Android Test');
      expect(evidence.dartVersion, 'Dart Test');
      expect(
        evidence.revisionProvenance,
        SceneSpikeObservationProvenance.compileTimeManifest,
      );
      expect(
        evidence.renderingBackendProvenance,
        SceneSpikeObservationProvenance.operatorAttestation,
      );
      expect(
        evidence.renderingBackend,
        'Impeller Vulkan from verbose device log',
      );
    });

    test('propagates unsupported platform and build mode failures', () {
      final platformCollector = SceneSpikeEvidenceCollector(
        runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(
          unsupportedPlatform: true,
        ),
        manifestSource: FakeSceneSpikeBuildManifestSource(
          manifest: sceneSpikeCollectorFixture.manifest(),
        ),
      );
      final buildModeCollector = SceneSpikeEvidenceCollector(
        runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(
          unsupportedBuildMode: true,
        ),
        manifestSource: FakeSceneSpikeBuildManifestSource(
          manifest: sceneSpikeCollectorFixture.manifest(),
        ),
      );

      expect(
        sceneSpikeCollectorFixture.collect(platformCollector),
        throwsUnsupportedError,
      );
      expect(
        sceneSpikeCollectorFixture.collect(buildModeCollector),
        throwsUnsupportedError,
      );
    });

    test('rejects missing invalid or dirty build manifests', () {
      final missing = sceneSpikeCollectorFixture.manifest(
        flutterFrameworkRevision: '',
      );
      final invalid = sceneSpikeCollectorFixture.manifest(
        eqmonitorMapRendererRevision: 'renderer-main',
      );
      final dirty = sceneSpikeCollectorFixture.manifest(
        eqmonitorMapRendererCheckoutDirty: true,
      );

      for (final manifest in [missing, invalid, dirty]) {
        final collector = SceneSpikeEvidenceCollector(
          runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(),
          manifestSource: FakeSceneSpikeBuildManifestSource(
            manifest: manifest,
          ),
        );
        expect(
          sceneSpikeCollectorFixture.collect(collector),
          throwsStateError,
        );
      }
    });

    test(
      'rejects blank device identity and backend without fallback',
      () {
        final blankDeviceCollector = SceneSpikeEvidenceCollector(
          runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(
            deviceModel: ' ',
          ),
          manifestSource: FakeSceneSpikeBuildManifestSource(
            manifest: sceneSpikeCollectorFixture.manifest(),
          ),
        );
        final validCollector = SceneSpikeEvidenceCollector(
          runtimeSource: const FakeSceneSpikeRuntimeIdentitySource(),
          manifestSource: FakeSceneSpikeBuildManifestSource(
            manifest: sceneSpikeCollectorFixture.manifest(),
          ),
        );

        expect(
          sceneSpikeCollectorFixture.collect(blankDeviceCollector),
          throwsStateError,
        );
        expect(
          sceneSpikeCollectorFixture.collect(
            validCollector,
            renderingBackend: ' ',
          ),
          throwsStateError,
        );
      },
    );
  });
}

const sceneSpikeCollectorFixture = SceneSpikeCollectorFixture();

class SceneSpikeCollectorFixture {
  const SceneSpikeCollectorFixture();

  Future<SceneSpikeEvidence> collect(
    SceneSpikeEvidenceCollector collector, {
    String renderingBackend = 'Impeller Vulkan',
  }) => collector.collect(
    renderingBackend: renderingBackend,
    startedAtUtc: DateTime.utc(2026, 8, 2),
    elapsedMicroseconds: 2000000,
    frameCount: 2,
    partialUpdateCount: 2,
    lifecycleResumeCount: 1,
    appResourceGeneration: 1,
    capabilities: capabilities(),
    performance: performance(),
  );

  SceneSpikeBuildManifest manifest({
    String flutterFrameworkRevision =
        SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
    String flutterEngineRevision =
        SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
    String flutterSceneRevision =
        SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
    String eqmonitorMapRendererRevision =
        '0123456789abcdef0123456789abcdef01234567',
    bool eqmonitorMapRendererCheckoutDirty = false,
  }) => SceneSpikeBuildManifest(
    flutterFrameworkRevision: flutterFrameworkRevision,
    flutterEngineRevision: flutterEngineRevision,
    flutterSceneRevision: flutterSceneRevision,
    eqmonitorMapRendererRevision: eqmonitorMapRendererRevision,
    eqmonitorMapRendererCheckoutDirty: eqmonitorMapRendererCheckoutDirty,
  );

  List<SceneSpikeCapabilityResult> capabilities() => SceneSpikeCapability.values
      .map(
        (capability) => SceneSpikeCapabilityResult(
          capability: capability,
          status: switch (capability) {
            .explicitResourceDisposal ||
            .contextResourceRebuild ||
            .gpuCompletionOrSafeRetirement => .unobserved,
            _ => .passed,
          },
          provenance: switch (capability) {
            .partialPositionAndColorUpdate ||
            .backgroundAndForeground ||
            .disposeAndRemount => .runtimeSignal,
            .explicitResourceDisposal ||
            .contextResourceRebuild ||
            .gpuCompletionOrSafeRetirement => .unavailablePublicApi,
            _ => .operatorAttestation,
          },
          detail: 'Observed with the required evidence source.',
          observedAtUtc: DateTime.utc(2026, 8, 2, 0, 0, 1),
        ),
      )
      .toList();

  SceneSpikePerformanceSnapshot performance() =>
      const SceneSpikePerformanceSnapshot(
        buildDurationCount: 2,
        buildDurationMaxMicroseconds: 15,
        buildDurationP50Microseconds: 10,
        buildDurationP95Microseconds: 15,
        rasterDurationCount: 2,
        rasterDurationMaxMicroseconds: 12,
        rasterDurationP50Microseconds: 8,
        rasterDurationP95Microseconds: 12,
        droppedFrameCount: 0,
        partialUpdateCount: 2,
        resourceRebuildCount: 1,
        exceptionCount: 0,
      );
}

class FakeSceneSpikeRuntimeIdentitySource
    implements SceneSpikeRuntimeIdentitySource {
  const FakeSceneSpikeRuntimeIdentitySource({
    this.unsupportedPlatform = false,
    this.unsupportedBuildMode = false,
    this.deviceModel = 'Pixel Test',
  });

  final bool unsupportedPlatform;
  final bool unsupportedBuildMode;
  final String deviceModel;

  @override
  SceneSpikePlatform readPlatform() {
    if (unsupportedPlatform) {
      throw UnsupportedError('Unsupported test platform.');
    }
    return .android;
  }

  @override
  SceneSpikeBuildMode readBuildMode() {
    if (unsupportedBuildMode) {
      throw UnsupportedError('Unsupported test build mode.');
    }
    return .release;
  }

  @override
  Future<String> readDeviceModel(SceneSpikePlatform platform) async =>
      deviceModel;

  @override
  String readOperatingSystemVersion() => 'Android Test';

  @override
  String readDartVersion() => 'Dart Test';
}

class FakeSceneSpikeBuildManifestSource
    implements SceneSpikeBuildManifestSource {
  const FakeSceneSpikeBuildManifestSource({required this.manifest});

  final SceneSpikeBuildManifest manifest;

  @override
  SceneSpikeBuildManifest read() => manifest;
}
