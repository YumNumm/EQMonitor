import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;
  late HttpCacheStore store;

  setUp(() {
    db = CacheDatabase(NativeDatabase.memory());
    store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: '3.0.0+100');
  });
  tearDown(() => db.close());

  RequestOptions options() => RequestOptions(
    path: '/v2/earthquake',
    baseUrl: 'https://v2.api.eqmonitor.app',
    method: 'GET',
    queryParameters: <String, dynamic>{'limit': '10'},
  );

  HttpCacheEntry entryFor(String key) => HttpCacheEntry(
    key: key,
    statusCode: 200,
    eTag: 'W/"abc"',
    headers: const {'content-type': ['application/json']},
    responseType: 'json',
    body: Uint8List.fromList(utf8.encode('{}')),
    updatedAtMs: 0,
  );

  test('primaryKeyForUrl は buildHttpCacheKey と一致', () {
    expect(
      store.primaryKeyForUrl(options()),
      buildHttpCacheKey(
        schemaVersion: 1,
        appBuild: '3.0.0+100',
        url: options().uri,
      ),
    );
  });

  test('write した内容が read で往復する', () async {
    final key = store.primaryKeyForUrl(options());
    await store.write(entryFor(key));
    final got = await store.read(key);
    expect(got, isNotNull);
    expect(got!.eTag, 'W/"abc"');
    expect(utf8.decode(got.body), '{}');
    expect(got.headers['content-type'], ['application/json']);
  });

  test('evict は指定キーのみ削除', () async {
    final key = store.primaryKeyForUrl(options());
    await store.write(entryFor(key));
    expect(await store.read(key), isNotNull);
    await store.evict(key);
    expect(await store.read(key), isNull);
  });

  test('clearAll は全削除', () async {
    await store.write(entryFor('k1'));
    await store.write(entryFor('k2'));
    await store.clearAll();
    expect(await store.read('k1'), isNull);
    expect(await store.read('k2'), isNull);
  });
}
