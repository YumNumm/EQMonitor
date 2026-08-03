import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_spike_gate.freezed.dart';
part 'scene_spike_gate.g.dart';

@freezed
sealed class SceneSpikeCapabilityFinding with _$SceneSpikeCapabilityFinding {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeCapabilityFinding({
    required SceneSpikeRunKey run,
    required SceneSpikeCapabilityResult result,
  }) = _SceneSpikeCapabilityFinding;

  factory SceneSpikeCapabilityFinding.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeCapabilityFindingFromJson(json);
}

@freezed
sealed class SceneSpikeGateDecision with _$SceneSpikeGateDecision {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SceneSpikeGateDecision({
    required bool isPass,
    required List<SceneSpikeRunKey> missingRuns,
    required List<SceneSpikeCapabilityFinding> failedCapabilities,
    required List<SceneSpikeCapabilityFinding> unobservedCapabilities,
    required List<String> validationErrors,
    required List<String> revisionMismatches,
  }) = _SceneSpikeGateDecision;

  factory SceneSpikeGateDecision.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeGateDecisionFromJson(json);
}

class SceneSpikeEvidenceContract {
  const SceneSpikeEvidenceContract._();

  static const schemaVersion = 1;
  static const expectedFlutterFrameworkRevision =
      '4dacd3fc91d96262a33e5c598e17d816f0b35641';
  static const expectedFlutterEngineRevision =
      'b1e405a9c311d858bef870c472bb24c015f4bcf9';
  static const expectedFlutterSceneRevision =
      '695c954f237fabef65d49fa7199002851d2dcd88';

  static const requiredRuns = [
    SceneSpikeRunKey(platform: .ios, buildMode: .profile),
    SceneSpikeRunKey(platform: .ios, buildMode: .release),
    SceneSpikeRunKey(platform: .android, buildMode: .profile),
    SceneSpikeRunKey(platform: .android, buildMode: .release),
  ];

  static const List<SceneSpikeCapability> requiredCapabilities = [
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
  ];

  static const Set<SceneSpikeCapability> unavailablePublicApiCapabilities = {
    SceneSpikeCapability.explicitResourceDisposal,
    SceneSpikeCapability.contextResourceRebuild,
    SceneSpikeCapability.gpuCompletionOrSafeRetirement,
  };

  static SceneSpikeObservationProvenance requiredProvenance(
    SceneSpikeCapability capability,
  ) => switch (capability) {
    .partialPositionAndColorUpdate ||
    .backgroundAndForeground ||
    .disposeAndRemount => SceneSpikeObservationProvenance.runtimeSignal,
    .explicitResourceDisposal ||
    .contextResourceRebuild ||
    .gpuCompletionOrSafeRetirement =>
      SceneSpikeObservationProvenance.unavailablePublicApi,
    _ => SceneSpikeObservationProvenance.operatorAttestation,
  };
}

class SceneSpikeGate {
  const SceneSpikeGate._();

  static SceneSpikeGateDecision evaluate(List<SceneSpikeEvidence> evidence) {
    final missingRuns = SceneSpikeGateOrdering.sortRuns(
      SceneSpikeEvidenceContract.requiredRuns
          .where(
            (requiredRun) => evidence.every((item) => item.run != requiredRun),
          )
          .toList(),
    );
    final duplicateRunErrors = SceneSpikeEvidenceValidator.duplicateRunErrors(
      evidence,
    );
    final validationErrors = <String>[
      ...duplicateRunErrors,
      ...evidence.expand(SceneSpikeEvidenceValidator.validationErrors),
    ];
    final revisionMismatches = evidence
        .expand(SceneSpikeEvidenceValidator.revisionMismatches)
        .toList();
    final failedCapabilities = SceneSpikeGateOrdering.sortFindings(
      SceneSpikeGateFindingCollector.collect(
        evidence: evidence,
        status: .failed,
      ),
    );
    final unobservedCapabilities = SceneSpikeGateOrdering.sortFindings(
      SceneSpikeGateFindingCollector.collect(
        evidence: evidence,
        status: .unobserved,
      ),
    );
    final sortedValidationErrors = SceneSpikeGateOrdering.sortUniqueStrings(
      validationErrors,
    );
    final sortedRevisionMismatches = SceneSpikeGateOrdering.sortUniqueStrings(
      revisionMismatches,
    );
    final isPass =
        missingRuns.isEmpty &&
        failedCapabilities.isEmpty &&
        unobservedCapabilities.isEmpty &&
        sortedValidationErrors.isEmpty &&
        sortedRevisionMismatches.isEmpty;

    return SceneSpikeGateDecision(
      isPass: isPass,
      missingRuns: missingRuns,
      failedCapabilities: failedCapabilities,
      unobservedCapabilities: unobservedCapabilities,
      validationErrors: sortedValidationErrors,
      revisionMismatches: sortedRevisionMismatches,
    );
  }
}

