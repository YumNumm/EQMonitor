import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:test/test.dart';

void main() {
  RequestOptions options() => RequestOptions(
    path: '/v2/earthquake',
    baseUrl: 'https://v2.api.eqmonitor.app',
    method: 'GET',
    queryParameters: <String, dynamic>{'limit': '10'},
  );

  CacheResponse responseFor(String key) => CacheResponse(
    cacheControl: CacheControl(),
    content: const [1, 2, 3],
    date: DateTime.now(),
    eTag: 'W/"abc"',
    expires: null,
    headers: null,
    key: key,
    lastModified: null,
    maxStale: null,
    priority: CachePriority.normal,
    requestDate: DateTime.now(),
    responseDate: DateTime.now(),
    url: 'https://v2.api.eqmonitor.app/v2/earthquake?limit=10',
    statusCode: 200,
  );

  test('primaryKeyForUrl は buildHttpCacheKey と一致', () {
    final sut = HttpCacheStore(
      store: MemCacheStore(),
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    expect(
      sut.primaryKeyForUrl(options()),
      buildHttpCacheKey(
        schemaVersion: 1,
        appBuild: '3.0.0+100',
        url: options().uri,
      ),
    );
  });

  test('evict は指定キーのみ削除', () async {
    final mem = MemCacheStore();
    final sut = HttpCacheStore(
      store: mem,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    final key = sut.primaryKeyForUrl(options());
    await mem.set(responseFor(key));
    expect(await mem.exists(key), isTrue);

    await sut.evict(key);

    expect(await mem.exists(key), isFalse);
  });

  test('clearAll は全削除', () async {
    final mem = MemCacheStore();
    final sut = HttpCacheStore(
      store: mem,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    await mem.set(responseFor('k1'));
    await mem.set(responseFor('k2'));

    await sut.clearAll();

    expect(await mem.exists('k1'), isFalse);
    expect(await mem.exists('k2'), isFalse);
  });
}
