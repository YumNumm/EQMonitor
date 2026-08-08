import 'dart:collection';
import 'dart:typed_data';

import 'package:dio/dio.dart';

sealed class NetworkRangeReply {
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  });
}

final class NetworkRangeTestAdapter implements HttpClientAdapter {
  final Queue<NetworkRangeReply> _responses = Queue<NetworkRangeReply>();
  final List<RequestOptions> requests = <RequestOptions>[];

  void enqueueResponse({
    required int statusCode,
    required List<int> body,
    String? etag,
    String? contentRange,
  }) {
    _responses.add(
      StaticNetworkRangeReply(
        statusCode: statusCode,
        body: body,
        etag: etag,
        contentRange: contentRange,
      ),
    );
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    if (_responses.isEmpty) {
      throw StateError('No queued mock response.');
    }
    return _responses.removeFirst().resolve(
      options: options,
      cancelFuture: cancelFuture,
    );
  }

  @override
  void close({bool force = false}) {}
}

final class StaticNetworkRangeReply implements NetworkRangeReply {
  const StaticNetworkRangeReply({
    required this.statusCode,
    required this.body,
    required this.etag,
    required this.contentRange,
  });

  final int statusCode;
  final List<int> body;
  final String? etag;
  final String? contentRange;

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) async {
    return ResponseBody.fromBytes(
      body,
      statusCode,
      headers: <String, List<String>>{
        if (etag case final value?) 'etag': <String>[value],
        if (contentRange case final value?) 'content-range': <String>[value],
      },
    );
  }
}