class SceneSpikeGateFindingCollector {
  const SceneSpikeGateFindingCollector._();

  static List<SceneSpikeCapabilityFinding> collect({
    required List<SceneSpikeEvidence> evidence,
    required SceneSpikeCapabilityStatus status,
  }) => evidence
      .expand(
        (item) => item.capabilities
            .where(
              (result) =>
                  SceneSpikeEvidenceContract.requiredCapabilities.contains(
                    result.capability,
                  ) &&
                  result.status == status,
            )
            .map(
              (result) => SceneSpikeCapabilityFinding(
                run: item.run,
                result: result,
              ),
            ),
      )
      .toList();
}

class SceneSpikeEvidenceValidator {
  const SceneSpikeEvidenceValidator._();

  static List<String> duplicateRunErrors(List<SceneSpikeEvidence> evidence) {
    final counts = <SceneSpikeRunKey, int>{};
    for (final item in evidence) {
      counts.update(item.run, (count) => count + 1, ifAbsent: () => 1);
    }
    return counts.entries
        .where((entry) => entry.value > 1)
        .map((entry) => 'Duplicate run: ${SceneSpikeLabels.run(entry.key)}.')
        .toList();
  }

  static List<String> validationErrors(SceneSpikeEvidence evidence) => [
    ...schemaErrors(evidence),
    ...metadataErrors(evidence),
    ...revisionValidationErrors(evidence),
    ...counterErrors(evidence),
    ...performanceErrors(evidence),
    ...capabilityErrors(evidence),
  ];

  static List<String> schemaErrors(SceneSpikeEvidence evidence) {
    if (evidence.schemaVersion == SceneSpikeEvidenceContract.schemaVersion) {
      return const [];
    }
    final run = SceneSpikeLabels.run(evidence.run);
    return ['$run has unsupported schema version: ${evidence.schemaVersion}.'];
  }

  static List<String> metadataErrors(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    return [
      if (evidence.deviceModel.trim().isEmpty)
        '$prefix deviceModel must not be blank.',
      if (evidence.operatingSystemVersion.trim().isEmpty)
        '$prefix operatingSystemVersion must not be blank.',
      if (evidence.dartVersion.trim().isEmpty)
        '$prefix dartVersion must not be blank.',
      if (evidence.renderingBackend.trim().isEmpty)
        '$prefix renderingBackend must not be blank.',
      if (!evidence.startedAtUtc.isUtc) '$prefix startedAtUtc must be UTC.',
    ];
  }

  static List<String> revisionValidationErrors(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    final revisions = {
      'flutterFrameworkRevision': evidence.flutterFrameworkRevision,
      'flutterEngineRevision': evidence.flutterEngineRevision,
      'flutterSceneRevision': evidence.flutterSceneRevision,
      'eqmonitorMapRendererRevision': evidence.eqmonitorMapRendererRevision,
    };
    return [
      for (final revision in revisions.entries)
        if (!SceneSpikeRevisionValidator.isLowercaseSha(revision.value))
          '$prefix ${revision.key} must be 40 lowercase hex.',
      if (evidence.eqmonitorMapRendererCheckoutDirty)
        '$prefix renderer checkout must be clean.',
      if (evidence.revisionProvenance != .compileTimeManifest)
        '$prefix revisionProvenance must be compileTimeManifest.',
      if (evidence.renderingBackendProvenance != .operatorAttestation)
        '$prefix renderingBackendProvenance must be operatorAttestation.',
    ];
  }

  static List<String> revisionMismatches(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    final revisions = [
      (
        field: 'flutterFrameworkRevision',
        actual: evidence.flutterFrameworkRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterFrameworkRevision,
      ),
      (
        field: 'flutterEngineRevision',
        actual: evidence.flutterEngineRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterEngineRevision,
      ),
      (
        field: 'flutterSceneRevision',
        actual: evidence.flutterSceneRevision,
        expected: SceneSpikeEvidenceContract.expectedFlutterSceneRevision,
      ),
    ];
    return [
      for (final revision in revisions)
        if (revision.actual != revision.expected)
          SceneSpikeValidationMessages.revisionMismatch(
            prefix: prefix,
            field: revision.field,
            expected: revision.expected,
            actual: revision.actual,
          ),
    ];
  }

