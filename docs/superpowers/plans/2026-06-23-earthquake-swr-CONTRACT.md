# Earthquake SWR — 計画間インターフェース契約 (CONTRACT)

> 全計画 (A〜E) が参照する**唯一の真実**。型名・フィールド名・パラメータ名・関数シグネチャはここに合わせる。
> 元設計: `docs/superpowers/specs/2026-06-23-earthquake-swr-cache-design.md`

## 確定した実装パラメータ (本フェーズで確定)

| 項目 | 値 | 根拠 |
|---|---|---|
| `cache_id` の位置 | `StartResponse` 直下 (`v.string()`) | feature flag と責務分離 |
| `cache_id` 発番 | 環境変数 `CACHE_ID` 手動バンプ。デフォルト `"1"` | YAGNI |
| 差分モード `limit` | 固定 `50` | 既存 fetchNextData と整合 |
| `s-maxage` | 差分正規契約: `60` (初回・カーソルページ共通) | 設計書記載 |
| キャッシュ機構の配置 | 新規パッケージ **`packages/cache`** (`name: cache`, import `package:cache/cache.dart`) | アプリ固有インフラの分離 |

---

## 0. パッケージ構成 `packages/cache` (計画C が新設 / D・E が消費)

既存 `packages/*` のパターン (例: `eqmonitor_api` は Dio を受け取るだけで Riverpod 非依存) に揃え、**Riverpod / app feature 非依存のインフラのみ**を `packages/cache` に置く。Riverpod provider・SWR notifier (paging_view)・UI・ドメイン結線は **`app`** に残す。

**`packages/cache` に入れる (Riverpod 非依存・app 非依存):**
- Drift `CacheDatabase` + テーブル + DAO (§4.1)。
- `HttpCacheStore` クラス + `buildHttpCacheKey` + `kHttpCacheSchemaVersion` (§3)。
- `CacheWriteQueue` (§4.4)、`SelfHealGuard` (§4.6)、`HourBucketJst` (§4.3)。
- `CacheRevalidationState` sealed (§4.5)、`CacheRetentionStrategy` enum (§5)。
- 純粋マージ/カーソルロジック (§4.4。**ジェネリック**にして app モデル非依存にする: `T? mergeIncoming<T>(T?, T, DateTime Function(T))` 等)。
- `kCacheSchemaVersion` (§4.8。`kHttpCacheSchemaVersion` と同値。同一パッケージなので 1 定数に統合可)。

**`app` に残す (Riverpod / domain / UI):**
- 全 Riverpod provider: `cacheDatabaseProvider` / `httpCacheStoreProvider` / `cacheWriteQueueProvider` / `cacheRevalidationStateProvider` / `cacheRetentionStrategyProvider`。
- `cacheScopeOf` / `isCacheableScope` (app feature 型 `EarthquakeHistoryParameter` 依存)。
- SWR DataSource 結線 (paging_view)、詳細キャッシュ notifier、`CacheWipeService`/`CachePruner` の起動結線、UI (`CacheStatusOverlay`/設定 Tile)、`dioProvider` への interceptor 登録。
- `EarthquakeCacheLog`/`HttpCacheLog` (talker。app の `talker.dart` に既存ログと同居)。

**依存方向**: `packages/cache` → drift / drift_flutter / dio / dio_cache_interceptor / http_cache_drift_store のみ。`app` → `package:cache` + Riverpod。`packages/cache` は app・eqmonitor を import しない。

**workspace 追加**: 新規パッケージは melos workspace に登録 (`melos.yaml` の packages glob が `packages/**` を含むか確認し、含めば `melos bootstrap` のみ。pubspec workspace 採用なら root `pubspec.yaml` の `workspace:` にも追加)。

---

## 1. Backend API 契約 (計画A が産出 / B・C・D が消費)

### 1.1 DB スキーマ (`earthquake` テーブル新規カラム)
- `updated_at` `timestamp({ mode: 'string', withTimezone: true })` — **DB now() で統一**。BEFORE UPDATE トリガで強制 (唯一の強制点)。ORM の `.defaultNow()` は insert 補助。**差分カーソル**。
- `last_reported_at` `timestamp({ mode: 'string', withTimezone: true })` — 発表時刻 (ドメイン値、表示/ソート)。差分カーソルには使わない。
- インデックス: `CREATE INDEX earthquake_updated_at_event_id_index ON earthquake (updated_at DESC, event_id DESC)`。

