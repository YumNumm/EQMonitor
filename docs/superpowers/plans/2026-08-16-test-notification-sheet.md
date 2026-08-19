# Test Notification Sheet Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** テスト通知UIをSheetへ統一し、サイレントを選択肢から除外して、重大な通知の送信前に警告確認を必須にする。

**Architecture:** 通知種別ボタン、送信Action、通知設定用Sheet/タイルを小さな単位へ分離する。送信Actionが確認ダイアログ、Repository呼び出し、結果SnackBarを一元化し、通知設定とデバッグ画面が同じ挙動を利用する。

**Tech Stack:** Flutter、Dart、Riverpod、flutter_hooks、sheet、flutter_test、build_runner

## Global Constraints

- Flutter/Dartコマンドは必ず `mise exec --` 経由で実行する。
- APIと内部モデルの `TestNotificationKind.silent` は互換性のため残し、UI選択肢からだけ除外する。
- `TestNotificationKind.critical` の表示名は「重大な通知」とする。
- 重大な通知は、端末のマナーモード設定に関わらず音が鳴ることを確認してから送信する。
- Widgetはイベント処理をActionへ委譲し、`ref` と `context` はActionメソッドの引数でのみ渡す。
- 既存の未コミット差分には触れない。

---

### Task 1: テスト通知の選択肢を共通化する

**Files:**
- Create: `app/lib/feature/notification/ui/component/test_notification_kind_buttons.dart`
- Create: `app/test/feature/notification/ui/component/test_notification_kind_buttons_test.dart`
- Modify: `app/lib/feature/notification/data/model/test_notification_delivery.dart:61-67`

**Interfaces:**
- Produces: `TestNotificationKindButtons({required TestNotificationKind? pendingKind, required Future<void> Function(TestNotificationKind) onPressed})`
- Produces: UI選択肢 `normal`、`critical` と表示名「通常」「重大な通知」

- [ ] **Step 1: 失敗するWidgetテストを書く**

  実Widgetをpumpし、「通常」「重大な通知」が各1件、「サイレント」「クリティカル」が0件であることを検証する。さらに「重大な通知」をtapし、コールバックで受けた値が `TestNotificationKind.critical` であることを検証する。削除対象のボタンを戻す、またはcriticalのラベルを戻す変更で失敗するテストにする。

- [ ] **Step 2: REDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/notification/ui/component/test_notification_kind_buttons_test.dart`

  Expected: `test_notification_kind_buttons.dart` が存在しないためFAIL。

- [ ] **Step 3: 最小実装を書く**

  `TestNotificationKindButtons` は `Wrap` と `FilledButton.tonal` を使い、固定の2種類だけを描画する。`pendingKind` が非nullの間は他方を無効化し、該当ボタンには既存と同じ18pxの進捗表示を出す。モデルの `critical` 表示名を「重大な通知」へ変更する。

- [ ] **Step 4: GREENを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/notification/ui/component/test_notification_kind_buttons_test.dart`

  Expected: PASS。

- [ ] **Step 5: コミットする**

  `git add app/lib/feature/notification/data/model/test_notification_delivery.dart app/lib/feature/notification/ui/component/test_notification_kind_buttons.dart app/test/feature/notification/ui/component/test_notification_kind_buttons_test.dart`

  `git commit -m "Feat: テスト通知の選択肢を通常と重大通知に統一"`

### Task 2: 重大な通知の確認と送信処理をActionへ集約する

**Files:**
- Create: `app/lib/feature/notification/data/action/test_notification_send_action.dart`
- Generate: `app/lib/feature/notification/data/action/test_notification_send_action.g.dart`
- Create: `app/test/feature/notification/data/action/test_notification_send_action_test.dart`

**Interfaces:**
- Produces: `testNotificationSendActionProvider`
- Produces: `Future<bool> TestNotificationSendAction.handle({required WidgetRef ref, required BuildContext context, required TestNotificationKind kind, VoidCallback? onConfirmed})`
- Returns: 送信を開始した場合は `true`、確認をキャンセルした場合は `false`

- [ ] **Step 1: 通常通知の失敗テストを書く**

  `deviceIdProvider` と `pushNotificationRepositoryProvider` を具体的なFakeでoverrideし、通常ボタンからActionを呼ぶ。ダイアログが出ず、Fake Repositoryが `normal` を1回受け、成功SnackBarが表示されることを検証する。送信分岐を削除すると失敗するテストにする。

