import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/http_cache_disabled_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/cache_only_dio_provider.dart';
import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class _DisabledHttpCache extends HttpCacheDisabled {
  @override
  Future<bool> build() async => true;
}

final class _EnabledHttpCache extends HttpCacheDisabled {
  @override
  Future<bool> build() async => false;
}

final class _TestTelegramUrl extends TelegramUrl {
  @override
  Future<TelegramUrlModel> build() async => const TelegramUrlModel(
    restApiUrl: 'https://example.com',
    wsApiUrl: 'wss://example.com',
  );
}

void main() {
  talker_lib.talker = Talker();

  test('無効化中はstoreを読まずcacheなしDioを返す', () async {
    final factory = ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: const {},
      baseInterceptors: const [],
    );
    final container = ProviderContainer(
      overrides: [
        apiDioFactoryProvider.overrideWith((ref) async => factory),
        httpCacheDisabledProvider.overrideWith(_DisabledHttpCache.new),
        httpCacheStoreProvider.overrideWith(
          (ref) async => throw StateError('store must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(httpCachedDioProvider.future);

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
  });

  test('store取得失敗時はcacheなしDioへ縮退する', () async {
    final factory = ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: const {},
      baseInterceptors: const [],
    );
    final container = ProviderContainer(
      overrides: [
        apiDioFactoryProvider.overrideWith((ref) async => factory),
        httpCacheDisabledProvider.overrideWith(_EnabledHttpCache.new),
        httpCacheStoreProvider.overrideWith(
          (ref) async => throw StateError('store unavailable'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(httpCachedDioProvider.future);

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
  });

  test('有効時はstoreを使うcache対応Dioを返す', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final factory = ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: const {},
      baseInterceptors: const [],
    );
    final container = ProviderContainer(
      overrides: [
        apiDioFactoryProvider.overrideWith((ref) async => factory),
        httpCacheDisabledProvider.overrideWith(_EnabledHttpCache.new),
        httpCacheStoreProvider.overrideWith((ref) async => store),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(httpCachedDioProvider.future);

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), hasLength(1));
  });

  test('cache-onlyも無効化中はstoreを読まず必ずcache missを返す', () async {
    final container = ProviderContainer(
      overrides: [
        httpCacheDisabledProvider.overrideWith(_DisabledHttpCache.new),
        telegramUrlProvider.overrideWith(_TestTelegramUrl.new),
        httpCacheStoreProvider.overrideWith(
          (ref) async => throw StateError('store must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(cacheOnlyDioProvider.future);

    expect(dio.interceptors.whereType<CacheOnlyInterceptor>(), hasLength(1));
    await expectLater(
      dio.get<Map<String, dynamic>>('/value'),
      throwsA(
        isA<DioException>().having(
          (e) => e.error,
          'error',
          isA<CacheMissException>(),
        ),
      ),
    );
  });
}
