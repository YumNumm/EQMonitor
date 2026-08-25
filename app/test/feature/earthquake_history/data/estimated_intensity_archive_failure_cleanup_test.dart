import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  test('request例外の本文を保持せずclientとpartをcleanupする', () async {
    const secret =
        'https://secret.example/token/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_request_failure_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final response = Completer<EstimatedIntensityArchiveHttpResponse>();
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: response.future,
    );

    final resultFuture =
        EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
        );
    await operation.opened.future;
    response.completeError(StateError(secret));
    final result = await resultFuture;

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.requestFailed,
    );
    expect(result.toString(), isNot(contains(secret)));
    expect(operation.abortCount, 1);
    expect(operation.closeCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('書込先作成失敗はpathや例外を保持しないstorage failureにする', () async {
    final missingRoot = Directory(
      '${Directory.systemTemp.path}/missing-estimated-intensity-root/child',
    );
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(estimatedIntensityTestResponse()),
    );

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: missingRoot,
          limits: estimatedIntensityTransportTestLimits,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.storageFailure,
    );
    expect(result.toString(), isNot(contains(missingRoot.path)));
    expect(operation.abortCount, 1);
    expect(operation.closeCount, 1);
  });
}
