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
}
