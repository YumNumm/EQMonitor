import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;
  late HttpCacheStore store;
  late Dio dio;

  setUp(() {
    db = CacheDatabase(NativeDatabase.memory());
    store = HttpCacheStore(
      db: db,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(CacheOnlyInterceptor(store));
  });

  tearDown(() => db.close());

  test('GET hit: resolves with cached response (status 200)', () async {
    final key = store.primaryKeyForUrl(
      RequestOptions(
        path: '/v1/start',
        baseUrl: 'https://v2.api.eqmonitor.app',
      ),
    );
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 200,
        eTag: 'W/"v1"',
        headers: {
          'content-type': ['application/json'],
        },
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{"data":"cached"}')),
        updatedAtMs: 0,
      ),
    );

    final response = await dio.get<dynamic>('/v1/start');

    expect(response.statusCode, 200);
    expect(response.data, {'data': 'cached'});
  });

  test('GET miss: rejects with DioException containing CacheMissException', () {
    expect(
      () => dio.get<dynamic>('/not-cached'),
      throwsA(
        isA<DioException>().having(
          (e) => e.error,
          'error',
          isA<CacheMissException>(),
        ),
      ),
    );
  });

  test('non-GET: rejects with CacheMissException', () {
    expect(
      () => dio.post<dynamic>('/v1/start'),
      throwsA(
        isA<DioException>().having(
          (e) => e.error,
          'error',
          isA<CacheMissException>(),
        ),
      ),
    );
  });

  test('isCacheMiss identifies rejection correctly', () async {
    try {
      await dio.get<dynamic>('/not-cached');
      fail('should throw');
    } on Object catch (e) {
      expect(isCacheMiss(e), isTrue);
    }
  });

  test(
    'uses same key as HttpCacheInterceptor (store.primaryKeyForUrl)',
    () async {
      // Save via HttpCacheInterceptor-compatible key
      final key = store.primaryKeyForUrl(
        RequestOptions(
          path: '/v2/earthquake/12345',
          baseUrl: 'https://v2.api.eqmonitor.app',
        ),
      );
      await store.write(
        HttpCacheEntry(
          key: key,
          statusCode: 200,
          eTag: null,
          headers: {
            'content-type': ['application/json'],
          },
          responseType: 'json',
          body: Uint8List.fromList(utf8.encode('{"id":"12345"}')),
          updatedAtMs: 0,
        ),
      );

      // Read via CacheOnlyInterceptor
      final response = await dio.get<dynamic>('/v2/earthquake/12345');
      expect(response.data, {'id': '12345'});
    },
  );

  test('query parameters produce different cache keys', () async {
    final keyWithQuery = store.primaryKeyForUrl(
      RequestOptions(
        path: '/v1/start',
        baseUrl: 'https://v2.api.eqmonitor.app',
        queryParameters: {'lang': 'ja'},
      ),
    );
    await store.write(
      HttpCacheEntry(
        key: keyWithQuery,
        statusCode: 200,
        eTag: null,
        headers: {'content-type': ['application/json']},
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{"lang":"ja"}')),
        updatedAtMs: 0,
      ),
    );

    // Request WITHOUT query param → miss (different key)
    expect(
      () => dio.get<dynamic>('/v1/start'),
      throwsA(isA<DioException>()),
    );

    // Request WITH matching query param → hit
    final response = await dio.get<dynamic>(
      '/v1/start',
      queryParameters: {'lang': 'ja'},
    );
    expect(response.data, {'lang': 'ja'});
  });

  test('restored response includes headers from cache entry', () async {
    final key = store.primaryKeyForUrl(
      RequestOptions(
        path: '/v1/start',
        baseUrl: 'https://v2.api.eqmonitor.app',
      ),
    );
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 200,
        eTag: 'W/"v1"',
        headers: {
          'content-type': ['application/json'],
          'x-custom': ['custom-value'],
        },
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{}')),
        updatedAtMs: 0,
      ),
    );

    final response = await dio.get<dynamic>('/v1/start');

    expect(response.headers.value('x-custom'), 'custom-value');
    expect(response.headers.value('content-type'), 'application/json');
  });

  test('restored response always has statusCode 200', () async {
    final key = store.primaryKeyForUrl(
      RequestOptions(
        path: '/v1/start',
        baseUrl: 'https://v2.api.eqmonitor.app',
      ),
    );
    // Even if stored with a non-200 status (shouldn't happen, but defense)
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 304,
        eTag: null,
        headers: {'content-type': ['application/json']},
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{}')),
        updatedAtMs: 0,
      ),
    );

    final response = await dio.get<dynamic>('/v1/start');
    expect(response.statusCode, 200);
  });

  test('plain text response type restores correctly', () async {
    final key = store.primaryKeyForUrl(
      RequestOptions(
        path: '/health',
        baseUrl: 'https://v2.api.eqmonitor.app',
      ),
    );
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 200,
        eTag: null,
        headers: {'content-type': ['text/plain']},
        responseType: 'plain',
        body: Uint8List.fromList(utf8.encode('OK')),
        updatedAtMs: 0,
      ),
    );

    final response = await dio.get<dynamic>('/health');
    expect(response.data, 'OK');
  });

  test('bytes response type restores correctly', () async {
    final key = store.primaryKeyForUrl(
      RequestOptions(
        path: '/image',
        baseUrl: 'https://v2.api.eqmonitor.app',
      ),
    );
    final body = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 200,
        eTag: null,
        headers: {'content-type': ['image/jpeg']},
        responseType: 'bytes',
        body: body,
        updatedAtMs: 0,
      ),
    );

    final response = await dio.get<dynamic>('/image');
    expect(response.data, body);
  });
}
