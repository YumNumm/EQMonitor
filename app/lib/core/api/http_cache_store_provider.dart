import 'package:cache/cache.dart';
import 'package:eqmonitor/core/api/http_cache_migrator.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
Future<HttpCacheStore> httpCacheStore(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final db = await openHttpCacheDatabase();
  final store = HttpCacheStore(
    db: db,
    schemaVersion: kHttpCacheSchemaVersion,
    appBuild: '${package.version}+${package.buildNumber}',
  );
  try {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    await HttpCacheMigrator(
      clearCache: store.clearAll,
      dataSource: dataSource,
    ).migrate();
  } on Object {
    await db.close();
    rethrow;
  }
  ref.onDispose(db.close);
  return store;
}
