import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_abort_test_support.dart';
import 'estimated_intensity_archive_io_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_abort_settlement_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('dart:io open待機中cancelはclient closeでsettleしてcleanupする', () async {
    final openResponse = Completer<HttpClientRequest>();
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(response: response);
    final client = RecordingEstimatedIntensityHttpClient(
      request: request,
      openResponse: openResponse.future,
      onClose: () {
        if (!openResponse.isCompleted) {
          openResponse.completeError(const HttpException('aborted'));
        }
      },
    );
    final cancellation = EstimatedIntensityArchiveDownloadCancellation();
    final resultFuture = downloadWithCancellation(
      temporaryDirectory: temporaryDirectory,
      client: client,
      cancellation: cancellation,
    );
    await client.opened.future;

    await cancellation.cancel();
    final result = await resultFuture;

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.cancelled,
    );
    expect(client.closeForce, isTrue);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

}
