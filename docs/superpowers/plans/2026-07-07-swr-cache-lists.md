# 一覧のSWRキャッシュ化 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴一覧タブ・お知らせ一覧タブ・Home フィードシートを cache-first (キャッシュ即返し → 裏で revalidate → 更新) にし、オフライン/初回で timeout エラーにならずキャッシュを表示する。

**Architecture:** paging_view の 2 DataSource (Feed 一覧・地震履歴一覧) は共通ヘルパー `cacheFirstRefresh` で初回 Refresh を cache-first 化し背景 revalidate で in-place upsert。Home フィードシートの `FeedNotifier` は既存 `CachedNotifier` mixin を適用。cache-only クライアントは `cacheOnlyApiClientProvider`。

**Tech Stack:** Flutter / Dart, Riverpod (riverpod_annotation), paging_view (`DataSource`/`GroupedDataSource`/`LoadResult`/`PageData`), flutter_test。

## Global Constraints

- コード生成は使わない (build_runner がリポジトリ全体で恒常故障: drift_dev/analyzer 非互換, freezed↔riverpod_generator の analyzer 版数非互換)。mixin 付与・オプション引数追加は riverpod 生成物 (`*.g.dart`) の署名を変えないため regenerate 不要。生成物を手編集しない。
- `dart analyze` はこのリポジトリで非常に遅く (数分) ハングし得る (eqmonitor-lints プラグイン競合)。コンパイル検証は `flutter test` を主軸にする。パイプで exit code を隠さない。
- Riverpod 公開 Provider は 1 ファイル 1 つ。コメントは「なぜ」のみ。YAGNI。package import。例外を握りつぶさない (背景 revalidate 失敗は `talker.error` に記録)。
- テストは緑にしてからコミット。作業は git worktree 内 (`cd` を毎コマンド前置し、コミット前に `git branch --show-current` が `worktree-swr-cache-lists` であることを確認)。
- コミットメッセージ末尾に `Claude-Session: https://claude.ai/code/session_016kNc5tMmW5x7a4A4ms83EB` を付ける。

## File Structure

- `app/lib/core/paging/cache_first_refresh.dart` (新規): paging DataSource 用 cache-first ヘルパー。
- `app/lib/feature/feed/data/repository/feed_repository.dart` (変更): `fetch` に `ApiClient? client`。
- `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart` (変更): `fetchEarthquakeList` に `ApiClient? client`。
- `app/lib/feature/feed/data/notifier/feed_data_source.dart` (変更): cache-first + `upsertItems(byid)` + `isRevalidating`。
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart` (変更): 既定 All の cache-first + `isRevalidating`。
- `app/lib/feature/feed/data/notifier/feed_notifier.dart` (変更): `CachedNotifier` 適用。
- `app/lib/feature/feed/ui/page/feed_page.dart` / `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart` (変更): 「更新中」バナー。

---

### Task 1: cacheFirstRefresh ヘルパー

**Files:**
- Create: `app/lib/core/paging/cache_first_refresh.dart`
- Test: `app/test/core/paging/cache_first_refresh_test.dart`

**Interfaces:**
- Consumes: paging_view の `LoadResult`/`PageData`/`Success`/`Failure`。
- Produces:
  ```dart
  Future<LoadResult<String?, V>> cacheFirstRefresh<V>({
    required Future<PageData<String?, V>> Function({required bool cacheOnly}) fetchPage,
    required void Function(List<V> fresh) upsert,
    required bool Function() isActive,
    ValueNotifier<bool>? isRevalidating,
    void Function(Object error, StackTrace stackTrace)? onRevalidateError,
  })
  ```

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/paging/cache_first_refresh_test.dart`:

