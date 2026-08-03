import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/scene_spike_evidence_validator.dart';

void main() {
  late Directory evidenceDirectory;

  setUp(() async {
    evidenceDirectory = await Directory.systemTemp.createTemp(
      'scene_spike_evidence_validator_test_',
    );
  });

  tearDown(() async {
    await evidenceDirectory.delete(recursive: true);
  });

  test(
    'empty directory fails closed with every required run missing',
    () {
      final result = validateSceneSpikeEvidence(
        directory: evidenceDirectory,
      );

      expect(result.processExitCode, 1);
      expect(result.decision.isPass, isFalse);
      expect(
        result.decision.missingRuns,
        SceneSpikeEvidenceContract.requiredRuns,
      );
      expect(result.decision.validationErrors, isEmpty);
      expect(jsonDecode(result.canonicalJson), result.decision.toJson());
    },
  );

  test('malformed JSON is normalized without leaking a parse error', () async {
    await File('${evidenceDirectory.path}/malformed.json').writeAsString('{');

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.validationErrors,
      ['Evidence file is malformed: malformed.json'],
    );
    expect(result.canonicalJson, isNot(contains('FormatException')));
  });

  test('duplicate run evidence is rejected by the Task 5 gate', () async {
    final evidence = sceneSpikeValidatorFixture.evidence(
      run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
    );
    await sceneSpikeValidatorFixture.writeEvidence(
      directory: evidenceDirectory,
      filename: 'first.json',
      evidence: evidence,
    );
    await sceneSpikeValidatorFixture.writeEvidence(
      directory: evidenceDirectory,
      filename: 'second.json',
      evidence: evidence,
    );

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.validationErrors,
      contains('Duplicate run: ios/profile.'),
    );
  });

  test('unknown schema version is rejected by the Task 5 gate', () async {
    final json = sceneSpikeValidatorFixture
        .evidence(
          run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
        )
        .toJson();
    json['schemaVersion'] = SceneSpikeEvidenceContract.schemaVersion + 1;
    await sceneSpikeValidatorFixture.writeJson(
      directory: evidenceDirectory,
      filename: 'unknown_schema.json',
      json: json,
    );

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.validationErrors,
      contains('ios/profile has unsupported schema version: 5.'),
    );
  });

  test('invalid field is normalized as a validation error', () async {
    final json = sceneSpikeValidatorFixture
        .evidence(
          run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
        )
        .toJson();
    json['frameCount'] = 'two';
    await sceneSpikeValidatorFixture.writeJson(
      directory: evidenceDirectory,
      filename: 'invalid_field.json',
      json: json,
    );

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.validationErrors,
      ['Evidence file has an invalid field: invalid_field.json'],
    );
  });

  test('fixed revision mismatch fails closed', () async {
    final json = sceneSpikeValidatorFixture
        .evidence(
          run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
        )
        .toJson();
    json['flutterSceneRevision'] = '0000000000000000000000000000000000000000';
    await sceneSpikeValidatorFixture.writeJson(
      directory: evidenceDirectory,
      filename: 'revision_mismatch.json',
      json: json,
    );

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.revisionMismatches,
      contains(contains('flutterSceneRevision')),
    );
  });

  test('engine artifact content hash mismatch fails closed', () async {
    final json = sceneSpikeValidatorFixture
        .evidence(
          run: const SceneSpikeRunKey(platform: .ios, buildMode: .release),
        )
        .toJson();
    json['flutterEngineContentHash'] =
        '0123456789abcdef0123456789abcdef01234567';
    await sceneSpikeValidatorFixture.writeJson(
      directory: evidenceDirectory,
      filename: 'engine_artifact_mismatch.json',
      json: json,
    );

    final result = validateSceneSpikeEvidence(directory: evidenceDirectory);

    expect(result.processExitCode, 1);
    expect(
      result.decision.revisionMismatches,
      contains(contains('flutterEngineContentHash')),
    );
  });

  test('failed and unavailable capabilities both fail closed', () async {
    final evidence = sceneSpikeValidatorFixture.evidence(
      run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
      failedCapability: .customMaterial,
    );
    await sceneSpikeValidatorFixture.writeEvidence(
      directory: evidenceDirectory,
      filename: 'capabilities.json',
      evidence: evidence,
    );

    final result = validateSceneSpikeEvidence(
      directory: evidenceDirectory,
    );

    expect(result.processExitCode, 1);
    expect(
      result.decision.failedCapabilities.map(
        (finding) => finding.result.capability,
      ),
      contains(SceneSpikeCapability.customMaterial),
    );
    expect(
      result.decision.unobservedCapabilities
          .map((finding) => finding.result.capability)
          .toSet(),
      SceneSpikeEvidenceContract.unavailablePublicApiCapabilities,
    );
  });
}

