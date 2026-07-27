import 'package:cache/cache.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/provider/seismicity_repository_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  test('GeoJSON 用 Dio に HTTP キャッシュを設定する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(
      db: db,
      schemaVersion: 1,
      appBuild: '3.0.0+100',
    );
    final container = ProviderContainer(
      overrides: [httpCacheStoreProvider.overrideWith((ref) async => store)],
    );
    addTearDown(container.dispose);

    final dio = await container.read(seismicityGeoJsonDioProvider.future);

    expect(dio.interceptors, [
      isNot(isA<HttpCacheInterceptor>()),
      isA<HttpCacheInterceptor>(),
    ]);
  });
}
