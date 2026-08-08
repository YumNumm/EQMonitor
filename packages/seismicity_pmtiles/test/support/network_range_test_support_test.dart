import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'network_range_test_support.dart';

void main() {
  test('static response records request and literal headers', () async {
    final adapter = NetworkRangeTestAdapter()
      ..enqueueResponse(
        statusCode: 206,
        body: const [1, 2],
        etag: '"v1"',
        contentRange: 'bytes 0-1/16',
      );
    final options = RequestOptions(
      path: 'https://example.com/archive.pmtiles',
    );
    final body = await adapter.fetch(options, null, null);

    expect(body.statusCode, 206);
    expect(body.headers['etag'], <String>['"v1"']);
    expect(adapter.requests, <RequestOptions>[options]);
  });

  test('failing reply preserves the nullable response status', () async {
    final adapter = NetworkRangeTestAdapter()
      ..enqueueDioFailure(statusCode: 503);
    final fetch = adapter.fetch(
      RequestOptions(path: 'https://example.com/archive.pmtiles'),
      null,
      null,
    );

    await expectLater(
      fetch,
      throwsA(
        isA<DioException>().having(
          (failure) => failure.response?.statusCode,
          'statusCode',
          503,
        ),
      ),
    );
  });

  test('failing reply omits the response without a status', () async {
    final adapter = NetworkRangeTestAdapter()
      ..enqueueDioFailure(statusCode: null);
    final fetch = adapter.fetch(
      RequestOptions(path: 'https://example.com/archive.pmtiles'),
      null,
      null,
    );

    await expectLater(
      fetch,
      throwsA(
        isA<DioException>().having(
          (failure) => failure.response,
          'response',
          isNull,
        ),
      ),
    );
  });

  test('pending response observes Dio cancellation', () async {
    final adapter = NetworkRangeTestAdapter();
    final pending = adapter.enqueuePending206(
      offset: 0,
      total: 16,
      etag: '"v1"',
    );
    final cancelled = Completer<void>();
    final fetch = adapter.fetch(
      RequestOptions(path: 'https://example.com/archive.pmtiles'),
      null,
      cancelled.future,
    );
    cancelled.complete();

    await expectLater(
      fetch,
      throwsA(
        isA<DioException>().having(
          (failure) => failure.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(pending.cancelled, isTrue);
  });
}
