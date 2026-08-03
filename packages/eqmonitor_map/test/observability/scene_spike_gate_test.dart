import 'dart:convert';

import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SceneSpikeGate fail closed', () {
    test('does not pass when a required capability is unobserved', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .profile,
        ),
      );

      final decision = SceneSpikeGate.evaluate([evidence]);

      expect(decision.isPass, isFalse);
      expect(
        decision.unobservedCapabilities.map(
          (finding) => finding.result.capability,
        ),
        contains(SceneSpikeCapability.gpuCompletionOrSafeRetirement),
      );
    });

    test('requires profile and release evidence for both mobile platforms', () {
      final evidence = sceneSpikeFixture
          .fourRuns()
          .where(
            (run) =>
                run.run !=
                const SceneSpikeRunKey(
                  platform: .android,
                  buildMode: .release,
                ),
          )
          .toList();

      expect(SceneSpikeGate.evaluate(evidence).missingRuns, [
        const SceneSpikeRunKey(
          platform: .android,
          buildMode: .release,
        ),
      ]);
    });

    test('rejects duplicate run keys and duplicate capabilities', () {
      final run = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .profile,
        ),
      );
      final duplicateRunDecision = SceneSpikeGate.evaluate([run, run]);
      final duplicateCapability = run.copyWith(
        capabilities: [...run.capabilities, run.capabilities.first],
      );
      final duplicateCapabilityDecision = SceneSpikeGate.evaluate([
        duplicateCapability,
      ]);

      expect(duplicateRunDecision.isPass, isFalse);
      expect(
        duplicateRunDecision.validationErrors,
        contains('Duplicate run: android/profile.'),
      );
      expect(duplicateCapabilityDecision.isPass, isFalse);
      expect(
        duplicateCapabilityDecision.validationErrors,
        contains(
          'android/profile has duplicate capability: '
          'proceduralOrthographicMesh.',
        ),
      );
    });

    test(
      'rejects unknown schema, wrong revisions, invalid UTC and counters',
      () {
        final invalid = sceneSpikeFixture
            .evidence(
              run: const SceneSpikeRunKey(
                platform: .android,
                buildMode: .profile,
              ),
            )
            .copyWith(
              schemaVersion: 2,
              flutterFrameworkRevision: 'wrong',
              startedAtUtc: DateTime(2026, 8, 2),
              frameCount: -1,
            );

        final decision = SceneSpikeGate.evaluate([invalid]);

        expect(decision.isPass, isFalse);
        expect(
          decision.validationErrors,
          containsAll([
            'android/profile has unsupported schema version: 2.',
            'android/profile startedAtUtc must be UTC.',
            'android/profile frameCount must be non-negative.',
          ]),
        );
        expect(
          decision.revisionMismatches,
          contains(
            'android/profile flutterFrameworkRevision expected '
            '${SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision}, '
            'got wrong.',
          ),
        );
      },
    );

    test(
      'complete four-run fixture remains blocked by unavailable public APIs',
      () {
        final decision = SceneSpikeGate.evaluate(sceneSpikeFixture.fourRuns());

        expect(decision.missingRuns, isEmpty);
        expect(decision.failedCapabilities, isEmpty);
        expect(decision.validationErrors, isEmpty);
        expect(decision.revisionMismatches, isEmpty);
        expect(decision.unobservedCapabilities, hasLength(12));
        expect(decision.isPass, isFalse);
      },
    );

    test('rejects attempts to mark public-API gaps as passed', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .ios,
          buildMode: .profile,
        ),
        blockedCapabilityStatus: .passed,
      );

      final decision = SceneSpikeGate.evaluate([evidence]);

      expect(
        decision.validationErrors,
        containsAll([
          'ios/profile explicitResourceDisposal cannot pass because the required Flutter Scene public API is unavailable.',
          'ios/profile contextResourceRebuild cannot pass because the required Flutter Scene public API is unavailable.',
          'ios/profile gpuCompletionOrSafeRetirement cannot pass because the required Flutter Scene public API is unavailable.',
        ]),
      );
      expect(decision.isPass, isFalse);
    });

    test('reports failed required capabilities separately', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .ios,
          buildMode: .release,
        ),
      );
      final failed = evidence.copyWith(
        capabilities: evidence.capabilities
            .map(
              (result) => result.capability == .customMaterial
                  ? result.copyWith(status: .failed)
                  : result,
            )
            .toList(),
      );

      final decision = SceneSpikeGate.evaluate([failed]);

      expect(
        decision.failedCapabilities.single.result.capability,
        SceneSpikeCapability.customMaterial,
      );
      expect(decision.isPass, isFalse);
    });
  });

  group('SceneSpikeEvidenceContract validation', () {
    test('contains every required capability exactly once', () {
      expect(SceneSpikeEvidenceContract.requiredCapabilities, [
        SceneSpikeCapability.proceduralOrthographicMesh,
        SceneSpikeCapability.unlitMaterial,
        SceneSpikeCapability.customMaterial,
        SceneSpikeCapability.partialPositionAndColorUpdate,
        SceneSpikeCapability.textPainterOverlay,
        SceneSpikeCapability.dprAndResize,
        SceneSpikeCapability.backgroundAndForeground,
        SceneSpikeCapability.disposeAndRemount,
        SceneSpikeCapability.explicitResourceDisposal,
        SceneSpikeCapability.contextResourceRebuild,
        SceneSpikeCapability.gpuCompletionOrSafeRetirement,
      ]);
      expect(
        SceneSpikeEvidenceContract.requiredCapabilities.toSet(),
        hasLength(11),
      );
    });

    test('enforces the capability provenance matrix', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .release,
        ),
      );
      final wrong = evidence.copyWith(
        capabilities: evidence.capabilities
            .map(
              (result) => result.capability == .partialPositionAndColorUpdate
                  ? result.copyWith(provenance: .operatorAttestation)
                  : result,
            )
            .toList(),
      );

      expect(SceneSpikeGate.evaluate([evidence]).validationErrors, isEmpty);
      expect(
        SceneSpikeGate.evaluate([wrong]).validationErrors,
        contains(
          'android/release partialPositionAndColorUpdate does not allow '
          'operatorAttestation provenance.',
        ),
      );
    });

    test('requires runtime counters for passed runtime capabilities', () {
      final evidence = sceneSpikeFixture
          .evidence(
            run: const SceneSpikeRunKey(
              platform: .android,
              buildMode: .profile,
            ),
          )
          .copyWith(
            partialUpdateCount: 0,
            lifecycleResumeCount: 0,
            performance: sceneSpikeFixture.performance().copyWith(
              partialUpdateCount: 0,
              resourceRebuildCount: 0,
            ),
          );

      expect(
        SceneSpikeGate.evaluate([evidence]).validationErrors,
        containsAll([
          'android/profile partialPositionAndColorUpdate passed without a partial update runtime signal.',
          'android/profile backgroundAndForeground passed without a lifecycle resume runtime signal.',
          'android/profile disposeAndRemount passed without a resource rebuild runtime signal.',
        ]),
      );
    });

    test('rejects empty evidence metadata and capability detail', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .ios,
          buildMode: .release,
        ),
      );
      final invalid = evidence.copyWith(
        deviceModel: ' ',
        operatingSystemVersion: '',
        dartVersion: '\n',
        renderingBackend: ' ',
        capabilities: [
          evidence.capabilities.first.copyWith(detail: ' '),
          ...evidence.capabilities.skip(1),
        ],
      );

      expect(
        SceneSpikeGate.evaluate([invalid]).validationErrors,
        containsAll([
          'ios/release deviceModel must not be blank.',
          'ios/release operatingSystemVersion must not be blank.',
          'ios/release dartVersion must not be blank.',
          'ios/release renderingBackend must not be blank.',
          'ios/release proceduralOrthographicMesh detail must not be blank.',
        ]),
      );
    });

    test('rejects invalid revision format, provenance, and dirty checkout', () {
      final invalid = sceneSpikeFixture
          .evidence(
            run: const SceneSpikeRunKey(
              platform: .android,
              buildMode: .profile,
            ),
          )
          .copyWith(
            flutterEngineRevision: 'ABCDEF0123456789ABCDEF0123456789ABCDEF01',
            eqmonitorMapRendererRevision: 'renderer-main',
            eqmonitorMapRendererCheckoutDirty: true,
            revisionProvenance: .runtimeSignal,
            renderingBackendProvenance: .compileTimeManifest,
          );

      final decision = SceneSpikeGate.evaluate([invalid]);

      expect(
        decision.validationErrors,
        containsAll([
          'android/profile flutterEngineRevision must be 40 lowercase hex.',
          'android/profile eqmonitorMapRendererRevision must be 40 lowercase hex.',
          'android/profile renderer checkout must be clean.',
          'android/profile revisionProvenance must be compileTimeManifest.',
          'android/profile renderingBackendProvenance must be operatorAttestation.',
        ]),
      );
      expect(
        decision.revisionMismatches,
        contains(
          'android/profile flutterEngineRevision expected '
          '${SceneSpikeEvidenceContract.expectedFlutterEngineRevision}, got '
          'ABCDEF0123456789ABCDEF0123456789ABCDEF01.',
        ),
      );
    });

    test('rejects every negative counter and duration', () {
      final invalid = sceneSpikeFixture
          .evidence(
            run: const SceneSpikeRunKey(
              platform: .ios,
              buildMode: .profile,
            ),
          )
          .copyWith(
            elapsedMicroseconds: -1,
            partialUpdateCount: -2,
            lifecycleResumeCount: -3,
            appResourceGeneration: -4,
            performance: sceneSpikeFixture.performance().copyWith(
              buildDurationCount: -1,
              buildDurationMaxMicroseconds: -2,
              buildDurationP50Microseconds: -3,
              buildDurationP95Microseconds: -4,
              rasterDurationCount: -5,
              rasterDurationMaxMicroseconds: -6,
              rasterDurationP50Microseconds: -7,
              rasterDurationP95Microseconds: -8,
              droppedFrameCount: -9,
              partialUpdateCount: -10,
              resourceRebuildCount: -11,
              exceptionCount: -12,
            ),
          );

      final errors = SceneSpikeGate.evaluate([invalid]).validationErrors;

      expect(
        errors.where((error) => error.contains('non-negative')),
        hasLength(15),
      );
    });

    test('rejects inconsistent percentiles and performance counters', () {
      final invalid = sceneSpikeFixture
          .evidence(
            run: const SceneSpikeRunKey(
              platform: .ios,
              buildMode: .release,
            ),
          )
          .copyWith(
            performance: sceneSpikeFixture.performance().copyWith(
              buildDurationP50Microseconds: 16,
              buildDurationP95Microseconds: 14,
              buildDurationMaxMicroseconds: 15,
              rasterDurationCount: 0,
              rasterDurationP50Microseconds: 1,
              rasterDurationP95Microseconds: 2,
              rasterDurationMaxMicroseconds: 3,
              partialUpdateCount: 9,
              exceptionCount: 1,
            ),
          );

      expect(
        SceneSpikeGate.evaluate([invalid]).validationErrors,
        containsAll([
          'ios/release build duration percentiles must satisfy p50 <= p95 <= max.',
          'ios/release empty raster duration statistics must be zero.',
          'ios/release rasterDurationCount must equal frameCount.',
          'ios/release performance partialUpdateCount must equal partialUpdateCount.',
          'ios/release exceptionCount must be zero.',
        ]),
      );
    });

    test('rejects non-UTC capability timestamps', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .release,
        ),
      );
      final invalid = evidence.copyWith(
        capabilities: [
          evidence.capabilities.first.copyWith(
            observedAtUtc: DateTime(2026, 8, 2),
          ),
          ...evidence.capabilities.skip(1),
        ],
      );

      expect(
        SceneSpikeGate.evaluate([invalid]).validationErrors,
        contains(
          'android/release proceduralOrthographicMesh observedAtUtc must be '
          'UTC.',
        ),
      );
    });

    test('rejects capability timestamps outside the observation interval', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .release,
        ),
      );
      final startedAt = evidence.startedAtUtc;
      final endedAt = DateTime.fromMicrosecondsSinceEpoch(
        startedAt.microsecondsSinceEpoch + evidence.elapsedMicroseconds,
        isUtc: true,
      );
      final stale = evidence.copyWith(
        capabilities: [
          evidence.capabilities.first.copyWith(
            observedAtUtc: startedAt.subtract(const Duration(microseconds: 1)),
          ),
          ...evidence.capabilities.skip(1),
        ],
      );
      final future = evidence.copyWith(
        capabilities: [
          evidence.capabilities.first.copyWith(
            observedAtUtc: endedAt.add(const Duration(microseconds: 1)),
          ),
          ...evidence.capabilities.skip(1),
        ],
      );

      expect(
        SceneSpikeGate.evaluate([stale]).validationErrors,
        contains(
          'android/release proceduralOrthographicMesh observedAtUtc must be '
          'within the observation interval.',
        ),
      );
      expect(
        SceneSpikeGate.evaluate([future]).validationErrors,
        contains(
          'android/release proceduralOrthographicMesh observedAtUtc must be '
          'within the observation interval.',
        ),
      );
    });

    test('reports missing required capabilities without throwing', () {
      final evidence = sceneSpikeFixture
          .evidence(
            run: const SceneSpikeRunKey(
              platform: .ios,
              buildMode: .profile,
            ),
          )
          .copyWith(capabilities: const []);

      final decision = SceneSpikeGate.evaluate([evidence]);

      expect(decision.validationErrors, hasLength(11));
      expect(decision.isPass, isFalse);
    });
  });

  group('SceneSpikeGate deterministic evidence', () {
    test('sorts every decision list independently of input order', () {
      final forward = sceneSpikeFixture.fourRuns();
      final reverse = forward.reversed
          .map(
            (evidence) => evidence.copyWith(
              capabilities: evidence.capabilities.reversed.toList(),
            ),
          )
          .toList();

      final forwardJson = jsonEncode(SceneSpikeGate.evaluate(forward).toJson());
      final reverseJson = jsonEncode(SceneSpikeGate.evaluate(reverse).toJson());

      expect(reverseJson, forwardJson);
    });

    test('round trips evidence and gate decision through JSON', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .profile,
        ),
      );
      final evidenceJson = jsonDecode(jsonEncode(evidence.toJson()));
      final restoredEvidence = SceneSpikeEvidence.fromJson(
        evidenceJson as Map<String, dynamic>,
      );
      final decision = SceneSpikeGate.evaluate(sceneSpikeFixture.fourRuns());
      final decisionJson = jsonDecode(jsonEncode(decision.toJson()));
      final restoredDecision = SceneSpikeGateDecision.fromJson(
        decisionJson as Map<String, dynamic>,
      );

      expect(restoredEvidence, evidence);
      expect(restoredDecision, decision);
    });

    test('freezed lists cannot be mutated from outside', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .ios,
          buildMode: .profile,
        ),
      );
      final decision = SceneSpikeGate.evaluate([evidence]);

      expect(
        () => evidence.capabilities.add(evidence.capabilities.first),
        throwsUnsupportedError,
      );
      expect(
        () => decision.validationErrors.add('mutated'),
        throwsUnsupportedError,
      );
    });

    test('copies evidence lists at constructor and copyWith boundaries', () {
      final constructorCapabilities = sceneSpikeFixture.capabilities();
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .ios,
          buildMode: .profile,
        ),
        capabilities: constructorCapabilities,
      );
      constructorCapabilities.clear();
      final copyWithCapabilities = sceneSpikeFixture.capabilities();
      final copied = evidence.copyWith(capabilities: copyWithCapabilities);
      copyWithCapabilities.clear();

      expect(evidence.capabilities, hasLength(11));
      expect(copied.capabilities, hasLength(11));
    });

    test('copies every gate decision list at public boundaries', () {
      final missingRuns = <SceneSpikeRunKey>[
        const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
      ];
      final failedCapabilities = <SceneSpikeCapabilityFinding>[];
      final unobservedCapabilities = <SceneSpikeCapabilityFinding>[];
      final validationErrors = <String>['original validation'];
      final revisionMismatches = <String>['original revision'];
      final decision = SceneSpikeGateDecision(
        isPass: false,
        missingRuns: missingRuns,
        failedCapabilities: failedCapabilities,
        unobservedCapabilities: unobservedCapabilities,
        validationErrors: validationErrors,
        revisionMismatches: revisionMismatches,
      );
      missingRuns.clear();
      failedCapabilities.add(
        SceneSpikeCapabilityFinding(
          run: const SceneSpikeRunKey(
            platform: .ios,
            buildMode: .profile,
          ),
          result: sceneSpikeFixture.capabilities().first,
        ),
      );
      unobservedCapabilities.add(failedCapabilities.single);
      validationErrors.clear();
      revisionMismatches.clear();

      expect(decision.missingRuns, hasLength(1));
      expect(decision.failedCapabilities, isEmpty);
      expect(decision.unobservedCapabilities, isEmpty);
      expect(decision.validationErrors, ['original validation']);
      expect(decision.revisionMismatches, ['original revision']);

      final copiedMissingRuns = <SceneSpikeRunKey>[];
      final copiedFailedCapabilities = <SceneSpikeCapabilityFinding>[];
      final copiedUnobservedCapabilities = <SceneSpikeCapabilityFinding>[];
      final copiedValidationErrors = <String>['copied validation'];
      final copiedRevisionMismatches = <String>['copied revision'];
      final copied = decision.copyWith(
        missingRuns: copiedMissingRuns,
        failedCapabilities: copiedFailedCapabilities,
        unobservedCapabilities: copiedUnobservedCapabilities,
        validationErrors: copiedValidationErrors,
        revisionMismatches: copiedRevisionMismatches,
      );
      copiedMissingRuns.add(
        const SceneSpikeRunKey(platform: .android, buildMode: .release),
      );
      copiedFailedCapabilities.add(failedCapabilities.single);
      copiedUnobservedCapabilities.add(failedCapabilities.single);
      copiedValidationErrors.clear();
      copiedRevisionMismatches.clear();

      expect(copied.missingRuns, isEmpty);
      expect(copied.failedCapabilities, isEmpty);
      expect(copied.unobservedCapabilities, isEmpty);
      expect(copied.validationErrors, ['copied validation']);
      expect(copied.revisionMismatches, ['copied revision']);
    });

    test('fromJson does not retain caller-owned JSON lists', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .profile,
        ),
      );
      final evidenceJson = evidence.toJson();
      final restoredEvidence = SceneSpikeEvidence.fromJson(evidenceJson);
      final capabilityJson =
          evidenceJson['capabilities'] as List<Map<String, dynamic>>;
      capabilityJson.clear();

      final decision = SceneSpikeGate.evaluate(sceneSpikeFixture.fourRuns());
      final decisionJson = decision.toJson();
      decisionJson['validationErrors'] = <String>[];
      final restoredDecision = SceneSpikeGateDecision.fromJson(decisionJson);
      final missingRunJson =
          decisionJson['missingRuns'] as List<Map<String, dynamic>>;
      final validationJson = decisionJson['validationErrors'] as List<String>;
      missingRunJson.add(
        const SceneSpikeRunKey(
          platform: .android,
          buildMode: .release,
        ).toJson(),
      );
      validationJson.add('caller mutation');

      expect(restoredEvidence.capabilities, hasLength(11));
      expect(restoredDecision.missingRuns, isEmpty);
      expect(restoredDecision.validationErrors, isEmpty);
    });
  });

  group('SceneSpike JSON integer contract', () {
    test('rejects fractional schema counters and duration statistics', () {
      final evidence = sceneSpikeFixture.evidence(
        run: const SceneSpikeRunKey(
          platform: .android,
          buildMode: .profile,
        ),
      );
      final fractionalSchema = evidence.toJson()..['schemaVersion'] = 1.5;
      final fractionalCounter = evidence.toJson()..['frameCount'] = -0.5;
      final fractionalDuration = evidence.toJson();
      final performanceJson =
          fractionalDuration['performance'] as Map<String, dynamic>;
      performanceJson['buildDurationP95Microseconds'] = 1.5;

      expect(
        () => SceneSpikeEvidence.fromJson(fractionalSchema),
        throwsFormatException,
      );
      expect(
        () => SceneSpikeEvidence.fromJson(fractionalCounter),
        throwsFormatException,
      );
      expect(
        () => SceneSpikeEvidence.fromJson(fractionalDuration),
        throwsFormatException,
      );
    });
  });

  group('SceneSpikePerformanceAccumulator', () {
    test('empty snapshot contains only zero counters and durations', () {
      final accumulator = SceneSpikePerformanceAccumulator(sampleCapacity: 4);

      expect(
        accumulator.snapshot(),
        const SceneSpikePerformanceSnapshot(
          buildDurationCount: 0,
          buildDurationMaxMicroseconds: 0,
          buildDurationP50Microseconds: 0,
          buildDurationP95Microseconds: 0,
          rasterDurationCount: 0,
          rasterDurationMaxMicroseconds: 0,
          rasterDurationP50Microseconds: 0,
          rasterDurationP95Microseconds: 0,
          droppedFrameCount: 0,
          partialUpdateCount: 0,
          resourceRebuildCount: 0,
          exceptionCount: 0,
        ),
      );
    });

    test('computes nearest-rank p50 p95 and global max', () {
      final accumulator = SceneSpikePerformanceAccumulator(sampleCapacity: 20);
      for (var sample = 1; sample <= 20; sample += 1) {
        accumulator.recordFrameTiming(
          buildDurationMicroseconds: sample,
          rasterDurationMicroseconds: sample * 10,
          wasDropped: false,
        );
      }

      final snapshot = accumulator.snapshot();

      expect(snapshot.buildDurationCount, 20);
      expect(snapshot.buildDurationP50Microseconds, 10);
      expect(snapshot.buildDurationP95Microseconds, 19);
      expect(snapshot.buildDurationMaxMicroseconds, 20);
      expect(snapshot.rasterDurationP50Microseconds, 100);
      expect(snapshot.rasterDurationP95Microseconds, 190);
      expect(snapshot.rasterDurationMaxMicroseconds, 200);
    });

    test(
      'retains only bounded recent samples while preserving total count',
      () {
        final accumulator = SceneSpikePerformanceAccumulator(sampleCapacity: 2);
        accumulator.recordFrameTiming(
          buildDurationMicroseconds: 1,
          rasterDurationMicroseconds: 10,
          wasDropped: false,
        );
        accumulator.recordFrameTiming(
          buildDurationMicroseconds: 100,
          rasterDurationMicroseconds: 1000,
          wasDropped: false,
        );
        accumulator.recordFrameTiming(
          buildDurationMicroseconds: 200,
          rasterDurationMicroseconds: 2000,
          wasDropped: true,
        );

        final snapshot = accumulator.snapshot();

        expect(snapshot.buildDurationCount, 3);
        expect(snapshot.buildDurationP50Microseconds, 100);
        expect(snapshot.buildDurationP95Microseconds, 200);
        expect(snapshot.buildDurationMaxMicroseconds, 200);
        expect(snapshot.droppedFrameCount, 1);
      },
    );

    test('counts observation events without allocating snapshot models', () {
      final SceneSpikePerformanceSink sink = SceneSpikePerformanceAccumulator(
        sampleCapacity: 1,
      );
      sink.recordPartialUpdate();
      sink.recordResourceRebuild();
      sink.recordException();

      final snapshot = sink.snapshot();

      expect(snapshot.partialUpdateCount, 1);
      expect(snapshot.resourceRebuildCount, 1);
      expect(snapshot.exceptionCount, 1);
    });

    test('rejects non-positive capacity and negative frame durations', () {
      expect(
        () => SceneSpikePerformanceAccumulator(sampleCapacity: 0),
        throwsArgumentError,
      );
      final accumulator = SceneSpikePerformanceAccumulator(sampleCapacity: 1);
      expect(
        () => accumulator.recordFrameTiming(
          buildDurationMicroseconds: -1,
          rasterDurationMicroseconds: 0,
          wasDropped: false,
        ),
        throwsRangeError,
      );
      expect(accumulator.snapshot().buildDurationCount, 0);
    });
  });
}

