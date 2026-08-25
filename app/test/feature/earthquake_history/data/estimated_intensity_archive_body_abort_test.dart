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
      'estimated_intensity_body_abort_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('dart:io body待機中cancelはrequest abortでsettleしてcleanupする', () async {
    final listened = Completer<void>();
    final body = StreamController<List<int>>(
      onListen: listened.complete,
    );
    Future<void>? bodyClosed;
    final response = RecordingEstimatedIntensityHttpResponse(body: body.stream);
    final request = RecordingEstimatedIntensityHttpRequest(
      response: response,
      onAbort: () {
        if (!body.isClosed) {
          body.addError(const HttpException('aborted'));
          bodyClosed = body.close();
        }
      },
    );
    final client = RecordingEstimatedIntensityHttpClient(request: request);
    final cancellation = EstimatedIntensityArchiveDownloadCancellation();
    final resultFuture = downloadWithCancellation(
      temporaryDirectory: temporaryDirectory,
      client: client,
      cancellation: cancellation,
    );
    await listened.future.timeout(
      const Duration(seconds: 2),
      onTimeout: () => throw StateError('body was not listened'),
    );
    await cancellation.cancel().timeout(
      const Duration(seconds: 2),
      onTimeout: () => throw StateError('cancel did not settle'),
    );
    final result = await resultFuture.timeout(
      const Duration(seconds: 2),
      onTimeout: () => throw StateError('download did not settle'),
    );
    await bodyClosed?.timeout(
      const Duration(seconds: 2),
      onTimeout: () => throw StateError('body close did not settle'),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.cancelled,
    );
    expect(request.abortCount, 1);
    expect(client.closeForce, isTrue);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}
