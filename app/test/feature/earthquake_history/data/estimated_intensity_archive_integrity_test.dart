import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart_api_compiler_test_support.dart';
import 'estimated_intensity_archive_compile_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_integrity_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('SHA-256不一致ではverified resultを発行せずpartを消す', () async {
    const wrongSha256 =
        '0000000000000000000000000000000000000000000000000000000000000000';
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(estimatedIntensityTestResponse()),
    );

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(sha256: wrongSha256),
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.sha256Mismatch,
    );
    expect(result.toString(), isNot(contains(wrongSha256)));
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('外部libraryからverified resultをunchecked生成できない', () async {
    final compiler = DartApiCompiler.resolve();
    final controlResult = await compiler.compile(
      directory: temporaryDirectory,
      name: 'control',
      source: downloadApiControlSource,
    );
    final controlDiagnostics =
        '${controlResult.stdout}\n${controlResult.stderr}';
    expect(controlResult.exitCode, 0, reason: controlDiagnostics);

    final result = await compiler.compile(
      directory: temporaryDirectory,
      name: 'unchecked',
      source: uncheckedVerifiedConstructorSource,
    );
    final diagnostics = '${result.stdout}\n${result.stderr}';

    expect(result.exitCode, isNot(0), reason: diagnostics);
    expect(
      diagnostics,
      anyOf(
        contains(
          "Couldn't find constructor "
          "'VerifiedEstimatedIntensityArchiveDownload'",
        ),
        contains(
          "Member not found: "
          "'VerifiedEstimatedIntensityArchiveDownload.new'",
        ),
      ),
    );
  });
}
