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
}
