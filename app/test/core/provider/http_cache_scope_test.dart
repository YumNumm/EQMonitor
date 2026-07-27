import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  talker_lib.talker = Talker();

  test('通常Dioのpaging・検索・個人・Realtime GETは保存されない', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final dio = const ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: {},
      baseInterceptors: [],
    ).build()..httpClientAdapter = _JsonAdapter();

    await dio.get<Map<String, dynamic>>(
      '/v2/earthquake',
      queryParameters: {'cursor': 'next', 'magnitude_gte': '5.0'},
    );
    await dio.get<Map<String, dynamic>>('/v2/device/me');
    await dio.get<Map<String, dynamic>>('/v2/realtime/ticket');

    expect(await store.listSummaries(), isEmpty);
  });

  test('キャッシュ対応Dioは許可された詳細GETを保存する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final dio = const ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: {},
      baseInterceptors: [],
    ).build(httpCacheStore: store)..httpClientAdapter = _JsonAdapter();

    await dio.get<Map<String, dynamic>>('/v2/earthquake/202607270001');

    final entries = await store.listSummaries();
    expect(entries, hasLength(1));
    expect(entries.single.key, contains('/v2/earthquake/202607270001'));
  });
}

final class _JsonAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    '{"ok":true}',
    200,
    headers: const {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      'etag': ['W/"scope-test"'],
    },
  );

  @override
  void close({bool force = false}) {}
}