const sceneSpikeValidatorFixture = SceneSpikeValidatorFixture();

class SceneSpikeValidatorFixture {
  const SceneSpikeValidatorFixture();

  SceneSpikeEvidence evidence({
    required SceneSpikeRunKey run,
    SceneSpikeCapability? failedCapability,
  }) => SceneSpikeEvidence(
    schemaVersion: SceneSpikeEvidenceContract.schemaVersion,
    run: run,
    deviceModel: 'Test Device',
    operatingSystemVersion: 'Test OS 1.0',
    flutterFrameworkRevision:
        SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
    flutterEngineRevision:
        SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
    flutterEngineContentHash:
        SceneSpikeEvidenceContract.expectedFlutterEngineContentHash,
    dartVersion: '3.14.0-29.0.dev',
    dartSourceRevision: SceneSpikeEvidenceContract.expectedDartSourceRevision,
    flutterSceneRevision:
        SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
    eqmonitorMapRendererRevision: '0123456789abcdef0123456789abcdef01234567',
    eqmonitorMapRendererCheckoutDirty: false,
    revisionProvenance: .compileTimeManifest,
    renderingBackend: 'Impeller Vulkan',
    renderingBackendProvenance: .operatorAttestation,
    startedAtUtc: DateTime.utc(2026, 8, 2),
    elapsedMicroseconds: 2000000,
    frameCount: 2,
    partialUpdateCount: 2,
    lifecycleResumeCount: 1,
    disposeAndRemountCount: 1,
    controllerGeneration: 2,
    appResourceGeneration: 1,
    customMaterialRuntimeSuccess: SceneSpikeCustomMaterialRuntimeSuccess(
      controllerGeneration: 2,
      appResourceGeneration: 1,
      observedAtUtc: DateTime.utc(2026, 8, 2, 0, 0, 0, 500),
    ),
    customMaterialRuntimeFailures: const [],
    capabilities: capabilities(failedCapability: failedCapability),
    performance: const SceneSpikePerformanceSnapshot(
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
    ),
  );

  List<SceneSpikeCapabilityResult> capabilities({
    required SceneSpikeCapability? failedCapability,
  }) => SceneSpikeCapability.values.map((capability) {
    final isUnavailable = SceneSpikeEvidenceContract
        .unavailablePublicApiCapabilities
        .contains(
          capability,
        );
    final status = switch ((isUnavailable, capability == failedCapability)) {
      (true, _) => SceneSpikeCapabilityStatus.unobserved,
      (false, true) => SceneSpikeCapabilityStatus.failed,
      (false, false) => SceneSpikeCapabilityStatus.passed,
    };
    return SceneSpikeCapabilityResult(
      capability: capability,
      status: status,
      provenance: SceneSpikeEvidenceContract.requiredProvenance(capability),
      detail: isUnavailable
          ? 'Flutter Scene has no required public API.'
          : 'Observed with the required evidence source.',
      observedAtUtc: DateTime.utc(2026, 8, 2, 0, 0, 1),
    );
  }).toList();

  Future<void> writeEvidence({
    required Directory directory,
    required String filename,
    required SceneSpikeEvidence evidence,
  }) => writeJson(
    directory: directory,
    filename: filename,
    json: evidence.toJson(),
  );

  Future<void> writeJson({
    required Directory directory,
    required String filename,
    required Map<String, dynamic> json,
  }) => File('${directory.path}/$filename').writeAsString(jsonEncode(json));
}