const sceneSpikeFixture = SceneSpikeFixture();

class SceneSpikeFixture {
  const SceneSpikeFixture();

  List<SceneSpikeEvidence> fourRuns() => [
    evidence(
      run: const SceneSpikeRunKey(platform: .ios, buildMode: .profile),
    ),
    evidence(
      run: const SceneSpikeRunKey(platform: .ios, buildMode: .release),
    ),
    evidence(
      run: const SceneSpikeRunKey(platform: .android, buildMode: .profile),
    ),
    evidence(
      run: const SceneSpikeRunKey(platform: .android, buildMode: .release),
    ),
  ];

  SceneSpikeEvidence evidence({
    required SceneSpikeRunKey run,
    SceneSpikeCapabilityStatus blockedCapabilityStatus =
        SceneSpikeCapabilityStatus.unobserved,
    List<SceneSpikeCapabilityResult>? capabilities,
  }) => SceneSpikeEvidence(
    schemaVersion: SceneSpikeEvidenceContract.schemaVersion,
    run: run,
    deviceModel: 'Test Device',
    operatingSystemVersion: 'Test OS 1.0',
    flutterFrameworkRevision:
        SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
    flutterEngineRevision:
        SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
    dartVersion: '3.14.0-29.0.dev',
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
    appResourceGeneration: 1,
    capabilities:
        capabilities ?? this.capabilities(status: blockedCapabilityStatus),
    performance: performance(),
  );

