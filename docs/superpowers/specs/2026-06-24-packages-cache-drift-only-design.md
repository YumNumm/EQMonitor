# packages/cache を Drift 自前実装へ移行する設計

## 背景 / 目的

`packages/cache` は現在、HTTP ETag/304 透過キャッシュを `dio_cache_interceptor`、ストレージを `http_cache_drift_store` に依存して実装している。これら 2 つの外部パッケージへの依存を排除し、**Drift のみ**でストレージと往復を自前実装する。

## 確定方針

- `dio_cache_interceptor` / `http_cache_drift_store` を完全に削除する。
- ETag/304 インターセプタを自前実装し、`packages/cache` に置く。`dio` 依存は維持する。
- ストレージは Drift。本番 DB のオープンは `drift_flutter` で `packages/cache` 内に置く。
- DB クラスは `QueryExecutor` 注入式とし、テストは `NativeDatabase.memory()` で行う（`packages/telemetry_store` の確立済みパターンに倣う）。
- 新規パッケージ導入はユーザー承認済（`drift` / `drift_flutter` / `path_provider` / dev: `drift_dev`）。
- 自明なコメントは書かない。コメントは非自明な理由のみ。

## 依存変更

`packages/cache/pubspec.yaml`

- 削除: `dio_cache_interceptor`, `http_cache_drift_store`
- 追加(dependencies): `drift`, `drift_flutter`, `path_provider`
- 追加(dev_dependencies): `drift_dev`, `sqlite3`(テストの NativeDatabase 用), `flutter_test`(sdk)
- 維持: `dio`, `build_runner`

`drift_flutter` は `flutter` SDK を引き込むため `packages/cache` は Flutter パッケージとなり、テストは `flutter test` で実行する。

## ファイル構成

```
lib/cache.dart                                   公開 export
lib/src/database/http_cache_entries_table.dart   Drift Table 定義
lib/src/database/http_cache_database.dart         @DriftDatabase CacheDatabase(QueryExecutor) + DAO
lib/src/database/open_http_cache_database.dart     drift_flutter による本番オープナー
lib/src/http/http_cache_key.dart                   buildHttpCacheKey + kHttpCacheSchemaVersion
lib/src/http/http_cache_entry.dart                 HttpCacheEntry モデル(dio 非依存)
lib/src/http/http_cache_store.dart                 HttpCacheStore (DB ファサード)
lib/src/http/http_cache_interceptor.dart           HttpCacheInterceptor (Dio Interceptor)
```

## データモデル

### テーブル `HttpCacheEntries`（DataClass: `HttpCacheEntryRow`）

| 列 | Drift 型 | 説明 |
|---|---|---|
| `key` | `text()` PK | 名前空間化済みキャッシュキー |
| `statusCode` | `integer()` | 保存時のステータス（通常 200） |
| `eTag` | `text().nullable()` | `If-None-Match` 用 |
| `headers` | `text()` | レスポンスヘッダの JSON (`Map<String, List<String>>`) |
| `responseType` | `text()` | `json` / `plain` / `bytes`（本文往復の再現） |
| `body` | `blob()` | 本文バイト列 |
| `updatedAtMs` | `integer()` | 保存時刻 epoch ms |

### `HttpCacheEntry`（dio 非依存の受け渡しモデル）

```
key, statusCode, eTag(nullable), headers(Map<String,List<String>>),
responseType(String), body(Uint8List), updatedAtMs(int)
```

## インターフェース

### `buildHttpCacheKey`

```dart
const kHttpCacheSchemaVersion = 1;

String buildHttpCacheKey({
  required int schemaVersion,
  required String appBuild,
  required Uri url,
  Map<String, String>? headers, // 互換のため受けるが未使用
  Object? body,                 // 同上
}) => 'v$schemaVersion:$appBuild:$url';
```

`dio_cache_interceptor` の `defaultCacheKeyBuilder`（`uuid.v5(url)`）の代替。DB は新規作成のためバイト互換は不要。キーは URL 文字列そのものを名前空間 prefix で囲む。決定的・query 差分で別キー・schemaVersion/appBuild 変更で別キーを満たす。

