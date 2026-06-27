# 汎用 cache-first SWR 基盤 設計

- 日付: 2026-06-27
- 対象: Flutter アプリ (`app/`) + 共有パッケージ (`packages/cache`, `packages/eqmonitor_api`)
- ゴール: GET 系 API について「**キャッシュがあれば待たずに即表示 → 裏で ETag 再検証 → 変化があれば差し替え**」(stale-while-revalidate) を、各 feature が最小コストで載せられる**再利用可能な共通基盤**として用意する。

## 背景 / 現状

実装済みのキャッシュ層が 2 つあり、どちらも「**検証してから返す (blocking revalidation)**」方式で、ネットワーク往復 (304 でも) を待ってから表示する。

1. **HTTP 透過キャッシュ** (`packages/cache`, [2026-06-24 設計](2026-06-24-packages-cache-drift-only-design.md))
   - Drift 製。`HttpCacheInterceptor` が GET に `if-none-match` を付与し、304 ならストアから本文を復元。200 で保存。通常 Dio (`dio_provider.dart`) に組込済み。
2. **リポジトリ層キャッシュ** (例 `app/lib/feature/start/data/repository/start_repository.dart`)
   - `SharedPreferences` に body + etag を保存し、自前で `if-none-match` 送信・304/失敗時にキャッシュ返却。**(1) と機能が重複している。**

`StartNotifier.fetchInBackground` は裏で取得して state を更新するが、`build()` は `data(null)` を返すため**キャッシュを同期的に即表示していない**。

求める挙動 (SWR) は単一 Future では表現できず、状態を 2 回 emit する必要がある (= Riverpod 状態層の責務)。

### 既存 SWR 設計との関係

- 地震取得の [2026-06-23 設計](2026-06-23-earthquake-swr-cache-design.md) は、バックエンド差分 API + **ドメインモデルの Drift 永続キャッシュ**という別レイヤー・別スコープの取り組み。ページネーション一覧 (無限スクロール) を扱う。
- 本設計は **HTTP 透過キャッシュ層 (`packages/cache`) の上に汎用アプリ層 SWR を載せる**もので、層が異なり補完関係。ページネーション一覧は本基盤の初期スコープ外 (後述) とし、地震一覧は引き続き専用設計に委ねる。

## 確定方針

- **スコープ**: 再利用可能な共通 SWR 基盤 + 主要 GET エンドポイントの移行 (Tier 制、PR 分割)。
- **永続化**: HTTP 層 (`packages/cache` の `HttpCacheStore`) に一本化。`start_repository` の自前 `SharedPreferences` キャッシュ (`startEtag` / `startBody`) は**廃止**。ETag 保存・304 復元・本文保存はすべて HTTP インターセプタが担当する。
- **状態型**: 独自状態型は作らず `AsyncValue<T>` をそのまま使う。`copyWithPrevious` で stale を保持し、`isRefreshing` (= `isLoading && hasValue`) で「stale 表示中かつ裏で再検証中」を表現する。
- **再検証トリガ**: 基本は `build` 時 (+ 明示 refresh)。Provider の性質に応じて**アプリ復帰時もオプトイン**で有効化できる。
- **YAGNI**: TTL による再検証間引き・ページネーション SWR・FutureProvider のまま SWR 化 (後述) は本基盤では行わない。

## アーキテクチャ全体像

```
┌─────────────────────────────────────────────────────────────┐
│ UI (Widget)                                                   │
│   ref.watch(xxxProvider) → AsyncValue<T>                      │
│   - isRefreshing で「更新中」表示 / value で stale でも即描画  │
└───────────────▲───────────────────────────────────────────────┘
                │ AsyncValue<T>（独自状態型なし）
┌───────────────┴───────────────────────────────────────────────┐
│ CachedNotifier<T> mixin（app/core）                            │
│   build(): fetch(cacheOnlyApi) → 即return → microtaskでrevalidate│
│   revalidate(): copyWithPrevious で stale維持しつつ最新へ        │
│   （オプション）AppLifecycle 復帰時に revalidate                │
└───────┬───────────────────────────────────┬───────────────────┘
        │ cacheOnlyApiClient                │ apiClient（既存・通常Dio）
┌───────▼──────────────┐          ┌─────────▼─────────────────────┐
│ cache-only Dio (新規) │          │ 通常 Dio（既存）               │
│  CacheOnlyInterceptor │          │  HttpCacheInterceptor（既存）  │
│  - storeヒット→resolve │          │  - ETag付与/304復元/200保存    │
│  - ミス→CacheMiss例外  │          │  - ネットワーク往復            │
│  - ネットワーク行かない│          └─────────┬─────────────────────┘
└───────┬───────────────┘                    │
        └──────────────┬─────────────────────┘
                       ▼
            HttpCacheStore（共有・既存 / Drift）
```

