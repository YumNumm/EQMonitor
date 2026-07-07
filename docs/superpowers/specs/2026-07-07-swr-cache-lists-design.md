# 一覧のSWRキャッシュ化 (地震履歴・お知らせ) 設計書

- 日付: 2026-07-07
- 対象: Flutter アプリ (`app/`)
- 関連: 静的データの SWR 化 (地震詳細・最高震度・電文詳細など) は実装済み。本件はその一覧版。

## 背景・目的

機内モード (オフライン) でアプリを起動すると、地震履歴一覧とお知らせ (Feed) 一覧が timeout でエラー表示になる。原因は、既存の SWR 基盤 `CachedNotifier` (キャッシュ即返し → 裏で revalidate → 前値保持) が、この 2 つの一覧 Notifier に適用されていないため。他の多くの Notifier (地震詳細・県別/市別最高震度・電文詳細・お知らせ詳細・パラメータ等) は既に SWR 化済み。

目的は、地震履歴の**デフォルト一覧**とお知らせ一覧に `CachedNotifier` を適用し、オフライン/初回でも「キャッシュがあれば即表示し、裏で再取得して更新する」挙動にすること。差分取得 API (計画 A〜E) は非対象で、従来通り全件取得のまま。

## 現状 (調査結果)

### 既存 SWR 基盤 `CachedNotifier`
`app/lib/core/provider/cached_notifier.dart`。`mixin CachedNotifier<T> on $AsyncNotifier<T>`。

- `Future<T> fetch(ApiClient client)` を実装側が定義。
- `cachedBuild()`: cache-only クライアントで取得 → 即 return → マイクロタスクで背景 revalidate 予約。cache miss → 通常クライアントで取得。corrupt cache → force-fresh。
- `_revalidateInBackground(gen, cached)`: `state = AsyncLoading.copyWithPrevious(AsyncData(cache, kind: cache))` → fresh 取得 → `AsyncData(fresh)`。失敗時は `AsyncError.copyWithPrevious(state)` で前値保持。`_generation` ガードで古い revalidate の上書きを防止。
- `revalidateOnAppResume` (既定 false): app 復帰時に `invalidateSelf`。

定型パターン (`start_notifier.dart`):
```dart
class StartNotifier extends _$StartNotifier with CachedNotifier<StartResponse> {
  @override
  Future<StartResponse> fetch(ApiClient client) async =>
      (await client.start.getV1Start()).data;
  @override
  Future<StartResponse> build() => cachedBuild();
}
```
family notifier への適用実績あり (`earthquake_history_details_notifier` 等)。

リポジトリ側は client 上書きを受ける形が既存 (`FeedRepository.fetchByTelegramHash(hash, {ApiClient? client})` → `(client ?? _api)`)。

### 対象 (未 SWR 化)
- **お知らせ**: `app/lib/feature/feed/data/notifier/feed_notifier.dart`: `@riverpod class FeedNotifier`。`build()` で `repository.fetch()`。ページネーション (`fetchNextData`, nextCursor) あり。`feedProvider` として Home フィードシート・お知らせ一覧ページで使用中 (実利用あり)。
- **地震履歴**: 実際の一覧は `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart` の **`earthquakeHistoryDataSourceProvider(parameter)`** (family) が返す `EarthquakeHistoryDataSource extends GroupedDataSource<String?, String, EarthquakePartial>` (paging_view)。`earthquake_history_page.dart` が唯一の消費者。`load(Refresh/Append)` → `_load` → `_fetch` → repository。`EarthquakeHistoryParameterAll` 時に 5 分タイマー (`invalidateSelf`)・リアルタイム `upsertItems`・app 復帰時 `revalidateLatest` を provider 側で設定。既定一覧の parameter は `const EarthquakeHistoryParameter.all(sortBy: .eventId, sortOrder: .desc)`。
  - 注: `earthquake_history_notifier.dart` (`EarthquakeHistoryNotifier`) は**消費者ゼロの死んだコード**。SWR 対象ではない (別途削除可)。
- `CachedNotifier` は `$AsyncNotifier<T>` 用の mixin。Feed には適用できるが、地震履歴の `GroupedDataSource` には適用できないため、地震履歴は DataSource 内に cache-first を作り込む。

### UI 表示基盤
`app/lib/core/component/cached_data_banner.dart`: `CachedDataBanner(values: [asyncValue...])`。いずれかが `isFromCache` (DataKind.cache) の時「更新中」バナーを表示。既に地震詳細・お知らせ詳細・強度履歴・電文一覧ページで使用。

## 設計

### 方針
既存 `CachedNotifier` を、お知らせ一覧と地震履歴の**デフォルト一覧のみ**に適用する。地震履歴の既存更新機構 (タイマー・リアルタイム・app 復帰) は**維持**し、初回ロードを cache-first にする「上乗せ」。

**コード生成不要**: mixin の付与とリポジトリメソッドへのオプション引数追加は、riverpod 生成物 (`*.g.dart`) の署名を変えないため build_runner を回さない (本リポジトリは build_runner が恒常故障のため重要)。

### 1. お知らせ (Feed)

