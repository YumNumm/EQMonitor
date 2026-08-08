import 'dart:async';
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

  void enqueueDioFailure({required int? statusCode}) {
    _responses.add(FailingNetworkRangeReply(statusCode: statusCode));
  }

  PendingRangeResponse enqueuePending206({
    required int offset,
    required int total,
    required String? etag,
  }) {
    final response = PendingRangeResponse(
      offset: offset,
      total: total,
      etag: etag,
    );
    _responses.add(response);
    return response;
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

final class FailingNetworkRangeReply implements NetworkRangeReply {
  const FailingNetworkRangeReply({required this.statusCode});

  final int? statusCode;

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) async {
    throw DioException(
      requestOptions: options,
      response: switch (statusCode) {
        final value? => Response<void>(
          requestOptions: options,
          statusCode: value,
        ),
        null => null,
      },
    );
  }
}

final class PendingRangeResponse implements NetworkRangeReply {
  PendingRangeResponse({
    required this.offset,
    required this.total,
    required this.etag,
  });

  final int offset;
  final int total;
  final String? etag;
  final _bytes = Completer<List<int>>();
  var _cancelled = false;

  bool get cancelled => _cancelled;

  void complete(List<int> bytes) {
    _bytes.complete(bytes);
  }

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) {
    final response = _bytes.future.then<ResponseBody>(
      (bytes) => StaticNetworkRangeReply(
        statusCode: 206,
        body: bytes,
        etag: etag,
        contentRange: 'bytes $offset-${offset + bytes.length - 1}/$total',
      ).resolve(options: options, cancelFuture: cancelFuture),
    );
    final cancellation = switch (cancelFuture) {
      final future? => future.then<ResponseBody>((_) {
        _cancelled = true;
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
        );
      }),
      null => null,
    };

    return Future.any(<Future<ResponseBody>>[
      response,
      ?cancellation,
    ]);
  }
}
