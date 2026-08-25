import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_io_test_support.dart';

void main() {
  test('dart:io adapterは自動展開とredirectを無効化しidentityを要求する', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(response: response);
    final client = RecordingEstimatedIntensityHttpClient(request: request);
    final operation = DartIoEstimatedIntensityArchiveHttpOperation(
      client: client,
    );
    final url = Uri.parse('https://tiles.example.test/archive.pmtiles');

    final opened = await operation.open(
      url: url,
      connectTimeout: const Duration(seconds: 2),
      headerTimeout: const Duration(seconds: 3),
    );

    expect(client.recordedAutoUncompress, isFalse);
    expect(client.recordedConnectionTimeout, const Duration(seconds: 2));
    expect(client.openedMethod, 'GET');
    expect(client.openedUrl, url);
    expect(request.recordedFollowRedirects, isFalse);
    expect(request.recordedMaxRedirects, 0);
    expect(
      request.requestHeaders.values[HttpHeaders.acceptEncodingHeader],
      ['identity'],
    );
    expect(opened.statusCode, HttpStatus.ok);

    operation.close();
    expect(client.closeForce, isTrue);
  });

  test('response encodingを自動展開前のheader値のまま渡す', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    response.responseHeaders.values[HttpHeaders.contentEncodingHeader] = [
      'gzip',
    ];
    final request = RecordingEstimatedIntensityHttpRequest(response: response);
    final operation = DartIoEstimatedIntensityArchiveHttpOperation(
      client: RecordingEstimatedIntensityHttpClient(request: request),
    );

    final opened = await operation.open(
      url: Uri.parse('https://tiles.example.test/archive.pmtiles'),
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(seconds: 1),
    );

    expect(opened.contentEncodings, ['gzip']);
  });

  test('connect timeoutをcaller指定値で強制する', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(response: response);
    final client = RecordingEstimatedIntensityHttpClient(
      request: request,
      openResponse: Completer<HttpClientRequest>().future,
    );
    final operation = DartIoEstimatedIntensityArchiveHttpOperation(
      client: client,
    );

    await expectLater(
      operation.open(
        url: Uri.parse('https://tiles.example.test/archive.pmtiles'),
        connectTimeout: const Duration(milliseconds: 10),
        headerTimeout: const Duration(seconds: 1),
      ),
      throwsA(isA<TimeoutException>()),
    );
  });

  test('header timeoutをcaller指定値で強制する', () async {
    final response = RecordingEstimatedIntensityHttpResponse();
    final request = RecordingEstimatedIntensityHttpRequest(
      response: response,
      closeResponse: Completer<HttpClientResponse>().future,
    );
    final operation = DartIoEstimatedIntensityArchiveHttpOperation(
      client: RecordingEstimatedIntensityHttpClient(request: request),
    );

    await expectLater(
      operation.open(
        url: Uri.parse('https://tiles.example.test/archive.pmtiles'),
        connectTimeout: const Duration(seconds: 1),
        headerTimeout: const Duration(milliseconds: 10),
      ),
      throwsA(isA<TimeoutException>()),
    );
  });
}