  List<SceneSpikeCapabilityResult> capabilities({
    SceneSpikeCapabilityStatus status = SceneSpikeCapabilityStatus.unobserved,
  }) => SceneSpikeCapability.values
      .map(
        (capability) => capabilityResult(
          capability: capability,
          blockedCapabilityStatus: status,
        ),
      )
      .toList();

  SceneSpikeCapabilityResult capabilityResult({
    required SceneSpikeCapability capability,
    required SceneSpikeCapabilityStatus blockedCapabilityStatus,
  }) {
    final isBlocked = switch (capability) {
      .explicitResourceDisposal ||
      .contextResourceRebuild ||
      .gpuCompletionOrSafeRetirement => true,
      _ => false,
    };
    final provenance = switch (capability) {
      .partialPositionAndColorUpdate ||
      .backgroundAndForeground ||
      .disposeAndRemount => SceneSpikeObservationProvenance.runtimeSignal,
      .explicitResourceDisposal ||
      .contextResourceRebuild ||
      .gpuCompletionOrSafeRetirement =>
        SceneSpikeObservationProvenance.unavailablePublicApi,
      _ => SceneSpikeObservationProvenance.operatorAttestation,
    };
    return SceneSpikeCapabilityResult(
      capability: capability,
      status: isBlocked ? blockedCapabilityStatus : .passed,
      provenance: provenance,
      detail: isBlocked
          ? 'Flutter Scene has no required public API.'
          : 'Observed with the required evidence source.',
      observedAtUtc: DateTime.utc(2026, 8, 2, 0, 0, 1),
    );
  }

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
