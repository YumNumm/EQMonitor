import 'package:cache/cache.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
Future<HttpCacheStore> httpCacheStore(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final db = await openHttpCacheDatabase();
  ref.onDispose(db.close);
  return HttpCacheStore(
    db: db,
    schemaVersion: kHttpCacheSchemaVersion,
    appBuild: '${package.version}+${package.buildNumber}',
  );
}
