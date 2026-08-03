// The device spike contract requires compile-time, non-runtime manifest data.
// ignore_for_file: do_not_use_environment

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:flutter/foundation.dart';

abstract interface class SceneSpikeRuntimeIdentitySource {
  SceneSpikePlatform readPlatform();

  SceneSpikeBuildMode readBuildMode();

  Future<String> readDeviceModel(SceneSpikePlatform platform);

  String readOperatingSystemVersion();

  String readDartVersion();
}

abstract interface class SceneSpikeBuildManifestSource {
  SceneSpikeBuildManifest read();
}

class SceneSpikeRuntimeIdentity {
  const SceneSpikeRuntimeIdentity({
    required this.run,
    required this.deviceModel,
    required this.operatingSystemVersion,
    required this.dartVersion,
  });

  final SceneSpikeRunKey run;
  final String deviceModel;
  final String operatingSystemVersion;
  final String dartVersion;
}

class SceneSpikeBuildManifest {
  const SceneSpikeBuildManifest({
    required this.flutterFrameworkRevision,
    required this.flutterEngineRevision,
    required this.flutterEngineContentHash,
    required this.dartSourceRevision,
    required this.flutterSceneRevision,
    required this.eqmonitorMapRendererRevision,
    required this.eqmonitorMapRendererCheckoutDirty,
  });

  final String flutterFrameworkRevision;
  final String flutterEngineRevision;
  final String flutterEngineContentHash;
  final String dartSourceRevision;
  final String flutterSceneRevision;
  final String eqmonitorMapRendererRevision;
  final bool eqmonitorMapRendererCheckoutDirty;
}

class SceneSpikeEnvironmentKeys {
  const SceneSpikeEnvironmentKeys._();

  static const flutterFrameworkRevision =
      'EQMONITOR_SCENE_SPIKE_FLUTTER_FRAMEWORK_REVISION';
  static const flutterEngineRevision =
      'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_REVISION';
  static const flutterEngineContentHash =
      'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_CONTENT_HASH';
  static const dartSourceRevision =
      'EQMONITOR_SCENE_SPIKE_DART_SOURCE_REVISION';
  static const flutterSceneRevision =
      'EQMONITOR_SCENE_SPIKE_FLUTTER_SCENE_REVISION';
  static const eqmonitorMapRendererRevision =
      'EQMONITOR_SCENE_SPIKE_RENDERER_REVISION';
  static const eqmonitorMapRendererCheckoutDirty =
      'EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY';
}

class SceneSpikeEnvironmentBuildManifestSource
    implements SceneSpikeBuildManifestSource {
  const SceneSpikeEnvironmentBuildManifestSource();

  @override
  SceneSpikeBuildManifest read() {
    const dirtyValue = String.fromEnvironment(
      SceneSpikeEnvironmentKeys.eqmonitorMapRendererCheckoutDirty,
    );
    final dirty = switch (dirtyValue) {
      'true' => true,
      'false' => false,
      _ => throw StateError(
        '${SceneSpikeEnvironmentKeys.eqmonitorMapRendererCheckoutDirty} '
        'must be explicitly set to true or false.',
      ),
    };
    return SceneSpikeBuildManifest(
      flutterFrameworkRevision: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.flutterFrameworkRevision,
      ),
      flutterEngineRevision: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.flutterEngineRevision,
      ),
      flutterEngineContentHash: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.flutterEngineContentHash,
      ),
      dartSourceRevision: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.dartSourceRevision,
      ),
      flutterSceneRevision: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.flutterSceneRevision,
      ),
      eqmonitorMapRendererRevision: const String.fromEnvironment(
        SceneSpikeEnvironmentKeys.eqmonitorMapRendererRevision,
      ),
      eqmonitorMapRendererCheckoutDirty: dirty,
    );
  }
}

