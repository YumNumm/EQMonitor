# デバッグ画面: トークン再送信・デバイス削除・再プロビジョニング 設計

作成日: 2026-07-20

## 概要

デバッグの「デバイス・通知」画面（`DebugDeviceSettingsPage`）に、プッシュトークンの送信状態と種類別の強制再送信、およびデバイス削除・再プロビジョニング操作を追加する。

## 決定事項

| 項目 | 内容 |
|------|------|
| 配置 | 既存の `DebugDeviceSettingsPage`（`/settings/debug/device-settings`）のみ |
| トークン再送信 | FCM / APNs（通知） / Push to Start ごとにボタン。同期済みでも強制 upsert |
| 再プロビジョニング | サーバー削除 → ローカルクリア → 再登録 |
| 削除単体 | サーバー削除後、ローカル（Bearer / `device_provisioned`）もクリア |
| デバイス管理画面 | 変更しない（既存導線は残す） |
| 本番バナー | 変更しない |
| 実装方針 | Notifier / Worker に正規 API を追加し、UI は表示と確認ダイアログに専念 |

## 現状

- `_TokenSection` で FCM / APNs / Push to Start の同期ステータスは表示済みだが、再送信ボタンはない
- `PushTokenSyncWorker.accept` は同一トークンをスキップし、`_lastSyncedToken` 一致時は upsert しない
- `retryFailed()` は `Failed`（`_blockedToken` あり）のときだけ再開する
- 未登録時のプロビジョニングボタンはあるが、登録済みからの強制再プロビジョンはない
- `DeviceRepository.deleteDevice` はサーバー削除 + Bearer クリアまで。`device_provisioned` はクリアしない
- 削除 UI は `debug_device_admin` にあり、ローカルフラグは残る

## 機能① プッシュトークン強制再送信

### Worker

`PushTokenSyncWorker` に `forceResync()` を追加する。

- `_lastSyncedToken` / `_blockedToken` をクリア
- `_attempt = 0`
- `_latestToken` があれば、同一トークンでも再 upsert するよう再投入する
- `_latestToken` が無い場合は no-op

### Notifier

`PushTokenSyncNotifier` に以下を追加する。

- `forceResync({required PushTokenKind kind})`
- `forceResyncMutation`（Riverpod 3 Mutation）
- Worker にトークンが無い場合は、`notificationTokenStream` の最新値を `accept` してから `forceResync` する（取得できない場合は UI で「未取得」を通知）

### UI

`_TokenSection` を拡張する。

- 各トークン行に「再送信」ボタン
- `NotApplicable` はボタン非表示
- `Syncing` 中は disabled
- 結果は SnackBar（成功 / 失敗 / 未取得）

## 機能② デバイス削除

### Notifier

`DeviceProvisioningNotifier` に `deleteDeviceAndClearLocal` を追加する。

1. `DeviceRepository.deleteDevice`（既存: サーバー削除 + Bearer クリア）
2. `DeviceProvisioningRepository.clearProvisioned()`
3. 関連 Provider を invalidate（`deviceProvisioning` / `pushTokenSync` / デバッグ用 device info 等）

結果として画面状態は「未登録」になる。

### UI / Flow

- 「デバイス操作」セクションに削除ボタン（危険色）
- 確認ダイアログ: 「サーバー上のデバイスとローカル認証情報を削除します」
- 実行中は操作ボタンを disabled + 進捗表示
- 成否は SnackBar

## 機能③ 再プロビジョニング

### Notifier

`DeviceProvisioningNotifier` に `reprovision` を追加する。

1. 機能②と同じ削除・ローカルクリア
2. 既存の `provision()` を実行（再登録 → `markProvisioned` → push token sync 再開）

途中失敗時は SnackBar で理由を出す。ローカルは可能な範囲でクリア済みのままにし、再実行可能にする。

### UI / Flow

- 「デバイス操作」セクションに「再プロビジョニング」ボタン
- 確認ダイアログ: 「削除してから再登録します。通知トークンも再同期されます」
- 実行中は削除ボタンも含めて disabled

## UI 配置順

1. 起動時プロビジョニング（既存）
2. **デバイス操作（新設）** — 削除 / 再プロビジョニング
3. デバイス（サーバー情報）（既存・操作後に再取得）
4. 通知許可状態（既存）
5. **プッシュトークン同期（拡張）** — 状態 + 種類別再送信
6. 以降は現状どおり

## エラー表示

- API / プロビジョン失敗: SnackBar。`userMessage` があれば優先
- トークン未取得時の再送信: 「トークン未取得のため再送信できません」
- 確認ダイアログキャンセル時は何もしない

## テスト

- `PushTokenSyncWorker.forceResync`: 同期済み同一トークンでも upsert が再実行されること
- Failed 状態からの `forceResync` でブロック解除されること
- 削除後に `device_provisioned == false` かつ Bearer 不在になること（Notifier 単体、可能な範囲）

## スコープ外

- `debug_device_admin` の改修・統合
- 本番 `DeviceProvisioningBanner` の挙動変更
- トークン値や同期ステータスの SharedPreferences 永続化
- 新ルートの追加（既存 `DebugDeviceSettingsRoute` を利用）

## 主な変更ファイル

| ファイル | 内容 |
|----------|------|
| `push_token_sync_worker.dart` | `forceResync()` |
| `push_token_sync_notifier.dart` | 種類別 `forceResync` + Mutation |
| `device_provisioning_notifier.dart` | `deleteDeviceAndClearLocal` / `reprovision` + Mutation |
| `debug_device_settings_page.dart` | デバイス操作セクション・トークン再送信 UI |
| `data/flow/debug_device_lifecycle_flow.dart` | 確認ダイアログ → Mutation → SnackBar |
| `push_token_sync_worker_test.dart` | `forceResync` の単体テスト追加 |