- [ ] **Step 2: REDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/notification/data/action/test_notification_send_action_test.dart`

  Expected: Action/providerが未定義のためFAIL。

- [ ] **Step 3: 通常通知を送信できる最小Actionを書く**

  `@riverpod` providerはRefを保持しない `const TestNotificationSendAction()` を返す。`handle` は引数の `WidgetRef` から端末IDとRepositoryを読み、既存文言の成功・失敗SnackBarを表示して `true` を返す。取得または送信で例外がthrowされた場合も失敗SnackBarへ変換する。

- [ ] **Step 4: 通常通知のGREENを確認する**

  Task 2のテストコマンドを再実行し、通常通知ケースがPASSすることを確認する。

- [ ] **Step 5: 重大通知の確認テストを追加してREDを確認する**

  重大な通知で、確認前はRepositoryが未呼び出しであること、本文に「マナーモードの設定に関わらず音が鳴ります」が表示されること、キャンセル後も未送信で戻り値が `false` であることを検証する。別ケースで「送信する」をtapし、`onConfirmed` が1回実行され、Repositoryが `critical` を1回受け、戻り値が `true` になることを検証する。

  Run: Task 2のテストコマンド。

  Expected: 確認なしで送信されるためFAIL。

- [ ] **Step 6: 重大通知の確認を実装する**

  `critical` のときだけ `AlertDialog` を開く。タイトルは「重大な通知を送信しますか？」、本文は「重大な通知は、端末のマナーモードの設定に関わらず音が鳴ります。周囲の状況を確認してから送信してください。」、操作は「キャンセル」と「送信する」にする。確認後に `onConfirmed` を呼び、その後で通信を開始する。

- [ ] **Step 7: GREENとコード生成を確認する**

  Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

  Run: Task 2のテストコマンド。

  Expected: 生成成功、全ケースPASS。

- [ ] **Step 8: コミットする**

  `git add app/lib/feature/notification/data/action/test_notification_send_action.dart app/lib/feature/notification/data/action/test_notification_send_action.g.dart app/test/feature/notification/data/action/test_notification_send_action_test.dart`

  `git commit -m "Feat: 重大なテスト通知に送信確認を追加"`

### Task 3: 通知設定をAppSheetRouteへ移行しデバッグ画面も統一する

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart`
- Create: `app/lib/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart`
- Create: `app/test/feature/settings/features/notification_settings/test_notification_tile_test.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart:1-35,130,1069-1168`
- Modify: `app/lib/feature/devices/ui/page/debug_device_settings_page.dart:1-32,881-959`

**Interfaces:**
- Consumes: `TestNotificationKindButtons`、`testNotificationSendActionProvider`
- Produces: `TestNotificationSheet` と `TestNotificationTile`
- `TestNotificationSheet` accepts `Future<void> Function(TestNotificationKind kind, BuildContext sheetContext) onPressed`

- [ ] **Step 1: SheetRouteの失敗テストを書く**

  `TestNotificationTile` を `MaterialApp` と `ProviderScope` でpumpし、タイルtap後に `TestNotificationSheet` が表示され、NavigatorObserverが記録した最終Routeが `AppSheetRoute<void>` であることを検証する。`showModalBottomSheet` に戻すと失敗するテストにする。

- [ ] **Step 2: REDを確認する**

  Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/test_notification_tile_test.dart`

  Expected: SheetとTileが未定義のためFAIL。

- [ ] **Step 3: SheetとTileの最小実装を書く**

  `TestNotificationSheet` はScaffold、閉じるボタン付きAppBar、説明文、`TestNotificationKindButtons` を持つ。`TestNotificationTile` は `Navigator.push(AppSheetRoute<void>(initialExtent: 0.4, ...))` でSheetを開く。ボタン押下時はpending種別を設定してActionを呼び、`onConfirmed` でSheetだけをpopし、完了後にpendingを解除する。

- [ ] **Step 4: GREENを確認する**

  Task 3のテストコマンドを再実行する。

  Expected: PASS。

- [ ] **Step 5: 本番画面へ統合する**

  通知設定ページの `_TestNotificationTile` とローカル送信関数を削除し、公開 `TestNotificationTile` をimportして配置する。デバッグ画面のサイレントを含む手書きボタンとローカル送信関数を削除し、`TestNotificationKindButtons` とActionへ置き換える。デバッグ画面では `onConfirmed` を渡さず、その場で送信する。

- [ ] **Step 6: 対象テストと静的解析を実行する**

  Run: `cd app && mise exec -- flutter test test/feature/notification/ui/component/test_notification_kind_buttons_test.dart test/feature/notification/data/action/test_notification_send_action_test.dart test/feature/settings/features/notification_settings/test_notification_tile_test.dart test/feature/notification/data/repository/push_notification_repository_test.dart`

  Run: `cd app && mise exec -- dart analyze lib/feature/notification lib/feature/settings/features/notification_settings lib/feature/devices/ui/page/debug_device_settings_page.dart`

  Expected: 全テストPASS、解析エラー0件。

- [ ] **Step 7: コミットする**

  `git add app/lib/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart app/lib/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart app/test/feature/settings/features/notification_settings/test_notification_tile_test.dart app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/lib/feature/devices/ui/page/debug_device_settings_page.dart`

  `git commit -m "Refactor: テスト通知ModalをSheetへ統一"`

### Task 4: 最終回帰検証と引き渡し

**Files:**
- Verify only: 上記で変更した全ファイル

- [ ] **Step 1: フォーマット差分を確認する**

  Run: `cd app && mise exec -- dart format --output=none --set-exit-if-changed lib/feature/notification lib/feature/settings/features/notification_settings/ui/component lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart lib/feature/devices/ui/page/debug_device_settings_page.dart test/feature/notification test/feature/settings/features/notification_settings`

- [ ] **Step 2: 回帰テストと差分検査を実行する**

  Task 3 Step 6のテストを再実行し、`git --no-pager diff --check HEAD^..HEAD` と `git --no-pager status --short` で意図したファイルだけが変わっていることを確認する。

- [ ] **Step 3: プッシュ可能なブランチ状態ならプッシュする**

  detached HEADの場合は新規ブランチを暗黙に作らず、Codex Appの「Create branch」で `codex/test-notification-sheet` を作成後、作成済みコミットをpushする。
