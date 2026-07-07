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

### 対象 Notifier (未 SWR 化)
- `app/lib/feature/feed/data/notifier/feed_notifier.dart`: `@riverpod class FeedNotifier`。`build()` で `repository.fetch()`。ページネーション (`fetchNextData`, nextCursor) あり。
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`: `@riverpod class EarthquakeHistoryNotifier`。`build(EarthquakeHistoryParameter parameter)` (family)。`EarthquakeHistoryParameterAll` 時に 5 分タイマー (`invalidateSelf`)・リアルタイム upsert・app 復帰時 `_revalidateLatest` を設定。`_fetch(parameter, limit, cursor)` で取得。ページネーション (`fetchNextData`)・`_upsertItems` あり。parameter は All / Region / Prefecture / City / Station と各種フィルタ (magnitude/depth/intensity/… ・sort) を持つ。

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

### 2. 地震履歴 (デフォルト一覧のみ)

**`EarthquakeHistoryRepository.fetchEarthquakeList`** と Notifier の **`_fetch`** に オプション `api.ApiClient? client` を追加し、`(client ?? 既定)` で使う。SWR はデフォルト All のみに適用するため、client 上書きが実際に渡るのは `fetchEarthquakeList` 経由のデフォルト All パスのみ。他パスは `client` を渡さず従来通り。

**`EarthquakeHistoryNotifier`** に `with CachedNotifier<PaginatedResponse<EarthquakePartial>>` を付与:
```dart
@override
Future<PaginatedResponse<EarthquakePartial>> fetch(ApiClient client) =>
    _fetch(parameter: parameter, limit: 10, cursor: null, client: client);

@override
Future<PaginatedResponse<EarthquakePartial>> build(
  EarthquakeHistoryParameter parameter,
) async {
  if (parameter is EarthquakeHistoryParameterAll) {
    // 既存の 5 分タイマー・リアルタイム upsert・app 復帰 revalidate をそのまま設定
    ...
  }
  if (_isDefaultAll(parameter)) {
    return cachedBuild();
  }
  return _fetch(parameter: parameter, limit: ..., cursor: null);
}
```

- `_isDefaultAll(parameter)`: フィルタ未適用・既定ソートの `EarthquakeHistoryParameterAll` を判定する述語。既定インスタンスとの等価判定、または全フィルタ null + 既定 sort の確認で実装する (正確な定義は実装計画で確定)。
- `limit`: 既存に合わせ、All は 10、検索系は 50。
- `_revalidateLatest`・`fetchNextData`・`_upsertItems` は不変。`revalidateOnAppResume` は有効化しない (既存の軽量 `_revalidateLatest` を app 復帰時に使い続ける)。

### 3. UI

地震履歴一覧ページとお知らせ一覧ページに `CachedDataBanner(values: [asyncValue])` を追加 (詳細ページ等と一貫)。デフォルト All のキャッシュ表示時のみバナーが出る (フィルタ時は `isFromCache=false` で非表示)。

### 4. 相互作用の扱い

背景 revalidate・5 分タイマー `invalidateSelf`・リアルタイム `_upsertItems` はいずれも最終的に `AsyncData` を生成する。`CachedNotifier` の `_generation` ガードが古い revalidate による上書きを防ぐ。既存コードに既にあるレース (timer invalidate vs upsert) と同程度で、新たな根本問題は増やさない。背景 revalidate 完了時に `AsyncData(fresh)` がリアルタイム upsert 直後の値を一時的に上書きしうるが、fresh は最新のサーバ値のため実害は軽微 (許容)。

## テスト方針

- `FeedNotifier`: cache-only ヒットで即データを返す / cache miss で通常取得へフォールバック / 背景 revalidate で fresh に更新。
- `EarthquakeHistoryNotifier`: デフォルト All は cache-first になる / フィルタ付き All・検索系は従来のネットワーク経路のまま (cache-only を使わない)。
- オフライン (cache-only ヒット) 時に `AsyncError` にならずデータが表示される。
- 既存の CachedNotifier 系テストのパターンに倣う。

## 非対象 (Out of Scope)

- 差分取得 API (backend, 計画 A〜E)。
- 地震履歴のフィルタ/検索クエリのオフラインキャッシュ (デフォルト All のみ SWR 化)。
- オフラインでのページネーション。
