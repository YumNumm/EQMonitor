# キャッシュ先行表示の全面展開 + CachedDataBanner 実装計画 (Issue #1432)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 既存の cache-first SWR 基盤 (`CachedNotifier`) を詳細・静的系 6 provider へ広げ、キャッシュ表示中を明示する共通バナー `CachedDataBanner` を追加する。

**Architecture:** 各 provider を `CachedNotifier<T>` mixin のクラス型 Notifier に変換し (`build() => cachedBuild()`、`fetch(ApiClient client)` を実装)、Repository の対象メソッドには省略可能な `client` 引数を追加する (未指定なら従来のコンストラクタ client)。バナーは `AsyncValue` の公開 API (`isFromCache` / `hasValue && hasError`) だけで状態判定する StatelessWidget。

**Tech Stack:** Flutter / Riverpod 3 (riverpod_generator) / Retrofit (eqmonitor_api) / packages/cache (実装済み SWR 基盤)

**Spec:** `docs/superpowers/specs/2026-07-04-cached-data-banner-swr-rollout-design.md`

## Global Constraints

- 公開 provider 名は変えない。関数型→クラス型変換時のクラス名は生成名が一致するよう命名する: `telegramDetails`→`TelegramDetails`, `nearbyEarthquake`→`NearbyEarthquake`, `prefectureHighest`→`PrefectureHighest`, `cityHighest`→`CityHighest`, `feedBySource`→`FeedBySource` (×`TelegramDetailsNotifier` — provider 名が変わってしまう)。
- keepAlive / autoDispose は現状維持: `prefectureHighest` のみ `@Riverpod(keepAlive: true)`、他は `@riverpod`。
- family 引数は riverpod_generator が生成する getter (`String get eventId` 等) で `fetch()` から参照できる。
- Repository の SWR 対象メソッドは省略可能な named 引数 `client` を追加し `(client ?? _api)` / `(client?.earthquake ?? _earthquake)` を使う。他メソッド・他呼び出し元は変更しない。
- `fetch()` 内の provider 参照は `ref.read`、`build()` 内での repository 依存は `ref.watch` (既存 `ParameterSetNotifier` のパターン)。
- コード生成: `cd app && dart run build_runner build --delete-conflicting-outputs`。生成物 (`*.g.dart`) もコミットする。
- 検証: `cd app && flutter test <対象>` (タスク単位) / 最後に `cd app && dart analyze` と `cd app && flutter test`。※ローカル `dart analyze` が analyzer plugin 起因で exit 4 になる既知事象あり — エラー内容が `analysis_server_plugin`/`prefer_shorthands` 関連のみなら既存事象として無視し、コード由来の diagnostics ゼロを確認する。
- コミットは各タスク末尾で実施 (pre-commit hooks: gitleaks 等が走る)。コミットメッセージ末尾に `Claude-Session: https://claude.ai/code/session_01GWVtfA7sftVHT88FyaV5fD` を付ける。
- PR は `--repo YumNumm/EQMonitor`。PR-1 は base `develop`、PR-2 は base = PR-1 ブランチ (stacked)。PR-1 マージ後、GitHub がブランチ削除時に PR-2 の base を develop へ自動付け替える。
- deploy-app.yaml は `push: branches: [develop]` で自動起動する (PR-2 マージ時に CD が走る)。手動起動は `gh workflow run deploy-app.yaml`。
- 文言 (バナー): 更新中「キャッシュ表示中・更新を確認しています…」/ 失敗「最新情報の取得に失敗しました（キャッシュ表示中）」。

---

## PR-1: CachedDataBanner + 地震詳細系 (branch: `feat/cached-data-banner`)

### Task 1: ブランチ作成

**Files:** なし (git 操作のみ)

- [ ] **Step 1: develop から作業ブランチを切る**

```bash
git checkout -b feat/cached-data-banner develop
```

