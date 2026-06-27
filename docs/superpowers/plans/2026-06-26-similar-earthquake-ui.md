# Similar Earthquake UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細シートの最下部に「類似している地震」セクションを追加し、バックエンド API からの類似地震データを表示する。

**Architecture:** eqmonitor_api パッケージの生成済み Retrofit クライアント（`getV2EarthquakeEventIdSimilar`）を利用。アプリ層で API モデルをドメインモデルに変換し、Riverpod Provider で状態管理。詳細シートの Column に新しいカードウィジェットを追加。

**Tech Stack:** Flutter, Riverpod (`@riverpod`), Freezed, go_router, eqmonitor_api (Retrofit生成)

## Global Constraints

- `dart analyze` 警告なし
- パッケージインポートのみ（相対インポート禁止）
- 生成ファイル（`*.g.dart`, `*.freezed.dart`）はコード生成後にコミット
- eqmonitor_api パッケージの手動変更は禁止（全て OpenAPI からのコード生成）

---

### Task 1: backend submodule 更新 + eqmonitor_api 再生成のコミット

**Files:**
- Modify: `backend` (submodule ref → `3ec73f05`)
- Modify: `packages/eqmonitor_api/` (再生成されたファイル群)

**Interfaces:**
- Produces: `api.SimilarEarthquakeResponse`, `api.SimilarEarthquakeItem`, `EarthquakeApiClient.getV2EarthquakeEventIdSimilar(eventId:)`

**NOTE:** このタスクは既に完了済み。コード生成は実行済みのため、コミットのみ必要。

- [ ] **Step 1: 変更をステージング**

```bash
git add backend
git add packages/eqmonitor_api/
```

- [ ] **Step 2: コミット**

```bash
git commit -m "chore: update backend submodule and regenerate eqmonitor_api client

Add similar earthquake API endpoint (GET /v2/earthquake/{eventId}/similar)
with SimilarEarthquakeResponse and SimilarEarthquakeItem models."
```

---

### Task 2: アプリ層モデル + SimilarityLevel enum

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/similar_earthquake_item.dart`
- Create: `app/lib/feature/earthquake_history/data/model/similarity_level.dart`

**Interfaces:**
- Consumes: `app/lib/feature/earthquake_history/data/model/earthquake_partial.dart` の `EarthquakePartial`
- Produces: `SimilarEarthquakeItem(earthquake, score, level, groupedEarthquakes)`, `SimilarityLevel` enum, `SimilarEarthquakeItemApiExtension.toSimilarEarthquakeItem(parameter:)`

- [ ] **Step 1: SimilarityLevel enum を作成**

```dart
// app/lib/feature/earthquake_history/data/model/similarity_level.dart
enum SimilarityLevel {
  a(maxScore: 100),
  b(maxScore: 200),
  c(maxScore: 300),
  d(maxScore: 400),
  e(maxScore: 500);

  const SimilarityLevel({required this.maxScore});
  final double maxScore;

  int get filledCount => 5 - index;

  static SimilarityLevel fromScore(double score) {
    for (final level in values) {
      if (score <= level.maxScore) {
        return level;
      }
    }
    return SimilarityLevel.e;
  }
}
```

- [ ] **Step 2: SimilarEarthquakeItem freezed モデルを作成**

```dart
// app/lib/feature/earthquake_history/data/model/similar_earthquake_item.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_level.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_earthquake_item.freezed.dart';

