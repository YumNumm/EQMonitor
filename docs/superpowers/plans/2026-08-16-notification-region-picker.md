# Notification Region Picker Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** カスタム通知で正しい地域をかな検索または地図から安全に選択できるようにする。

**Architecture:** EEW region、地震観測パラメータの市区町村、観測点→EEW region対応を不変カタログへ結合し、一覧と地図で共有する。地図タップは既存JMA map isolate、style操作はマップ単位キュー、非同期結果とcameraは世代guardで競合を防ぐ。

**Tech Stack:** Flutter、Riverpod 3、flutter_hooks、MapLibre、jma_map、unorm_dart、flutter_test

## Global Constraints

- 地域別最大震度は変更しない。欠損を固定値・ランダム値・別地域への推測で補わない。
- Dart/Flutterコマンドは `mise exec --` 経由、依存追加は `flutter pub add` を使う。
- UIはHook/Consumer Widget、ロジックは専用クラスとRiverpod DIへ分離し、`dynamic`、`Object`、`!`を追加しない。
- 1コミット30〜100行程度、英語1語prefix＋日本語説明、完了後push・Draft PR作成。

---

### Task 1: 地域カタログとかな検索

**Files:** Create `app/lib/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart`, `data/logic/notification_region_catalog_builder.dart`, `data/logic/notification_region_search.dart`, `data/provider/notification_region_catalog_provider.dart`; Test `app/test/feature/settings/features/notification_settings/notification_region_catalog_builder_test.dart`, `notification_region_search_test.dart`; Modify `app/pubspec.yaml`, lockfiles.

**Interfaces:** Produce `NotificationRegionCatalog.regions`, `NotificationRegionOption(code,name,kana,cities)`, `NotificationCityOption(code,name,kana)`, `NotificationRegionCatalogBuilder.build({required JmaCodeTableParameter codeTable, required EarthquakeParameter earthquake})`, `NotificationRegionSearch.filter({required List<T> items, required String query, required String Function(T) name, required String? Function(T) kana})`.

```dart
NotificationRegionCatalog build({required JmaCodeTableParameter codeTable, required EarthquakeParameter earthquake});
List<T> filter<T>({required List<T> items, required String query, required String Function(T) name, required String? Function(T) kana});
```

- [ ] Add `unorm_dart` with `mise exec -- flutter pub add unorm_dart` from `app/`.
- [ ] Test that station codes join correct city names/kana, duplicates collapse, multi-region cities remain in each actual region, and unmapped cities are omitted.
- [ ] Implement catalog models/builder/provider; log unmapped data without fallback.
- [ ] Test kanji, hiragana, katakana, half-width kana, full-width ASCII, and whitespace queries.
- [ ] Implement NFKC→lowercase→whitespace removal→katakana-to-hiragana normalization and generic filtering.
- [ ] Run both tests, format, and commit `Feat: 通知地域カタログとかな検索を追加`.

### Task 2: 一覧選択UI

**Files:** Create `app/lib/feature/settings/features/notification_settings/data/model/notification_region_selection.dart`; Modify `ui/page/region_picker_page.dart`, `ui/page/city_picker_page.dart`; Test `app/test/feature/settings/features/notification_settings/region_picker_page_test.dart`, `city_picker_page_test.dart`.

**Interfaces:** Consume catalog/search. Produce `NotificationRegionSelection(regionCode,regionName,cityCode?,cityName?)`; city/map pages return this value, and `RegionPickerPage` alone runs `NotificationSlotsNotifier.addRegionMutation`.

```dart
final class NotificationRegionSelection {
  const NotificationRegionSelection({required this.regionCode, required this.regionName, this.cityCode, this.cityName});
}
```

- [ ] Write Widget tests for no IDs, compact 48px-min rows, correct city names, kana search, empty states, and disabled double submission.
- [ ] Refactor region/city pages to watch catalog provider, use shared search, return a selection, and centralize mutation/error/navigation in the region page.
- [ ] Run Widget tests and commit `Fix: 通知地域一覧の表示と検索を改善`.

### Task 3: 地図状態・解決・競合guard

**Files:** Create `data/model/notification_region_map_selection.dart`, `data/notifier/notification_region_map_selection_notifier.dart`, `data/logic/notification_region_map_filter.dart`, `data/logic/latest_map_operation_guard.dart`; Test matching files under `app/test/feature/settings/features/notification_settings/`.

**Interfaces:** Produce `focusRegion`, `selectCity`, `reset`; `buildRegionCityFilter(List<String>)`, `buildSelectedCityFilter(String?)`; `LatestMapOperationGuard.begin/isCurrent/invalidate/dispose` and queued latest-wins camera execution.

```dart
int begin();
bool isCurrent(int generation);
Future<void> runLatest(Future<void> Function() operation);
void invalidate();
```

- [ ] Test nationwide→region→city→region→nationwide transitions and rejection of cities outside the focused region.
- [ ] Implement the auto-dispose notifier with immutable selection values.
- [ ] Test empty/region/selected-city MapLibre filter expressions and stale/disposed operation rejection.
- [ ] Implement filter builders and generation-based async/camera guard without storing MapController in provider state.
- [ ] Run tests, generate Riverpod code, and commit `Feat: 通知地域地図の状態と競合制御を追加`.

### Task 4: 地図ページとレイヤー

**Files:** Create `ui/page/notification_region_map_picker_page.dart`, `ui/component/notification_region_map_layer.dart`, `ui/component/notification_region_map_selection_card.dart`; Modify `ui/page/region_picker_page.dart`; Test `app/test/feature/settings/features/notification_settings/notification_region_map_selection_card_test.dart`.

**Interfaces:** Consume `mapConfigurationProvider`, `jmaMapIsolateProvider`, catalog, selection notifier, filters, guard. Return `NotificationRegionSelection?` to `RegionPickerPage`.

```dart
static Future<NotificationRegionSelection?> show(BuildContext context);
```

- [ ] Test bottom card content/actions for nationwide, region, and city states.
- [ ] Build Japan-initialized MapLibre page; preload style/catalog/isolate, resolve EEW region then city by code, fit region bounds, reset to Japan, and ignore stale/unmounted results.
- [ ] Add queued layers for selected region outline and selected-city thick line; update base city-line and custom filters so only focused-region cities appear; restore/remove individually on cleanup.
- [ ] Wire region/city decision buttons and AppBar reset; surface short loading/error/outside-map messages.
- [ ] Run map-related tests, format/analyze touched files, and commit `Feat: 通知地域を地図から選択可能にする`.

### Task 5: 検証・知見・PR

**Files:** Create `docs/knowledge/20260816_notification_region_map_lifecycle.md`; Modify generated files only as required.

- [ ] Record catalog source-of-truth and MapLibre isolate/generation/queue lifecycle rules with exact verification commands.
- [ ] Run targeted tests, `mise exec -- flutter analyze --no-pub`, `git diff --check`, and inspect that `app/lib/feature/intensity_history/` is unchanged.
- [ ] Commit docs as `Docs: 通知地域地図のデータとライフサイクルを記録` and any isolated verification fixes separately.
- [ ] Create `codex/notification-region-picker`, push all commits, and open a Draft PR summarizing behavior, tests, risks, and manual map checks.