※ワークツリー分離環境で実行する場合は worktree 側で同名ブランチを作成する。作業ツリーに既存の未コミット変更 (`analysis_options.yaml`, `backend`) がある場合は触らない・コミットに含めない。

### Task 2: `CachedDataBanner` ウィジェット (TDD)

**Files:**
- Create: `app/lib/core/component/cached_data_banner.dart`
- Test: `app/test/core/component/cached_data_banner_test.dart`

**Interfaces:**
- Produces: `CachedDataBanner({required List<AsyncValue<Object?>> values, Key? key})` — 後続タスクの各画面がこのシグネチャで組み込む。

- [ ] **Step 1: 失敗するテストを書く**

```dart
// app/test/core/component/cached_data_banner_test.dart
// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/src/internals.dart' show DataKind;

const _revalidatingText = 'キャッシュ表示中・更新を確認しています…';
const _staleErrorText = '最新情報の取得に失敗しました（キャッシュ表示中）';

/// CachedNotifier が裏更新中に流す「キャッシュ由来の値を保持した Loading」状態。
AsyncValue<String> _cacheRevalidating() =>
    const AsyncLoading<String>().copyWithPrevious(
      AsyncData('stale', kind: DataKind.cache),
    );

/// 再検証失敗で stale を維持した状態。
AsyncValue<String> _staleWithError() =>
    AsyncError<String>(Exception('offline'), StackTrace.empty)
        .copyWithPrevious(const AsyncData('stale'));

Future<void> _pump(WidgetTester tester, List<AsyncValue<Object?>> values) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: CachedDataBanner(values: values)),
    ),
  );
}

void main() {
  testWidgets('fresh のみでは何も表示しない', (tester) async {
    await _pump(tester, [const AsyncData('fresh')]);
    expect(find.text(_revalidatingText), findsNothing);
    expect(find.text(_staleErrorText), findsNothing);
  });

  testWidgets('値なし Loading (初回ロード) では何も表示しない', (tester) async {
    await _pump(tester, [const AsyncLoading<String>()]);
    expect(find.text(_revalidatingText), findsNothing);
    expect(find.text(_staleErrorText), findsNothing);
  });

  testWidgets('キャッシュ由来の値を再検証中は更新中バナーを表示する', (tester) async {
    await _pump(tester, [_cacheRevalidating()]);
    expect(find.text(_revalidatingText), findsOneWidget);
  });

  testWidgets('cache マークなしの isRefreshing では表示しない', (tester) async {
    final refreshing = const AsyncLoading<String>()
        .copyWithPrevious(const AsyncData('value'));
    await _pump(tester, [refreshing]);
    expect(find.text(_revalidatingText), findsNothing);
  });

  testWidgets('再検証失敗 (stale + error) は失敗バナーを表示する', (tester) async {
    await _pump(tester, [_staleWithError()]);
    expect(find.text(_staleErrorText), findsOneWidget);
  });

  testWidgets('複数 values は 1 つでも該当すれば表示する', (tester) async {
    await _pump(tester, [const AsyncData('fresh'), _cacheRevalidating()]);
    expect(find.text(_revalidatingText), findsOneWidget);
  });

  testWidgets('失敗が更新中より優先される', (tester) async {
    await _pump(tester, [_cacheRevalidating(), _staleWithError()]);
    expect(find.text(_staleErrorText), findsOneWidget);
    expect(find.text(_revalidatingText), findsNothing);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/core/component/cached_data_banner_test.dart`
Expected: FAIL (`cached_data_banner.dart` が存在しない)

- [ ] **Step 3: 実装を書く**

