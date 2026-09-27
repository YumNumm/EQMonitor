import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_download_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_size_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('Content-Lengthがなくてもexact bodyを受理する', () async {
    final result = await downloadBody(
      temporaryDirectory: temporaryDirectory,
      contentLength: -1,
      body: 'hello world'.codeUnits,
    );

    expect(result, isA<EstimatedIntensityArchiveDownloadSuccess>());
  });

  test('Content-Lengthなしのshort bodyをEOFで拒否してpartを消す', () async {
    final result = await downloadBody(
      temporaryDirectory: temporaryDirectory,
      contentLength: -1,
      body: 'hello worl'.codeUnits,
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
    );
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('descriptor sizeを超えるbodyを途中で拒否してpartを消す', () async {
    final result = await downloadBody(
      temporaryDirectory: temporaryDirectory,
      contentLength: -1,
      body: 'hello world!'.codeUnits,
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
    );
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('caller capを超えるstreamを途中で拒否する', () async {
    final descriptor = estimatedIntensityTestDescriptor(sizeBytes: 20);
    final limits = EstimatedIntensityArchiveDownloadLimits(
      maxArchiveBytes: 20,
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(seconds: 1),
      idleTimeout: const Duration(seconds: 1),
      totalTimeout: const Duration(seconds: 2),
    );
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(
        estimatedIntensityTestResponse(
          contentLength: -1,
          body: Stream.value(List.filled(21, 1)),
        ),
      ),
    );

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: descriptor,
          temporaryDirectory: temporaryDirectory,
          limits: limits,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.archiveTooLarge,
    );
    expect(operation.abortCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}
