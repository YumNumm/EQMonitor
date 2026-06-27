import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late CacheDatabase db;
  late HttpCacheStore store;

  setUp(() {
    db = CacheDatabase(NativeDatabase.memory());
    store = HttpCacheStore(
      db: db,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
  });

  tearDown(() => db.close());

  group('HttpCacheInterceptor with kForceFreshExtra', () {
    test('skips if-none-match when forceFresh flag is set', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
        ..interceptors.add(HttpCacheInterceptor(store));

      // Seed cache with ETag
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
          eTag: 'W/"old"',
          headers: {
            'content-type': ['application/json'],
          },
          responseType: 'json',
          body: Uint8List.fromList(utf8.encode('{"old":true}')),
          updatedAtMs: 0,
        ),
      );

      // Capture the request after HttpCacheInterceptor processes it
      RequestOptions? capturedOptions;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {'fresh': true},
                headers: Headers.fromMap({
                  'etag': ['W/"fresh"'],
                  'content-type': ['application/json'],
                }),
              ),
            );
          },
        ),
      );

      await dio.get<dynamic>(
        '/v1/start',
        options: Options(extra: {kForceFreshExtra: true}),
      );

      expect(capturedOptions!.headers['if-none-match'], isNull);
    });

    test('sends if-none-match normally without forceFresh flag', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
        ..interceptors.add(HttpCacheInterceptor(store));

      // Seed cache
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
          body: Uint8List.fromList(utf8.encode('{"data":1}')),
          updatedAtMs: 0,
        ),
      );

      RequestOptions? capturedOptions;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 304,
                headers: Headers.fromMap({
                  'etag': ['W/"v1"'],
                }),
              ),
            );
          },
        ),
      );

      await dio.get<dynamic>('/v1/start');

      expect(capturedOptions!.headers['if-none-match'], 'W/"v1"');
    });

    test('200 response still saved to cache with forceFresh', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
        ..interceptors.add(HttpCacheInterceptor(store));
      final adapter = DioAdapter(dio: dio);

      adapter.onGet(
        '/v1/start',
        (server) => server.reply(
          200,
          {'updated': true},
          headers: {
            'etag': ['W/"new"'],
            'content-type': ['application/json'],
          },
        ),
      );

      await dio.get<dynamic>(
        '/v1/start',
        options: Options(extra: {kForceFreshExtra: true}),
      );

      // Verify the new data was saved
      final key = store.primaryKeyForUrl(
        RequestOptions(
          path: '/v1/start',
          baseUrl: 'https://v2.api.eqmonitor.app',
        ),
      );
      final cached = await store.read(key);
      expect(cached, isNotNull);
      expect(cached!.eTag, 'W/"new"');
    });
  });

  group('ForceFreshInterceptor', () {
    test('sets kForceFreshExtra flag on requests', () async {
      final dio = Dio()..interceptors.add(ForceFreshInterceptor());

      RequestOptions? capturedOptions;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.resolve(
              Response(requestOptions: options, statusCode: 200),
            );
          },
        ),
      );

      await dio.get<dynamic>('https://example.com/test');

      expect(capturedOptions!.extra[kForceFreshExtra], isTrue);
    });
  });
}