### 1.2 差分カーソルトークン (新規)
- 差分モード: `cursor = base64(JSON.stringify({ updatedAt: string, eventId: string }))`。`type` フィールドは**持たない**。
- 通常リスト (lastUpdatedSince 無し): 既存 `base64("PAGING:{eventId}")` を維持。
- 差分モードか否かは `?lastUpdatedSince=` の有無で判別。
- Valibot 型名: `DiffCursor` (`{ updatedAt: v.string(), eventId: v.string() }`)、`DiffCursorSchema` (base64 decode + parse)。
- next-page 述語 (DESC, タイ分解):
  ```
  and(
    gte(earthquake.updatedAt, lastUpdatedSince),
    or(
      lt(earthquake.updatedAt, cursor.updatedAt),
      and(eq(earthquake.updatedAt, cursor.updatedAt), lt(earthquake.eventId, cursor.eventId)),
    ),
  )
  ```

### 1.3 `HourBucketJst` Valibot 型 (差分パラメータ検証)
- 型名: `HourBucketJstSchema` (`backend/api/api/src/shared/model/hour-bucket/hour-bucket.ts`)。
- regex: `^\d{4}-\d{2}-\d{2}T\d{2}:00:00\+09:00$` → 通過後に実日時パース検証 (`new Date()` が有効か)。
- 不正は 400 (`vValidator` が返す)。

### 1.4 クエリパラメータ (`EarthquakeQueryParams` 拡張)
- 追加: `lastUpdatedSince` (optional, `HourBucketJstSchema`)、`cacheId` (optional, `v.string()`)。
- 差分モード (= `lastUpdatedSince` あり) の**正規契約**: 受理は `lastUpdatedSince` / `cursor` / `limit`(固定50) / scope code / `cacheId` / `statuses`(固定既定) のみ。それ以外の任意フィルタ (magnitude/depth/intensity/originTime/epicenterCodes/...) が**1つでも付いたら** `no-store` + 差分マージ対象外。
- `statuses` は差分モードで可変にしない (型/コードで制約)。

### 1.5 レスポンス型 (`EarthquakePartial` 拡張 — `backend/packages/types/src/earthquake.ts`)
- 追加フィールド: `updated_at: v.isoTimestamp()` (必須)、`last_reported_at: v.isoTimestamp()` (必須)。
- transformer `toEarthquakePartial` が両者を emit。

### 1.6 キャッシュヘッダ条件分岐 (`earthquake.ts` の Cache-Control middleware)
- 差分モード かつ 正規契約を満たす: `Cache-Control: public, s-maxage=60`。
- filtered/search・非正規パラメータ・通常リスト: 既存 `cacheConfig.earthquake.list` (既定 `no-store`)。

### 1.7 `/v1/start` `cache_id` (`StartResponseSchema` 拡張)
- 追加: `cache_id: v.string()` (トップレベル)。`StartConfigDatasource.build()` が env `CACHE_ID`(既定 `"1"`) から設定。
- ETag は body 全体の sha256 なので `cache_id` 変更で ETag も変わる (304 整合)。

### 1.8 Cloudflare キャッシュキー正規化 (Terraform / Cache Rule)
- キー = `path + scope code + lastUpdatedSince + cursor + limit + cacheId`。それ以外のクエリは無視 (差分正規契約のみ s-maxage を返すため安全)。

---

## 2. Dart API クライアント契約 (計画B が産出 / C・D が消費)

> すべて `dart run bin/generate.dart` による**生成結果**。手書きしない。openapi.json 変更が前提。

### 2.1 `EarthquakePartial` (`packages/eqmonitor_api/lib/src/models/earthquake_partial.dart`)
- 追加 (生成): `@JsonKey(name: 'updated_at') required DateTime updatedAt`、`@JsonKey(name: 'last_reported_at') required DateTime lastReportedAt`。

### 2.2 `getV2Earthquake` ほか scope メソッド (`earthquake_api_client.dart`)
- 追加 `@Query('lastUpdatedSince') String? lastUpdatedSince`、`@Query('cacheId') String? cacheId`。
- intensity scope 系 4 メソッドにも同様に追加。

### 2.3 `StartResponse` (`packages/eqmonitor_api/lib/src/models/start_response.dart`)
- 追加 (生成): `@JsonKey(name: 'cache_id') required String cacheId`。

---

## 3. ETag/304 横断層 契約 (計画C が産出 / D が消費)