```dart
// app/lib/core/component/cached_data_banner.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SWR (cache-first) 対象 provider の状態を明示する上部バナー。
///
/// - いずれかが再検証失敗で stale 維持中 (`hasValue && hasError`) → 失敗表示
/// - いずれかがキャッシュ由来の値を表示中 (`isFromCache`) → 更新中表示
/// - それ以外 (fresh / 初回ロード) → 高さゼロ
class CachedDataBanner extends StatelessWidget {
  const CachedDataBanner({required this.values, super.key});

  /// 画面が表示している SWR 対象 provider の状態。値の中身は参照しない。
  final List<AsyncValue<Object?>> values;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasStaleError = values.any((v) => v.hasValue && v.hasError);
    final isRevalidating = values.any((v) => v.isFromCache);

    final Widget content;
    if (hasStaleError) {
      content = _BannerContent(
        key: const ValueKey('cached-data-banner-error'),
        leading: Icon(
          Icons.cloud_off,
          size: 14,
          color: colorScheme.onErrorContainer,
        ),
        message: '最新情報の取得に失敗しました（キャッシュ表示中）',
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
      );
    } else if (isRevalidating) {
      content = _BannerContent(
        key: const ValueKey('cached-data-banner-revalidating'),
        leading: SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        message: 'キャッシュ表示中・更新を確認しています…',
        backgroundColor: colorScheme.surfaceContainerHighest,
        foregroundColor: colorScheme.onSurfaceVariant,
      );
    } else {
      content = const SizedBox.shrink();
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: content,
    );
  }
}

class _BannerContent extends StatelessWidget {
  const _BannerContent({
    required this.leading,
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
  });

  final Widget leading;
  final String message;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: foregroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/core/component/cached_data_banner_test.dart`
Expected: PASS (7 tests)

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/component/cached_data_banner.dart app/test/core/component/cached_data_banner_test.dart
git commit -m "feat(app): キャッシュ表示中を明示する CachedDataBanner を追加"
```

### Task 3: 地震詳細の SWR 化 (Repository + Notifier + ページ)

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart` (`fetchEarthquakeDetail` に client 引数)
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart` (switch 値優先化 + バナー)

**Interfaces:**
- Consumes: `CachedNotifier<T>` (`cachedBuild()` / `fetch(ApiClient)`), `CachedDataBanner(values:)` (Task 2)
- Produces: `EarthquakeHistoryRepository.fetchEarthquakeDetail({required String eventId, api.ApiClient? client})` — Task 4 も同 Repository の `fetchEarthquakeList` で同型の変更を行う。

- [ ] **Step 1: Repository に client 引数を追加**

`fetchEarthquakeDetail` を次に変更 (`_api` 直参照を `(client ?? _api)` に):

```dart
  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
    api.ApiClient? client,
  }) async {
    final response = await (client ?? _api).earthquake.getV2EarthquakeEventId(
      eventId: eventId,
    );
    return response.data.earthquake.toEarthquake(
      parameter: earthquakeParameter,
      shindoDbStations: shindoDbStations,
    );
  }
```

- [ ] **Step 2: Notifier を CachedNotifier 化**

`earthquake_history_details_notifier.dart` 全体を次に置き換え:

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier
    with CachedNotifier<Earthquake> {
  @override
  Future<Earthquake> build(String eventId) async {
    await ref.watch(earthquakeHistoryRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<Earthquake> fetch(api.ApiClient client) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    return repository.fetchEarthquakeDetail(eventId: eventId, client: client);
  }
}
```

- [ ] **Step 3: ページの switch を値優先に並べ替え + バナー設置**

`earthquake_history_details_page.dart` の `build` 内 switch を次に変更 (SWR の「値付き Loading」で全画面スピナーにしないため、値ありを最優先):

```dart
    return switch (detailsState) {
      AsyncValue(:final value?) => _LoadedContent(earthquake: value),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async => ref.refresh(
            earthquakeHistoryDetailsProvider(eventId),
          ),
        ),
      ),
      _ => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              const SizedBox(height: 8),
              Text(
                '各地の震度データを取得中...',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    };
```

`_LoadedContent` (HookConsumerWidget) の `Scaffold(body: Stack(...))` の Stack **最後の子**として追加 (import に `package:eqmonitor/core/component/cached_data_banner.dart` を追加):

