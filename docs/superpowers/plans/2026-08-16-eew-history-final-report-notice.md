# EEW History Final Report Notice Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 緊急地震速報履歴一覧の初回案内を永続化し、各行に報数・最終報状態とマグニチュードを適切に配置する。

**Architecture:** SharedPreferences の専用キーと Riverpod notifier で初回確認状態を管理し、UI 操作を flow に分離する。一覧行は既存 `EewTelegramItem` の `serialNo`、`isLastInfo`、震源情報だけを使って描画する。

**Tech Stack:** Flutter / Dart / Riverpod 3 Mutation / flutter_hooks / SharedPreferences

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- SharedPreferences は `SharedPreferencesDataSource` と `SharedPreferencesKey` を通して利用する。
- 固定値による欠損データの補完は行わない。
- Widget Test と厳密な TDD はユーザー指定により今回必須としない。
- 既存の未コミット変更はステージングしない。

---

### Task 1: 初回案内状態とダイアログ

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Create: `app/lib/feature/eew_history/data/notifier/eew_history_notice_notifier.dart`
- Create: `app/lib/feature/eew_history/data/flow/show_eew_history_notice_flow.dart`
- Create: `app/lib/feature/eew_history/ui/components/eew_history_notice_dialog.dart`
- Modify: `app/lib/feature/eew_history/ui/eew_history_page.dart`
- Test: `app/test/feature/eew_history/eew_history_notice_notifier_test.dart`

**Interfaces:** `eewHistoryNoticeShownProvider` (`AsyncValue<bool>`)、`EewHistoryNoticeShown.markShown()`、`showEewHistoryNoticeFlow({required WidgetRef ref, required BuildContext context})` を提供する。

- [ ] **Step 1: Preferences キーと notifier を追加する**

`SharedPreferencesKey.eewHistoryNoticeShown` を追加する。notifier の `build()` は未保存時を `false` とし、`markShown()` は保存成功後に state を更新する。

```dart
@riverpod
class EewHistoryNoticeShown extends _$EewHistoryNoticeShown {
  static final markShownMutation = Mutation<void>();

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: .eewHistoryNoticeShown) ?? false;
  }
}
```

- [ ] **Step 2: 確認結果を返すダイアログと flow を追加する**

`showDialog<bool>` は OK ボタンだけが `true` を返す。flow は `true` の時だけ Mutation 経由で `markShown()` を呼ぶ。

```dart
final acknowledged = await showDialog<bool>(
  context: context,
  barrierDismissible: false,
  builder: (context) => const EewHistoryNoticeDialog(),
);
if (acknowledged != true || !context.mounted) {
  return;
}
```

- [ ] **Step 3: 履歴ページから未確認時だけ flow を実行する**

`AsyncData(false)` の時だけ `addPostFrameCallback` から flow を呼ぶ。Loading/Error 中は表示しない。

- [ ] **Step 4: Riverpod コードを生成する**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Expected: `eew_history_notice_notifier.g.dart` が生成される。

- [ ] **Step 5: 確認済みフラグの初期値と永続化を単体テストする**

未保存時が `false` であることと、`markShown()` が state と SharedPreferences を `true` にすることを確認する。

### Task 2: 一覧行の情報配置

**Files:**
- Modify: `app/lib/feature/eew_history/ui/components/eew_history_list_tile.dart`
- Modify: `app/lib/feature/eew_history/ui/eew_history_page.dart`

**Interfaces:** `EewTelegramItem.serialNo`、`isLastInfo`、`hypocenter?.magnitude` を消費する。

- [ ] **Step 1: subtitle を値のリストから組み立てる**

```dart
final subtitleParts = [
  '${dateFormatter.format(time.toLocal())}発生',
  if (depth != null) '深さ ${depth}km',
  if (magnitude != null) 'M${magnitude.toStringAsFixed(1)}',
];
```

- [ ] **Step 2: trailing を報数と最終報状態へ変更する**

```dart
final reportLabel = '#${item.serialNo}${item.isLastInfo ? ' (最終)' : ''}';
```

- [ ] **Step 3: スケルトンの情報配置を合わせる**

subtitle に `M6.0`、trailing に `#29 (最終)` を表示する。

### Task 3: テスト方針ルールと検証

**Files:**
- Modify: `AGENTS.md`
- Modify: `.cursor/rules/flutter-rules.mdc`
- Create: `docs/knowledge/20260816_test_strategy.md`

- [ ] **Step 1: 比例的なテスト方針を追記する**

Widget Test と TDD を一律必須にせず、変更リスクに応じて選択する。生命に関わる判定、データ変換、通知条件、永続化などの高リスクロジックには自動テストを求める。

- [ ] **Step 2: フォーマットとコード生成差分を確認する**

Run: `cd app && mise exec -- dart format lib/core/data/preferences/shared/shared_preferences_key.dart lib/feature/eew_history`

- [ ] **Step 3: EEW 履歴テストを実行する**

Run: `cd app && mise exec -- flutter test test/feature/eew_history`

Expected: exit code 0。

- [ ] **Step 4: 変更対象を静的解析する**

Run: `cd app && mise exec -- flutter analyze lib/core/data/preferences/shared/shared_preferences_key.dart lib/feature/eew_history`

Expected: 変更起因の error が 0 件。

- [ ] **Step 5: 対象ファイルだけをコミット・push し、ドラフト PR を作成する**

未コミットの既存 `analysis_options.yaml`、`mise.lock` などを除外し、明示した対象ファイルだけを stage する。
