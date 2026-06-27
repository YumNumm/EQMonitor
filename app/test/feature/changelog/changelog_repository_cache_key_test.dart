import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/feature/changelog/data/notifier/changelog_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  test(
    'provider returns package cache first and revalidates with etag',
    () async {
      final db = CacheDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final store = HttpCacheStore(
        db: db,
        schemaVersion: 1,
        appBuild: '3.0.0+100',
      );
      final key = store.primaryKeyForUrl(
        RequestOptions(path: '/v1/changelog', baseUrl: 'https://example.com'),
      );
      await store.write(
        HttpCacheEntry(
          key: key,
          statusCode: 200,
          eTag: 'W/"cached"',
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
            'etag': ['W/"cached"'],
          },
          responseType: 'json',
          body: Uint8List.fromList(
            utf8.encode(jsonEncode(_changelogJson('1.0.0'))),
          ),
          updatedAtMs: 0,
        ),
      );
      final cacheOnlyDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(CacheOnlyInterceptor(store));
      final adapter = _ChangelogCacheAdapter();
      final normalDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(HttpCacheInterceptor(store))
        ..httpClientAdapter = adapter;
      final container = ProviderContainer(
        overrides: [
          cacheOnlyApiClientProvider.overrideWith(
            (ref) async => api.ApiClient(cacheOnlyDio),
          ),
          apiClientProvider.overrideWith(
            (ref) async => api.ApiClient(normalDio),
          ),
        ],
      );
      addTearDown(container.dispose);

      final first = await container.read(changelogProvider.future);
      await _pumpMicrotasks();

      expect(first.entries.single.version, '1.0.0');
      expect(container.read(changelogProvider).isFromCache, isTrue);
      expect(adapter.requests.single.headers['if-none-match'], 'W/"cached"');

      adapter.completeNotModified();
      await _pumpMicrotasks();

      final finalState = container.read(changelogProvider);
      expect(finalState.value?.entries.single.version, '1.0.0');
      expect(finalState.isLoading, isFalse);
      expect(finalState.isFromCache, isFalse);
    },
  );
}

Future<void> _pumpMicrotasks() async {
  for (var i = 0; i < 10; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

final class _ChangelogCacheAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final _completer = Completer<ResponseBody>();

  void completeNotModified() {
    _completer.complete(
      ResponseBody.fromString(
        '',
        304,
        headers: {
          'etag': ['W/"cached"'],
        },
      ),
    );
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _completer.future;
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> _changelogJson(String version) => {
  'entries': [
    {
      'version': version,
      'date': '2026-06-04T00:00:00Z',
      'url': 'https://example.com/changelog/$version',
      'sections': [
        {
          'title': '追加',
          'items': ['更新内容'],
        },
      ],
    },
  ],
};
