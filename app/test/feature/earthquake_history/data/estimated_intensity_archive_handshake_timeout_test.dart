import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_io_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_handshake_timeout_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('connect timeoutはtyped failureにしてclientとpartをcleanupする', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(response: response);
    final client = RecordingEstimatedIntensityHttpClient(
      request: request,
      openResponse: Completer<HttpClientRequest>().future,
    );

    final result = await downloadWithIoClient(
      temporaryDirectory: temporaryDirectory,
      client: client,
      connectTimeout: const Duration(milliseconds: 10),
      headerTimeout: const Duration(seconds: 1),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(client.closeForce, isTrue);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('header timeoutはrequestをabortしてclientとpartをcleanupする', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(
      response: response,
      closeResponse: Completer<HttpClientResponse>().future,
    );
    final client = RecordingEstimatedIntensityHttpClient(request: request);

    final result = await downloadWithIoClient(
      temporaryDirectory: temporaryDirectory,
      client: client,
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(milliseconds: 10),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(request.abortCount, 1);
    expect(client.closeForce, isTrue);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}

Future<EstimatedIntensityArchiveDownloadResult> downloadWithIoClient({
  required Directory temporaryDirectory,
  required RecordingEstimatedIntensityHttpClient client,
  required Duration connectTimeout,
  required Duration headerTimeout,
}) =>
    EstimatedIntensityArchiveHttpDataSource(
      operationFactory: () =>
          DartIoEstimatedIntensityArchiveHttpOperation(client: client),
    ).download(
      descriptor: estimatedIntensityTestDescriptor(),
      temporaryDirectory: temporaryDirectory,
      limits: EstimatedIntensityArchiveDownloadLimits(
        maxArchiveBytes: 1024,
        connectTimeout: connectTimeout,
        headerTimeout: headerTimeout,
        idleTimeout: const Duration(seconds: 1),
        totalTimeout: const Duration(seconds: 2),
      ),
    );
