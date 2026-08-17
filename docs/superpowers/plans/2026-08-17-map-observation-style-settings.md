# Map Observation Style Settings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** マップレイヤー設定の観測点サイズと観測点の枠を、強震モニタ観測点の描画へ正しく反映する。

**Architecture:** 既存の `KyoshinMonitorObservationLayerBuilder` を描画設定の単一変換点として維持する。Widget は Home 設定、強震モニタ設定、生存中 EEW の有無を購読し、既存の操作キューで circle layer のみ再構築する。

**Tech Stack:** Flutter、Dart、Riverpod 3、flutter_hooks、MapLibre、flutter_test

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- サイズ係数は小 `0.65`、中 `1.0`、大 `1.35` とする。
- `onlyEew` は生存中の EEW 電文が1件以上ある場合だけ枠を表示する。
- Preferences の保存形式、GeoJSON、他レイヤーは変更しない。
- 既存の未コミット `analysis_options.yaml` 群と `mise.lock` は変更・stage しない。

---

### Task 1: 観測点サイズを円半径へ適用する

**Files:**
- Modify: `app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`
- Modify: `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`

**Interfaces:**
- Consumes: `KyoshinMonitorObservationLayerBuilder.build({required double radiusScaleFactor})`
- Produces: サイズ係数を含む MapLibre `circle-radius` 式

- [x] **Step 1: 円半径の回帰テストを書く**

```dart
test('marker size係数をcircle radiusへ適用する', () {
  const builder = KyoshinMonitorObservationLayerBuilder();

  expect(
    builder.build(radiusScaleFactor: 0.65).paint['circle-radius'],
    [
      '*',
      0.65,
      [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        1,
        10,
        10,
      ],
    ],
  );
});
```

- [x] **Step 2: テストが意図した理由で失敗することを確認する**

Run: `cd app && mise exec -- flutter test --no-pub test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

Expected: `circle-radius` が先頭 `interpolate` の現行値であるため FAIL。

- [x] **Step 3: 円半径の補間式へ係数を乗算する**

```dart
'circle-radius': [
  '*',
  radiusScaleFactor,
  [
    'interpolate',
    ['linear'],
    ['zoom'],
    3,
    1,
    10,
    10,
  ],
],
```

- [x] **Step 4: 対象テストが通ることを確認する**

Run: `cd app && mise exec -- flutter test --no-pub test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

Expected: PASS。

### Task 2: 枠表示モードと EEW 状態を描画へ適用する

**Files:**
- Modify: `app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`
- Modify: `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`

**Interfaces:**
- Consumes: `KyoshinMonitorMarkerType`、`eewAliveTelegramProvider`
- Produces: `build({required double radiusScaleFactor, required KyoshinMonitorMarkerType markerType, required bool hasActiveEew})`

- [x] **Step 1: 枠モードの回帰テストを書く**

```dart
final visibleStrokeWidth = [
  '*',
  1.0,
  [
    'interpolate',
    ['linear'],
    ['zoom'],
    3,
    0.2,
    10,
    1,
  ],
];
for (final testCase in <({
  KyoshinMonitorMarkerType markerType,
  bool hasActiveEew,
  Object expected,
})>[
  (markerType: .always, hasActiveEew: false, expected: visibleStrokeWidth),
  (markerType: .onlyEew, hasActiveEew: true, expected: visibleStrokeWidth),
  (markerType: .onlyEew, hasActiveEew: false, expected: 0),
  (markerType: .never, hasActiveEew: true, expected: 0),
]) {
  expect(
    builder
        .build(
          radiusScaleFactor: 1,
          markerType: testCase.markerType,
          hasActiveEew: testCase.hasActiveEew,
        )
        .paint['circle-stroke-width'],
    testCase.expected,
  );
}
```

- [x] **Step 2: 新しい描画入力が未実装で失敗することを確認する**

Run: `cd app && mise exec -- flutter test --no-pub test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

Expected: `markerType` と `hasActiveEew` が未定義のためコンパイル FAIL。

- [x] **Step 3: Widget から枠モードと EEW 状態を渡す**

```dart
final markerType = ref.watch(
  kyoshinMonitorSettingsProvider.select(
    (value) => value.value?.kmoniMarkerType ?? .onlyEew,
  ),
);
final hasActiveEew = ref.watch(
  eewAliveTelegramProvider.select((eews) => eews?.isNotEmpty ?? false),
);
```

`build` 呼び出しへ `markerType` と `hasActiveEew` を渡し、レイヤー更新の
`useEffect` 依存配列にも両方を追加する。

- [x] **Step 4: ビルダーで枠表示条件を変換する**

```dart
final showMarkerBorder = switch (markerType) {
  .always => true,
  .onlyEew => hasActiveEew,
  .never => false,
};
```

`showMarkerBorder` が false の場合は `circle-stroke-width` を `0`、true の場合は
サイズ係数を乗算したズーム補間式にする。

- [x] **Step 5: 対象テストが通ることを確認する**

Run: `cd app && mise exec -- flutter test --no-pub test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

Expected: PASS。

### Task 3: 検証と公開準備

**Files:**
- Verify: `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`
- Verify: `app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

**Interfaces:**
- Consumes: Task 1・2 の完成差分
- Produces: format・analyze・test の検証結果と、対象ファイルだけのコミット候補

- [x] **Step 1: 対象ファイルを整形する**

Run: `mise exec -- dart format app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

- [x] **Step 2: 対象テストを再実行する**

Run: `cd app && mise exec -- flutter test --no-pub test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart`

Expected: PASS。

- [x] **Step 3: 対象ファイルを静的解析する**

Run: `cd app && mise exec -- dart analyze lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`

Expected: `No issues found!`。

テストファイルを含めると、全テストの必須 `main()` に対する既知の
`avoid_top_level_functions` debt 1件が発生する。これは
`docs/todo/760_existing_eqmonitor_custom_lint_debt.md` の対象であり、
本修正では一括 ignore を追加しない。

- [x] **Step 4: 差分の健全性を確認する**

Run: `git diff --check && git --no-pager diff -- app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart docs/superpowers/specs/2026-08-16-map-observation-style-settings-design.md docs/superpowers/plans/2026-08-17-map-observation-style-settings.md`

Expected: whitespace error なし。対象外ファイルを含まない。

- [ ] **Step 5: 対象ファイルだけをコミット・push・PR化する**

Git メタデータへの書き込みが許可された環境で、次の4ファイルだけを stage する。

```text
app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart
app/test/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer_test.dart
docs/superpowers/specs/2026-08-16-map-observation-style-settings-design.md
docs/superpowers/plans/2026-08-17-map-observation-style-settings.md
```

Commit: `Fix: 観測点のサイズと枠設定を描画へ反映`
