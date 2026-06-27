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

- **スコープ**: 再利用可能な共通 SWR 基盤 + `/v1/start` の移行を**本 spec のコミット対象**とする。他の GET エンドポイント(Tier 1 残り / Tier 2)は方向性のみ示し、後続の別 spec で詰める(レビュー指摘によるスコープ過大回避)。
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
- `restoreResponse` (json/bytes/plain の復元) は既存 `HttpCacheInterceptor._restore` を共通関数へ切り出して両者で共有する。復元 Response の `statusCode` は**常に 200 に正規化**する(retrofit の status 検証・`validateStatus` 差異で弾かれないため。`HttpCacheInterceptor._toEntry` は 200 のみ保存するので実害は薄いが明示する)。
- `CacheMissException` は `packages/cache` が export する。ただし `handler.reject` 経由では呼び出し側に `DioException(.error == CacheMissException())` として届く(dio 5.9.2 はこの `DioException` をそのまま rethrow)。判定漏れを防ぐため、`bool isCacheMiss(Object e)`(`CacheMissException` 本体と `DioException(.error is CacheMissException)` の両方を真とする)を併せて export し、`CachedNotifier` はこれで判定する。なお実装上 `CachedNotifier` の cache-only 経路は包括 catch でフォールバックするため、parse 失敗も含めて取りこぼさない(セクション2・4 参照)。
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
- cache-only Dio はネットワークに出ないため、認証・AppCheck・device-id 等のインターセプタは不要 (付けない)。復元 Response は status 200 に正規化されるため `validateStatus` は既定 (200 OK) のままでよい。
- 認証必須エンドポイントでも cache-only 経路は store ヒット時に認証なしで復元する(設計意図どおり。store への保存は通常 Dio 経由の 200 取得時のみ発生するため、未取得なら CacheMiss → 通常ロードで認証が走る)。トークン失効中に stale を表示し続ける挙動は許容する。

## セクション2: `CachedNotifier<T>` mixin (`app/core`)

riverpod_generator (3.2.1) は `class X extends _$X` を要求し、`Future<T> build()` のクラス Notifier の生成基底は `abstract class _$X extends $AsyncNotifier<T>`(`$` 付き)。レガシーの `AsyncNotifier` は `$AsyncNotifier` の**サブクラス**なので、mixin 制約は **`on $AsyncNotifier<T>`** にしなければコンパイルできない(`on AsyncNotifier<T>` は不可)。`ref` は `AnyNotifier`/`$AsyncNotifier` 上に定義されるためこの制約で利用可能。各 feature は `fetch(ApiClient)` を 1 つ実装するだけ。

cache-only 経路は**投機的読み出し**なので、cache-miss(`DioException(.error=CacheMissException)`)もデシリアライズ失敗(retrofit が元例外を rethrow)も区別せず**包括 catch で通常ロードへフォールバック**し、壊れたエントリは evict する。`isCacheMiss(Object)` ヘルパを `packages/cache` から export し判定に使う。

