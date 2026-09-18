import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_timeout_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('idle timeoutはstreamをcancelしてpartを消す', () async {
    final body = StreamController<List<int>>();
    addTearDown(body.close);
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(
        estimatedIntensityTestResponse(contentLength: -1, body: body.stream),
      ),
    );
    final limits = EstimatedIntensityArchiveDownloadLimits(
      maxArchiveBytes: 1024,
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(seconds: 1),
      idleTimeout: const Duration(milliseconds: 20),
      totalTimeout: const Duration(seconds: 1),
    );

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: limits,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(operation.abortCount, 1);
    expect(operation.closeCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('total timeoutはrequestをabortしてlate streamをpublishしない', () async {
    final body = StreamController<List<int>>();
    addTearDown(body.close);
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(
        estimatedIntensityTestResponse(contentLength: -1, body: body.stream),
      ),
    );
    operation.onAbort = () => body.addError(StateError('aborted'));
    final limits = EstimatedIntensityArchiveDownloadLimits(
      maxArchiveBytes: 1024,
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(seconds: 1),
      idleTimeout: const Duration(seconds: 1),
      totalTimeout: const Duration(milliseconds: 20),
    );

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: limits,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(operation.abortCount, greaterThanOrEqualTo(1));
    expect(operation.closeCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}