- パッケージ依存 (`packages/cache/pubspec.yaml`): `dio` + `dio_cache_interceptor` + `http_cache_drift_store` (Drift ベース。旧 `dio_cache_interceptor_db_store` は discontinued)。dev: `http_mock_adapter`。
- 登録 (**app 側**): `dioProvider` (`app/lib/core/provider/dio_provider.dart`) に `DioCacheInterceptor` を `TalkerDioLogger` の**前**に追加。
- ポリシー: `CachePolicy.refreshForceCache` 相当 (ETag があれば必ず再検証、304 ならキャッシュ body 復元)。GET のみ。
- キャッシュキー名前空間: `keyBuilder` を schema version + app build で名前空間化。
- **`packages/cache` が産出 (Riverpod 非依存)**:
  - `const int kHttpCacheSchemaVersion` + `String buildHttpCacheKey({required int schemaVersion, required String appBuild, required RequestOptions options})` (`packages/cache/lib/src/http/http_cache_key.dart`)。
  - クラス `HttpCacheStore` (`packages/cache/lib/src/http/http_cache_store.dart`) が `dio_cache_interceptor` の `CacheStore` をラップ。コンストラクタ `HttpCacheStore({required CacheStore store, required int schemaVersion, required String appBuild})`。
    - `Future<void> evict(String primaryKey)` / `Future<void> clearAll()`。
    - `String primaryKeyForUrl(RequestOptions options)` — interceptor の keyBuilder と同一ロジック (`buildHttpCacheKey`)。
- **app が産出**: `@Riverpod(keepAlive: true) HttpCacheStore httpCacheStore(Ref ref)` (`app/lib/core/api/http_cache_store_provider.dart`、1 ファイル 1 公開 Provider)。`packageInfoProvider` から `appBuild` を作り `DriftCacheStore` を生成して `HttpCacheStore` で包む。

---

## 4. Drift SWR キャッシュ 契約 (計画D が産出 / E が消費)

> インフラ (Drift DB / 値オブジェクト / キュー / sealed state / マージ) は **`packages/cache`**。Riverpod provider・scope ヘルパ (app feature 型依存)・SWR 結線は **app**。

### 4.1 Drift DB — **`packages/cache`**
- DB クラス `CacheDatabase` (`packages/cache/lib/src/drift/cache_database.dart`)。テスト用 `CacheDatabase.forTesting(QueryExecutor)`。
- テーブル:
  - `EarthquakeCacheTable` → SQL `earthquake_cache`。PK (`scope`, `eventId`)。列: `payload`(Text, JSON), `updatedAt`(DateTime), `lastReportedAt`(DateTime), `fetchedAt`(DateTime)。
  - `EarthquakeDetailCacheTable` → `earthquake_detail_cache`。PK `eventId`。列: `payload`, `updatedAt`, `lastReportedAt`, `fetchedAt`。
  - `CacheSyncStateTable` → `cache_sync_state`。PK `scope`。列: `sinceCursor`(Text, nullable), `lastSyncedAt`(DateTime, nullable)。
  - `CacheMetaTable` → `cache_meta`。単一行 (id=0)。列: `schemaVersion`(int), `lastSeenCacheId`(Text, nullable)。
- DAO メソッド名は計画D §Task5 の通り (`readScope`/`upsertList`/`deleteScopeRow`/`readSinceCursor`/`writeSinceCursor`/`deleteOlderThan`/`clearAllCache`/`readSchemaVersionMeta`/`writeMeta`/`readLastSeenCacheId`/`readDetail`/`upsertDetail`)。
- Provider (**app**): `@Riverpod(keepAlive: true) CacheDatabase cacheDatabase(Ref ref)` (`app/lib/core/cache/cache_database_provider.dart`)。

### 4.2 scope 文字列 — **app** (app feature 型依存)
- `national` / `region:<code>` / `prefecture:<code>` / `city:<code>`。
- ヘルパー `String cacheScopeOf(EarthquakeHistoryParameter)` / `bool isCacheableScope(EarthquakeHistoryParameter)` (`app/lib/feature/earthquake_history/data/cache/cache_scope.dart`)。

### 4.3 HourBucketJst 値オブジェクト — **`packages/cache`**
- `class HourBucketJst` (`packages/cache/lib/src/model/hour_bucket_jst.dart`)。
- `factory HourBucketJst.floor(DateTime instant)` — JST 時境界へ切り下げ。
- `String get value` — `yyyy-MM-ddTHH:00:00+09:00` (差分 API へ渡す)。

