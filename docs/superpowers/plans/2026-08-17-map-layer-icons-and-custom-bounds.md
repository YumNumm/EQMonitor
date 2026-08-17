# Map Layer Icons and Custom Bounds Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** セクション装飾アイコンを削除し、MapLibreの表示範囲がホーム設定へ永続化・復元されることを自動テストで保証する。
**Architecture:** `_SettingsSection` はテキストと開閉操作だけを描画する。範囲取得・notifier更新・保存後の画面終了は公開flowへ集約し、テスト用controllerと実SharedPreferencesで境界全体を検証する。
**Tech Stack:** Flutter、Dart、Riverpod 3 Mutation、MapLibre、SharedPreferences、flutter_test、mockito

## Global Constraints

- Flutter / Dartコマンドは必ず `mise exec --` 経由で実行する。
- 戻る、開閉矢印、情報、保存の操作用アイコンは残す。
- 新しい固定値フォールバックを追加しない。
- 既存の解析設定と`mise.lock`の未コミット差分をステージしない。

---

### Task 1: セクション装飾アイコンの削除
**Files:**
- Modify: `app/lib/feature/home/ui/page/home_map_layer_page.dart`
- Create: `app/test/feature/home/ui/home_map_layer_page_test.dart`

**Interfaces:**
- Consumes: `HomeMapLayerPage`、`DesignSystemThemeExtension.light()`
- Produces: `HomeMapLayerPage`の5セクション見出し（装飾アイコンなし、開閉矢印あり）

- [ ] **Step 1: 失敗するWidgetテストを書く**

```dart
testWidgets('セクションの装飾アイコンだけを表示しない', (tester) async {
  await tester.pumpWidget(const ProviderScope(child: _TestApp()));
  expect(find.byIcon(Icons.emergency_rounded), findsNothing);
  expect(find.byIcon(Icons.vibration_rounded), findsNothing);
  expect(find.byIcon(Icons.my_location_rounded), findsNothing);
  expect(find.byIcon(Icons.sensors_rounded), findsNothing);
  expect(find.byIcon(Icons.map_rounded), findsNothing);
  expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(5));
  expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
});
```

- [ ] **Step 2: REDを確認する**

Run: `mise exec -- flutter test app/test/feature/home/ui/home_map_layer_page_test.dart`
Expected: 5つの装飾アイコンが見つかりFAIL。

- [ ] **Step 3: 最小実装を行う**

各 `_SettingsSection` 呼び出しの `icon:`、コンストラクタの `icon`、`IconData`フィールド、40pxアイコンコンテナと後続余白を削除する。

- [ ] **Step 4: GREENを確認してコミットする**

Run: `mise exec -- flutter test app/test/feature/home/ui/home_map_layer_page_test.dart`
Commit: `Style: マップレイヤーの装飾アイコンを削除`

### Task 2: カスタム範囲取得・永続化flow
**Files:**
- Create: `app/lib/feature/home/data/flow/save_home_map_bounds_flow.dart`
- Modify: `app/lib/feature/home/ui/page/home_map_bounds_selector_page.dart`
- Create: `app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart`

**Interfaces:**
- Consumes: `BuildContext context`、`WidgetRef ref`、`MapController controller`
- Produces: `Future<void> saveHomeMapBoundsFlow({required BuildContext context, required WidgetRef ref, required MapController controller})`

- [ ] **Step 1: 失敗するflowテストを書く**

```dart
const visible = LngLatBounds(
  longitudeWest: 129.25,
  longitudeEast: 145.75,
  latitudeSouth: 30.5,
  latitudeNorth: 44.25,
);
// Consumer内のボタンからflowを実行し、provider、保存JSON、新containerで
// custom・southWest(30.5, 129.25)・northEast(44.25, 145.75)とpopを検証する。
```

- [ ] **Step 2: REDを確認する**

Run: `mise exec -- flutter test app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart`
Expected: `save_home_map_bounds_flow.dart`または関数が存在せずFAIL。

- [ ] **Step 3: 最小実装を行う**

flowで`getVisibleRegion()`→`LatLngBoundary.fromTwo()`→`saveMutation.run()`→mounted時`Navigator.pop()`を順番に実行し、selector pageの保存コールバックはflowへ委譲する。

- [ ] **Step 4: GREENと全体整合性を確認する**

Run: `mise exec -- flutter test app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart app/test/feature/home/ui/home_map_layer_page_test.dart`
Run: `mise exec -- dart format --output=none --set-exit-if-changed app/lib/feature/home/data/flow/save_home_map_bounds_flow.dart app/lib/feature/home/ui/page/home_map_bounds_selector_page.dart app/lib/feature/home/ui/page/home_map_layer_page.dart app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart app/test/feature/home/ui/home_map_layer_page_test.dart`
Run: `mise exec -- flutter analyze app/lib/feature/home/data/flow/save_home_map_bounds_flow.dart app/lib/feature/home/ui/page/home_map_bounds_selector_page.dart app/lib/feature/home/ui/page/home_map_layer_page.dart app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart app/test/feature/home/ui/home_map_layer_page_test.dart`
Commit: `Test: カスタム表示範囲の保存を検証`

### Task 3: 公開
- [ ] `git --no-pager diff --check`と対象テストを再実行する。
- [ ] 意図したファイルだけがコミット済みであることを確認する。
- [ ] `git push -u origin codex/map-layer-icons-custom-bounds`を実行する。
- [ ] GitHub appでdevelop向けDraft PRを作成し、変更内容・理由・検証結果を記載する。