class SceneSpikeProductionRuntimeIdentitySource
    implements SceneSpikeRuntimeIdentitySource {
  SceneSpikeProductionRuntimeIdentitySource({
    DeviceInfoPlugin? deviceInfoPlugin,
  }) : _deviceInfoPlugin = deviceInfoPlugin ?? DeviceInfoPlugin();

  final DeviceInfoPlugin _deviceInfoPlugin;

  @override
  SceneSpikePlatform readPlatform() {
    if (Platform.isIOS) {
      return .ios;
    }
    if (Platform.isAndroid) {
      return .android;
    }
    throw UnsupportedError(
      'Scene spike evidence requires a physical iOS or Android device.',
    );
  }

  @override
  SceneSpikeBuildMode readBuildMode() {
    if (kProfileMode) {
      return .profile;
    }
    if (kReleaseMode) {
      return .release;
    }
    throw UnsupportedError(
      'Scene spike evidence requires profile or release build mode.',
    );
  }

  @override
  Future<String> readDeviceModel(SceneSpikePlatform platform) async =>
      switch (platform) {
        .ios => (await _deviceInfoPlugin.iosInfo).utsname.machine,
        .android => (await _deviceInfoPlugin.androidInfo).model,
      };

  @override
  String readOperatingSystemVersion() => Platform.operatingSystemVersion;

  @override
  String readDartVersion() => Platform.version;
}

class SceneSpikeEvidenceCollector {
  const SceneSpikeEvidenceCollector({
    required this.runtimeSource,
    required this.manifestSource,
    this.factory = const SceneSpikeEvidenceFactory(),
  });

  final SceneSpikeRuntimeIdentitySource runtimeSource;
  final SceneSpikeBuildManifestSource manifestSource;
  final SceneSpikeEvidenceFactory factory;

  Future<SceneSpikeEvidence> collect({
    required String renderingBackend,
    required DateTime startedAtUtc,
    required int elapsedMicroseconds,
    required int frameCount,
    required int partialUpdateCount,
    required int lifecycleResumeCount,
    required int disposeAndRemountCount,
    required int controllerGeneration,
    required int appResourceGeneration,
    required SceneSpikeCustomMaterialRuntimeSuccess?
    customMaterialRuntimeSuccess,
    required List<SceneSpikeCustomMaterialRuntimeFailure>
    customMaterialRuntimeFailures,
    required List<SceneSpikeCapabilityResult> capabilities,
    required SceneSpikePerformanceSnapshot performance,
  }) async {
    final platform = runtimeSource.readPlatform();
    final buildMode = runtimeSource.readBuildMode();
    final identity = SceneSpikeRuntimeIdentity(
      run: SceneSpikeRunKey(platform: platform, buildMode: buildMode),
      deviceModel: await runtimeSource.readDeviceModel(platform),
      operatingSystemVersion: runtimeSource.readOperatingSystemVersion(),
      dartVersion: runtimeSource.readDartVersion(),
    );
    return factory.create(
      identity: identity,
      manifest: manifestSource.read(),
      renderingBackend: renderingBackend,
      startedAtUtc: startedAtUtc,
      elapsedMicroseconds: elapsedMicroseconds,
      frameCount: frameCount,
      partialUpdateCount: partialUpdateCount,
      lifecycleResumeCount: lifecycleResumeCount,
      disposeAndRemountCount: disposeAndRemountCount,
      controllerGeneration: controllerGeneration,
      appResourceGeneration: appResourceGeneration,
      customMaterialRuntimeSuccess: customMaterialRuntimeSuccess,
      customMaterialRuntimeFailures: customMaterialRuntimeFailures,
      capabilities: capabilities,
      performance: performance,
    );
  }
}

class SceneSpikeEvidenceFactory {
  const SceneSpikeEvidenceFactory();

