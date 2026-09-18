import 'dart:async' show StreamController;
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  test('cancelは一度だけ通知してawait可能にcloseする', () async {
    final cancellation = EstimatedIntensityArchiveDownloadCancellation();
    var events = 0;
    var completed = false;
    cancellation.onCancel.listen(
      (_) => events += 1,
      onDone: () => completed = true,
    );

    await cancellation.cancel();
    await cancellation.cancel();
    await Future<void>.delayed(Duration.zero);

    expect(cancellation.isCancelled, isTrue);
    expect(events, 1);
    expect(completed, isTrue);
    await expectLater(cancellation.onCancel, emitsDone);
  });

  test('開始前cancelはHTTP operationもpartも作らない', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_precancel_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final cancellation = EstimatedIntensityArchiveDownloadCancellation();
    await cancellation.cancel();
    var operationCreated = false;

    final result =
        await EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () {
            operationCreated = true;
            return TestEstimatedIntensityArchiveHttpOperation(
              openResponse: Future.value(estimatedIntensityTestResponse()),
            );
          },
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
          cancellation: cancellation,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.cancelled,
    );
    expect(operationCreated, isFalse);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('stream中cancelはrequestをabortしてpartを消す', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_cancel_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final body = StreamController<List<int>>();
    addTearDown(body.close);
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(
        estimatedIntensityTestResponse(contentLength: -1, body: body.stream),
      ),
    );
    operation.onAbort = () => body.addError(StateError('aborted'));
    final cancellation = EstimatedIntensityArchiveDownloadCancellation();
    final resultFuture =
        EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
          cancellation: cancellation,
        );
    body.add('hello'.codeUnits);

    await cancellation.cancel();
    final result = await resultFuture;

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.cancelled,
    );
    expect(operation.abortCount, greaterThanOrEqualTo(1));
    expect(operation.closeCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}
