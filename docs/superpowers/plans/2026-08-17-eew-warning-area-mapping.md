# EEW Warning Area Mapping Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** EEW の警報地域表示と現在地向け警報 overlay を、現在報の正しい気象庁区域コードで即時更新する。

**Architecture:** `EewWarningAreaSelector` が現在警報イベントから `warning.prefectures` code を純粋に抽出し、ホーム地図と詳細地図が共有する。overlay は既存 selector / builder の責務を維持しつつ、府県予報区と地方予報区の現在報配列を `hadWarning` 非依存で参照する。

**Tech Stack:** Flutter、Dart、Riverpod 3 code generation、flutter_hooks、MapLibre、flutter_test

## Global Constraints

- Flutter / Dart コマンドは常に `mise exec --` 経由で実行する。
- `dynamic`、`Object`、null assertion (`!`) を追加しない。
- MapLibre 操作は既存の `MapOperationQueueScope` で直列化する。
- 固定地域、推測値、ランダム値へのフォールバックを追加しない。
- 初回警報、追加地域、取消を同じ報で反映する。
- ユーザーの既存未コミット差分を変更・stageしない。

---

### Task 1: 現在警報の府県予報区 selector

**Files:**
- Create: `app/lib/feature/eew/data/logic/eew_warning_area_selector.dart`
- Create: `app/lib/feature/eew/data/logic/eew_warning_area_selector.g.dart`
- Create: `app/test/feature/eew/data/logic/eew_warning_area_selector_test.dart`

**Interfaces:**
- Consumes: `Iterable<EewTelegramItem>`
- Produces: `EewWarningAreaSelector.selectPrefectureCodes({required Iterable<EewTelegramItem> events}) -> List<String>`
- Produces: `eewWarningAreaSelectorProvider`

- [ ] **Step 1: Write the failing selector tests**

```dart
test('初回警報でもwarning.prefecturesのcodeを返す', () {
  final codes = const EewWarningAreaSelector().selectPrefectureCodes(
    events: [
      warningEew(
        prefectures: [
          EewWarningZoneInfo(code: '9020', name: '青森', hadWarning: false),
        ],
        regions: [
          EewWarningZoneInfo(code: '202', name: '青森県三八上北', hadWarning: false),
        ],
      ),
    ],
  );
  expect(codes, ['9020']);
});

test('取消・非警報を除外し複数イベントを重複排除する', () {
  final codes = const EewWarningAreaSelector().selectPrefectureCodes(
    events: [
      warningEew(prefectureCode: '9020'),
      warningEew(prefectureCode: '9020'),
      warningEew(prefectureCode: '9030', isCanceled: true),
      warningEew(prefectureCode: '9040', isWarning: false),
    ],
  );
  expect(codes, ['9020']);
});
```

- [ ] **Step 2: Run the selector test and verify RED**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/eew/data/logic/eew_warning_area_selector_test.dart
```

Expected: FAIL because `EewWarningAreaSelector` does not exist.

- [ ] **Step 3: Implement the minimal selector and provider**

```dart
@riverpod
EewWarningAreaSelector eewWarningAreaSelector(Ref ref) =>
    const EewWarningAreaSelector();

class EewWarningAreaSelector {
  const EewWarningAreaSelector();

  List<String> selectPrefectureCodes({
    required Iterable<EewTelegramItem> events,
  }) => {
    for (final event in events)
      if (event.isWarning == true && !event.isCanceled)
        for (final area
            in event.warning?.prefectures ?? const <EewWarningZoneInfo>[])
          area.code,
  }.toList(growable: false);
}
```

- [ ] **Step 4: Generate Riverpod code and verify GREEN**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test --no-pub app/test/feature/eew/data/logic/eew_warning_area_selector_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit the selector slice**

```bash
git add app/lib/feature/eew/data/logic/eew_warning_area_selector.dart app/lib/feature/eew/data/logic/eew_warning_area_selector.g.dart app/test/feature/eew/data/logic/eew_warning_area_selector_test.dart
git commit -m "fix: EEW現在警報の府県予報区抽出を修正"
```

### Task 2: 地図レイヤーの区域対応とライフサイクル回帰

**Files:**
- Modify: `app/lib/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart`
- Modify: `app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart`
- Create: `app/test/feature/home/ui/component/map/layer/eew_warning_regions_layer_lifecycle_test.dart`

**Interfaces:**
- Consumes: `eewWarningAreaSelectorProvider`
- Produces: MapLibre `areaForecastLocalEew` filter containing `warning.prefectures` codes

- [ ] **Step 1: Write a failing Widget lifecycle test**

Build a `MapLibreInheritedModel` test harness with a delayed fake
`StyleController`. Mount `EewWarningRegionsLayer` with region `202` and
prefecture `9020`, both `hadWarning: false`, and assert the final filter is:

```dart
[
  'in',
  ['get', 'code'],
  [
    'literal',
    ['9020'],
  ],
]
```

In the same test, delay the first add, update to `9030`, dispose, remount with
`9040`, then assert operations are ordered `add -> filter:9030 -> remove -> add -> filter:9040`
and exactly one `eew-warning-regions-fill` remains active.

- [ ] **Step 2: Run the lifecycle test and verify RED**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/home/ui/component/map/layer/eew_warning_regions_layer_lifecycle_test.dart
```

Expected: FAIL because the current filter uses `warning.regions.where(hadWarning)`.

- [ ] **Step 3: Use the shared selector in both map layers**

In each Widget build:

```dart
final warningAreaSelector = ref.watch(eewWarningAreaSelectorProvider);
final warningCodes = useMemoized(
  () => warningAreaSelector.selectPrefectureCodes(events: events),
  [warningAreaSelector, events],
);
```