```dart
import 'package:eqmonitor/core/paging/cache_first_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

PageData<String?, int> _page(List<int> data) =>
    PageData(data: data, appendKey: null);

void main() {
  test('cache hit: Success を即返し、背景で upsert が呼ばれる', () async {
    final upserted = <int>[];
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async =>
          _page(cacheOnly ? [1, 2] : [1, 2, 3]),
      upsert: upserted.addAll,
      isActive: () => true,
    );
    expect(result, isA<Success<String?, int>>());
    expect((result as Success<String?, int>).page.data, [1, 2]);
    await Future<void>.delayed(Duration.zero);
    expect(upserted, [1, 2, 3]); // 背景 revalidate の fresh
  });

  test('cache miss: 通常取得の Success を返す', () async {
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async {
        if (cacheOnly) throw Exception('cache miss');
        return _page([9]);
      },
      upsert: (_) {},
      isActive: () => true,
    );
    expect((result as Success<String?, int>).page.data, [9]);
  });

  test('cache miss かつ通常取得も失敗 → Failure', () async {
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => throw Exception('offline'),
      upsert: (_) {},
      isActive: () => true,
    );
    expect(result, isA<Failure<String?, int>>());
  });

  test('isActive()==false なら背景 upsert をスキップ', () async {
    final upserted = <int>[];
    await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => _page([1]),
      upsert: upserted.addAll,
      isActive: () => false,
    );
    await Future<void>.delayed(Duration.zero);
    expect(upserted, isEmpty);
  });

  test('cache hit で isRevalidating が true→false に遷移', () async {
    final flag = ValueNotifier(false);
    await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => _page([1]),
      upsert: (_) {},
      isActive: () => true,
      isRevalidating: flag,
    );
    expect(flag.value, isTrue); // 即返し直後は revalidate 中
    await Future<void>.delayed(Duration.zero);
    expect(flag.value, isFalse); // 背景完了で false
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.claude/worktrees/swr-cache-lists && cd app && flutter test test/core/paging/cache_first_refresh_test.dart`
Expected: FAIL (`cacheFirstRefresh` 未定義)

- [ ] **Step 3: 実装**

`app/lib/core/paging/cache_first_refresh.dart`:

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:paging_view/paging_view.dart';

/// paging_view DataSource の初回ページ (Refresh) を cache-first にする。
///
/// cache-only 取得がヒットしたら即 [Success] を返し、背景で通常取得して
/// [upsert] で in-place 更新する。cache-only が失敗 (miss/corrupt) したら
/// 通常取得にフォールバックし、それも失敗すれば [Failure]。
///
/// 背景更新は [isActive] が false (DataSource 破棄後・再 Refresh 後) ならスキップし、
/// 失敗は [onRevalidateError] に渡して握りつぶさない。
Future<LoadResult<String?, V>> cacheFirstRefresh<V>({
  required Future<PageData<String?, V>> Function({required bool cacheOnly})
  fetchPage,
  required void Function(List<V> fresh) upsert,
  required bool Function() isActive,
  ValueNotifier<bool>? isRevalidating,
  void Function(Object error, StackTrace stackTrace)? onRevalidateError,
}) async {
  try {
    final cached = await fetchPage(cacheOnly: true);
    isRevalidating?.value = true;
    unawaited(
      Future.microtask(() async {
        try {
          final fresh = await fetchPage(cacheOnly: false);
          if (isActive()) {
            upsert(fresh.data);
          }
        } on Object catch (error, stackTrace) {
          onRevalidateError?.call(error, stackTrace);
        } finally {
          if (isActive()) {
            isRevalidating?.value = false;
          }
        }
      }),
    );
    return Success(page: cached);
  } on Object catch (_) {
    try {
      final fresh = await fetchPage(cacheOnly: false);
      return Success(page: fresh);
    } on Exception catch (error, stackTrace) {
      return Failure(error: error, stackTrace: stackTrace);
    }
  }
}
```

- [ ] **Step 4: テスト成功を確認**

Run: `cd <worktree> && cd app && flutter test test/core/paging/cache_first_refresh_test.dart`
Expected: PASS (5 件)

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/paging/cache_first_refresh.dart app/test/core/paging/cache_first_refresh_test.dart
git commit -m "feat: paging DataSource 用 cacheFirstRefresh ヘルパーを追加"
```

---

### Task 2: リポジトリの client 上書き

