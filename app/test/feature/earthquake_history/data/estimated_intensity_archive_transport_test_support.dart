import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

export 'estimated_intensity_archive_transport_descriptor_test_support.dart';

EstimatedIntensityArchiveHttpResponse estimatedIntensityTestResponse({
  int statusCode = 200,
  List<String> contentEncodings = const [],
  int contentLength = 11,
  Stream<List<int>>? body,
}) => EstimatedIntensityArchiveHttpResponse(
  statusCode: statusCode,
  contentEncodings: contentEncodings,
  contentLength: contentLength,
  body: body ?? Stream.value('hello world'.codeUnits),
);

final class TestEstimatedIntensityArchiveHttpOperation
    implements EstimatedIntensityArchiveHttpOperation {
  new({required this.openResponse});

  final Future<EstimatedIntensityArchiveHttpResponse> openResponse;
  final Completer<void> opened = Completer<void>();
  Uri? openedUrl;
  Duration? connectTimeout;
  Duration? headerTimeout;
  var abortCount = 0;
  var closeCount = 0;
  void Function()? onAbort;

  @override
  Future<EstimatedIntensityArchiveHttpResponse> open({
    required Uri url,
    required Duration connectTimeout,
    required Duration headerTimeout,
  }) {
    openedUrl = url;
    this.connectTimeout = connectTimeout;
    this.headerTimeout = headerTimeout;
    if (!opened.isCompleted) {
      opened.complete();
    }
    return openResponse;
  }

  @override
  void abort() {
    abortCount += 1;
    onAbort?.call();
  }

  @override
  void close() {
    closeCount += 1;
  }
}

void expectEstimatedIntensityDownloadFailure({
  required EstimatedIntensityArchiveDownloadResult result,
  required EstimatedIntensityArchiveDownloadFailure failure,
}) {
  expect(
    result,
    isA<EstimatedIntensityArchiveDownloadRejected>().having(
      (value) => value.failure,
      'failure',
      failure,
    ),
  );
}
