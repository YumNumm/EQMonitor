# 一覧のSWRキャッシュ化 (地震履歴・お知らせ) 設計書

- 日付: 2026-07-07
- 対象: Flutter アプリ (`app/`)
- 関連: 静的データの SWR 化 (地震詳細・最高震度・電文詳細など) は実装済み。本件はその一覧版。
- Issue: YumNumm/EQMonitor#1452

## 背景・目的

機内モード (オフライン) でアプリを起動すると、地震履歴一覧とお知らせ (Feed) 一覧が timeout でエラー表示になる。原因は、これらの一覧が「キャッシュがあれば即表示 → 裏で再取得して更新」になっておらず、オフライン/初回で通常取得が失敗すると即エラーになるため。

目的は、地震履歴一覧・お知らせ一覧・Home フィードシートに cache-first (キャッシュ即返し → 裏で revalidate → 更新) を導入し、オフライン/初回でもキャッシュを表示すること。差分取得 API (計画 A〜E) は非対象で従来通り全件取得。

## 現状 (調査結果)

### 一覧の実データフロー
- **お知らせ一覧タブ** (`app/lib/feature/feed/ui/page/feed_page.dart`) → `feedDataSourceProvider` → `FeedDataSource extends DataSource<String?, FeedItem>` (paging_view, `feed_data_source.dart`)。`load(Refresh)` → `_fetch(null)` → `repository.fetch(after:)` → `Success`/`Failure`。
- **地震履歴一覧タブ** (`app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`) → `earthquakeHistoryDataSourceProvider(parameter)` → `EarthquakeHistoryDataSource extends GroupedDataSource<String?, String, EarthquakePartial>` (paging_view, `earthquake_history_data_source.dart`)。`EarthquakeHistoryParameterAll` 時に provider 側で 5 分タイマー・リアルタイム `upsertItems`・app 復帰 `revalidateLatest` を設定。既定一覧 parameter は `const EarthquakeHistoryParameter.all(sortBy: .eventId, sortOrder: .desc)`。`upsertItems(byeventId)` を保持。
- **Home フィードシート** (`app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart`) → `feedProvider` (`FeedNotifier`, `@riverpod` AsyncNotifier)。素の `build()` で `repository.fetch()`。ページネーション (`fetchNextData`) あり。
- `EarthquakeHistoryNotifier` (`earthquake_history_notifier.dart`) は**消費者ゼロの死んだコード** (SWR 対象外。別途削除可)。

### 既存 SWR 基盤・UI
- `CachedNotifier` (`app/lib/core/provider/cached_notifier.dart`): `mixin on $AsyncNotifier<T>`。`fetch(ApiClient)` 実装 → `cachedBuild()` で cache-only 即返し → 背景 revalidate。**AsyncNotifier 専用** (paging DataSource には使えない)。参照実装 `start_notifier.dart`。
- cache-only クライアント: `cacheOnlyApiClientProvider` (`app/lib/core/api/cache_only_api_client_provider.dart`)。miss 時 `CacheMissException` を投げる。通常クライアント: `apiClientProvider`。
- リポジトリの client 上書きパターン既存: `FeedRepository.fetchByTelegramHash(hash, {ApiClient? client})` → `(client ?? _api)`。
- `CachedDataBanner` (`app/lib/core/component/cached_data_banner.dart`): `CachedDataBanner(values: [asyncValue...])`。いずれかが `isFromCache` (DataKind.cache) の時「更新中」表示。

## 設計

3 つの表面に cache-first を導入する。paging DataSource 2 つ (Feed 一覧・地震履歴一覧) は同じ cache-first パターンなので**共通ヘルパーに切り出す** (DRY)。Home フィードシートは AsyncNotifier なので既存 `CachedNotifier` を適用。**コード生成不要** (mixin 付与・オプション引数追加は riverpod 生成物の署名を変えない。本リポジトリは build_runner が恒常故障のため重要)。

### 0. 共通: paging cache-first ヘルパー

`app/lib/feature/.../` もしくは共通の場所に、paging DataSource の初回ページ (Refresh) を cache-first にするヘルパーを新設する。責務: cache-only で 1 ページ目を取得 → ヒットなら即 `Success` を返し、背景で通常取得して in-place 更新 (upsert) を予約 → miss/エラーなら通常取得。

インターフェース案 (ジェネリック関数):
```dart
Future<LoadResult<String?, V>> cacheFirstRefresh<V>({
  required Future<PageData<String?, V>> Function(ApiClient client) fetchPage,
  required ApiClient cacheOnlyClient,
  required ApiClient normalClient,
  required void Function(List<V> fresh) upsert, // 背景 revalidate 成功時の in-place 更新
  required bool Function() isActive,            // disposal / 世代ガード
});
```
- cache-only `fetchPage` がヒット → その `PageData` で `Success` を即返し、`Future.microtask` で通常 `fetchPage` を実行 → 成功かつ `isActive()` なら `upsert(fresh.data)`。
- cache-only が `CacheMissException` (または cache 系エラー) → 通常 `fetchPage` で `Success`/`Failure`。
- 背景 revalidate の失敗は握りつぶさず log。

