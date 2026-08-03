import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:json_annotation/json_annotation.dart';

class SceneSpikeEvidenceValidationResult {
  const SceneSpikeEvidenceValidationResult({
    required this.processExitCode,
    required this.decision,
    required this.canonicalJson,
  });

  final int processExitCode;
  final SceneSpikeGateDecision decision;
  final String canonicalJson;
}

SceneSpikeEvidenceValidationResult validateSceneSpikeEvidence({
  required Directory directory,
}) {
  if (!directory.existsSync()) {
    return sceneSpikeEvidenceValidationResult(
      evidence: const [],
      validationErrors: [
        'Evidence directory does not exist: ${directory.path}',
      ],
    );
  }

  final List<FileSystemEntity> entities;
  try {
    entities = directory.listSync(followLinks: false);
  } on FileSystemException {
    return sceneSpikeEvidenceValidationResult(
      evidence: const [],
      validationErrors: [
        'Evidence directory could not be read: ${directory.path}',
      ],
    );
  }
  final files =
      entities
          .whereType<File>()
          .where((file) => file.path.endsWith('.json'))
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));
  final evidence = <SceneSpikeEvidence>[];
  final validationErrors = <String>[];

  for (final file in files) {
    try {
      final decoded = jsonDecode(file.readAsStringSync());
      if (decoded is! Map<String, dynamic>) {
        validationErrors.add(
          'Evidence file must contain a JSON object: '
          '${file.uri.pathSegments.last}',
        );
        continue;
      }
      evidence.add(SceneSpikeEvidence.fromJson(decoded));
    } on FileSystemException {
      validationErrors.add(
        'Evidence file could not be read: ${file.uri.pathSegments.last}',
      );
    } on FormatException {
      validationErrors.add(
        'Evidence file is malformed: ${file.uri.pathSegments.last}',
      );
    } on CheckedFromJsonException {
      validationErrors.add(
        'Evidence file has an invalid field: ${file.uri.pathSegments.last}',
      );
      // Generated casts report invalid untrusted JSON as TypeError.
      // ignore: avoid_catching_errors
    } on TypeError {
      validationErrors.add(
        'Evidence file has an invalid field: ${file.uri.pathSegments.last}',
      );
      // json_serializable reports unknown enum input as ArgumentError.
      // ignore: avoid_catching_errors
    } on ArgumentError {
      validationErrors.add(
        'Evidence file has an invalid field: ${file.uri.pathSegments.last}',
      );
    }
  }

  return sceneSpikeEvidenceValidationResult(
    evidence: evidence,
    validationErrors: validationErrors,
  );
}

SceneSpikeEvidenceValidationResult sceneSpikeEvidenceValidationResult({
  required List<SceneSpikeEvidence> evidence,
  required List<String> validationErrors,
}) {
  final gateDecision = SceneSpikeGate.evaluate(evidence);
  final mergedValidationErrors = SceneSpikeGateOrdering.sortUniqueStrings([
    ...gateDecision.validationErrors,
    ...validationErrors,
  ]);
  final decision = SceneSpikeGateDecision(
    isPass: gateDecision.isPass && mergedValidationErrors.isEmpty,
    missingRuns: gateDecision.missingRuns,
    failedCapabilities: gateDecision.failedCapabilities,
    unobservedCapabilities: gateDecision.unobservedCapabilities,
    validationErrors: mergedValidationErrors,
    revisionMismatches: gateDecision.revisionMismatches,
  );
  return SceneSpikeEvidenceValidationResult(
    processExitCode: decision.isPass ? 0 : 1,
    decision: decision,
    canonicalJson: jsonEncode(decision.toJson()),
  );
}
