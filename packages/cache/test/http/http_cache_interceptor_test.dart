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
      (server) => server.reply(304, '', headers: {'etag': ['W/"v1"']}),
    );
    final second = await dio.get<dynamic>(path);
    expect((second.data as Map)['items'], <dynamic>[]);
  });

  test('200 応答で body 更新', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(path, (s) => s.reply(200, {'v': 1}, headers: jsonHeaders('W/"v1"')));
    await dio.get<dynamic>(path);
    adapter.onGet(path, (s) => s.reply(200, {'v': 2}, headers: jsonHeaders('W/"v2"')));
    final updated = await dio.get<dynamic>(path);
    expect((updated.data as Map)['v'], 2);
  });

  test('schemaVersion 変更で旧 body が復元されない', () async {
    const path = '/v2/earthquake';
    final dio1 = buildDio();
    final adapter1 = DioAdapter(dio: dio1);
    adapter1.onGet(path, (s) => s.reply(200, {'gen': 1}, headers: jsonHeaders('W/"v1"')));
    await dio1.get<dynamic>(path);

    final dio2 = buildDio(schemaVersion: 2);
    final adapter2 = DioAdapter(dio: dio2);
    adapter2.onGet(path, (s) => s.reply(200, {'gen': 2}, headers: jsonHeaders('W/"v2"')));
    final res = await dio2.get<dynamic>(path);
    expect((res.data as Map)['gen'], 2);
  });
}
