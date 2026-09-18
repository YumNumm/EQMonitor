import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_transport_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('exact bodyだけを検証済みidentity付き一時fileとして返す', () async {
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(estimatedIntensityTestResponse()),
    );
    final descriptor = estimatedIntensityTestDescriptor();
    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: descriptor,
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
        );

    final verified = switch (result) {
      EstimatedIntensityArchiveDownloadSuccess(:final archive) => archive,
      EstimatedIntensityArchiveDownloadRejected(:final failure) =>
        throw TestFailure('unexpected failure: $failure'),
    };
    expect(await verified.file.readAsString(), 'hello world');
    expect(verified.eventId, estimatedIntensityTestEventId);
    expect(verified.sha256, helloWorldSha256);
    expect(verified.sizeBytes, 11);
    expect(verified.toString(), isNot(contains(verified.file.path)));
    expect(verified.toString(), isNot(contains(verified.sha256)));
    expect(operation.openedUrl, descriptor.url);
    expect(operation.abortCount, 0);
    expect(operation.closeCount, 1);
  });

  test('同時に成功した一時fileはuniqueなpart pathを持つ', () async {
    Future<VerifiedEstimatedIntensityArchiveDownload> download() async {
      final result =
          await EstimatedIntensityArchiveHttpDataSource(
            operationFactory: () => TestEstimatedIntensityArchiveHttpOperation(
              openResponse: Future.value(estimatedIntensityTestResponse()),
            ),
          ).download(
            descriptor: estimatedIntensityTestDescriptor(),
            temporaryDirectory: temporaryDirectory,
            limits: estimatedIntensityTransportTestLimits,
          );
      return switch (result) {
        EstimatedIntensityArchiveDownloadSuccess(:final archive) => archive,
        EstimatedIntensityArchiveDownloadRejected(:final failure) =>
          throw TestFailure('unexpected failure: $failure'),
      };
    }

    final archives = await Future.wait([download(), download()]);
    expect(archives[0].file.path, isNot(archives[1].file.path));
    expect(
      archives.every((archive) => archive.file.path.endsWith('.part')),
      isTrue,
    );
  });
}