```dart
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CachedDataBanner(
                values: [
                  ref.watch(
                    earthquakeHistoryDetailsProvider(earthquake.eventId),
                  ),
                ],
              ),
            ),
          ),
```

※ Stack 内に既存のヘッダー/戻るボタン等のオーバーレイがある場合は、それらと重ならない位置 (それらの直前=下層) に挿入し、実機確認はせずレイアウト上妥当な位置を選ぶ。

- [ ] **Step 4: codegen + 既存テストが通ることを確認**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
cd app && flutter test test/feature/earthquake_history/
```
Expected: PASS (既存テスト無変更で緑)

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/
git commit -m "feat(app): 地震詳細を cache-first SWR 化しバナーを設置"
```

### Task 4: 類似地震 (`nearbyEarthquake`) の SWR 化

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart` (`fetchEarthquakeList` に client 引数)
- Modify: `app/lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart` (クラス化)
- Modify: `app/lib/feature/earthquake_history/ui/components/similar_earthquake_card.dart` (switch 値優先化)

**Interfaces:**
- Consumes: Task 3 と同じ Repository。
- Produces: `nearbyEarthquakeProvider` (名前・引数・戻り値型は不変)。

- [ ] **Step 1: `fetchEarthquakeList` に client 引数を追加**

メソッドシグネチャの named 引数群に `api.ApiClient? client,` を追加し、本文の `_api.earthquake.getV2Earthquake(` を `(client ?? _api).earthquake.getV2Earthquake(` に変更。他の呼び出し元 (ページネーション系) は引数省略で従来挙動のため無変更。

- [ ] **Step 2: provider をクラス化**

`similar_earthquake_provider.dart` 全体を次に置き換え (クラス名 `NearbyEarthquake` で provider 名維持):

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_earthquake_provider.g.dart';

@riverpod
class NearbyEarthquake extends _$NearbyEarthquake
    with CachedNotifier<List<EarthquakePartial>> {
  @override
  Future<List<EarthquakePartial>> build(
    String excludeEventId,
    double latitude,
    double longitude,
    int? depth,
    api.EarthquakeSortBy sortBy,
    api.SortOrder sortOrder,
    NearbyEarthquakeParameter parameter,
  ) async {
    await ref.watch(earthquakeHistoryRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<List<EarthquakePartial>> fetch(api.ApiClient client) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    final response = await repository.fetchEarthquakeList(
      client: client,
      latitudeGte: latitude - parameter.latitudeOffset,
      latitudeLte: latitude + parameter.latitudeOffset,
      longitudeGte: longitude - parameter.longitudeOffset,
      longitudeLte: longitude + parameter.longitudeOffset,
      depthGte: depth != null
          ? (depth! - parameter.depthOffset).clamp(0, 9999)
          : null,
      depthLte: depth != null ? depth! + parameter.depthOffset : null,
      sortBy: sortBy,
      sortOrder: sortOrder,
      limit: 5,
    );
    return response.items
        .where((e) => e.eventId != excludeEventId)
        .toList();
  }
}
```

※ 生成 getter `depth` は `int?` のため `!` が必要 (null チェック済みブロック内でもフィールド getter は promotion されない)。build_runner 実行後に analyzer の指摘へ従い調整する。

- [ ] **Step 3: 類似地震カードの switch を値優先化**

`similar_earthquake_card.dart` の `switch (asyncItems)` を並べ替え (branch 本体のコードは既存のまま移動):

- 先頭: `AsyncValue(:final value?) when value.isEmpty =>` 「該当する地震がありません」(既存 `AsyncData(value: final items) when items.isEmpty` の本体)
- 2番目: `AsyncValue(:final value?) =>` リスト表示 (既存 `AsyncData(value: final items)` の本体。`items` → `value` に読み替え)
- 3番目: `AsyncError() =>` エラー行 (既存のまま — 値なし初回失敗のみ到達)
- 最後: `_ =>` スピナー (既存 `AsyncLoading()` の本体)

- [ ] **Step 4: codegen + テスト**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
cd app && flutter test test/feature/earthquake_history/
```
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/
git commit -m "feat(app): 類似地震カードを cache-first SWR 化"
```

### Task 5: 電文詳細 (`telegramDetails`) の SWR 化 + 電文一覧ページ

**Files:**
- Modify: `app/lib/feature/telegram_list/data/notifier/telegram_details_notifier.dart` (クラス化)
- Modify: `app/lib/feature/telegram_list/ui/telegram_list_by_event_id_page.dart` (バナー設置)

**Interfaces:**
- Produces: `telegramDetailsProvider(eventId)` (名前・型 `AsyncValue<Map<String, TelegramDetailResponse>>` 不変)。

- [ ] **Step 1: provider をクラス化**

`telegram_details_notifier.dart` 全体を次に置き換え (Repository を介さないため client 直接使用。クラス名 `TelegramDetails` で provider 名維持):

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    hide TelegramStatus, TelegramType;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_notifier.g.dart';

@riverpod
class TelegramDetails extends _$TelegramDetails
    with CachedNotifier<Map<String, TelegramDetailResponse>> {
  @override
  Future<Map<String, TelegramDetailResponse>> build(String eventId) =>
      cachedBuild();

  @override
  Future<Map<String, TelegramDetailResponse>> fetch(ApiClient client) async {
    final response = await client.telegram.getV2TelegramEventIdEventIdDetails(
      eventId: eventId,
    );
    return {
      for (final item in response.data.items) item.telegram.id: item,
    };
  }
}
```

- [ ] **Step 2: 電文一覧ページにバナー設置**

`telegram_list_by_event_id_page.dart` の `body: RefreshIndicator(...)` を `Column` でラップ (import に `cached_data_banner.dart` を追加):

```dart
      body: Column(
        children: [
          CachedDataBanner(values: [asyncDetails]),
          Expanded(
            child: RefreshIndicator(
              // 既存の onRefresh / child をそのまま
            ),
          ),
        ],
      ),
```

※ 同ページの電文一覧 (`telegramListByEventIdProvider`) はページングのため SWR 対象外。バナーの values は `asyncDetails` のみ。既存の `asyncDetails.value ?? const {}` 参照は値付き Loading でも動くため無変更。

- [ ] **Step 3: codegen + テスト**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
cd app && flutter test test/feature/telegram_list/ 2>/dev/null || cd app && flutter test
```
Expected: PASS (telegram_list にテストが無ければ全体で確認)

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/telegram_list/
git commit -m "feat(app): 電文詳細を cache-first SWR 化しバナーを設置"
```

### Task 6: PR-1 検証と作成

**Files:** なし

- [ ] **Step 1: 全体検証**

```bash
cd app && dart analyze
cd app && flutter test
cd app && dart format --set-exit-if-changed lib test || dart format lib test
```
Expected: analyze はコード由来 diagnostics ゼロ / test 全緑 / format 差分があれば追いコミット

- [ ] **Step 2: push + PR 作成**

```bash
git push -u origin feat/cached-data-banner
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(app): キャッシュ先行表示の全面展開 (1/2) — CachedDataBanner + 地震詳細系SWR化 (#1432)" \
  --body "<Issue #1432 / spec / 変更点 / テスト結果を記載。末尾に https://claude.ai/code/session_01GWVtfA7sftVHT88FyaV5fD>"
```

---

## PR-2: 震度履歴 + フィード詳細 (branch: `feat/swr-static-rollout`, base: `feat/cached-data-banner`)

### Task 7: ブランチ作成

- [ ] **Step 1:**

```bash
git checkout -b feat/swr-static-rollout feat/cached-data-banner
```

### Task 8: 過去最高震度 2 provider の SWR 化 + 代表 SWR テスト (TDD)

**Files:**
- Modify: `app/lib/feature/intensity_history/data/repository/intensity_highest_repository.dart` (client 引数)
- Modify: `app/lib/feature/intensity_history/data/notifier/prefecture_highest_provider.dart` (クラス化)
- Modify: `app/lib/feature/intensity_history/data/notifier/city_highest_provider.dart` (クラス化)
- Modify: `app/test/feature/intensity_history/intensity_highest_repository_test.dart` (fake のシグネチャ追従)
- Test: `app/test/feature/intensity_history/city_highest_notifier_test.dart` (新規)

**Interfaces:**
- Produces: `IntensityHighestRepository.fetchPrefectureHighest({ApiClient? client})` / `fetchCityHighest(String prefectureCode, {ApiClient? client})`、`prefectureHighestProvider` / `cityHighestProvider(prefectureCode)` (名前不変)。

- [ ] **Step 1: 失敗するテストを書く**

```dart
// app/test/feature/intensity_history/city_highest_notifier_test.dart
import 'dart:async';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

late ApiClient _cacheOnlyClient;
late ApiClient _networkClient;

EarthquakePartial _partial(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTimePrecision: OriginTimePrecision.second,
  datasource: EarthquakeDatasource.jmaDisasterInformationXml,
  telegramTypes: const [],
  earthquakeType: EarthquakeType.normal,
);

HighestIntensityItem _item(String code, JmaIntensity intensity) =>
    HighestIntensityItem(
      code: code,
      name: 'エリア$code',
      intensity: intensity,
      count: 1,
      earthquake: _partial('evt-$code'),
    );

class _SwrFakeRepository extends IntensityHighestRepository {
  _SwrFakeRepository() : super(earthquake: ApiClient(Dio()).earthquake);

  bool cacheHit = false;
  List<HighestIntensityItem> cachedItems = const [];
  List<HighestIntensityItem> freshItems = const [];
  Object? networkError;

  @override
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode, {
    ApiClient? client,
  }) async {
    if (identical(client, _cacheOnlyClient)) {
      if (cacheHit) {
        return cachedItems.map(HighestIntensityEntry.fromApi).toList();
      }
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    if (networkError != null) {
      throw networkError!;
    }
    return freshItems.map(HighestIntensityEntry.fromApi).toList();
  }
}

Future<void> _pumpMicrotasks() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  late ProviderContainer container;
  late _SwrFakeRepository repository;

  setUp(() {
    _cacheOnlyClient = ApiClient(Dio());
    _networkClient = ApiClient(Dio());
    repository = _SwrFakeRepository();
    container = ProviderContainer(
      overrides: [
        intensityHighestRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith(
          (ref) async => _cacheOnlyClient,
        ),
        apiClientProvider.overrideWith((ref) async => _networkClient),
        dioProvider.overrideWith((ref) async => Dio()),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('キャッシュヒット時は stale を即返し、裏で fresh に差し替える', () async {
    repository
      ..cacheHit = true
      ..cachedItems = [_item('0101', JmaIntensity.value3)]
      ..freshItems = [_item('0101', JmaIntensity.value5Lower)];

    container.listen(cityHighestProvider('01'), (_, _) {});
    final stale = await container.read(cityHighestProvider('01').future);
    expect(stale.single.intensity, JmaIntensity.value3);
    expect(container.read(cityHighestProvider('01')).isFromCache, isTrue);

    await _pumpMicrotasks();

    final state = container.read(cityHighestProvider('01'));
    expect(state.requireValue.single.intensity, JmaIntensity.value5Lower);
    expect(state.isLoading, isFalse);
  });

  test('キャッシュミス時は通常ロードで fresh を返す', () async {
    repository.freshItems = [_item('0102', JmaIntensity.value4)];

    final result = await container.read(cityHighestProvider('01').future);

    expect(result.single.intensity, JmaIntensity.value4);
  });

  test('再検証失敗時は stale を維持しエラーを併記する', () async {
    repository
      ..cacheHit = true
      ..cachedItems = [_item('0103', JmaIntensity.value2)]
      ..networkError = Exception('offline');

    container.listen(cityHighestProvider('01'), (_, _) {});
    await container.read(cityHighestProvider('01').future);
    await _pumpMicrotasks();

    final state = container.read(cityHighestProvider('01'));
    expect(state.hasValue, isTrue);
    expect(state.requireValue.single.intensity, JmaIntensity.value2);
    expect(state.hasError, isTrue);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/intensity_history/city_highest_notifier_test.dart`
Expected: FAIL (fetchCityHighest に client 引数が無い / cityHighest がクラスでない)

- [ ] **Step 3: Repository に client 引数を追加**

```dart
  Future<List<HighestIntensityEntry>> fetchPrefectureHighest({
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureHighest();
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }

  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode, {
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureCodeCityHighest(
          code: prefectureCode,
        );
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }
```

既存 `intensity_highest_repository_test.dart` の `_FakeIntensityHighestRepository` の override 2 メソッドにも `{ApiClient? client}` を追加してシグネチャを合わせる。

- [ ] **Step 4: 2 provider をクラス化**

`prefecture_highest_provider.dart` 全体:

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_highest_provider.g.dart';

/// 全都道府県の過去最高震度一覧をキャッシュする provider。
@Riverpod(keepAlive: true)
class PrefectureHighest extends _$PrefectureHighest
    with CachedNotifier<List<HighestIntensityEntry>> {
  @override
  Future<List<HighestIntensityEntry>> build() async {
    await ref.watch(intensityHighestRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<List<HighestIntensityEntry>> fetch(ApiClient client) async {
    final repository = await ref.read(
      intensityHighestRepositoryProvider.future,
    );
    return repository.fetchPrefectureHighest(client: client);
  }
}
```

`city_highest_provider.dart` 全体:

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_highest_provider.g.dart';

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。
@riverpod
class CityHighest extends _$CityHighest
    with CachedNotifier<List<HighestIntensityEntry>> {
  @override
  Future<List<HighestIntensityEntry>> build(String prefectureCode) async {
    await ref.watch(intensityHighestRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<List<HighestIntensityEntry>> fetch(ApiClient client) async {
    final repository = await ref.read(
      intensityHighestRepositoryProvider.future,
    );
    return repository.fetchCityHighest(prefectureCode, client: client);
  }
}
```

- [ ] **Step 5: codegen + テストが通ることを確認**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
cd app && flutter test test/feature/intensity_history/
```
Expected: PASS (新規 3 tests + 既存 repository test 緑)

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/intensity_history/ app/test/feature/intensity_history/
git commit -m "feat(app): 過去最高震度 provider を cache-first SWR 化"
```

### Task 9: 震度履歴マップページへのバナーオーバーレイ

**Files:**
- Modify: `app/lib/feature/intensity_history/ui/intensity_history_page.dart`

- [ ] **Step 1: `_MapContent` の Stack にオーバーレイを追加**

`_MapContent` は `state = ref.watch(intensityHistoryControllerProvider)` を既に持つ。`Scaffold(body: Stack(...))` の子として、既存の上部 UI (SafeArea 付き Positioned 群) より**前**の重なり順にならないよう、既存オーバーレイ群の直後に追加 (import に `cached_data_banner.dart` を追加):

```dart
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CachedDataBanner(
                values: [
                  ref.watch(prefectureHighestProvider),
                  if (state is IntensityHistoryStateCity)
                    ref.watch(cityHighestProvider(state.prefectureCode)),
                ],
              ),
            ),
          ),
```

※ 既存の上部フローティング UI (検索バー等) と視覚的に衝突する場合は `top` にオフセットを与えるのではなく、既存上部 UI の Column 先頭にバナーを差し込む形を優先する (実装時にレイアウトを見て判断し、変更は最小にする)。

- [ ] **Step 2: 検証 + コミット**

```bash
cd app && flutter test test/feature/intensity_history/
git add app/lib/feature/intensity_history/
git commit -m "feat(app): 震度履歴マップにキャッシュ表示バナーを設置"
```

### Task 10: フィード詳細 (`feedBySource`) の SWR 化

**Files:**
- Modify: `app/lib/feature/feed/data/repository/feed_repository.dart` (client 引数)
- Modify: `app/lib/feature/feed/data/provider/feed_by_source_provider.dart` (クラス化)
- Modify: `app/lib/feature/feed/ui/page/feed_details_page.dart` (skipError + バナー)

- [ ] **Step 1: Repository に client 引数を追加**

```dart
  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) async {
    final response = await (client ?? _api).feed.getV2FeedsSourceTelegramHash(
      telegramHash: telegramHash,
    );
    return response.data.toFeedDetail();
  }
```

- [ ] **Step 2: provider をクラス化**

`feed_by_source_provider.dart` 全体:

```dart
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_by_source_provider.g.dart';

@riverpod
class FeedBySource extends _$FeedBySource with CachedNotifier<FeedDetail> {
  @override
  Future<FeedDetail> build(String telegramHash) async {
    await ref.watch(feedRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<FeedDetail> fetch(api.ApiClient client) async {
    final repository = await ref.read(feedRepositoryProvider.future);
    return repository.fetchByTelegramHash(telegramHash, client: client);
  }
}
```

- [ ] **Step 3: フィード詳細ページを skipError + バナー化**

`feed_details_page.dart` の body を次に変更 (import に `cached_data_banner.dart` を追加)。`skipError: true` により再検証失敗でも stale を表示し続け、失敗はバナーが伝える:

```dart
      body: Column(
        children: [
          CachedDataBanner(values: [feed]),
          Expanded(
            child: feed.when(
              skipError: true,
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, _) => ErrorCard(
                error: error,
                onReload: () async =>
                    ref.invalidate(feedBySourceProvider(telegramHash)),
              ),
              data: (item) => _FeedDetailsBody(item: item),
            ),
          ),
        ],
      ),
```

- [ ] **Step 4: codegen + 検証 + コミット**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
cd app && flutter test
git add app/lib/feature/feed/
git commit -m "feat(app): フィード詳細を cache-first SWR 化しバナーを設置"
```

### Task 11: PR-2 検証と作成 (stacked)

- [ ] **Step 1: 全体検証**

```bash
cd app && dart analyze
cd app && flutter test
```
Expected: コード由来 diagnostics ゼロ / 全緑

- [ ] **Step 2: push + stacked PR 作成**

```bash
git push -u origin feat/swr-static-rollout
gh pr create --repo YumNumm/EQMonitor --base feat/cached-data-banner \
  --title "feat(app): キャッシュ先行表示の全面展開 (2/2) — 震度履歴・フィード詳細SWR化 (#1432)" \
  --body "<PR-1 の上に stack。PR-1 マージ後に base が develop へ自動付け替えされる旨を明記。末尾に https://claude.ai/code/session_01GWVtfA7sftVHT88FyaV5fD>"
```

- [ ] **Step 3: CD について報告**

PR-2 が develop にマージされると `deploy-app.yaml` (`push: branches: [develop]`) が自動起動し iOS/Android がビルド・配布される。手動で起動する場合は `gh workflow run deploy-app.yaml`。

## Self-Review 済み確認事項

- 生成 provider 名の維持: クラス名対応表 (Global Constraints) どおり。`TelegramDetailsNotifier` 等にしない。
- 型整合: `fetch(ApiClient client)` は `cached_notifier.dart` の抽象と一致 (unaliased `ApiClient` / `api.ApiClient` はファイルごとの import 形式に合わせた)。
- family getter (`eventId` / `prefectureCode` / `telegramHash` / `latitude` 等) は riverpod_generator が生成する (既存 `.g.dart` で確認済み)。
- 値付き Loading の消費側対応: 地震詳細ページ・類似地震カード (switch 並べ替え)、フィード詳細 (`skipError: true`)。電文一覧 (`.value ?? {}`)・震度マップ (`whenOrNull`) は既存コードのままで安全。
