import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// HTTP キャッシュ (ETag/304 透過層) のスキーマバージョン。
///
/// モデル変更でキャッシュ済み body が古くなった場合にこの値を上げると、
/// keyBuilder の名前空間が変わり旧 body が 304 で復元されなくなる。
/// 計画D の `kCacheSchemaVersion` (lib/src/cache_constants.dart) と同値で同期。
const kHttpCacheSchemaVersion = 1;

/// interceptor の keyBuilder と `HttpCacheStore.primaryKeyForUrl` が共用する
/// 名前空間化済みキャッシュキー生成関数。
///
/// `dio_cache_interceptor` の [CacheKeyBuilder] typedef
/// (`String Function({required Uri url, Map<String, String>? headers, Object? body})`)
/// と整合する。既定キー生成 ([CacheOptions.defaultCacheKeyBuilder]) を base に
/// `v<schemaVersion>:<appBuild>:` を prefix し、schema version / app build ごとに
/// キャッシュ空間を分離する。
String buildHttpCacheKey({
  required int schemaVersion,
  required String appBuild,
  required Uri url,
  Map<String, String>? headers,
  Object? body,
}) {
  final base = CacheOptions.defaultCacheKeyBuilder(
    url: url,
    headers: headers,
    body: body,
  );
  return 'v$schemaVersion:$appBuild:$base';
}
