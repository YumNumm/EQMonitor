# Earthquake History List Display Settings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴一覧の背景塗りつぶし設定を反映し、日付区切りを発生時刻ソート時だけ表示するか常に非表示にするかを設定可能にする。

**Architecture:** 一覧設定モデルへ後方互換なbooleanを追加し、表示条件は小さなpresentation modelへ集約する。地震履歴ページは設定Providerを購読してpresentation modelの値をListTileとgroup headerへ渡し、設定画面は既存Notifier経由で保存する。

**Tech Stack:** Flutter 3.44、Dart 3.11、Riverpod 3、Freezed、paging_view、flutter_test

## Global Constraints

- Flutter / Dartコマンドは必ず `mise exec --` 経由で実行する。
- `dynamic`、`Object`、null assertion (`!`) を新規コードで使わない。
- 既存の地震履歴設定JSONに新キーがなくても既定値 `true` で復元する。
- 日付区切りは `EarthquakeSortBy.eventId` の昇順・降順でだけ表示対象とする。
- 「常に表示」モードは実装しない。
- ユーザーの未コミット差分には触れない。

---

### Task 1: 設定モデルの後方互換な拡張

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`
- Modify: `app/test/feature/earthquake_history/data/earthquake_history_config_test.dart`
- Modify: `app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`
- Generate: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.freezed.dart`
- Generate: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.g.dart`

**Interfaces:**
- Produces: `EarthquakeHistoryListConfig.showDateSeparator: bool`（既定値 `true`）

- [ ] **Step 1: 失敗するモデルテストを書く**

```dart
expect(config.list.showDateSeparator, isTrue);

final restored = EarthquakeHistoryConfig.fromJson({
  'list': <String, dynamic>{'show_date_separator': false},
});
expect(restored.list.showDateSeparator, isFalse);
```

- [ ] **Step 2: REDを確認する**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_history_config_test.dart test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`

Expected: `showDateSeparator` が未定義でコンパイル失敗。

- [ ] **Step 3: 最小実装を追加して生成コードを更新する**

```dart
/// 発生時刻ソート時に日付区切りを表示するか
@Default(true) bool showDateSeparator,
```

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 4: GREENを確認する**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_history_config_test.dart test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`

Expected: PASS。

- [ ] **Step 5: コミットする**

```bash
git add app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.freezed.dart app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.g.dart app/test/feature/earthquake_history/data/earthquake_history_config_test.dart app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart
git commit -m "Feat: 地震履歴の日付区切り設定を追加"
```

### Task 2: 一覧表示への設定反映

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/model/earthquake_history_list_display.dart`
- Create: `app/test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`

**Interfaces:**
- Consumes: `EarthquakeHistoryListConfig.showDateSeparator`, `EarthquakeHistoryListConfig.isFillBackground`, `EarthquakeSortBy`
- Produces: `EarthquakeHistoryListDisplay.resolve({required EarthquakeHistoryListConfig config, required EarthquakeSortBy sortBy})`
- Produces: `showBackgroundColor: bool`, `showDateSeparator: bool`

- [ ] **Step 1: 失敗する表示ポリシーテストを書く**

```dart
final display = EarthquakeHistoryListDisplay.resolve(
  config: const EarthquakeHistoryListConfig(
    isFillBackground: false,
    showDateSeparator: true,
  ),
  sortBy: EarthquakeSortBy.eventId,
);
expect(display.showBackgroundColor, isFalse);
expect(display.showDateSeparator, isTrue);
```

`showDateSeparator: false` と `EarthquakeSortBy.magnitude` のケースでは `display.showDateSeparator` がfalseになることも別テストで確認する。

- [ ] **Step 2: REDを確認する**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart`

Expected: `EarthquakeHistoryListDisplay` が未定義でコンパイル失敗。

- [ ] **Step 3: presentation modelを最小実装する**

```dart
class EarthquakeHistoryListDisplay {
  const EarthquakeHistoryListDisplay({
    required this.showBackgroundColor,
    required this.showDateSeparator,
  });

  factory EarthquakeHistoryListDisplay.resolve({
    required EarthquakeHistoryListConfig config,
    required EarthquakeSortBy sortBy,
  }) => EarthquakeHistoryListDisplay(
    showBackgroundColor: config.isFillBackground,
    showDateSeparator:
        config.showDateSeparator && sortBy == EarthquakeSortBy.eventId,
  );