### `CacheDatabase`（Drift）

```dart
@DriftDatabase(tables: [HttpCacheEntries])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(super.e);
  int get schemaVersion => 1;

  Future<HttpCacheEntryRow?> getEntry(String key);
  Future<void> putEntry(HttpCacheEntriesCompanion data); // insertOnConflictUpdate
  Future<void> deleteEntry(String key);
  Future<void> clear();
}
```

### `HttpCacheStore`（ファサード）

```dart
class HttpCacheStore {
  HttpCacheStore({required CacheDatabase db, required int schemaVersion, required String appBuild});

  Future<HttpCacheEntry?> read(String key);
  Future<void> write(HttpCacheEntry entry);
  Future<void> evict(String key);
  Future<void> clearAll();
  String primaryKeyForUrl(RequestOptions options); // dio 依存はここ
}
```

### `HttpCacheInterceptor`（`extends Interceptor`）

GET のみ対象。

- **onRequest**: `key = store.primaryKeyForUrl(options)` を算出し `options.extra` に保持。既存エントリの `eTag` があれば `If-None-Match` を付与。`options.validateStatus` を 304 許可に差し替える。
- **onResponse**:
  - `304`: `store.read(key)` で復元し、`body` を `responseType` に応じデコード、`statusCode`/`headers` を再構築して `handler.resolve(restored)`。エントリが無ければ素通し。
  - `200`（かつ `responseType` が json/plain/bytes）: 本文を `responseType` に応じシリアライズして `store.write`。それ以外（stream 等）は保存しない。
  - その他: 素通し。

### 本文シリアライズ

`onResponse` 時点で `response.data` はトランスフォーマ後。`requestOptions.responseType` で往復する。

- `json`: 保存 `utf8.encode(jsonEncode(data))` / 復元 `jsonDecode(utf8.decode(bytes))`
- `plain`: 保存 `utf8.encode(data as String)` / 復元 `utf8.decode(bytes)`
- `bytes`: 保存 `Uint8List.fromList(data)` / 復元 そのまま

### 本番オープナー

```dart
CacheDatabase openHttpCacheDatabase() =>
    CacheDatabase(driftDatabase(name: 'eqmonitor_http_cache'));
```

## app 側の変更

- `app/lib/core/api/http_cache_store_provider.dart`: `DriftCacheStore` → `openHttpCacheDatabase()` で `CacheDatabase` を生成し `HttpCacheStore` に渡す。DB を lazy オープンできるため `package_info` のみ参照、`getApplicationSupportDirectory` の await は不要になり同期 Provider 化が可能（`onDispose` で `db.close()`）。
- `app/lib/core/provider/dio_provider.dart`: `DioCacheInterceptor(CacheOptions(...))` → `HttpCacheInterceptor(httpCache)` に置換。`dio_cache_interceptor` import を削除。
- `app/pubspec.yaml`: `dio_cache_interceptor`, `http_cache_drift_store` を削除（他に利用箇所なし）。

## テスト戦略（TDD・`flutter test`）

- `http_cache_key_test.dart`: 決定性 / schemaVersion 差分 / appBuild 差分 / query 差分 / 名前空間 prefix（dio_cache_interceptor 非依存に書換）。
- `http_cache_database_test.dart`: `NativeDatabase.memory()` で put→get / 上書き / delete / clear。
- `http_cache_store_test.dart`: `primaryKeyForUrl` の決定性 / evict が指定キーのみ / clearAll が全削除（`MemCacheStore`/`CacheResponse` 依存を廃し memory DB ベースに書換）。
- `http_cache_interceptor_test.dart`: `http_mock_adapter` で 200保存→304復元 / 200更新 / schemaVersion 差分で旧 body 非復元。

## 非目標 (YAGNI)

- maxStale / TTL / 暗号化 / POST キャッシュ / hitCacheOnError などは実装しない（現状も未使用）。
- 旧 DB スキーマからのマイグレーションは行わない（キャッシュは再構築可能なため新規 DB で問題ない）。
