import 'dart:async';

import 'package:cache/cache.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:http_cache_drift_store/http_cache_drift_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_store_provider.g.dart';

/// API 層横断の ETag/304 HTTP キャッシュストア。
///
/// `DriftCacheStore` が絶対パス (`databasePath`) を要求するため、
/// `getApplicationSupportDirectory()` を await する非同期 Provider。
/// 計画D は `ref.watch(httpCacheStoreProvider.future)` で消費する。
@Riverpod(keepAlive: true)
Future<HttpCacheStore> httpCacheStore(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final appBuild = '${package.version}+${package.buildNumber}';
  final dir = await getApplicationSupportDirectory();
  final store = DriftCacheStore(databasePath: dir.path);
  ref.onDispose(() => unawaited(store.close()));
  return HttpCacheStore(
    store: store,
    schemaVersion: kHttpCacheSchemaVersion,
    appBuild: appBuild,
  );
}
