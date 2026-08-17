import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, List<String>> jsonHeaders(String eTag) => {
  'etag': [eTag],
  'content-type': ['application/json'],
};

void main() {
  late CacheDatabase db;

  setUp(() => db = CacheDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Dio buildDio({int schemaVersion = 1}) {
    final store = HttpCacheStore(
      db: db,
      schemaVersion: schemaVersion,
      appBuild: '3.0.0+100',
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(HttpCacheInterceptor(store));
    return dio;
  }

  Dio buildDioWithStore(HttpCacheStore store) {
    final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(HttpCacheInterceptor(store));
    return dio;
  }

  test('200 で保存 → 再GETで 304 → body 復元', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(
      path,
      (server) => server.reply(
        200,
        {'items': <dynamic>[]},
        headers: jsonHeaders('W/"v1"'),
      ),
    );
    final first = await dio.get<dynamic>(path);
    expect((first.data as Map)['items'], <dynamic>[]);

    adapter.onGet(
      path,
      (server) => server.reply(
        304,
        '',
        headers: {
          'etag': ['W/"v1"'],
        },
      ),
    );
    final second = await dio.get<dynamic>(path);
    expect((second.data as Map)['items'], <dynamic>[]);
  });

  test('200 応答で body 更新', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(
      path,
      (s) => s.reply(200, {'v': 1}, headers: jsonHeaders('W/"v1"')),
    );
    await dio.get<dynamic>(path);
    adapter.onGet(
      path,
      (s) => s.reply(200, {'v': 2}, headers: jsonHeaders('W/"v2"')),
    );
    final updated = await dio.get<dynamic>(path);
    expect((updated.data as Map)['v'], 2);
  });

  test('復元可能なエントリがあれば if-none-match を付与する', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(
      path,
      (s) =>
          s.reply(200, {'items': <dynamic>[]}, headers: jsonHeaders('W/"v1"')),
    );
    await dio.get<dynamic>(path);

    adapter.onGet(
      path,
      (s) => s.reply(
        304,
        '',
        headers: {
          'etag': ['W/"v1"'],
        },
      ),
    );
    final second = await dio.get<dynamic>(path);

    expect(second.requestOptions.headers['if-none-match'], 'W/"v1"');
    expect((second.data as Map)['items'], <dynamic>[]);
  });

  test('復元元が無い場合は上流の if-none-match を除去して 200 を取得', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    // ストアは空。Repository など上流が付与した if-none-match だけが存在する状況。
    adapter.onGet(
      path,
      (s) =>
          s.reply(200, {'items': <dynamic>[]}, headers: jsonHeaders('W/"v1"')),
    );

    final res = await dio.get<dynamic>(
      path,
      options: Options(headers: {'if-none-match': 'W/"stale"'}),
    );

    // 復元元が無いので条件付きリクエストにせず、フルの 200 を取得できる。
    expect((res.data as Map)['items'], <dynamic>[]);
    expect(res.requestOptions.headers.containsKey('if-none-match'), isFalse);
  });

  test('ストアの body が壊れている場合も if-none-match を除去', () async {
    const path = '/v2/earthquake';
    final store = HttpCacheStore(
      db: db,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(HttpCacheInterceptor(store));
    final adapter = DioAdapter(dio: dio);

    // eTag は持つが body が JSON として壊れているエントリを直接書き込む。
    final key = store.primaryKeyForUrl(
      RequestOptions(path: path, baseUrl: 'https://v2.api.eqmonitor.app'),
    );
    await store.write(
      HttpCacheEntry(
        key: key,
        statusCode: 200,
        eTag: 'W/"v1"',
        headers: const {
          'content-type': ['application/json'],
        },
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{ broken json')),
        updatedAtMs: 0,
      ),
    );

    adapter.onGet(
      path,
      (s) =>
          s.reply(200, {'items': <dynamic>[]}, headers: jsonHeaders('W/"v2"')),
    );

    final res = await dio.get<dynamic>(path);

    expect((res.data as Map)['items'], <dynamic>[]);
    expect(res.requestOptions.headers.containsKey('if-none-match'), isFalse);
  });

  test('schemaVersion 変更で旧 body が復元されない', () async {
    const path = '/v2/earthquake';
    final dio1 = buildDio();
    final adapter1 = DioAdapter(dio: dio1);
    adapter1.onGet(
      path,
      (s) => s.reply(200, {'gen': 1}, headers: jsonHeaders('W/"v1"')),
    );
    await dio1.get<dynamic>(path);

    final dio2 = buildDio(schemaVersion: 2);
    final adapter2 = DioAdapter(dio: dio2);
    adapter2.onGet(
      path,
      (s) => s.reply(200, {'gen': 2}, headers: jsonHeaders('W/"v2"')),
    );
    final res = await dio2.get<dynamic>(path);
    expect((res.data as Map)['gen'], 2);
  });

  test('store.read例外時は条件付きヘッダーを除去してネットワーク継続', () async {
    const path = '/v2/earthquake';
    final store = _ReadFailureHttpCacheStore(db: db);
    final dio = buildDioWithStore(store);
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      path,
      (server) => server.reply(200, <String, dynamic>{
        'ok': true,
      }, headers: jsonHeaders('W/"v2"')),
    );

    final response = await dio.get<Map<String, dynamic>>(
      path,
      options: Options(
        headers: {
          'if-none-match': 'W/"stale"',
          'if-modified-since': 'Mon, 27 Jul 2026 12:00:00 GMT',
        },
      ),
    );

    expect(response.data, <String, dynamic>{'ok': true});
    expect(response.requestOptions.headers, isNot(contains('if-none-match')));
    expect(
      response.requestOptions.headers,
      isNot(contains('if-modified-since')),
    );
  });

  test('store.write例外時も成功した200応答を返す', () async {
    const path = '/v2/earthquake';
    final store = _WriteFailureHttpCacheStore(db: db);
    final dio = buildDioWithStore(store);
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      path,
      (server) => server.reply(200, <String, dynamic>{
        'ok': true,
      }, headers: jsonHeaders('W/"v1"')),
    );

    final response = await dio.get<Map<String, dynamic>>(path);

    expect(response.statusCode, 200);
    expect(response.data, <String, dynamic>{'ok': true});
  });
}

final class _ReadFailureHttpCacheStore extends HttpCacheStore {
  new({required CacheDatabase db})
    : super(db: db, schemaVersion: 1, appBuild: 'test');

  @override
  Future<HttpCacheEntry?> read(String key) async =>
      throw StateError('read unavailable');
}

final class _WriteFailureHttpCacheStore extends HttpCacheStore {
  new({required CacheDatabase db})
    : super(db: db, schemaVersion: 1, appBuild: 'test');

  @override
  Future<void> write(HttpCacheEntry entry) async =>
      throw StateError('write unavailable');
}