  static List<String> counterErrors(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    final counters = {
      'elapsedMicroseconds': evidence.elapsedMicroseconds,
      'frameCount': evidence.frameCount,
      'partialUpdateCount': evidence.partialUpdateCount,
      'lifecycleResumeCount': evidence.lifecycleResumeCount,
    };
    return [
      for (final counter in counters.entries)
        if (counter.value < 0) '$prefix ${counter.key} must be non-negative.',
      if (evidence.appResourceGeneration < 0)
        '$prefix appResourceGeneration must be zero or greater.',
    ];
  }

  static List<String> performanceErrors(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    final performance = evidence.performance;
    final counters = SceneSpikePerformanceValidator.counters(performance);
    final partialUpdateMismatch =
        '$prefix performance partialUpdateCount must equal '
        'partialUpdateCount.';
    return [
      for (final counter in counters.entries)
        if (counter.value < 0) '$prefix ${counter.key} must be non-negative.',
      ...SceneSpikePerformanceValidator.durationErrors(
        prefix: prefix,
        label: 'build',
        count: performance.buildDurationCount,
        p50: performance.buildDurationP50Microseconds,
        p95: performance.buildDurationP95Microseconds,
        max: performance.buildDurationMaxMicroseconds,
      ),
      ...SceneSpikePerformanceValidator.durationErrors(
        prefix: prefix,
        label: 'raster',
        count: performance.rasterDurationCount,
        p50: performance.rasterDurationP50Microseconds,
        p95: performance.rasterDurationP95Microseconds,
        max: performance.rasterDurationMaxMicroseconds,
      ),
      if (performance.buildDurationCount != evidence.frameCount)
        '$prefix buildDurationCount must equal frameCount.',
      if (performance.rasterDurationCount != evidence.frameCount)
        '$prefix rasterDurationCount must equal frameCount.',
      if (performance.droppedFrameCount > evidence.frameCount)
        '$prefix droppedFrameCount must not exceed frameCount.',
      if (performance.partialUpdateCount != evidence.partialUpdateCount)
        partialUpdateMismatch,
      if (performance.exceptionCount != 0)
        '$prefix exceptionCount must be zero.',
    ];
  }

