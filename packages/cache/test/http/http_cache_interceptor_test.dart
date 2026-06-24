import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

/// 実サーバ同様に JSON 文字列 + content-type を返すヘッダ。
Map<String, List<String>> jsonHeaders(String eTag) => {
  'etag': [eTag],
  'cache-control': ['no-cache'],
  'content-type': ['application/json'],
};

CacheOptions buildCacheOptions({
  required CacheStore store,
  required int schemaVersion,
  required String appBuild,
}) => CacheOptions(
  store: store,
  policy: CachePolicy.refreshForceCache,
  keyBuilder: ({required url, headers, body}) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    url: url,
    headers: headers,
    body: body,
  ),
);

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late MemCacheStore store;

  setUp(() {
    store = MemCacheStore();
    dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(
        DioCacheInterceptor(
          options: buildCacheOptions(
            store: store,
            schemaVersion: kHttpCacheSchemaVersion,
            appBuild: '3.0.0+100',
          ),
        ),
      );
    adapter = DioAdapter(dio: dio);
  });

  test('200 で ETag/body 保存 → 再GETで 304 → body 復元', () async {
    const path = '/v2/earthquake';
    const eTag = 'W/"v1"';
    adapter.onGet(
      path,
      (server) => server.reply(
        200,
        jsonEncode({'items': <dynamic>[]}),
        headers: jsonHeaders(eTag),
      ),
    );
    final first = await dio.get<dynamic>(path);
    expect(jsonDecode(first.data as String), {'items': <dynamic>[]});

    adapter.onGet(
      path,
      (server) => server.reply(304, '', headers: {
        'etag': [eTag],
      }),
    );
    final second = await dio.get<dynamic>(path);
    expect(jsonDecode(second.data as String), {'items': <dynamic>[]});
  });

  test('200 応答で body 更新', () async {
    const path = '/v2/earthquake';
    adapter.onGet(
      path,
      (server) => server.reply(200, jsonEncode({'v': 1}), headers: jsonHeaders('W/"v1"')),
    );
    await dio.get<dynamic>(path);
    adapter.onGet(
      path,
      (server) => server.reply(200, jsonEncode({'v': 2}), headers: jsonHeaders('W/"v2"')),
    );
    final updated = await dio.get<dynamic>(path);
    expect((jsonDecode(updated.data as String) as Map)['v'], 2);
  });

  test('schemaVersion 変更で旧 body が復元されない (名前空間化)', () async {
    const path = '/v2/earthquake';
    adapter.onGet(
      path,
      (server) => server.reply(200, jsonEncode({'gen': 1}), headers: jsonHeaders('W/"v1"')),
    );
    await dio.get<dynamic>(path);

    final dio2 = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(
        DioCacheInterceptor(
          options: buildCacheOptions(
            store: store,
            schemaVersion: 2,
            appBuild: '3.0.0+100',
          ),
        ),
      );
    final adapter2 = DioAdapter(dio: dio2);
    adapter2.onGet(
      path,
      (server) => server.reply(200, jsonEncode({'gen': 2}), headers: jsonHeaders('W/"v2"')),
    );
    final res = await dio2.get<dynamic>(path);
    expect((jsonDecode(res.data as String) as Map)['gen'], 2);
  });
}
