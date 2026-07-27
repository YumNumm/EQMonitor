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

  test('通常Dioは対象外GETを保存せず、専用Dioだけが保存する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final adapter = _RecordingJsonAdapter();
    final factory = const ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: {},
      baseInterceptors: [],
    );
    final dio = factory.build()..httpClientAdapter = adapter;

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);

    await dio.get<Map<String, dynamic>>(
      '/v2/earthquake',
      queryParameters: {'cursor': 'next'},
    );
    expect(adapter.requests, hasLength(1));
    expect(adapter.requests.last.uri.queryParameters['cursor'], 'next');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>(
      '/v2/earthquake',
      queryParameters: {'magnitude_gte': '5.0'},
    );
    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.last.uri.queryParameters['magnitude_gte'], '5.0');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>('/v2/device/me');
    expect(adapter.requests, hasLength(3));
    expect(adapter.requests.last.path, '/v2/device/me');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>('/v2/realtime/ticket');
    expect(adapter.requests, hasLength(4));
    expect(adapter.requests.last.path, '/v2/realtime/ticket');
    expect(await store.listSummaries(), isEmpty);

    final cachedAdapter = _RecordingJsonAdapter();
    final cachedDio = factory.build(httpCacheStore: store)
      ..httpClientAdapter = cachedAdapter;

    await cachedDio.get<Map<String, dynamic>>('/v2/earthquake/202607270001');

    expect(cachedAdapter.requests, hasLength(1));
    expect(cachedAdapter.requests.single.path, '/v2/earthquake/202607270001');
    final entries = await store.listSummaries();
    expect(entries, hasLength(1));
    expect(entries.single.key, contains('/v2/earthquake/202607270001'));
  });
}

final class _RecordingJsonAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      '{"ok":true}',
      200,
      headers: const {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        'etag': ['W/"scope-test"'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
