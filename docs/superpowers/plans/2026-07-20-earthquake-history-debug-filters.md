# Earthquake History Debug Filters Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴一覧のステータスと電文種別フィルターを、デバッグ画面のデバッグモードが有効な場合だけ表示する。

**Architecture:** 既に `ConsumerWidget` である地震履歴フィルターバーが `debugProvider` を直接監視し、対象チップをリストへ追加する条件だけを制御する。APIパラメータ、フィルター値、地域絞り込み時の既存条件は変更しない。

**Tech Stack:** Flutter, Dart, Riverpod 3, flutter_test, SharedPreferences mock

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- デバッグモードの判定には `debugProvider` を使用し、`kDebugMode` を直接参照しない。
- `debugProvider` が読み込み中またはエラーの場合は対象フィルターを非表示にする。
- 電文種別フィルターの「地域未指定時のみ」という既存条件を維持する。
- APIパラメータと既存のフィルター値は変更しない。

---

### Task 1: デバッグモードによるフィルター表示制御

**Files:**
- Create: `app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart`

**Interfaces:**
- Consumes: `debugProvider` の `AsyncValue<bool>` と `EarthquakeHistoryParameterPersistentDelegate`
- Produces: デバッグモード有効時だけ `StatusFilterChip` と `TelegramTypeFilterChip` を含むフィルターバー

- [ ] **Step 1: デバッグモードOFF/ONのWidgetテストを書く**

`SharedPreferencesKey.debug` を `false` または `true` で初期化し、`sharedPreferencesProvider` をモックで上書きする。`CustomScrollView` に `EarthquakeHistoryParameterPersistentDelegate` を組み込み、次を検証する。

```dart
testWidgets('デバッグモードが無効な場合はデバッグ用フィルターを表示しない', (tester) async {
  await pumpDelegate(tester, isDebugEnabled: false);

  expect(find.byType(StatusFilterChip), findsNothing);
  expect(find.byType(TelegramTypeFilterChip), findsNothing);
});

testWidgets('デバッグモードが有効な場合はデバッグ用フィルターを表示する', (tester) async {
  await pumpDelegate(tester, isDebugEnabled: true);

  expect(find.byType(StatusFilterChip), findsOneWidget);
  expect(find.byType(TelegramTypeFilterChip), findsOneWidget);
});
```

- [ ] **Step 2: テストが意図した理由で失敗することを確認する**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart
```

Expected: OFFのテストが、両フィルターを各1件検出して失敗する。ONのテストは成功する。

- [ ] **Step 3: 最小限の表示条件を実装する**

`_FilterChipBar.build` でフラグを取得する。

```dart
final isDebugEnabled = ref.watch(debugProvider).value ?? false;
```

ステータスのエントリーを `if (isDebugEnabled)` で囲む。地域未指定時のリストでは、電文種別のエントリーだけを同じ条件で囲み、DatasourceとLatLngは従来どおり表示する。

- [ ] **Step 4: 対象テストと静的解析を実行する**

Run:

```bash
mise exec -- dart format app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart app/test/core/component/chip/status_filter_chip_test.dart app/test/core/component/chip/telegram_type_filter_chip_test.dart
mise exec -- flutter analyze app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart
git --no-pager diff --check
```

Expected: formatで差分が正規化され、全テストと解析が成功し、`git diff --check` が出力なしで終了する。

- [ ] **Step 5: 対象ファイルだけをコミットする**

```bash
git add app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart app/test/feature/earthquake_history/ui/earthquake_history_parameter_persistent_delegate_test.dart docs/superpowers/plans/2026-07-20-earthquake-history-debug-filters.md
git commit -m "fix: 地震履歴のデバッグ用フィルターを限定表示"
```