中心的な技術判断: **同じ retrofit メソッドを「cache-only Dio」と「通常 Dio」の 2 経路で呼ぶ**ことで、型デシリアライズもキャッシュキー計算も通常経路と完全に共通化する。手書きの `fromJson` やキー再宣言を一切持ち込まない。

### コンポーネント一覧

| コンポーネント | 場所 | 役割 | 新規/変更 |
|---|---|---|---|
| `HttpCacheStore` | `packages/cache` | Drift 永続化 (既存) | 変更なし |
| `HttpCacheInterceptor` | `packages/cache` | 通常 Dio 用。ETag/304/保存 (既存) | 復元ロジック共通化のため軽微リファクタ |
| `CacheOnlyInterceptor` | `packages/cache` | cache-only Dio 用。store ヒットで即 resolve、ミスで `CacheMissException` | **新規** |
| `CacheMissException` | `packages/cache` | cache-only ミスを表す例外。export する | **新規** |
| 共通本文復元関数 | `packages/cache` | json/plain/bytes 復元を両インターセプタで共有 | **新規 (切り出し)** |
| cache-only Dio provider | `app/lib/core/provider/` | 通常 Dio と同一 baseUrl/cacheStore。auth 系 interceptor は付けない | **新規** |
| `cacheOnlyApiClientProvider` | `app/lib/core/api/` | cache-only Dio で `ApiClient` 生成 | **新規** |
| 共通 BaseOptions ビルダー | `app/lib/core/provider/` | 通常/cache-only Dio で URI 関連設定 (baseUrl, listFormat 等) を揃える | **新規 (切り出し)** |
| `CachedNotifier<T>` mixin | `app/lib/core/` | 2 フェーズ emit + ライフサイクル復帰オプトイン | **新規** |
| 各 feature notifier | `app/lib/feature/*` | `CachedNotifier` を mix-in し `fetch(ApiClient)` を 1 つ実装 | 変更 (移行) |

## セクション1: cache 層の変更 (`packages/cache`)

cache-only Dio 用のインターセプタと例外を追加。既存 `HttpCacheInterceptor` の挙動は不変 (復元ロジックの共通関数への切り出しのみ)。

```dart
/// cache-only Dio 専用。ネットワークには一切出ず、
/// ストアにヒットすれば復元、ミスなら CacheMissException を投げる。
class CacheOnlyInterceptor extends Interceptor {
  CacheOnlyInterceptor(this.store);
  final HttpCacheStore store;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.method.toUpperCase() != 'GET') {
      handler.reject(_cacheMiss(options));    // GET 以外はキャッシュ対象外
      return;
    }
    final key = store.primaryKeyForUrl(options);   // 通常 Dio と同一のキー計算
    final cached = await store.read(key);
    if (cached == null) {
      handler.reject(_cacheMiss(options));
      return;
    }
    handler.resolve(restoreResponse(options, cached));   // 復元 Response で短絡
  }

  DioException _cacheMiss(RequestOptions o) => DioException(
        requestOptions: o,
        type: DioExceptionType.unknown,
        error: const CacheMissException(),
      );
}
```