**Files:**
- Modify: `app/lib/feature/feed/data/repository/feed_repository.dart`
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`

**Interfaces:**
- Produces:
  - `FeedRepository.fetch({String? after, api.ApiClient? client})` — `(client ?? _api)` を使う。
  - `EarthquakeHistoryRepository.fetchEarthquakeList(..., {api.ApiClient? client})` — 既存の全引数 + `client`。内部で `(client ?? <既存の client フィールド>)` を使う。

**実装メモ:** `FeedRepository.fetchByTelegramHash` が既に `{ApiClient? client}` → `(client ?? _api)` の形。これに倣う。`earthquake_history_repository.dart` を読み、`fetchEarthquakeList` が使っている ApiClient フィールド名を確認し `(client ?? そのフィールド)` にする。**署名変更は生成に影響しない** (これらは通常クラスのメソッド)。

- [ ] **Step 1: feed_repository.dart を変更**

`fetch` を次のように変更 (既存の `toFeedListResponse()` 変換は保持):

```dart
Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
  final response = await (client ?? _api).feed.getV2Feeds(after: after);
  return response.data.toFeedListResponse();
}
```

- [ ] **Step 2: earthquake_history_repository.dart を変更**

`earthquake_history_repository.dart` を読み、`fetchEarthquakeList(...)` の末尾に `api.ApiClient? client` を追加し、実際の API 呼び出しで使っているクライアント (例 `_apiClient` / `_client`) を `(client ?? そのフィールド)` に置換する。他の引数・戻り値は不変。

- [ ] **Step 3: コンパイル確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/ test/feature/earthquake_history/`
Expected: 既存テストが PASS (署名追加のみで挙動不変)。テストが無いディレクトリはスキップされる。少なくともコンパイルが通ること。

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/feed/data/repository/feed_repository.dart app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart
git commit -m "feat: Feed/地震履歴リポジトリに ApiClient 上書きを追加"
```

---

### Task 3: FeedDataSource を cache-first 化

**Files:**
- Modify: `app/lib/feature/feed/data/notifier/feed_data_source.dart`
- Test: `app/test/feature/feed/feed_data_source_test.dart`

**Interfaces:**
- Consumes: `cacheFirstRefresh` (Task 1), `FeedRepository.fetch({after, client})` (Task 2), `cacheOnlyApiClientProvider`。
- Produces:
  - `FeedDataSource({required FeedRepository repository, required api.ApiClient cacheOnlyClient})`
  - `void upsertItems(List<FeedItem> fresh)` — `FeedItem.id` で update/insert。
  - `final ValueNotifier<bool> isRevalidating`
  - `feedDataSource` provider が cache-only クライアントを注入。

**実装メモ:** paging_view の `DataSource` の items 変更 API (`notifier.values` / `updateItem` / `insertItem`) は `EarthquakeHistoryDataSource.upsertItems` (GroupedDataSource) の実装を参照し、`FeedItem.id` (`required String id`) 一致で update、無ければ末尾 append (Feed は時系列順・cursor 追加なので新規は末尾で可) にする。plain `DataSource` に該当 API が無ければ paging_view のドキュメント/型定義を確認して等価操作にする。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/feed/feed_data_source_test.dart` — `upsertItems` の id マージを検証する単体テスト (DataSource の items 操作を最小構成で確認)。実際の paging_view `DataSource` の items 参照 API に合わせてテストを書く。最低限:
- 既存 items に同 id → 中身が更新される。
- 新規 id → 追加される。

(注: `load()` の cache-first 経路は `cacheFirstRefresh` (Task 1) 側で検証済みのため、ここでは `upsertItems` の id マージに集中する。paging_view の内部状態を直接検証しづらい場合は、`upsertItems` に渡す前後で公開 getter (`notifier.values` 等) を突き合わせる。)

- [ ] **Step 2: 失敗を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/feed_data_source_test.dart`
Expected: FAIL (`upsertItems` 未定義 / コンストラクタ引数不一致)

- [ ] **Step 3: FeedDataSource を実装**

- コンストラクタに `required api.ApiClient cacheOnlyClient` を追加し保持。`final ValueNotifier<bool> isRevalidating = ValueNotifier(false);` と `bool _disposed = false;` を追加。`dispose()` をオーバーライドして `_disposed = true; isRevalidating.dispose();` 後に `super.dispose()`。
- `load(Refresh)` を `cacheFirstRefresh` 経由に変更:
  ```dart
  Refresh() => await cacheFirstRefresh<FeedItem>(
    fetchPage: ({required cacheOnly}) async {
      final response = await _repository.fetch(
        after: null,
        client: cacheOnly ? _cacheOnlyClient : null,
      );
      return PageData(data: response.feeds, appendKey: response.nextCursor);
    },
    upsert: upsertItems,
    isActive: () => !_disposed,
    isRevalidating: isRevalidating,
    onRevalidateError: (e, st) => talker.error(e, st),
  ),
  ```
  `Append(:final key)` / `Prepend()` は従来通り。
- `upsertItems(List<FeedItem> fresh)` を追加 (id マージ)。
- `feedDataSource` provider で `final cacheOnly = await ref.watch(cacheOnlyApiClientProvider.future);` を取得し `FeedDataSource(repository: repository, cacheOnlyClient: cacheOnly)` に渡す。
- import 追加: `cacheFirstRefresh`, `cacheOnlyApiClientProvider`, `talker`, `flutter/foundation` (ValueNotifier)。

- [ ] **Step 4: テスト成功を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/feed/data/notifier/feed_data_source.dart app/test/feature/feed/feed_data_source_test.dart
git commit -m "feat: お知らせ一覧を cache-first 化 (FeedDataSource)"
```