### 1. お知らせ一覧タブ (`FeedDataSource`)

- `FeedRepository.fetch({String? after, ApiClient? client})` に client 上書きを追加 (`(client ?? _api)`)。
- `feedDataSource` provider で cache-only / 通常クライアントを取得し `FeedDataSource` に渡す。
- `FeedDataSource.load(Refresh)` を `cacheFirstRefresh` 経由に変更。`fetchPage(client)` = `repository.fetch(client: client)` を `PageData(data: feeds, appendKey: nextCursor)` に変換。`upsert` = 新設する `upsertItems(byid)` (FeedItem の一意 id でマージ; 既存を update / 新規を挿入)。`Append` は従来通り通常クライアント。
- 「更新中」を表す `ValueListenable<bool> isRevalidating` を公開 (cache 即返し〜背景 revalidate 完了で true)。

### 2. 地震履歴一覧タブ (`EarthquakeHistoryDataSource`)

- `EarthquakeHistoryRepository.fetchEarthquakeList(..., {ApiClient? client})` に client 上書きを追加 (`(client ?? _api)`)。
- `earthquakeHistoryDataSource` provider で cache-only / 通常クライアントを取得し DataSource に渡す。既存のタイマー・リアルタイム・app 復帰 setup は不変。
- `_isDefaultAll(parameter)` = `parameter == const EarthquakeHistoryParameter.all(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc)` (freezed 値等価)。
- `load(Refresh)` が `_isDefaultAll` の場合のみ `cacheFirstRefresh` 経由。`fetchPage(client)` = `_fetch(limit: 10, cursor: null, client: client)` を `PageData` に変換。`upsert` = 既存 `upsertItems`。それ以外 (フィルタ付き All・検索系)・`Append` は従来通り通常クライアント。
- `isRevalidating` を公開。既存 `revalidateLatest`・`upsertItems` は不変。

### 3. Home フィードシート (`FeedNotifier`)

- `FeedNotifier` に `with CachedNotifier<FeedNotifierState>` を付与。`fetch(ApiClient client)` → `repository.fetch(client: client)` を `(items, nextCursor)` に変換。`build() => cachedBuild()`。`fetchNextData` は不変 (ネットワーク専用)。
- 1 の `FeedRepository.fetch` の client 上書きを共用。

### 4. UI

- **お知らせ一覧ページ / 地震履歴一覧ページ**: 各 DataSource の `isRevalidating` を購読し、キャッシュ由来の詳細ページ等と同じ見た目の「更新中」バナーを出す (`CachedDataBanner` と揃える。paging は `AsyncValue.DataKind.cache` を持たないため flag 駆動)。
- **Home フィードシート**: `CachedNotifier` が revalidate 中に `DataKind.cache` を持つため、必要なら `CachedDataBanner(values: [feedAsyncValue])` を適用可 (任意)。

### 5. 相互作用の扱い

- paging DataSource の背景 revalidate・5 分タイマー `invalidateSelf`・リアルタイム `upsertItems` はいずれも items を操作する。既存のレース (timer invalidate vs upsert) と同程度。cache ヒット時に予約する背景 revalidate は `isActive` (disposal/世代) ガードで、DataSource 破棄後・再 Refresh 後に古い結果を反映しない。
- Feed AsyncNotifier: `CachedNotifier` の `_generation` ガードで古い revalidate の上書きを防止。

## テスト方針

- **共通ヘルパー `cacheFirstRefresh`**: cache-only ヒット → 即 `Success` + 背景で `upsert` 呼び出し / cache miss → 通常 `Success` / 通常も失敗 (オフライン) → `Failure` / `isActive()==false` で背景更新をスキップ。
- **`FeedDataSource`**: Refresh が cache-first になる / `upsertItems(byid)` が id で update/insert する / `Append` は従来通り。
- **`EarthquakeHistoryDataSource`**: `_isDefaultAll` の真偽 / 既定 All の Refresh のみ cache-first / フィルタ・検索・Append は従来経路。
- **`FeedNotifier`**: cache ヒット即返し / miss フォールバック / 背景 revalidate 更新。
- オフライン (cache ヒット) で `Failure`/`AsyncError` にならずデータ表示。

## 非対象 (Out of Scope)

- 差分取得 API (backend, 計画 A〜E)。
- 一覧のフィルタ/検索クエリのオフラインキャッシュ (地震履歴は既定 All のみ)。
- オフラインでのページネーション (Append)。
- 死んだ `EarthquakeHistoryNotifier` の削除 (任意。本 PR に含めても別でも可)。