- **キー計算 `store.primaryKeyForUrl` を共有**するため、通常 Dio が保存したエントリと cache-only Dio が読むキーは構造的に一致する。
- `restoreResponse` (json/bytes/plain の復元) は既存 `HttpCacheInterceptor._restore` を共通関数へ切り出して両者で共有する。
- `CacheMissException` は `packages/cache` が export し、`CachedNotifier` 側で「キャッシュ無し」と判定する。
- cache-only Dio は `handler.reject` で即エラーを返すため、ネットワークタイムアウト等は発生しない。

### app 側 provider

```dart
@Riverpod(keepAlive: true)
Future<Dio> cacheOnlyDio(Ref ref) async {
  final store = await ref.watch(httpCacheStoreProvider.future);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final dio = Dio(buildApiBaseOptions(telegramUrl));   // 通常 Dio と共通のビルダー
  dio.interceptors.add(CacheOnlyInterceptor(store));   // auth/appcheck/logger は付けない
  return dio;
}

@Riverpod(keepAlive: true)
Future<ApiClient> cacheOnlyApiClient(Ref ref) async =>
    ApiClient(await ref.watch(cacheOnlyDioProvider.future));
```

- cache-only Dio と通常 Dio は**同一の `HttpCacheStore` インスタンス** (`httpCacheStoreProvider`) を共有する。
- **baseUrl・`listFormat` 等 URI に影響する設定を通常 Dio と完全に揃える**必要がある (キーが URI 由来のため)。共通の `buildApiBaseOptions` に切り出し、`dio_provider.dart` の通常 Dio もこれを使うようにリファクタする。
- cache-only Dio はネットワークに出ないため、認証・AppCheck・device-id 等のインターセプタは不要 (付けない)。

## セクション2: `CachedNotifier<T>` mixin (`app/core`)

riverpod_generator は `class X extends _$X` を要求するため、基底は **mixin** とし `extends _$Foo with CachedNotifier<T>` の形で使う。各 feature は `fetch(ApiClient)` を 1 つ実装するだけ (cache-only / 通常で同じメソッドを呼ぶので重複しない)。

```dart
/// キャッシュ優先 + 裏で再検証する Notifier の共通 mixin。
///
/// - build(): cache-only を試し、ヒットすれば即返して裏で再検証。
///   ミス (CacheMissException) なら通常ロード。
/// - 状態は AsyncValue<T> のまま。stale 表示中は isRefreshing=true。
mixin CachedNotifier<T> on AsyncNotifier<T> {
  /// cache-only / 通常を問わず、渡された client で取得する。
  /// ETag 付与・304 復元・保存は通常 Dio のインターセプタが担当するため、
  /// ここではドメインの取得処理だけを書く。
  Future<T> fetch(ApiClient client);

  /// cache-only ApiClient (cache-only Dio 経由)。
  Future<ApiClient> get _cacheOnlyApi;   // ref.read(cacheOnlyApiClientProvider.future)
  /// 通常 ApiClient (通常 Dio 経由)。
  Future<ApiClient> get _networkApi;     // ref.read(apiClientProvider.future)

  /// アプリ復帰時にも再検証するか (Provider ごとにオーバーライド)。
  bool get revalidateOnAppResume => false;

  @override
  Future<T> build() async {
    if (revalidateOnAppResume) {
      _listenAppLifecycle();   // 復帰イベントで revalidate を発火
    }
    try {
      final cached = await fetch(await _cacheOnlyApi);
      Future.microtask(revalidate);   // 返した直後に裏で再検証
      return cached;                  // → AsyncData(stale) を即表示
    } on CacheMissException {
      return fetch(await _networkApi);   // キャッシュ無し → 通常ロード
    }
  }

  /// 明示的再検証 / 裏での再検証。stale を維持したまま最新へ。
  Future<void> revalidate() async {
    state = const AsyncLoading<T>().copyWithPrevious(state);   // isRefreshing=true
    try {
      state = AsyncData(await fetch(await _networkApi));       // 最新 (304 はストア復元値)
    } on Exception catch (e, st) {
      state = AsyncError<T>(e, st).copyWithPrevious(state);    // stale を残したままエラー通知
    }
  }
}
```

> `_cacheOnlyApi` / `_networkApi` / `_listenAppLifecycle` は mixin から `ref` 経由で実装する。`ref` は `AsyncNotifier` が持つため `on AsyncNotifier<T>` 制約で利用可能。