```dart
/// キャッシュ優先 + 裏で再検証する Notifier の共通 mixin。
///
/// - build(): cache-only を試し、ヒットすれば即返して裏で再検証。
///   失敗(ミス/パース不整合)なら通常ロード。
/// - 状態は AsyncValue<T> のまま。stale 表示中は isRefreshing=true。
mixin CachedNotifier<T> on $AsyncNotifier<T> {
  /// cache-only / 通常を問わず、渡された client で取得する。
  /// ETag 付与・304 復元・保存は通常 Dio のインターセプタが担当するため、
  /// ここではドメインの取得処理だけを書く。family の場合は引数を this から読む。
  Future<T> fetch(ApiClient client);

  Future<ApiClient> get _cacheOnlyApi => ref.read(cacheOnlyApiClientProvider.future);
  Future<ApiClient> get _networkApi => ref.read(apiClientProvider.future);

  /// アプリ復帰時にも再検証するか (Provider ごとにオーバーライド)。
  bool get revalidateOnAppResume => false;

  Future<void>? _inflight;   // in-flight な再検証(競合防止)

  @override
  Future<T> build() async {
    if (revalidateOnAppResume) {
      // 既存 app_lifecycle provider を ref.listen し、resumed で revalidate。
      // build 再実行ごとの二重登録は ref.listen の購読差し替えで回避。
      _listenAppLifecycleForResume();
    }
    try {
      final cached = await fetch(await _cacheOnlyApi);
      Future.microtask(revalidate);   // 返した直後に裏で再検証
      return cached;                  // → AsyncData(stale) を即表示
    } catch (_) {
      // cache-only はネットワークに出ないため、ここに来る例外は
      // cache-miss か壊れたキャッシュのみ。どちらも通常ロードへ。
      return fetch(await _networkApi);   // → 初回 AsyncLoading → AsyncData
    }
  }

  /// 明示的再検証 / 裏での再検証。stale を維持したまま最新へ。
  /// 多重発火(build microtask / 明示 refresh / 復帰)は in-flight で 1 本化する。
  Future<void> revalidate() {
    return _inflight ??= _revalidate().whenComplete(() => _inflight = null);
  }

  Future<void> _revalidate() async {
    if (!ref.mounted) {
      return;   // dispose 済み Notifier への state 代入クラッシュを防ぐ
    }
    state = const AsyncLoading<T>().copyWithPrevious(state);   // isRefreshing=true
    try {
      final fresh = await fetch(await _networkApi);
      if (!ref.mounted) {
        return;
      }
      state = AsyncData(fresh);                                // 最新 (304 はストア復元値)
    } on Exception catch (e, st) {
      if (!ref.mounted) {
        return;
      }
      state = AsyncError<T>(e, st).copyWithPrevious(state);    // stale を残したままエラー通知
    }
  }
}
```

