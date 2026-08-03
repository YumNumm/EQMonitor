import 'dart:io';

import 'src/scene_spike_evidence_validator.dart';

void main(List<String> arguments) {
  final defaultEvidenceDirectory = Directory.fromUri(
    Platform.script.resolve('../example/evidence/'),
  );
  final evidenceDirectory = switch (arguments) {
    [] => defaultEvidenceDirectory,
    [final path] => Directory(path),
    _ => null,
  };
  final result = evidenceDirectory == null
      ? sceneSpikeEvidenceValidationResult(
          evidence: const [],
          validationErrors: const [
            'Expected zero or one evidence directory argument.',
          ],
        )
      : validateSceneSpikeEvidence(directory: evidenceDirectory);

  stdout.writeln(result.canonicalJson);
  exitCode = result.processExitCode;
}
