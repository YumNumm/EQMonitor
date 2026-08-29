import 'dart:io';

final class EstimatedIntensityArchiveHttpResponse {
  const new({
    required this.statusCode,
    required this.contentEncodings,
    required this.contentLength,
    required this.body,
  });

  final int statusCode;
  final List<String> contentEncodings;
  final int contentLength;
  final Stream<List<int>> body;

  @override
  String toString() =>
      'EstimatedIntensityArchiveHttpResponse('
      'statusCode: $statusCode, headers: redacted)';
}

abstract interface class EstimatedIntensityArchiveHttpOperation {
  Future<EstimatedIntensityArchiveHttpResponse> open({
    required Uri url,
    required Duration connectTimeout,
    required Duration headerTimeout,
  });

  /// Pending `open`/bodyを必ずsettleさせる。cleanupはsettle後にだけ実行される。
  void abort();

  void close();
}

typedef EstimatedIntensityArchiveHttpOperationCreator =
    EstimatedIntensityArchiveHttpOperation Function();

final class EstimatedIntensityArchiveHttpOperationFactory {
  const new();

  static EstimatedIntensityArchiveHttpOperation create() =>
      DartIoEstimatedIntensityArchiveHttpOperation(client: HttpClient());
}

/// 一回のdownloadだけを所有する`dart:io` HTTP adapter。
final class DartIoEstimatedIntensityArchiveHttpOperation
    implements EstimatedIntensityArchiveHttpOperation {
  new({required this.client});

  final HttpClient client;
  HttpClientRequest? activeRequest;
  var aborted = false;

  @override
  Future<EstimatedIntensityArchiveHttpResponse> open({
    required Uri url,
    required Duration connectTimeout,
    required Duration headerTimeout,
  }) async {
    client
      ..autoUncompress = false
      ..connectionTimeout = connectTimeout;
    final request = await client.openUrl('GET', url).timeout(connectTimeout);
    activeRequest = request;
    request
      ..followRedirects = false
      ..maxRedirects = 0;
    request.headers.set(HttpHeaders.acceptEncodingHeader, 'identity');
    final response = await request.close().timeout(headerTimeout);
    return EstimatedIntensityArchiveHttpResponse(
      statusCode: response.statusCode,
      contentEncodings:
          response.headers[HttpHeaders.contentEncodingHeader] ?? const [],
      contentLength: response.contentLength,
      body: response,
    );
  }

  @override
  void abort() {
    if (aborted) {
      return;
    }
    aborted = true;
    activeRequest?.abort();
    client.close(force: true);
  }

  @override
  void close() {
    client.close(force: true);
  }
}
