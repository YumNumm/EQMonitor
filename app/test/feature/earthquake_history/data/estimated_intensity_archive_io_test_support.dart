import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

export 'estimated_intensity_archive_http_response_test_support.dart';
import 'estimated_intensity_archive_http_response_test_support.dart';

final class RecordingEstimatedIntensityHttpRequest extends Fake
    implements HttpClientRequest {
  new({
    required RecordingEstimatedIntensityHttpResponse response,
    Future<HttpClientResponse>? closeResponse,
    this.onAbort,
  }) : closeResponse = closeResponse ?? Future.value(response);

  final Future<HttpClientResponse> closeResponse;
  final void Function()? onAbort;
  final requestHeaders = RecordingEstimatedIntensityHttpHeaders();
  bool? recordedFollowRedirects;
  int? recordedMaxRedirects;
  var abortCount = 0;

  @override
  HttpHeaders get headers => requestHeaders;

  @override
  set followRedirects(bool value) => recordedFollowRedirects = value;

  @override
  set maxRedirects(int value) => recordedMaxRedirects = value;

  @override
  Future<HttpClientResponse> close() => closeResponse;

  @override
  void abort([
    covariant String? exception,
    StackTrace? stackTrace,
  ]) {
    abortCount += 1;
    onAbort?.call();
  }
}

final class RecordingEstimatedIntensityHttpClient extends Fake
    implements HttpClient {
  new({
    required RecordingEstimatedIntensityHttpRequest request,
    Future<HttpClientRequest>? openResponse,
    this.onClose,
  }) : openResponse = openResponse ?? Future.value(request);

  final Future<HttpClientRequest> openResponse;
  final void Function()? onClose;
  final Completer<void> opened = Completer<void>();
  bool? recordedAutoUncompress;
  Duration? recordedConnectionTimeout;
  String? openedMethod;
  Uri? openedUrl;
  bool? closeForce;

  @override
  set autoUncompress(bool value) => recordedAutoUncompress = value;

  @override
  set connectionTimeout(Duration? value) => recordedConnectionTimeout = value;

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async {
    openedMethod = method;
    openedUrl = url;
    if (!opened.isCompleted) {
      opened.complete();
    }
    return openResponse;
  }

  @override
  void close({bool force = false}) {
    closeForce = force;
    onClose?.call();
  }
}