### AsyncValue による状態表現

| SWR の状態 | AsyncValue での表現 |
|---|---|
| キャッシュ無しの初回ロード中 | `isLoading && !hasValue` |
| **stale 表示 + 裏で再検証中** | `isRefreshing` (= `isLoading && hasValue`)。`value` = stale |
| 再検証完了 (最新) | `AsyncData(fresh)`、`isLoading:false` |
| 再検証失敗だが stale 維持 | `AsyncError.copyWithPrevious(AsyncData(stale))` → `hasValue:true, value:stale, hasError:true` |

独自の `SwrState<T>` 型は不要。UI・各 feature とも通常の Riverpod 作法のまま扱える。

### feature 実装例 (start)

```dart
@Riverpod(keepAlive: true)
class StartCache extends _$StartCache with CachedNotifier<StartResponse> {
  @override
  Future<StartResponse> fetch(ApiClient client) async =>
      (await client.start.getV1Start()).data;
  // ETag 付与・304 復元・保存はすべて通常 Dio のインターセプタが担当 (repository 不要)
}
```

### FutureProvider の扱い

2 フェーズ emit は本質的に Notifier (クラス型) を要求する。`FutureProvider` (関数型 `@riverpod Future<T> foo(ref)`) は単一 Future しか返せず状態を 2 回 emit できない。

- SWR 対象で現状 `FutureProvider` のものは、移行時に**クラス型 (`@riverpod class X extends _$X with CachedNotifier<T>`) へ変換**する (Riverpod codegen の標準的方向)。
- 「キャッシュ即表示」が不要な単純な FutureProvider (EEW/realtime 等の非キャッシュ系) はそのまま据え置き、本基盤の対象外。
- `ref.invalidateSelf` や stage 管理用の伴走 StateProvider で FutureProvider のまま SWR 化することは、リーク・複雑さを生むため**行わない** (YAGNI)。

## セクション3: 移行対象 (Tier 制)

### Tier 1 — 静的・過去データ (SWR の恩恵大。優先移行)

- `/v1/start` (PoC 兼)、`/v1/changelog`
- `/v2/parameters/manifest`・`/v2/parameters/{type}`
- `/v2/earthquake/{eventId}`・`/v2/earthquake/{eventId}/similar`、`/v2/tsunami/{eventId}` 等の**確定済み過去データ** (不変なのでキャッシュが特に効く)

### Tier 2 — ユーザー設定系 (SWR 可だが書き込み連動が必要)

- `/v2/subscription/me`、`/v2/device/me/settings/*`、`/v2/user/me`
- **書き込み連動 evict**: これらは PUT/POST で更新される。書き込み成功時に該当 GET のキャッシュを `store.evict(key)` しないと直後の表示が古いままになる。書き込み repository に evict を仕込む。

### 対象外 — 常に最新が必要 / 一過性

- `/v2/realtime/ticket`、`/v2/eew/*`、`/v2/device/me/live-activity`、admin 系

### 保留 — ページネーション (初期スコープ外)

- `/v2/earthquake` (一覧)、`/v2/telegram`、`/v2/feeds`、通知履歴系
- クエリ (ページ/カーソル) ごとに別キャッシュエントリになり、無限スクロールでの cache-first 表示は別途設計が要る。地震一覧は [2026-06-23 設計](2026-06-23-earthquake-swr-cache-design.md) のドメインキャッシュに委ねる。基盤が固まった後に検討。

## セクション4: エラー処理・エッジケース

- **cache-only ミス** → `CacheMissException` → 通常ロード (初回 `AsyncLoading` → `AsyncData`)。
- **再検証失敗 (オフライン等)** → `AsyncError.copyWithPrevious` で stale 維持しつつエラー通知。UI は古い値を出し続けられる。
- **書き込み後の不整合** → Tier 2 は write 時 evict。
- **schemaVersion / appBuild 変更** → キャッシュキー (`v$schemaVersion:$appBuild:$url`) に含まれるため自動失効 (既存挙動)。
- **`fetch(cacheOnly)` のデシリアライズ失敗** (旧スキーマ等) → 例外を `CacheMissException` 相当として扱い、通常ロードへフォールバックする (壊れたキャッシュで固まらない)。

