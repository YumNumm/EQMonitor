# 通知プリセット4択 + OS権限制御 設計

## 概要

オンボーディングの通知設定ステップおよび設定画面の通知プリセットを、現行の2択（推奨設定 / カスタム）から4択に拡張する。OS 通知権限・重大な通知権限の状態に応じて選択可否と警告表示を制御する。

## 背景

- 現状: `NotificationPreset` は `recommended` / `custom` のみ
- オンボーディング・設定画面で同じ2択 UI を個別実装している
- ユーザーが「すべて受け取る」「通知しない」を初回から選べない
- OS 通知権限がオフでも他プリセットを選べてしまい、保存後に通知が届かない

## プリセット定義

| プリセット | enum 値 | API 操作 |
|---|---|---|
| 推奨設定 | `recommended` | 現在地スロット作成（EEW警報 ON、予報 震度4+、地震 震度1+） |
| すべて | `all` | 推奨設定 + 全国スロット（EEW・地震 震度3+、`defaultNotificationSlotMinIntensity`） |
| カスタム | `custom` | 現在地スロット作成 → カスタム設定画面へ遷移 |
| 通知しない | `none` | `notificationEnabled: false`、スロットは作成しない（既存スロットは削除しない） |

### カード説明テキスト

- **推奨設定**: 現状と同じ箇条書き
  - 現在地の緊急地震速報(警報)
  - 現在地で予想震度4以上の緊急地震速報(予報)
  - 現在地で震度1以上を観測した地震情報
- **すべて**: 「推奨設定に加え、全国の緊急地震速報・地震情報も通知します」
- **カスタム**: 現状と同じ
- **通知しない**: 「通知を受け取りません。後から設定で変更できます」

### 表示順

推奨設定 → すべて → カスタム → 通知しない

## OS 権限制御

### 判定

`FirebaseMessaging.getNotificationSettings()` の `authorizationStatus` を Riverpod Provider で watch する。

```dart
bool get isOsNotificationGranted =>
  status == AuthorizationStatus.authorized ||
  status == AuthorizationStatus.provisional;
```

### 選択可否

| OS 権限 | 選択可能 |
|---|---|
| `authorized` / `provisional` | 4つすべて |
| `denied` / `notDetermined` | **通知しない** のみ |

### 無効プリセットのタップ

ダイアログを表示:

- タイトル: 「通知権限が無効です」
- 本文: 「通知を受け取るには、通知の許可が必要です。許可しますか？」
- ボタン:
  - `notDetermined` / `denied`: 「許可する」→ `requestPermission(criticalAlert: true)` → Provider を invalidate
  - `deniedForever`（iOS）: 「設定を開く」→ `Geolocator.openAppSettings()` または同等

### 自動切り替え

OS 権限がオフの状態で推奨設定・すべて・カスタムが選択されている場合、**通知しない** に自動切り替える。

### 適用範囲

オンボーディング・設定画面の両方に同じ制御を適用する。

## 重大な通知の警告リンク

### 表示条件

以下をすべて満たすとき、該当カード下部にリンクを表示:

1. 推奨設定 or すべて が選択中
2. iOS / macOS（`criticalAlert != notSupported`）
3. `criticalAlert == disabled`

Android では非表示（プラットフォーム非対応のため）。

### UI

`Text.rich` + `TapGestureRecognizer` でリンク表示:

```
重大な通知が許可されていません
```

- リンク部分: `primary` 色 + 下線
- 通常テキスト: `onSurfaceVariant`

### タップ時ダイアログ

- タイトル: 「重大な通知が許可されていません」
- 本文: 「緊急地震速報(警報)を確実に受け取るには、重大な通知の許可が必要です。許可しますか？」
- 「許可する」→ `requestPermission(criticalAlert: true)` → Provider invalidate
- 既に拒否済みで再要求不可の場合は「設定を開く」

## アーキテクチャ

### 新規ファイル