@freezed
abstract class SimilarEarthquakeItem with _$SimilarEarthquakeItem {
  const factory SimilarEarthquakeItem({
    required EarthquakePartial earthquake,
    required double score,
    required SimilarityLevel level,
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeItem;
}

extension SimilarEarthquakeItemApiExtension on api.SimilarEarthquakeItem {
  SimilarEarthquakeItem toSimilarEarthquakeItem({
    required EarthquakeParameter parameter,
  }) =>
      SimilarEarthquakeItem(
        earthquake: earthquake.toEarthquakePartial(parameter: parameter),
        score: score.toDouble(),
        level: SimilarityLevel.fromScore(score.toDouble()),
        groupedEarthquakes: groupedEarthquakes
            .map((e) => e.toEarthquakePartial(parameter: parameter))
            .toList(),
      );
}
```

- [ ] **Step 3: コード生成を実行**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/earthquake_history/data/model/similar_earthquake_item.dart"
```

- [ ] **Step 4: コンパイル確認**

```bash
cd app && dart analyze lib/feature/earthquake_history/data/model/similar_earthquake_item.dart lib/feature/earthquake_history/data/model/similarity_level.dart
```

Expected: No issues found

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/data/model/similar_earthquake_item.dart
git add app/lib/feature/earthquake_history/data/model/similar_earthquake_item.freezed.dart
git add app/lib/feature/earthquake_history/data/model/similarity_level.dart
git commit -m "feat: add SimilarEarthquakeItem model and SimilarityLevel enum"
```

---

### Task 3: Repository メソッド + Provider

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart`

**Interfaces:**
- Consumes: `EarthquakeApiClient.getV2EarthquakeEventIdSimilar(eventId:)`, `SimilarEarthquakeItemApiExtension.toSimilarEarthquakeItem(parameter:)`
- Produces: `EarthquakeHistoryRepository.fetchSimilarEarthquakes(eventId:)` → `List<SimilarEarthquakeItem>`, `similarEarthquakeProvider(eventId)` → `AsyncValue<List<SimilarEarthquakeItem>>`

- [ ] **Step 1: Repository に fetchSimilarEarthquakes メソッドを追加**

`earthquake_history_repository.dart` に以下を追加:

```dart
// import を追加
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_item.dart';

// EarthquakeHistoryRepository クラスに追加
Future<List<SimilarEarthquakeItem>> fetchSimilarEarthquakes({
  required String eventId,
}) async {
  final response = await _api.earthquake.getV2EarthquakeEventIdSimilar(
    eventId: eventId,
  );
  return response.data.items
      .map(
        (e) => e.toSimilarEarthquakeItem(parameter: earthquakeParameter),
      )
      .toList();
}
```

- [ ] **Step 2: Provider を作成**

```dart
// app/lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_earthquake_provider.g.dart';

@riverpod
Future<List<SimilarEarthquakeItem>> similarEarthquake(
  Ref ref,
  String eventId,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  return repository.fetchSimilarEarthquakes(eventId: eventId);
}
```

- [ ] **Step 3: コード生成を実行**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart" --build-filter="lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart"
```

- [ ] **Step 4: コンパイル確認**

```bash
cd app && dart analyze lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart
```

Expected: No issues found

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart
git add app/lib/feature/earthquake_history/data/provider/similar_earthquake_provider.dart
git add app/lib/feature/earthquake_history/data/provider/similar_earthquake_provider.g.dart
git commit -m "feat: add similarEarthquakeProvider and repository method"
```

---

### Task 4: SimilarityScoreIndicator ウィジェット

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/similarity_score_indicator.dart`

**Interfaces:**
- Consumes: `SimilarityLevel` enum
- Produces: `SimilarityScoreIndicator(level:)` widget

- [ ] **Step 1: ウィジェットを作成**

```dart
// app/lib/feature/earthquake_history/ui/components/similarity_score_indicator.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_level.dart';
import 'package:flutter/material.dart';

class SimilarityScoreIndicator extends StatelessWidget {
  const SimilarityScoreIndicator({
    required this.level,
    super.key,
  });

  final SimilarityLevel level;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filledCount = level.filledCount;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(left: i > 0 ? 2 : 0),
            child: SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: i < filledCount
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        const SizedBox(width: 4),
        Text(
          level.name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: コンパイル確認**

```bash
cd app && dart analyze lib/feature/earthquake_history/ui/components/similarity_score_indicator.dart
```

Expected: No issues found

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/components/similarity_score_indicator.dart
git commit -m "feat: add SimilarityScoreIndicator widget"
```

---

### Task 5: SimilarEarthquakeCard ウィジェット + 詳細シートへの統合

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/similar_earthquake_card.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`

**Interfaces:**
- Consumes: `similarEarthquakeProvider(eventId)`, `EarthquakeHistoryListTile`, `SimilarityScoreIndicator`, `EarthquakeHistoryDetailsRoute`, `intensityColorProvider`
- Produces: `SimilarEarthquakeCard(eventId:)` widget（詳細シートに統合済み）

- [ ] **Step 1: SimilarEarthquakeCard ウィジェットを作成**

```dart
// app/lib/feature/earthquake_history/ui/components/similar_earthquake_card.dart
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similarity_score_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({
    required this.eventId,
    super.key,
  });

  final String eventId;

  static const _initialDisplayCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(similarEarthquakeProvider(eventId));
    final intensityColor = ref.watch(intensityColorProvider);

    return switch (asyncItems) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            ),
          ),
        ),
      AsyncError(:final error) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.error_outline, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '類似地震の取得に失敗しました',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () => ref.invalidate(
                  similarEarthquakeProvider(eventId),
                ),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      AsyncData(value: final items) when items.isEmpty => const SizedBox
          .shrink(),
      AsyncData(value: final items) => _SimilarEarthquakeList(
          items: items,
          intensityColor: intensityColor,
        ),
    };
  }
}

class _SimilarEarthquakeList extends HookWidget {
  const _SimilarEarthquakeList({
    required this.items,
    required this.intensityColor,
  });

  final List<SimilarEarthquakeItem> items;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final showAll = useState(false);
    final theme = Theme.of(context);

    final displayItems = showAll.value
        ? items
        : items.take(SimilarEarthquakeCard._initialDisplayCount).toList();
    final hasMore =
        items.length > SimilarEarthquakeCard._initialDisplayCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            '類似している地震',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (final item in displayItems)
          _SimilarEarthquakeItemTile(
            item: item,
            intensityColor: intensityColor,
          ),
        if (hasMore && !showAll.value)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextButton(
              onPressed: () => showAll.value = true,
              child: Text(
                'すべて表示（残り${items.length - SimilarEarthquakeCard._initialDisplayCount}件）',
              ),
            ),
          ),
      ],
    );
  }
}

class _SimilarEarthquakeItemTile extends HookWidget {
  const _SimilarEarthquakeItemTile({
    required this.item,
    required this.intensityColor,
  });

  final SimilarEarthquakeItem item;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasGroup = item.groupedEarthquakes.isNotEmpty;

    return Column(
      children: [
        Stack(
          children: [
            EarthquakeHistoryListTile(
              item: item.earthquake,
              intensityColor: intensityColor,
              onTap: () => EarthquakeHistoryDetailsRoute(
                eventId: item.earthquake.eventId,
              ).push<void>(context),
              showBackgroundColor: false,
              intensityIconSize: 32,
              dense: true,
            ),
            Positioned(
              right: 8,
              top: 8,
              child: SimilarityScoreIndicator(level: item.level),
            ),
          ],
        ),
        if (hasGroup)
          InkWell(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    isExpanded.value
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isExpanded.value
                        ? '閉じる'
                        : '他${item.groupedEarthquakes.length}件の余震',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        if (hasGroup && isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                for (final grouped in item.groupedEarthquakes)
                  EarthquakeHistoryListTile(
                    item: grouped,
                    intensityColor: intensityColor,
                    onTap: () => EarthquakeHistoryDetailsRoute(
                      eventId: grouped.eventId,
                    ).push<void>(context),
                    showBackgroundColor: false,
                    intensityIconSize: 28,
                    dense: true,
                  ),
              ],
            ),
          ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
```

- [ ] **Step 2: 詳細シートに SimilarEarthquakeCard を統合**

`earthquake_history_details_page.dart` の `_LoadedContent` の Column 内、AdBanner と `_TelegramListButton` の間に追加:

```dart
// import を追加
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_card.dart';

// Column children 内、AdBanner の後に追加
SimilarEarthquakeCard(eventId: earthquake.eventId),
```

- [ ] **Step 3: コンパイル確認**

```bash
cd app && dart analyze lib/feature/earthquake_history/ui/components/similar_earthquake_card.dart lib/feature/earthquake_history/ui/earthquake_history_details_page.dart
```

Expected: No issues found

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/components/similar_earthquake_card.dart
git add app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart
git commit -m "feat: add SimilarEarthquakeCard to earthquake detail sheet

Display similar earthquakes at the bottom of the detail sheet with:
- 5-level similarity score indicator (A-E)
- Collapsible aftershock groups
- Initial display of 5 items with 'show all' button
- Tap to navigate to earthquake detail page"
```

---

### Task 6: 全体のビルド・analyze 確認

**Files:** (変更なし、検証のみ)

- [ ] **Step 1: melos run analyze**

```bash
melos run analyze
```

Expected: No issues found

- [ ] **Step 2: アプリのビルド確認**

```bash
cd app && flutter build apk --debug --target-platform android-arm64 2>&1 | tail -5
```

Expected: ビルド成功