  static List<String> capabilityErrors(SceneSpikeEvidence evidence) {
    final prefix = SceneSpikeLabels.run(evidence.run);
    final counts = <SceneSpikeCapability, int>{};
    for (final result in evidence.capabilities) {
      counts.update(
        result.capability,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    return [
      for (final capability in SceneSpikeEvidenceContract.requiredCapabilities)
        if (!counts.containsKey(capability))
          '$prefix is missing required capability: ${capability.name}.',
      for (final entry in counts.entries)
        if (entry.value > 1)
          '$prefix has duplicate capability: ${entry.key.name}.',
      for (final result in evidence.capabilities)
        ...SceneSpikeCapabilityValidator.validationErrors(
          run: evidence.run,
          result: result,
          evidence: evidence,
        ),
    ];
  }
}

class SceneSpikeCapabilityValidator {
  const SceneSpikeCapabilityValidator._();

  static List<String> validationErrors({
    required SceneSpikeRunKey run,
    required SceneSpikeCapabilityResult result,
    required SceneSpikeEvidence evidence,
  }) {
    final prefix = SceneSpikeLabels.run(run);
    final capability = result.capability;
    final requiredProvenance = SceneSpikeEvidenceContract.requiredProvenance(
      capability,
    );
    final invalidProvenance =
        '$prefix ${capability.name} does not allow '
        '${result.provenance.name} provenance.';
    final unavailableApiPass =
        '$prefix ${capability.name} cannot pass because the required Flutter '
        'Scene public API is unavailable.';
    return [
      if (result.detail.trim().isEmpty)
        '$prefix ${capability.name} detail must not be blank.',
      if (!result.observedAtUtc.isUtc)
        '$prefix ${capability.name} observedAtUtc must be UTC.',
      if (result.provenance != requiredProvenance) invalidProvenance,
      if (SceneSpikeEvidenceContract.unavailablePublicApiCapabilities.contains(
            capability,
          ) &&
          result.status == .passed)
        unavailableApiPass,
      ...runtimeSignalErrors(
        prefix: prefix,
        result: result,
        evidence: evidence,
      ),
    ];
  }

  static List<String> runtimeSignalErrors({
    required String prefix,
    required SceneSpikeCapabilityResult result,
    required SceneSpikeEvidence evidence,
  }) {
    if (result.status != .passed) {
      return const [];
    }
    final partialUpdateError =
        '$prefix partialPositionAndColorUpdate passed without a partial '
        'update runtime signal.';
    final lifecycleError =
        '$prefix backgroundAndForeground passed without a lifecycle resume '
        'runtime signal.';
    final rebuildError =
        '$prefix disposeAndRemount passed without a resource rebuild '
        'runtime signal.';
    return switch (result.capability) {
      .partialPositionAndColorUpdate when evidence.partialUpdateCount == 0 => [
        partialUpdateError,
      ],
      .backgroundAndForeground when evidence.lifecycleResumeCount == 0 => [
        lifecycleError,
      ],
      .disposeAndRemount when evidence.performance.resourceRebuildCount == 0 =>
        [
          rebuildError,
        ],
      _ => const [],
    };
  }
}

class SceneSpikePerformanceValidator {
  const SceneSpikePerformanceValidator._();

  static Map<String, int> counters(SceneSpikePerformanceSnapshot snapshot) => {
    'buildDurationCount': snapshot.buildDurationCount,
    'buildDurationMaxMicroseconds': snapshot.buildDurationMaxMicroseconds,
    'buildDurationP50Microseconds': snapshot.buildDurationP50Microseconds,
    'buildDurationP95Microseconds': snapshot.buildDurationP95Microseconds,
    'rasterDurationCount': snapshot.rasterDurationCount,
    'rasterDurationMaxMicroseconds': snapshot.rasterDurationMaxMicroseconds,
    'rasterDurationP50Microseconds': snapshot.rasterDurationP50Microseconds,
    'rasterDurationP95Microseconds': snapshot.rasterDurationP95Microseconds,
    'droppedFrameCount': snapshot.droppedFrameCount,
    'performance partialUpdateCount': snapshot.partialUpdateCount,
    'resourceRebuildCount': snapshot.resourceRebuildCount,
    'exceptionCount': snapshot.exceptionCount,
  };

  static List<String> durationErrors({
    required String prefix,
    required String label,
    required int count,
    required int p50,
    required int p95,
    required int max,
  }) => [
    if (count == 0 && (p50 != 0 || p95 != 0 || max != 0))
      '$prefix empty $label duration statistics must be zero.',
    if (count > 0 && !(p50 <= p95 && p95 <= max))
      '$prefix $label duration percentiles must satisfy p50 <= p95 <= max.',
  ];
}

class SceneSpikeRevisionValidator {
  const SceneSpikeRevisionValidator._();

  static final lowercaseShaPattern = RegExp(r'^[0-9a-f]{40}$');

  static bool isLowercaseSha(String revision) =>
      lowercaseShaPattern.hasMatch(revision);
}

class SceneSpikeValidationMessages {
  const SceneSpikeValidationMessages._();

  static String revisionMismatch({
    required String prefix,
    required String field,
    required String expected,
    required String actual,
  }) => '$prefix $field expected $expected, got $actual.';
}

class SceneSpikeGateOrdering {
  const SceneSpikeGateOrdering._();

  static List<SceneSpikeRunKey> sortRuns(List<SceneSpikeRunKey> runs) =>
      [...runs]..sort(compareRuns);

  static List<SceneSpikeCapabilityFinding> sortFindings(
    List<SceneSpikeCapabilityFinding> findings,
  ) => [...findings]..sort(compareFindings);

  static List<String> sortUniqueStrings(List<String> values) =>
      values.toSet().toList()..sort();

  static int compareRuns(SceneSpikeRunKey left, SceneSpikeRunKey right) {
    final platform = left.platform.index.compareTo(right.platform.index);
    return platform != 0
        ? platform
        : left.buildMode.index.compareTo(right.buildMode.index);
  }

  static int compareFindings(
    SceneSpikeCapabilityFinding left,
    SceneSpikeCapabilityFinding right,
  ) {
    final run = compareRuns(left.run, right.run);
    final capability = left.result.capability.index.compareTo(
      right.result.capability.index,
    );
    final status = left.result.status.index.compareTo(
      right.result.status.index,
    );
    final provenance = left.result.provenance.index.compareTo(
      right.result.provenance.index,
    );
    final detail = left.result.detail.compareTo(right.result.detail);
    final observedAt = left.result.observedAtUtc.compareTo(
      right.result.observedAtUtc,
    );
    return [
      run,
      capability,
      status,
      provenance,
      detail,
      observedAt,
    ].firstWhere((comparison) => comparison != 0, orElse: () => 0);
  }
}

class SceneSpikeLabels {
  const SceneSpikeLabels._();

  static String run(SceneSpikeRunKey run) =>
      '${run.platform.name}/${run.buildMode.name}';
}