**`FeedRepository.fetch`** に client 上書きを追加:
```dart
Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
  final response = await (client ?? _api).feed.getV2Feeds(after: after);
  return response.data.toFeedListResponse();
}
```

**`FeedNotifier`** を SWR 化:
```dart
@riverpod
class FeedNotifier extends _$FeedNotifier with CachedNotifier<FeedNotifierState> {
  @override
  Future<FeedNotifierState> fetch(ApiClient client) async {
    final repository = await ref.read(feedRepositoryProvider.future);
    final response = await repository.fetch(client: client);
    return (items: response.feeds, nextCursor: response.nextCursor);
  }

  @override
  Future<FeedNotifierState> build() => cachedBuild();

  Future<void> fetchNextData() async { /* 既存のまま (ネットワーク専用) */ }
}
```
ページネーションはオフライン非対応のまま (仕様)。

### 2. 地震履歴 (デフォルト一覧のみ / paging_view DataSource に cache-first を作り込み)

`CachedNotifier` は使えないため、`EarthquakeHistoryDataSource` の初回ページ (Refresh) を cache-first にする。対象は **既定 All** (`_isDefaultAll`) のみ。フィルタ/検索は従来通り。

**`EarthquakeHistoryRepository.fetchEarthquakeList`** に オプション `api.ApiClient? client` を追加し `(client ?? _api)` で使う。cache-only クライアントを渡せるようにする。

**`earthquakeHistoryDataSource` provider** (`earthquake_history_data_source.dart`): 通常クライアントに加え cache-only クライアントも取得し、DataSource に両方 (または 2 つの client) を渡す。既存のタイマー・リアルタイム・app 復帰 setup は不変。

**`EarthquakeHistoryDataSource`**:
- `_isDefaultAll(parameter)` = `parameter == const EarthquakeHistoryParameter.all(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc)` (freezed の値等価。既定一覧の構築値と一致)。
- `load(Refresh)` が既定 All の場合:
  1. まず cache-only クライアントで first page を取得。
     - **cache ヒット** → `Success(cachedPage)` を即返す。加えて背景で通常クライアントの revalidate を予約し、成功したら fresh を `upsertItems` で反映 (失敗時はキャッシュ維持)。
     - **cache miss (`CacheMissException`)** → 通常クライアントで取得 (従来通り。オフラインなら `Failure`)。
  2. 既定 All 以外 (フィルタ付き All・検索系)・`Append` は従来通り通常クライアント。
- 背景 revalidate: `_fetch(limit: 10, cursor: null, client: normalClient)` → `upsertItems(fresh.items)` (既存の upsert ロジックを再利用。sortBy=eventId のみ有効)。disposal ガードを入れる。
- 既存の `revalidateLatest`・`upsertItems`・`Append` は不変。

### 3. UI

- **お知らせ一覧ページ**: `CachedDataBanner(values: [feedAsyncValue])` を追加 (詳細ページ等と一貫)。`CachedNotifier` が revalidate 中に `DataKind.cache` を持つため `isFromCache` で自然に表示される。
- **地震履歴一覧ページ**: paging_view の DataSource は `AsyncValue` の `DataKind.cache` を持たないため、`CachedDataBanner(values:)` を直接は使えない。DataSource に「キャッシュ表示中/背景 revalidate 中」を表す `ValueListenable<bool>` (例 `isRevalidating`) を公開し、ページはそれを購読してキャッシュ由来の詳細ページ等と同じ見た目の「更新中」バナーを出す。バナー UI は `CachedDataBanner` と揃える (共通見た目を再利用 or 同等の軽量表示)。

### 4. 相互作用の扱い

- **Feed**: 背景 revalidate は `CachedNotifier` の `_generation` ガードで古い上書きを防止。
- **地震履歴**: 背景 revalidate (`upsertItems`)・5 分タイマー `invalidateSelf`・リアルタイム `upsertItems` はいずれも DataSource の items を操作する。既存コードに既にあるレース (timer invalidate vs upsert) と同程度で、新たな根本問題は増やさない。cache ヒット時に予約する背景 revalidate は disposal / 世代ガードを入れ、DataSource 破棄後や再 Refresh 後に古い結果を反映しない。

## テスト方針

- `FeedNotifier`: cache-only ヒットで即データを返す / cache miss で通常取得へフォールバック / 背景 revalidate で fresh に更新。
- `EarthquakeHistoryDataSource`: 既定 All の Refresh で cache-only ヒット → `Success` を即返す / cache miss → 通常取得 / フィルタ付き All・検索系は cache-only を使わず従来経路。cache ヒット後の背景 revalidate で `upsertItems` が呼ばれ fresh が反映される。
- `_isDefaultAll` の判定 (既定 All のみ true、フィルタ/検索は false)。
- オフライン (cache-only ヒット) 時に `Failure`/`AsyncError` にならずデータが表示される。
- 既存の CachedNotifier 系テストのパターンに倣う。

## 非対象 (Out of Scope)

- 差分取得 API (backend, 計画 A〜E)。
- 地震履歴のフィルタ/検索クエリのオフラインキャッシュ (デフォルト All のみ SWR 化)。
- オフラインでのページネーション。