  final bool showBackgroundColor;
  final bool showDateSeparator;
}
```

- [ ] **Step 4: 地震履歴ページへ配線する**

`_SliverListBody` で `earthquakeHistoryConfigProvider` の `.list` を購読し、`_PagingBody` へ渡す。`_PagingBody.build` でpresentation modelを解決し、次を設定する。

```dart
stickyHeader: display.showDateSeparator,
headerBuilder: (_, date, _) => display.showDateSeparator
    ? _DateHeader(date: date)
    : const SizedBox.shrink(),
```

```dart
EarthquakeHistoryListTile(
  item: item,
  searchParameter: parameter.value,
  showBackgroundColor: display.showBackgroundColor,
)
```

- [ ] **Step 5: GREENと静的解析を確認する**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart`

Run: `mise exec -- dart analyze lib/feature/earthquake_history/ui/earthquake_history_page.dart lib/feature/earthquake_history/ui/model/earthquake_history_list_display.dart test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart`

Expected: PASS、対象ファイルにdiagnosticなし。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/earthquake_history/ui/earthquake_history_page.dart app/lib/feature/earthquake_history/ui/model/earthquake_history_list_display.dart app/test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart
git commit -m "Fix: 地震履歴一覧へ表示設定を反映"
```

### Task 3: 設定画面のスイッチ

**Files:**
- Modify: `app/lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart`
- Create: `app/test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

**Interfaces:**
- Consumes: `EarthquakeHistoryListConfig.showDateSeparator`
- Uses: `EarthquakeHistoryConfigNotifier.save(EarthquakeHistoryConfig value)`

- [ ] **Step 1: 失敗するWidgetテストを書く**

設定ProviderをテストNotifierで上書きし、ページ上の「発生時刻ソート時の日付区切り」をタップすると保存値の `showDateSeparator` が `true` から `false` になることを確認する。

```dart
expect(find.text('発生時刻ソート時の日付区切り'), findsOneWidget);
await tester.tap(find.text('発生時刻ソート時の日付区切り'));
await tester.pump();
expect(notifier.savedValue?.list.showDateSeparator, isFalse);
```

- [ ] **Step 2: REDを確認する**

Run: `mise exec -- flutter test test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

Expected: 対象の設定タイルが見つからずFAIL。

- [ ] **Step 3: 既存スイッチと同じ保存経路で実装する**

```dart
ListTile(
  title: const Text('発生時刻ソート時の日付区切り'),
  trailing: AppSwitch(value: state.showDateSeparator, onChanged: saveValue),
  onTap: () async => saveValue(!state.showDateSeparator),
)
```

`saveValue` はWidgetメソッドにせず、各コールバック内で既存と同じ `full.copyWith.list(showDateSeparator: value)` を保存する。

- [ ] **Step 4: GREENと対象解析を確認する**

Run: `mise exec -- flutter test test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

Run: `mise exec -- dart analyze lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

Expected: PASS、対象ファイルにdiagnosticなし。

- [ ] **Step 5: コミットする**

```bash
git add app/lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart app/test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart
git commit -m "Feat: 地震履歴の日付区切り設定UIを追加"
```

### Task 4: 回帰検証とPR作成

**Files:**
- Verify only: all files changed by Tasks 1-3

- [ ] **Step 1: フォーマットする**

Run: `mise exec -- dart format app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart app/lib/feature/earthquake_history/ui/model/earthquake_history_list_display.dart app/lib/feature/earthquake_history/ui/earthquake_history_page.dart app/lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart app/test/feature/earthquake_history/data/earthquake_history_config_test.dart app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart app/test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart app/test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

- [ ] **Step 2: 関連テストをまとめて実行する**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_history_config_test.dart test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

Expected: PASS。

- [ ] **Step 3: 対象範囲を解析する**

Run: `mise exec -- dart analyze app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart app/lib/feature/earthquake_history/ui/model/earthquake_history_list_display.dart app/lib/feature/earthquake_history/ui/earthquake_history_page.dart app/lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart app/test/feature/earthquake_history/data/earthquake_history_config_test.dart app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart app/test/feature/earthquake_history/ui/model/earthquake_history_list_display_test.dart app/test/feature/settings/children/config/earthquake_history/earthquake_history_config_page_test.dart`

Expected: diagnosticsなし。

- [ ] **Step 4: 差分を監査する**

Run: `git --no-pager diff origin/develop...HEAD --check`

Run: `git --no-pager diff origin/develop...HEAD --stat`

ユーザー既存差分がコミットへ混入していないことを `git --no-pager status --short` でも確認する。

- [ ] **Step 5: pushしてdraft PRを作成する**

ブランチ `codex/fix-earthquake-history-display-settings` をpushし、base `develop` のdraft PRを作成する。本文には原因、修正内容、テスト結果を記載する。