For the details layer, pass zero or one event through the same selector. Keep
the existing source layer `areaForecastLocalEew`, empty filter handling,
`latestCodes`, queue, and layer IDs unchanged.

- [ ] **Step 4: Run map tests and verify GREEN**

Run:

```bash
mise exec -- flutter test --no-pub \
  app/test/feature/home/ui/component/map/layer/eew_warning_regions_layer_lifecycle_test.dart \
  app/test/feature/home/ui/component/map/layer/eew_area_filter_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit the map slice**

```bash
git add app/lib/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart app/test/feature/home/ui/component/map/layer/eew_warning_regions_layer_lifecycle_test.dart
git commit -m "fix: EEW警報地域の地図コード対応を修正"
```

### Task 3: 現在地向け警報 overlay の現在報判定

**Files:**
- Modify: `app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart`
- Modify: `app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart`
- Modify: `app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart`
- Modify: `app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart`
- Modify: `app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart`

**Interfaces:**
- Consumes: `warningAreaCode` resolved from `areaForecastLocalEew`
- Produces: candidates matched against `event.warning.prefectures`
- Produces: display warning zone names from all current `event.warning.zones`

- [ ] **Step 1: Change tests to the correct current-report behavior and verify RED**

Add assertions that:

```dart
expect(
  selector.select(
    aliveEews: [
      warningEew(
        eventId: 'initial-warning',
        warningPrefectureCode: '9011',
        warningRegionCode: '100',
        hadWarning: false,
      ),
    ],
    warningAreaCode: '9011',
    warningAreaName: '北海道道央',
    forecastAreaCode: '100',
    forecastAreaName: '石狩地方北部',
  ),
  hasLength(1),
);
```

Use a mismatched `warning.regions` code to prove it cannot make the candidate
eligible. Add a display-model assertion that a `warning.zones` item with
`hadWarning: false` appears in the initial-warning headline.

Run:

```bash
mise exec -- flutter test --no-pub \
  app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart \
  app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart \
  app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart
```

Expected: FAIL because production code still checks `warning.regions` and
`hadWarning`.

- [ ] **Step 2: Implement the minimal overlay corrections**

Candidate eligibility:

```dart
final hasCurrentWarning = event.warning?.prefectures.any(
  (prefecture) => prefecture.code == warningAreaCode,
) ?? false;
```

Display-model zone collection:

```dart
for (final zone
    in candidate.event.warning?.zones ?? const <EewWarningZoneInfo>[]) {
  warningZoneNamesByCode[zone.code] = zone.name;
}
```

Keep existing `isWarning == true`, cancellation, sorting, deduplication,
representative event, and forecast-area lookup behavior unchanged.

- [ ] **Step 3: Run overlay tests and verify GREEN**

Run the three-file command from Step 1. Expected: PASS.

- [ ] **Step 4: Commit the overlay slice**

```bash
git add app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart
git commit -m "fix: EEW警報overlayの現在報判定を修正"
```

### Task 4: 文書訂正と全体検証

**Files:**
- Modify: `docs/superpowers/specs/2026-07-25-eew-warning-overlay-design.md`
- Modify: `docs/knowledge/20260725_eew_warning_message_sources.md`
- Delete: `docs/todo/950_eew_warning_region_fill_mapping.md`

**Interfaces:**
- Consumes: approved design `docs/superpowers/specs/2026-08-17-eew-warning-area-mapping-design.md`
- Produces: current behavior matching implementation and backend contract

- [ ] **Step 1: Correct active documentation**

Replace current-warning eligibility references from
`warning.regions.where(hadWarning)` to `warning.prefectures` and document that
`hadWarning` is previous-report history. Replace headline references from
`warning.zones.where(hadWarning)` to all current `warning.zones`. Add a link to
the 2026-08-17 correction design.

- [ ] **Step 2: Remove the resolved TODO**

Delete `docs/todo/950_eew_warning_region_fill_mapping.md` only after all RED
tests have turned GREEN.

- [ ] **Step 3: Run format, targeted tests, analysis, and diff checks**

```bash
mise exec -- dart format app/lib/feature/eew app/lib/feature/home/ui/component/map/layer app/test/feature/eew app/test/feature/home/ui/component/map/layer
mise exec -- flutter test --no-pub \
  app/test/feature/eew/data/logic/eew_warning_area_selector_test.dart \
  app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart \
  app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart \
  app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart \
  app/test/feature/home/ui/component/map/layer/eew_warning_regions_layer_lifecycle_test.dart \
  app/test/feature/home/ui/component/map/layer/eew_area_filter_test.dart \
  app/test/feature/eew/data/eew_realtime_test.dart \
  app/test/feature/eew/data/eew_upsert_test.dart
mise exec -- flutter analyze --no-pub \
  app/lib/feature/eew/data/logic/eew_warning_area_selector.dart \
  app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart \
  app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart \
  app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart \
  app/lib/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart
git --no-pager diff --check
git --no-pager status --short
```

Expected: all tests pass, analyzer reports no issues, diff check is empty, and
status contains only task files plus the user's pre-existing changes.

- [ ] **Step 4: Commit documentation**

```bash
git add docs/superpowers/specs/2026-07-25-eew-warning-overlay-design.md docs/knowledge/20260725_eew_warning_message_sources.md docs/todo/950_eew_warning_region_fill_mapping.md
git commit -m "docs: EEW現在警報の区域契約を訂正"
```

- [ ] **Step 5: Final diff review and push handoff**

Review each commit with `git --no-pager show --stat` and
`git --no-pager diff HEAD~4..HEAD`. This worktree is detached, so report the
commit hashes and instruct the user to use Codex App **Create branch** before
push.
