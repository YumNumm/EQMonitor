import 'package:cache/cache.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/http_cache_disabled_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/seismicity/data/provider/seismicity_repository_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class _DisabledHttpCache extends HttpCacheDisabled {
  @override
  Future<bool> build() async => true;
}

final class _EnabledHttpCache extends HttpCacheDisabled {
  @override
  Future<bool> build() async => false;
}

void main() {
  talker_lib.talker = Talker();

  test('無効化中はstoreを読まずcacheなしGeoJSON Dioを返す', () async {
    final container = ProviderContainer(
      overrides: [
        httpCacheDisabledProvider.overrideWith(_DisabledHttpCache.new),
        httpCacheStoreProvider.overrideWith(
          (ref) async => throw StateError('store must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(seismicityGeoJsonDioProvider.future);

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
  });

  test('store取得失敗時はcacheなしGeoJSON Dioへ縮退する', () async {
    final container = ProviderContainer(
      overrides: [
        httpCacheDisabledProvider.overrideWith(_EnabledHttpCache.new),
        httpCacheStoreProvider.overrideWith(
          (ref) async => throw StateError('store unavailable'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(seismicityGeoJsonDioProvider.future);

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
  });

  test('GeoJSON 用 Dio に HTTP キャッシュを設定する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(
      db: db,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    final container = ProviderContainer(
      overrides: [
        httpCacheDisabledProvider.overrideWith(_EnabledHttpCache.new),
        httpCacheStoreProvider.overrideWith((ref) async => store),
      ],
    );
    addTearDown(container.dispose);

    final dio = await container.read(seismicityGeoJsonDioProvider.future);

    expect(dio.interceptors, [
      isNot(isA<HttpCacheInterceptor>()),
      isA<HttpCacheInterceptor>(),
    ]);
  });
}
