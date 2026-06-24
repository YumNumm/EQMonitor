import 'package:cache/src/http/http_cache_key.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// `dio_cache_interceptor` の [CacheStore] をラップし、URL 単位 evict と
/// 全消去、キャッシュキー解決を公開する横断 HTTP キャッシュストア。
///
/// Riverpod 非依存 (provider は app が供給)。計画D の自己修復 (該当 URL の
/// evict) と一括 wipe (clearAll) から消費される。
class HttpCacheStore {
  HttpCacheStore({
    required this.store,
    required this.schemaVersion,
    required this.appBuild,
  });

  /// 内部の dio_cache_interceptor ストア (Drift / Mem)。
  final CacheStore store;

  /// キャッシュキーの名前空間に使う schema version。
  final int schemaVersion;

  /// キャッシュキーの名前空間に使う app build (`version+build`)。
  final String appBuild;

  /// 指定した primaryKey のキャッシュエントリを削除する。
  Future<void> evict(String primaryKey) => store.delete(primaryKey);

  /// すべての HTTP キャッシュエントリを削除する。
  Future<void> clearAll() => store.clean();

  /// interceptor の keyBuilder と同一ロジックで URL からキャッシュキーを解決する。
  ///
  /// 既定 keyBuilder は url のみを使うため、`options.uri` のみで一致する。
  String primaryKeyForUrl(RequestOptions options) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    url: options.uri,
  );
}