  SceneSpikeEvidence create({
    required SceneSpikeRuntimeIdentity identity,
    required SceneSpikeBuildManifest manifest,
    required String renderingBackend,
    required DateTime startedAtUtc,
    required int elapsedMicroseconds,
    required int frameCount,
    required int partialUpdateCount,
    required int lifecycleResumeCount,
    required int disposeAndRemountCount,
    required int controllerGeneration,
    required int appResourceGeneration,
    required SceneSpikeCustomMaterialRuntimeSuccess?
    customMaterialRuntimeSuccess,
    required List<SceneSpikeCustomMaterialRuntimeFailure>
    customMaterialRuntimeFailures,
    required List<SceneSpikeCapabilityResult> capabilities,
    required SceneSpikePerformanceSnapshot performance,
  }) {
    SceneSpikeTrustedInputValidator.validateIdentity(identity);
    SceneSpikeTrustedInputValidator.validateManifest(manifest);
    SceneSpikeTrustedInputValidator.validateBackend(renderingBackend);
    return SceneSpikeEvidence(
      schemaVersion: SceneSpikeEvidenceContract.schemaVersion,
      run: identity.run,
      deviceModel: identity.deviceModel,
      operatingSystemVersion: identity.operatingSystemVersion,
      flutterFrameworkRevision: manifest.flutterFrameworkRevision,
      flutterEngineRevision: manifest.flutterEngineRevision,
      flutterEngineContentHash: manifest.flutterEngineContentHash,
      dartVersion: identity.dartVersion,
      dartSourceRevision: manifest.dartSourceRevision,
      flutterSceneRevision: manifest.flutterSceneRevision,
      eqmonitorMapRendererRevision: manifest.eqmonitorMapRendererRevision,
      eqmonitorMapRendererCheckoutDirty:
          manifest.eqmonitorMapRendererCheckoutDirty,
      revisionProvenance: .compileTimeManifest,
      renderingBackend: renderingBackend,
      renderingBackendProvenance: .operatorAttestation,
      startedAtUtc: startedAtUtc,
      elapsedMicroseconds: elapsedMicroseconds,
      frameCount: frameCount,
      partialUpdateCount: partialUpdateCount,
      lifecycleResumeCount: lifecycleResumeCount,
      disposeAndRemountCount: disposeAndRemountCount,
      controllerGeneration: controllerGeneration,
      appResourceGeneration: appResourceGeneration,
      customMaterialRuntimeSuccess: customMaterialRuntimeSuccess,
      customMaterialRuntimeFailures: customMaterialRuntimeFailures,
      capabilities: capabilities,
      performance: performance,
    );
  }
}

class SceneSpikeTrustedInputValidator {
  const SceneSpikeTrustedInputValidator._();

  static void validateIdentity(SceneSpikeRuntimeIdentity identity) {
    final fields = {
      'deviceModel': identity.deviceModel,
      'operatingSystemVersion': identity.operatingSystemVersion,
      'dartVersion': identity.dartVersion,
    };
    for (final field in fields.entries) {
      if (field.value.trim().isEmpty) {
        throw StateError('${field.key} must not be blank.');
      }
    }
  }

  static void validateManifest(SceneSpikeBuildManifest manifest) {
    final revisions = {
      'flutterFrameworkRevision': (
        actual: manifest.flutterFrameworkRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
      ),
      'flutterEngineRevision': (
        actual: manifest.flutterEngineRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
      ),
      'flutterEngineContentHash': (
        actual: manifest.flutterEngineContentHash,
        expected: SceneSpikeEvidenceContract.expectedFlutterEngineContentHash,
      ),
      'dartSourceRevision': (
        actual: manifest.dartSourceRevision,
        expected: SceneSpikeEvidenceContract.expectedDartSourceRevision,
      ),
      'flutterSceneRevision': (
        actual: manifest.flutterSceneRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
      ),
    };
    for (final revision in revisions.entries) {
      if (!SceneSpikeRevisionValidator.isLowercaseSha(revision.value.actual) ||
          revision.value.actual != revision.value.expected) {
        throw StateError('${revision.key} is missing or invalid.');
      }
    }
    if (!SceneSpikeRevisionValidator.isLowercaseSha(
      manifest.eqmonitorMapRendererRevision,
    )) {
      throw StateError('eqmonitorMapRendererRevision is missing or invalid.');
    }
    if (manifest.eqmonitorMapRendererCheckoutDirty) {
      throw StateError('eqmonitor_map renderer checkout must be clean.');
    }
  }

  static void validateBackend(String renderingBackend) {
    if (renderingBackend.trim().isEmpty) {
      throw StateError('renderingBackend attestation must not be blank.');
    }
  }
}