## セクション5: テスト戦略

- **`packages/cache`**:
  - `CacheOnlyInterceptor` 単体: ヒットで復元 Response を resolve / ミスで `CacheMissException` / GET 以外で reject。
  - 復元ロジック共通化の回帰 (既存 `http_cache_interceptor_test` が緑のまま)。
- **`app/core`**: `CachedNotifier` mixin の状態遷移を偽 `ApiClient` または `http_mock_adapter` で検証。
  - cache hit → stale 即 emit → fresh。
  - cache miss → 通常ロード。
  - 再検証失敗で stale 維持 (`hasValue && hasError`)。
  - `revalidateOnAppResume=true` 時のアプリ復帰再検証。
- **各 feature 移行**: 既存の `*_cache_key_test` (`start` / `changelog`)・`parameter_repository_refresh_test` を新方式へ置換。
- **統合**: start 移行で end-to-end (cache 即表示 → 304 → 変化なし、200 → 差し替え) を確認。

## セクション6: PR 分割

1. **PR-1 基盤**: `CacheOnlyInterceptor` + `CacheMissException` + 復元共通化 (`packages/cache`)、cache-only Dio / `cacheOnlyApiClientProvider`、共通 `buildApiBaseOptions`、`CachedNotifier` mixin + テスト。
2. **PR-2 start 移行**: Start を `CachedNotifier` 化、`start_repository` の自前 prefs キャッシュ (`startEtag`/`startBody`) 廃止、旧 test 置換。
3. **PR-3 以降**: Tier 1 各エンドポイント (changelog / parameters / earthquake detail / tsunami detail) を順次。さらに細分化可。
4. **後続**: Tier 2 (write 連動 evict 込み)。ページネーション対応は別設計。

## 確定した決定事項

1. スコープ: 再利用可能な汎用 SWR 基盤 + 主要 GET の Tier 制移行 (PR 分割)。
2. 永続化は HTTP 層 (`packages/cache` `HttpCacheStore`) に一本化。`start_repository` の自前 prefs キャッシュは廃止。
3. 状態型は独自型を作らず `AsyncValue<T>` + `copyWithPrevious`。stale 表示中は `isRefreshing`。
4. 即表示は cache-only Dio が同一 store を読むことで実現。型デシリアライズ・キー計算は通常経路と完全共通。
5. cache-only Dio と通常 Dio は同一 `HttpCacheStore` を共有し、URI 関連 BaseOptions を共通ビルダーで揃える。
6. 基底は mixin `CachedNotifier<T> on AsyncNotifier<T>`。各 feature は `fetch(ApiClient)` を 1 つ実装。
7. 再検証は build 時 (+ 明示 refresh)。`revalidateOnAppResume` でアプリ復帰時もオプトイン可能。
8. cache-only ミスは `CacheMissException`、デシリアライズ失敗も同等扱いで通常ロードへフォールバック。再検証失敗は stale 維持。
9. SWR 対象の FutureProvider はクラス型へ変換。非キャッシュ系 FutureProvider は据え置き。
10. Tier 1 (静的・過去データ) を優先。Tier 2 (設定系) は write 連動 evict。realtime/EEW/admin は対象外。ページネーションは初期スコープ外。
11. 地震一覧の SWR は別レイヤー (2026-06-23 設計のドメイン Drift キャッシュ) に委ね、本基盤と補完関係。

## 実装計画フェーズで詰める未解決論点

- `_listenAppLifecycle` の実装手段 (既存の AppLifecycle 監視 provider があれば再利用)。
- `CachedNotifier` mixin から `ref` 経由で cache-only / 通常 ApiClient を取得する具体的配線 (provider 参照の持たせ方)。
- Tier 2 の write 連動 evict を、どの層 (repository / interceptor) でどう発火するか。
- 共通 `buildApiBaseOptions` 切り出しに伴う既存 `dio_provider.dart` のリファクタ範囲。