---

### Task 4: EarthquakeHistoryDataSource を cache-first 化 (既定 All のみ)

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- Test: `app/test/feature/earthquake_history/earthquake_history_data_source_cache_test.dart`

**Interfaces:**
- Consumes: `cacheFirstRefresh` (Task 1), `EarthquakeHistoryRepository.fetchEarthquakeList({client})` (Task 2), `cacheOnlyApiClientProvider`。
- Produces:
  - `EarthquakeHistoryDataSource({..., required api.ApiClient cacheOnlyClient})`
  - `final ValueNotifier<bool> isRevalidating`
  - 既定 All 判定 `bool _isDefaultAll(EarthquakeHistoryParameter)`。

**実装メモ:** 既存の `_fetch({limit, cursor})` に `api.ApiClient? client` を追加し、`EarthquakeHistoryParameterAll()` 分岐で `_repository.fetchEarthquakeList(..., client: client)` を渡す (他分岐は client 不要)。`upsertItems` は既存を再利用。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/earthquake_history_data_source_cache_test.dart` — `_isDefaultAll` 相当の判定を検証。`EarthquakeHistoryDataSource` に `@visibleForTesting bool isDefaultAll(p)` を公開するか、トップレベル関数として切り出して検証する:
```dart
test('既定 All は true、フィルタ付き/検索は false', () {
  expect(isDefaultAllParameter(
    const EarthquakeHistoryParameter.all(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc)), isTrue);
  expect(isDefaultAllParameter(
    const EarthquakeHistoryParameter.all(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc, magnitudeGte: 5)), isFalse);
  expect(isDefaultAllParameter(
    const EarthquakeHistoryParameter.prefecture(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc, prefectureCode: '13')), isFalse);
});
```
判定はトップレベル関数 `bool isDefaultAllParameter(EarthquakeHistoryParameter p) => p == const EarthquakeHistoryParameter.all(sortBy: EarthquakeSortBy.eventId, sortOrder: SortOrder.desc);` として `earthquake_history_data_source.dart` に定義する (freezed 値等価)。

- [ ] **Step 2: 失敗を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/earthquake_history/earthquake_history_data_source_cache_test.dart`
Expected: FAIL (`isDefaultAllParameter` 未定義)

- [ ] **Step 3: 実装**

- トップレベル `isDefaultAllParameter` を定義。
- コンストラクタに `required api.ApiClient cacheOnlyClient`、`final ValueNotifier<bool> isRevalidating = ValueNotifier(false);`、`bool _disposed = false;`、`dispose()` オーバーライドを追加。
- `_fetch` に `api.ApiClient? client` を追加し `EarthquakeHistoryParameterAll()` 分岐で `client: client` を渡す。
- `load(Refresh)` を変更: `isDefaultAllParameter(_parameter)` なら `cacheFirstRefresh<EarthquakePartial>(fetchPage: ({required cacheOnly}) async { final page = await _fetch(limit: 10, cursor: null, client: cacheOnly ? _cacheOnlyClient : null); return PageData(data: page.items, appendKey: page.nextToken); }, upsert: upsertItems, isActive: () => !_disposed, isRevalidating: isRevalidating, onRevalidateError: (e, st) => talker.error(e, st))`。それ以外は従来の `_load(limit: _parameter is EarthquakeHistoryParameterAll ? 10 : 50, cursor: null)`。`Append` は不変。
- `earthquakeHistoryDataSource` provider で cache-only を取得し DataSource に注入。既存の timer/realtime/appResume setup は不変。
- import 追加: `cacheFirstRefresh`, `cacheOnlyApiClientProvider`, `flutter/foundation`。`talker` は既に import 済み。

- [ ] **Step 4: テスト成功を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/earthquake_history/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart app/test/feature/earthquake_history/earthquake_history_data_source_cache_test.dart
git commit -m "feat: 地震履歴の既定一覧を cache-first 化 (EarthquakeHistoryDataSource)"
```

---

### Task 5: Home フィードシートの FeedNotifier を SWR 化

**Files:**
- Modify: `app/lib/feature/feed/data/notifier/feed_notifier.dart`
- Test: `app/test/feature/feed/feed_notifier_test.dart`

**Interfaces:**
- Consumes: `CachedNotifier` (既存), `FeedRepository.fetch({after, client})` (Task 2)。
- Produces: `FeedNotifier extends _$FeedNotifier with CachedNotifier<FeedNotifierState>`。`fetch(ApiClient)` / `build() => cachedBuild()`。

**実装メモ:** `start_notifier.dart` の形に倣う。`fetchNextData` は不変。**mixin 付与は `feed_notifier.g.dart` を変えない** (build_runner 不要)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/feed/feed_notifier_test.dart` — cache-only ヒット時に即データが返ること (fake repository/クライアントで検証)。既存の CachedNotifier 系テストがあればそのパターンに倣う。無ければ、`ProviderContainer` で `feedRepositoryProvider` と `cacheOnlyApiClientProvider`/`apiClientProvider` を override して `feedProvider` の初回値がキャッシュ由来になることを検証する。