### 4.4 直列書き込みキュー + マージ — **`packages/cache`**
- `class CacheWriteQueue` (`packages/cache/lib/src/write/cache_write_queue.dart`) — 全 Drift 書き込みを単一直列 Future チェーン経由。`Future<T> run<T>(Future<T> Function())`。
- 純粋マージ (`packages/cache/lib/src/swr/cache_merge.dart`、**ジェネリック**で app モデル非依存):
  - `T? mergeIncoming<T>(T? existing, T incoming, DateTime Function(T) updatedAtOf)` — incoming の updatedAt < 既存 ⇒ null。
  - `DateTime? maxUpdatedAt<T>(Iterable<T> items, DateTime Function(T) updatedAtOf)`。
  - `HourBucketJst computeLastUpdatedSince({required DateTime? maxUpdatedAt, required DateTime now, required Duration retention})`。
  - `bool shouldFullReload({required DateTime? maxUpdatedAt, required DateTime now, required Duration retention})`。
- Provider (**app**): `@Riverpod(keepAlive: true) CacheWriteQueue cacheWriteQueue(Ref ref)`。

### 4.5 Chip 状態 — sealed は **`packages/cache`** / Provider は **app**
- `packages/cache/lib/src/model/cache_revalidation_state.dart`:
  ```dart
  sealed class CacheRevalidationState {}
  class CacheRevalidationIdle ...
  class CacheRevalidationRevalidating ...
  class CacheRevalidationOffline ...
  class CacheRevalidationFailed { final Object error; ... }
  ```
- 公開 Provider (**app** が定義): `cacheRevalidationStateProvider(String scope)` (`app/lib/feature/earthquake_history/data/notifier/cache_revalidation_state_notifier.dart`)。

### 4.6 自己修復・保持
- 自己修復ガード `class SelfHealGuard` (**`packages/cache`**, `packages/cache/lib/src/swr/self_heal_guard.dart`): `(eventId)` ごと 1 回まで。
- schema 検証は row パース前。不一致は bulk clear に委譲。
- 自己修復時は `httpCacheStore.evict(primaryKeyForUrl(...))` も呼ぶ (§3 の API)。
- TTL 刈り取りは `lastReportedAt` (domain age) 基準。`fetchedAt` は診断用。
- 一括 wipe トリガ: ① `cache_meta.schemaVersion != kCacheSchemaVersion` ② `/v1/start` `cacheId != cache_meta.lastSeenCacheId`。両方 Drift + `httpCacheStore.clearAll()`。結線は **app** (`CacheWipeService`)。

### 4.7 typed talker ログ — **app**
- `app/lib/core/provider/log/talker.dart` に `class EarthquakeCacheLog extends TalkerLog` 追加 (title `'EarthquakeCache'`)。

### 4.8 共有定数 — **`packages/cache`**
- `const int kCacheSchemaVersion` (`packages/cache/lib/src/cache_constants.dart`)。§3 の `kHttpCacheSchemaVersion` と同値。同一パッケージなので将来 1 定数へ統合可だが、HTTP 層とドメイン層で別世代管理したいケースに備え当面は 2 定数を同値で維持。

---

## 5. 保持戦略・運用UI 契約 (計画E が産出)
- 保持戦略 enum `CacheRetentionStrategy { keepAll, ttl90Days, none }` (**`packages/cache`**, `packages/cache/lib/src/model/cache_retention_strategy.dart`)。デフォルト `kDefaultCacheRetentionStrategy = ttl90Days`。`Duration? get ttl` / `String get label`。
- `class CachePruner` (**`packages/cache`**, `packages/cache/lib/src/retention/cache_pruner.dart`): `Future<int> pruneOnStartup({required CacheRetentionStrategy strategy, required DateTime now})`。
- 永続化 (**app**): `cacheRetentionStrategyProvider` (`app/lib/feature/settings/.../cache_retention_provider.dart`)。`shared_preferences` キー `cacheRetentionStrategy` を `SharedPreferencesKey` に追加。
- cache overlay flag (**app**): `BuildConfig.isCacheOverlayEnabled => const bool.fromEnvironment('CACHE_OVERLAY_ENABLED')`。
- 設定画面 (**app**): 「キャッシュ削除」ListTile + DB サイズ表示。
- デバッグ画面 (**app**): 保持戦略トグル。
