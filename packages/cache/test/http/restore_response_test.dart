import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('restoreResponse', () {
    test('restores JSON response with status 200', () {
      final options = RequestOptions(path: '/test');
      final entry = HttpCacheEntry(
        key: 'test-key',
        statusCode: 200,
        eTag: 'W/"v1"',
        headers: {
          'content-type': ['application/json'],
        },
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{"key":"value"}')),
        updatedAtMs: 0,
      );

      final response = restoreResponse(options, entry);

      expect(response.statusCode, 200);
      expect(response.data, {'key': 'value'});
      expect(response.requestOptions, options);
      expect(response.headers.map, entry.headers);
    });

    test('restores plain text response', () {
      final options = RequestOptions(path: '/test');
      final entry = HttpCacheEntry(
        key: 'test-key',
        statusCode: 200,
        eTag: null,
        headers: {
          'content-type': ['text/plain'],
        },
        responseType: 'plain',
        body: Uint8List.fromList(utf8.encode('hello')),
        updatedAtMs: 0,
      );

      final response = restoreResponse(options, entry);

      expect(response.statusCode, 200);
      expect(response.data, 'hello');
    });

    test('restores bytes response', () {
      final options = RequestOptions(path: '/test');
      final body = Uint8List.fromList([1, 2, 3]);
      final entry = HttpCacheEntry(
        key: 'test-key',
        statusCode: 200,
        eTag: null,
        headers: {},
        responseType: 'bytes',
        body: body,
        updatedAtMs: 0,
      );

      final response = restoreResponse(options, entry);

      expect(response.statusCode, 200);
      expect(response.data, body);
    });

    test('normalizes statusCode to 200 regardless of stored value', () {
      final options = RequestOptions(path: '/test');
      final entry = HttpCacheEntry(
        key: 'test-key',
        statusCode: 304,
        eTag: null,
        headers: {},
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{}')),
        updatedAtMs: 0,
      );

      final response = restoreResponse(options, entry);

      expect(response.statusCode, 200);
    });
  });
}
