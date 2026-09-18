import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final class RecordingEstimatedIntensityHttpHeaders extends Fake
    implements HttpHeaders {
  final Map<String, List<String>> values = {};

  @override
  List<String>? operator [](String name) => values[name];

  @override
  void set(
    String name,
    covariant String value, {
    bool preserveHeaderCase = false,
  }) {
    values[name] = [value];
  }
}

final class RecordingEstimatedIntensityHttpResponse
    extends StreamView<List<int>>
    implements HttpClientResponse {
  // ignore: unnecessary_type_name_in_constructor
  factory RecordingEstimatedIntensityHttpResponse({
    int responseStatusCode = HttpStatus.ok,
    int responseContentLength = 11,
    Stream<List<int>>? body,
  }) => RecordingEstimatedIntensityHttpResponse._(
    responseStatusCode: responseStatusCode,
    responseContentLength: responseContentLength,
    body: body ?? const Stream.empty(),
  );

  // ignore: unnecessary_type_name_in_constructor
  RecordingEstimatedIntensityHttpResponse._({
    required this.responseStatusCode,
    required this.responseContentLength,
    required Stream<List<int>> body,
  }) : super(body);

  final responseHeaders = RecordingEstimatedIntensityHttpHeaders();
  final int responseStatusCode;
  final int responseContentLength;

  @override
  HttpHeaders get headers => responseHeaders;

  @override
  int get statusCode => responseStatusCode;

  @override
  int get contentLength => responseContentLength;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