```
app/lib/core/provider/notification/
  os_notification_permission_provider.dart

app/lib/feature/settings/features/notification_settings/
  data/action/notification_preset_applier.dart
  ui/component/notification_preset_selector.dart
  ui/dialog/notification_permission_dialog.dart
```

### 変更ファイル

```
data/notifier/notification_preset_notifier.dart   # enum 拡張 + 永続化マイグレーション
ui/page/notification_settings_page.dart          # 共有コンポーネント利用
feature/onboarding/ui/components/
  notification_settings_step_page.dart             # 共有コンポーネント利用
feature/onboarding/ui/model/
  onboarding_permission_status.dart                # _NotificationPreset 削除
```

### enum 変更

```dart
enum NotificationPreset { recommended, all, custom, none }
```

オンボーディングローカルの `_NotificationPreset` は廃止し `NotificationPreset` に統一。

### SharedPreferences 永続化

既存キー `notification_preset` の値:

| 保存値 | 読み込み結果 |
|---|---|
| `custom` | `NotificationPreset.custom` |
| `all` | `NotificationPreset.all` |
| `none` | `NotificationPreset.none` |
| 未設定 / `recommended` / その他 | `NotificationPreset.recommended` |

### NotificationPresetApplier

プリセット選択時の API 呼び出しを集約する Action クラス（Riverpod DI）。

| プリセット | 処理 |
|---|---|
| `recommended` | `putCurrentLocation(eew: 震度4, earthquake: 震度1)` + `notificationEnabled: true` |
| `all` | 上記 + `putNationwide(eew: 震度3, earthquake: 震度3)` + `notificationEnabled: true` |
| `custom` | `putCurrentLocation` のみ（詳細はカスタム画面） + preset を `custom` に保存 |
| `none` | `notificationEnabled: false`、スロットは作成しない。設定画面で既存スロットがある場合は削除せず保持する |

### NotificationPresetSelector

共有 UI コンポーネント。props:

- `selectedPreset: NotificationPreset`
- `onChanged: ValueChanged<NotificationPreset>`
- `onCustomSettingsTap: VoidCallback?`（カスタム詳細画面遷移、設定画面用）
- `style: NotificationPresetSelectorStyle`（`onboarding` / `settings` でレイアウト差分）

オンボーディング: 現行の `_PresetCard` スタイル（カード型ラジオ）
設定画面: 現行の `_PresetOptionGroup` スタイル（Card.outlined 内リスト）

## オンボーディング固有の挙動

- プリセット未選択時: 「次へ」無効
- 選択後「次へ」:
  - `recommended` / `all` / `none`: Applier で保存 → 次ステップへ
  - `custom`: 現在地スロット作成 → `NotificationSettingsPage` を push → pop 後に次ステップへ
- 保存失敗時: エラーメッセージ表示、リトライ可能

## 設定画面の変更

- `_PresetOptionGroup` を `NotificationPresetSelector` に置き換え
- 「通知を受け取る」マスタートグルは既存のまま維持
- プリセット変更時は即座に Applier で API 保存（オンボーディングと同じロジック）
- カスタム選択時の詳細画面遷移は既存の `_CustomNotificationSettingsPage` を維持

## エラーハンドリング

- API 保存失敗: ユーザーフレンドリーなエラーメッセージ（例外文字列は表示しない）
- 権限要求失敗: ダイアログを閉じ、状態は変更しない
- Mutation エラーは既存パターン（`showErrorDialog`）に従う

## テスト

| 対象 | 内容 |
|---|---|
| `NotificationPresetApplier` | 各プリセットの API 呼び出し内容 |
| `NotificationPresetNotifier` | enum 永続化・読み込みマイグレーション |
| OS 権限ロジック | 権限状態ごとの選択可否・自動切り替え |
| 重大通知リンク | iOS で表示、Android で非表示 |
| Widget テスト | 権限オフ時に無効カードタップでダイアログ表示 |

## スコープ外

- 津波・訓練・南海トラフ等の一般通知を「すべて」に含める（スロットのみ）
- 権限ステップ（permissions）の UI 変更
- 移行ユーザー（`_MigratedNotificationSettingsStepPage`）の変更