> `_listenAppLifecycleForResume` は既存 `app/lib/core/provider/app_lifecycle.dart`(`AppLifecycle`)を `ref.listen` して resumed を拾う。`_inflight` ガードにより「遅く完了した再検証が新しい値を上書きする(last-write-wins 逆転)」を防ぐ。

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
class StartNotifier extends _$StartNotifier with CachedNotifier<StartResponse> {
  @override
  Future<StartResponse> fetch(ApiClient client) async =>
      (await client.start.getV1Start()).data;   // ifNoneMatch は渡さない(下記注意)
  // ETag 付与・304 復元・保存はすべて通常 Dio のインターセプタが担当 (repository 不要)
}
```

移行時の注意:
- **公開 provider 名と型契約を変えない**: 既存 `StartNotifier`/`startProvider` を流用し、現在の `AsyncValue<StartResponse?>`(nullable・初期 `data(null)`)から `CachedNotifier<StartResponse>`(non-null・初回 `AsyncLoading`)へ**型が変わる**。`startProvider` の消費者(`splash_page.dart`, `debug_page.dart`, `maintenance_banner.dart`, `forced_update_dialog.dart`, `whats_new_banner.dart`)の null 取り扱い・loading 表現を PR-2 で個別に追従させる。
- **`ifNoneMatch` パラメータは呼び出し側で渡さない**: `getV1Start({ifNoneMatch})` のような retrofit 引数を指定すると、`HttpCacheInterceptor` が付与する `if-none-match` ヘッダと二重・競合する。ETag は常にインターセプタ任せ。
- **family エンドポイント**(`@Path('eventId')` 等)は `fetch(ApiClient)` に引数の口が無いため、family Notifier の引数(`this`/provider 引数)から読んで `client.earthquake.getV2EarthquakeEventId(this.eventId)` のように呼ぶ。

### FutureProvider の扱い

2 フェーズ emit は本質的に Notifier (クラス型) を要求する。`FutureProvider` (関数型 `@riverpod Future<T> foo(ref)`) は単一 Future しか返せず状態を 2 回 emit できない。

- SWR 対象で現状 `FutureProvider` のものは、移行時に**クラス型 (`@riverpod class X extends _$X with CachedNotifier<T>`) へ変換**する (Riverpod codegen の標準的方向)。
- 「キャッシュ即表示」が不要な単純な FutureProvider (EEW/realtime 等の非キャッシュ系) はそのまま据え置き、本基盤の対象外。
- `ref.invalidateSelf` や stage 管理用の伴走 StateProvider で FutureProvider のまま SWR 化することは、リーク・複雑さを生むため**行わない** (YAGNI)。

## セクション3: 移行対象 (Tier 制)

> **本 spec のコミット対象スコープ**は基盤(PR-1)+ `/v1/start` 移行(PR-2)に絞る。下記 Tier 1 の他エンドポイント・Tier 2 は方向性のみ示し、各々を**別 spec**として後続で詰める(レビュー指摘: スコープ過大の回避、parameters/Tier2 の非互換を本 spec から排除)。

### Tier 1 — 静的・過去データ (SWR の恩恵大。後続で順次)

- `/v1/start` (本 spec の PoC)、`/v1/changelog`
- `/v2/earthquake/{eventId}`・`/v2/earthquake/{eventId}/similar`、`/v2/tsunami/{eventId}` 等の**確定済み過去データ**(family。不変なのでキャッシュが特に効く)
- **parameters は対象外**: `/v2/parameters/*` はローカルファイル永続化 + manifest 検証 + アセット fallback の独自オーケストレーション(`app/lib/feature/parameter/data/repository/parameter_repository.dart`)で、`fetch(ApiClient):Future<T>` / `AsyncValue<T>` 単一値モデルに乗らない。本基盤の対象にしない。

### Tier 2 — ユーザー設定系 (後続・別 spec)

- `/v2/device/me/settings/*` 等(`/v2/user/me`・`/v2/subscription/me` は現状 app/lib に消費者ゼロのため当面除外 = YAGNI)。
- **書き込み連動の無効化は evict ではなく revalidate/invalidate**: 当初案の「write 成功時に `store.evict(key)`」は、key が URI 由来(`store.primaryKeyForUrl(RequestOptions)`)で write 側が GET の URI/`@Path`/baseUrl を再構築する必要があり、「キー再宣言を持ち込まない」中心思想に反する(`@Path` 動的・1 write→複数 GET もある)。代わりに **write 成功後に対応する `CachedNotifier` の `revalidate()`(または `ref.invalidate`)を叩く**。これで HTTP インターセプタが ETag 再検証し、サーバ反映済みの最新へ更新される。プレフィックス単位 evict が必要なら `HttpCacheStore` に専用 API を足すのは別 spec で検討。

### 対象外 — 常に最新が必要 / 一過性

- `/v2/realtime/ticket`、`/v2/eew/*`、`/v2/device/me/live-activity`、admin 系

### 保留 — ページネーション (初期スコープ外)

- `/v2/earthquake` (一覧)、`/v2/telegram`、`/v2/feeds`、通知履歴系
- クエリ (ページ/カーソル) ごとに別キャッシュエントリになり、無限スクロールでの cache-first 表示は別途設計が要る。地震一覧は [2026-06-23 設計](2026-06-23-earthquake-swr-cache-design.md) のドメインキャッシュに委ねる。基盤が固まった後に検討。

## セクション4: エラー処理・エッジケース

- **cache-only ミス / 壊れたキャッシュ** → cache-only 経路は**包括 catch** で通常ロードへフォールバック(初回 `AsyncLoading` → `AsyncData`)。cache-miss(`DioException(.error=CacheMissException)`)も旧スキーマでのデシリアライズ失敗(retrofit が元例外を rethrow)も区別せず吸収する。デシリアライズ失敗時は該当エントリを `store.evict(key)` し、同じ失敗の再発を防ぐ。
- **再検証失敗 (オフライン等)** → `AsyncError.copyWithPrevious` で stale 維持しつつエラー通知。UI は古い値を出し続けられる。
- **多重 revalidate** → `_inflight` ガードで 1 本化(last-write-wins 逆転を防ぐ)。dispose 後は `ref.mounted` チェックで state 代入を抑止。
- **書き込み後の不整合** → Tier 2 は write 成功後に対応 Notifier の `revalidate()`/`ref.invalidate`(evict ではない。セクション3 参照)。
- **schemaVersion / appBuild 変更** → キャッシュキー (`v$schemaVersion:$appBuild:$url`) に含まれるため自動失効 (既存挙動)。
- **`cacheId`(キャッシュ世代)変更** → キーに含まれないため**自動失効しない**(下記セクション5 で扱う)。

## セクション5: cacheId 一括 wipe との整合(`/v1/start`)

[2026-06-23 設計](2026-06-23-earthquake-swr-cache-design.md) は `/v1/start`(`StartResponse`)に `cacheId`(キャッシュ世代トークン)を載せ、クライアントが起動時に `last_seen_cache_id` と比較して**変化していたら Drift + HTTP キャッシュを全 wipe** する。本基盤が同じ `/v1/start` を cache-first SWR 化すると、cold start ではまず stale を即返すため、cacheId 比較と wipe の起動シーケンスが問題になる。

- **責務分界**: cacheId 比較と一括 wipe(`HttpCacheStore.clearAll()` 呼び出し)の**オーナーは 2026-06-23 設計側**とし、本基盤は wipe の手段(`clearAll`)を提供するに留める。
- **順序**: 起動時は `/v1/start` の stale を即表示(ブロックしない)。`revalidate()` 完了で最新 `StartResponse` が得られた時点で `cacheId` を比較し、不一致なら `clearAll()` + 再ロード。旧世代データが一時表示される window は 2026-06-23 設計の方針どおり許容(バンプは稀)。
- **本 spec での扱い**: cacheId 比較ロジック自体は本 spec の実装対象に**含めない**(別設計の責務)。ただし「`/v1/start` を SWR 化しても cacheId 比較が revalidate 完了後に発火できる」ことを PoC で確認し、矛盾しないことを担保する。詳細な起動シーケンス統合は未解決論点に挙げる。

## セクション6: テスト戦略

- **`packages/cache`**:
  - `CacheOnlyInterceptor` 単体: ヒットで復元 Response を resolve / ミスで `DioException(.error=CacheMissException)` を reject / GET 以外で reject。
  - `isCacheMiss` ヘルパが `CacheMissException` 本体と `DioException(.error is CacheMissException)` の両方を真と判定する。
  - 復元 Response の status が 200 に正規化される / responseType (json/plain/bytes) ごとの往復が壊れない回帰 (既存 `http_cache_interceptor_test` が緑のまま)。
- **cache-only 経路の retrofit 整合**: cache-only Dio が `handler.resolve` した復元 Response を retrofit が `T.fromJson` まで通せること(`responseType==json` 前提)を統合テストで確認。
- **`app/core`**: `CachedNotifier` mixin の状態遷移を偽 `ApiClient` または `http_mock_adapter` で検証。
  - cache hit → stale 即 emit → fresh。
  - cache miss → 通常ロード。
  - 壊れたキャッシュ(parse 失敗)→ 包括 catch で通常ロード + 該当エントリ evict。
  - 再検証失敗で stale 維持 (`hasValue && hasError`)。
  - 多重 revalidate が `_inflight` で 1 本化され last-write-wins 逆転が起きない。
  - dispose 後の revalidate が `ref.mounted` ガードでクラッシュしない。
  - `revalidateOnAppResume=true` 時のアプリ復帰再検証。
- **start 移行に伴うテスト整理**: `start_repository_cache_key_test` は prefs キャッシュ廃止に伴い**削除**(等価カバレッジは `packages/cache` の HTTP インターセプタ test が担保)。`changelog_repository_cache_key_test`・`parameter_repository_refresh_test` は本 spec のコミット対象外(後続 spec で扱う)なので**触らない**。
- **統合**: start 移行で end-to-end (cache 即表示 → 304 → 変化なし、200 → 差し替え) を確認。

## セクション7: PR 分割

**本 spec のコミット対象は PR-1 + PR-2 のみ。** 以降は方向性として記す。

1. **PR-1 基盤**: `CacheOnlyInterceptor` + `CacheMissException` + `isCacheMiss` + 復元共通化/status 正規化 (`packages/cache`)、cache-only Dio / `cacheOnlyApiClientProvider`、共通 `buildApiBaseOptions`、`CachedNotifier` mixin(`on $AsyncNotifier<T>`・`_inflight`/`ref.mounted` ガード)+ テスト。
2. **PR-2 start 移行**: `StartNotifier` を `CachedNotifier` 化(provider 名維持・型 nullable→non-null に伴う消費者 6 箇所の追従)、`start_repository` の自前 prefs キャッシュ (`startEtag`/`startBody`) 廃止、`start_repository_cache_key_test` 削除。cacheId 比較が revalidate 完了後に発火できることの確認。
3. **後続(別 spec)**: Tier 1 の changelog / earthquake detail / tsunami detail(family)を順次。
4. **後続(別 spec)**: Tier 2(`device/me/settings/*`、write 後 revalidate/invalidate)。parameters・ページネーション・cacheId wipe 統合はそれぞれ別設計。

## 確定した決定事項

1. スコープ: 再利用可能な汎用 SWR 基盤 + `/v1/start` 移行(本 spec のコミット対象)。他エンドポイント/Tier 2/parameters/ページネーションは後続別 spec。
2. 永続化は HTTP 層 (`packages/cache` `HttpCacheStore`) に一本化。`start_repository` の自前 prefs キャッシュは廃止。
3. 状態型は独自型を作らず `AsyncValue<T>` + `copyWithPrevious`。stale 表示中は `isRefreshing`。
4. 即表示は cache-only Dio が同一 store を読むことで実現。型デシリアライズ・キー計算は通常経路と完全共通。
5. cache-only Dio と通常 Dio は同一 `HttpCacheStore` を共有し、URI 関連 BaseOptions を共通ビルダーで揃える。復元 Response は status 200 に正規化。
6. 基底は mixin **`CachedNotifier<T> on $AsyncNotifier<T>`**(生成基底が `$AsyncNotifier`。`AsyncNotifier` では `on` 制約不成立)。各 feature は `fetch(ApiClient)` を 1 つ実装。
7. 再検証は build 時 (+ 明示 refresh)。`revalidateOnAppResume` でアプリ復帰時もオプトイン可能。多重発火は `_inflight` で 1 本化、dispose は `ref.mounted` ガード。
8. cache-only 経路は包括 catch で、cache-miss(`DioException(.error=CacheMissException)`、`isCacheMiss` で判定)もデシリアライズ失敗も通常ロードへフォールバック(失敗時は evict)。再検証失敗は stale 維持。
9. SWR 対象の FutureProvider はクラス型へ変換。非キャッシュ系 FutureProvider は据え置き。
10. Tier 2 の書き込み連動は **evict ではなく revalidate/invalidate**(key 再構築を避けるため)。realtime/EEW/admin は対象外。parameters は独自層のため対象外。
11. 地震一覧の SWR は別レイヤー (2026-06-23 設計のドメイン Drift キャッシュ) に委ね、本基盤と補完関係。
12. `cacheId` 一括 wipe は 2026-06-23 設計の責務。本基盤は `clearAll()` を提供し、`/v1/start` の SWR 化が cacheId 比較(revalidate 完了後発火)と矛盾しないことのみ担保。

## 実装計画フェーズで詰める未解決論点

- `_listenAppLifecycleForResume` の具体実装(既存 `app/lib/core/provider/app_lifecycle.dart` の `AppLifecycle` を `ref.listen`。build 再実行時の購読重複回避)。
- family Notifier(`@Path` 付き)で `fetch(ApiClient)` が provider 引数を読む配線パターン(PR-2 では非 family の start のみ)。
- 共通 `buildApiBaseOptions` 切り出しに伴う既存 `dio_provider.dart` のリファクタ範囲(`validateStatus`・`listFormat`・timeout の共有境界)。
- `/v1/start` SWR 化と cacheId 一括 wipe の起動シーケンス統合(本 spec は非矛盾の確認まで。実装は 2026-06-23 設計側)。
- `StartResponse?` → `StartResponse` 非 null 化に伴う `startProvider` 消費者(`splash_page` / `debug_page` / `maintenance_banner` / `forced_update_dialog` / `whats_new_banner`)の個別追従方針。
