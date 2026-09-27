import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'dart_api_compiler_test_support.dart';

void main() {
  test(
    'unchecked descriptor construction is not part of the public API',
    () async {
      final temporaryDirectory = await Directory.systemTemp.createTemp(
        'estimated_intensity_descriptor_api_',
      );
      addTearDown(() => temporaryDirectory.delete(recursive: true));
      final compiler = DartApiCompiler.resolve();
      final controlResult = await compiler.compile(
        directory: temporaryDirectory,
        name: 'control',
        source: '''
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';

void main() {
  const validator = EstimatedIntensityArchiveDescriptorValidator();
  final result = validator.validate(
    eventId: '20260823020050',
    input: null,
    policy: EstimatedIntensityArchiveUrlPolicy(
      allowedHosts: const {'tiles.example.test'},
      maxArchiveBytes: 1,
    ),
  );
  if (result is! EstimatedIntensityArchiveValidationMissing) {
    throw StateError('unexpected public API result');
  }
}
''',
      );
      final controlDiagnostics =
          '${controlResult.stdout}\n${controlResult.stderr}';
      expect(controlResult.exitCode, 0, reason: controlDiagnostics);

      final result = await compiler.compile(
        directory: temporaryDirectory,
        name: 'unchecked',
        source:
            '''
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';

void main() {
  EstimatedIntensityArchiveDescriptor(
    eventId: '20260823020050',
    url: Uri.parse(
      'https://tiles.example.test/ixac41/20260823020050/'
      '${'a' * 64}.pmtiles',
    ),
    sizeBytes: 1,
    sha256: '${'a' * 64}',
  );
}
''',
      );
      final diagnostics = '${result.stdout}\n${result.stderr}';

      expect(result.exitCode, isNot(0), reason: diagnostics);
      expect(
        diagnostics,
        anyOf(
          contains(
            "Couldn't find constructor 'EstimatedIntensityArchiveDescriptor'",
          ),
          contains(
            "Member not found: 'EstimatedIntensityArchiveDescriptor.new'",
          ),
        ),
      );
    },
  );
}
