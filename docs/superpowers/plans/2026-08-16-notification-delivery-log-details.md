# Notification Delivery Log Details Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 通知配信ログの詳細 Sheet に一般ユーザー向け情報を表示し、空状態から端末 ID を除去する。

**Architecture:** `PushNotificationLogEntry` から表示行とコピー文字列を作る Builder を Data/Logic 層へ追加し、Riverpod で UI に注入する。既存ページは生成済み表示モデルをスクロール可能な Sheet に描画する。

**Tech Stack:** Flutter, Dart 3.11, Riverpod code generation, intl, flutter_test

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- 表示項目は配信日時、配信結果、タイトル、本文、失敗時のエラー内容に限定する。
- 内部識別子と配信基盤固有値は表示・コピーしない。
- ユーザー承認により TDD と Widget Test は行わない。
- 既存の未コミット変更を編集・ステージしない。

---

### Task 1: 詳細表示モデルと Builder

**Files:**
- Create: `app/lib/feature/notification/data/logic/notification_delivery_log_detail_builder.dart`
- Generate: `app/lib/feature/notification/data/logic/notification_delivery_log_detail_builder.g.dart`
- Test: `app/test/feature/notification/data/logic/notification_delivery_log_detail_builder_test.dart`

**Interfaces:**
- Consumes: `PushNotificationLogEntry`
- Produces: `NotificationDeliveryLogDetailBuilder.build({required PushNotificationLogEntry entry})`
- Produces: `NotificationDeliveryLogDetail.rows` と `copyText`

- [ ] `NotificationDeliveryLogDetailRow`、`NotificationDeliveryLogDetail`、Builder を実装する。
- [ ] ISO 8601 日時を端末ローカルの `yyyy/MM/dd HH:mm:ss` に変換し、解析失敗時は元文字列を維持する。
- [ ] 成功・失敗ラベルと、空白でないタイトル・本文・失敗時エラーだけを表示行へ追加する。
- [ ] 表示行を `ラベル: 値` の改行区切りでコピー文字列へ変換する。
- [ ] `mise exec -- dart run build_runner build --delete-conflicting-outputs` で Provider を生成する。
- [ ] 成功、失敗、空白値、日時解析失敗、内部情報非混入の単体テストを追加する。
- [ ] 次のコマンドが成功することを確認する。

```bash
mise exec -- flutter test test/feature/notification/data/logic/notification_delivery_log_detail_builder_test.dart
```

### Task 2: 詳細 Sheet と空状態

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/notification/debug_notification_delivery_log_page.dart`

**Interfaces:**
- Consumes: `notificationDeliveryLogDetailBuilderProvider`
- Consumes: `NotificationDeliveryLogDetail.rows` と `copyText`
- Produces: 一般ユーザー向け詳細 Sheet と端末 ID を含まない空状態

- [ ] ログタップ時に Builder で詳細表示モデルを生成し、Sheet へ渡す。
- [ ] `DraggableScrollableSheet` 内の `ListView.builder` で表示行を描画する。
- [ ] コピーボタンで `copyText` をコピーし、完了 SnackBar を表示する。
- [ ] 空状態の「対象端末 ID」ListTileを削除し、案内文とプルダウン更新を維持する。
- [ ] 次のコマンドで対象ファイルを整形・解析する。

```bash
mise exec -- dart format \
  lib/feature/notification/data/logic/notification_delivery_log_detail_builder.dart \
  lib/feature/settings/children/config/debug/notification/debug_notification_delivery_log_page.dart \
  test/feature/notification/data/logic/notification_delivery_log_detail_builder_test.dart
mise exec -- flutter analyze \
  lib/feature/notification/data/logic/notification_delivery_log_detail_builder.dart \
  lib/feature/settings/children/config/debug/notification/debug_notification_delivery_log_page.dart \
  test/feature/notification/data/logic/notification_delivery_log_detail_builder_test.dart
```

### Task 3: 最終検証と公開

- [ ] `mise exec -- flutter test test/feature/notification` が成功することを確認する。
- [ ] `git --no-pager diff --check` と差分一覧で対象外変更の混入がないことを確認する。
- [ ] 設計、Builder、単体テスト、UIを責務単位でコミットする。
- [ ] `codex/fix-notification-log-details` を push し、検証結果を記載した Draft PR を作成する。