- [ ] **Step 2: 失敗を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/feed_notifier_test.dart`
Expected: FAIL

- [ ] **Step 3: 実装**

`feed_notifier.dart`:
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

  Future<void> fetchNextData() async { /* 既存のまま */ }
}
```
import 追加: `cached_notifier.dart`, `eqmonitor_api` (ApiClient)。既存の `async_value.dart` import 等は保持。

- [ ] **Step 4: テスト成功を確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/feed/data/notifier/feed_notifier.dart app/test/feature/feed/feed_notifier_test.dart
git commit -m "feat: Home フィードシート (FeedNotifier) を SWR 化"
```

---

### Task 6: 一覧ページに「更新中」バナー

**Files:**
- Modify: `app/lib/feature/feed/ui/page/feed_page.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`

**Interfaces:**
- Consumes: `FeedDataSource.isRevalidating` / `EarthquakeHistoryDataSource.isRevalidating` (Task 3/4), `CachedDataBanner` (既存)。

**実装メモ:** 両ページは `dataSourceAsync.when(data: (dataSource) => ...)` の形。`data` で得た DataSource の `isRevalidating` (`ValueListenable<bool>`) を `ValueListenableBuilder` で購読し、true の時に詳細ページ等と同じ見た目の「更新中」表示を出す。`CachedDataBanner` は `AsyncValue` ベースだが、同等の見た目 (同じ文言/スタイル) を出せば良い。`cached_data_banner.dart` を読み、内部の表示 Widget を再利用できるなら再利用、できなければ同等の小さな表示を追加する。バナーはリストの上部 (既存レイアウトの邪魔にならない位置) に置く。

- [ ] **Step 1: feed_page.dart にバナーを追加**

`feed_page.dart` の `data: (dataSource) => ...` 内で、リスト本体の上に `ValueListenableBuilder<bool>(valueListenable: dataSource.isRevalidating, builder: (_, revalidating, _) => revalidating ? <更新中バナー> : const SizedBox.shrink())` を重ねる (既存の `CachedDataBanner` の見た目に合わせる)。

- [ ] **Step 2: earthquake_history_page.dart にバナーを追加**

同様に `_PagingBody` (または `data:` 直下) で `dataSource.isRevalidating` を購読しバナーを出す。既存レイアウト (RefreshIndicator/paging list) を壊さない位置に置く。

- [ ] **Step 3: コンパイル確認**

Run: `cd <worktree> && cd app && flutter test test/feature/feed/ test/feature/earthquake_history/`
Expected: PASS (コンパイルが通ること)。UI の目視確認は実機/レビューで行う。

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/feed/ui/page/feed_page.dart app/lib/feature/earthquake_history/ui/earthquake_history_page.dart
git commit -m "feat: 地震履歴・お知らせ一覧に更新中バナーを追加"
```

---

### Task 7: 仕上げ (format + 統合テスト)

**Files:** 上記変更ファイル

- [ ] **Step 1: 変更 dart ファイルを format**

Run: `cd <worktree> && cd app && dart format $(git -C .. diff --name-only <merge-base>..HEAD | grep '^app/.*\.dart$' | sed 's|^app/||')`
(merge-base = このブランチの分岐元。`git merge-base origin/develop HEAD` で取得。) 差分が出たら次でコミット。

- [ ] **Step 2: 関連テストを統合実行**

Run: `cd <worktree> && cd app && flutter test test/core/paging/ test/feature/feed/ test/feature/earthquake_history/`
Expected: すべて PASS (既存 pre-existing 失敗 `parameter_repository_refresh_test.dart` の SHINDO_DB_STATIONS は本 PR 無関係)。

- [ ] **Step 3: format 差分をコミット**

```bash
git add -A -- '*.dart'
git commit -m "style: dart format 適用"
```

---

## 補足: PR とデプロイ

全 Task 完了後、`develop` ベースで PR を作成し (`--repo YumNumm/EQMonitor`)、Issue #1452 を close する。PR には build_runner 不使用の旨と、cache-first の対象 (両一覧タブ + Home フィードシート) を明記する。
