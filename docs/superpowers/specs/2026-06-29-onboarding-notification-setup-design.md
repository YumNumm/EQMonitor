# Onboarding Notification Setup Design

## Overview

オンボーディングフローを拡張し、デバイス登録・権限要求・通知設定を統合する。
ユーザーが初回起動時にスムーズに通知を受け取れる状態にすることが目的。

## Background

現在のオンボーディングは4ステップ（Welcome → 通知権限 → 位置情報権限 → 完了）で構成されている。
以下の課題がある:

- デバイス登録がオンボーディング外で行われており、登録前に通知設定が完了してしまう
- 重大な通知（Critical Alert）の権限要求がない
- 通知設定のプリセットがなく、ユーザーが設定画面で個別に設定する必要がある
- 通知権限と位置情報権限が別ステップで冗長

関連: https://github.com/YumNumm/eqmonitor-backend/issues/723

## Step Flow

```
Welcome → DeviceRegistration → Permissions → NotificationSettings → [CustomSettings] → Complete
```

| # | Step | Title | Description |
|---|------|-------|-------------|
| 0 | welcome | "EQMonitor へようこそ" | 既存のまま |
| 1 | deviceRegistration | "はじめに" | デバイス登録を自動実行 |
| 2 | permissions | "通知と位置情報" | 通知+重大通知+位置情報を1画面で順に要求 |
| 3 | notificationSettings | "通知設定" | 推奨/カスタム/高度な設定[PRO]の3択 |
| 4 | (customSettings) | カスタム詳細設定 | 別画面push。Placeholder実装 |
| 5 | complete | "準備完了" | 既存のまま |

## Step 1: DeviceRegistration

### UI
- タイトル: 「はじめに」
- 説明: 「サーバーにデバイスを登録しています...」
- 中央エリア:
  - 処理中: CircularProgressIndicator
  - 成功: チェックアイコン（成功色）
  - 失敗: エラーアイコン + エラーメッセージ + 「再試行」ボタン

### Logic
- ステップ到達時に `DeviceProvisioningNotifier.provision()` を Mutation 経由で自動実行
- 既にプロビジョニング済み（`DeviceProvisioningStatus.notRequired`）の場合は即座に次へ
- 成功時: 短いディレイ（~500ms）後に自動で次ページへアニメーション遷移
- 失敗時: 「再試行」ボタンを表示。タップで `provision()` を再実行

### Button Control
- 処理中: 次へボタン・戻るボタンともに無効
- 失敗時: 次へボタン無効、戻るボタン無効
- 成功時: 自動遷移するため次へボタンの状態は問わない

## Step 2: Permissions

### UI
- タイトル: 「通知と位置情報」
- 説明: 「緊急地震速報や地震情報をリアルタイムに受け取るために、通知と位置情報を許可してください」
- 中央: 通知アイコン + 位置情報アイコンを組み合わせたHeroビジュアル
- 権限拒否時:
  - 「設定アプリからいつでも変更できます」テキスト
  - 「設定アプリを開く」ボタン（`Geolocator.openAppSettings()`）

### Permission Request Sequence
「次へ」タップ時に以下を順番に実行:

1. **通知 + 重大な通知**: `messaging.requestPermission(alert: true, sound: true, badge: true, criticalAlert: true)`
   - iOS: 通常通知と Critical Alert を同時に要求
   - Android: 通常の通知権限のみ（criticalAlertは無視される）
2. **位置情報**: `Geolocator.requestPermission()`
   - `whileInUse` or `always` で許可
   - `denied` or `deniedForever` で拒否

### Permission Denied Handling
- いずれかの権限が拒否された場合: ボタンラベルが「スキップ」に変化
- スキップ可能 — 後から設定アプリで変更できる旨を表示
- `deniedForever` の場合: 「設定アプリを開く」ボタンを追加表示

## Step 3: NotificationSettings

### UI
- タイトル: 「通知設定」
- サブテキスト: 「細かい設定は後からでも変更できます」
- 3つの選択カード（ラジオ選択式、排他的）

### Choice Cards

#### 推奨設定
- カードスタイル: 通常の選択カード
- 箇条書き:
  - 現在地の緊急地震速報(警報)
  - 現在地で予想震度4以上の緊急地震速報(予報)
  - 現在地で震度1以上を観測

#### カスタム
- カードスタイル: 通常の選択カード
- 説明: 「緊急地震速報と地震情報について、追加で1地域まで指定」
- 箇条書き:
  - 現在地の緊急地震速報(警報)有無
  - 他の詳細はカスタム詳細画面で設定

#### 高度な設定 [PRO]
- カードスタイル: PROバッジ付き
- 無課金時: グレーアウト（`TODO: 課金状態の判定を実装`）
- 説明:
  - 緊急地震速報と地震情報について、追加で最大5地域まで指定
  - 予想震度や観測震度に合わせた通知音・通知割り込みレベルのカスタマイズ
- 「課金について見る」ボタン（`TODO: 課金画面への遷移`）

### Button Control
- 未選択時: 「次へ」無効
- 選択後: 「次へ」有効

### Navigation on Next
- 推奨設定:
  1. 通知設定APIへ保存（保存中はボタン無効+ローディング）
  2. 保存成功 → completeステップへ
  3. 保存失敗 → エラー表示、リトライ可能
- カスタム:
  1. カスタム詳細画面をNavigator.push
  2. 詳細画面からpop後 → completeステップへ
- 高度な設定 [PRO]:
  1. 通知設定APIへ保存（推奨と同じデフォルト設定で）
  2. 保存成功 → completeステップへ

### Recommended Settings API Payload

推奨設定選択時にAPIへ送信する内容:

- **EEW警報**: 現在地（`isCurrentLocation: true`）、割り込みレベル: Critical（固定）
- **EEW予報**: 現在地（`isCurrentLocation: true`）、`minJmaIntensity: JmaIntensity.four`
- **地震情報**: 現在地（`isCurrentLocation: true`）、`minJmaIntensity: JmaIntensity.one`

位置情報が許可されている場合: `BackgroundLocationTracker.startMonitoring()` を開始

## Step 4: CustomSettings (Placeholder)

### UI
- 別画面（Navigator.push）
- **全体を `Placeholder` ウィジェットで囲む**
- Placeholder 内テキスト: 「カスタム設定（後日実装）」
- Bottom 固定エリアに「次へ」ボタン
- 「次へ」タップ → pop → completeステップへ自動遷移

## Step 5: Complete

既存の `_CompleteStepContent` をそのまま流用。

- タイトル: 「準備完了」
- 説明: 「EQMonitor で日本の地震情報をリアルタイムに確認できます」
- チェックアイコン Hero
- 「はじめる」ボタン → `onboardingCompletedProvider.complete()` → `context.go('/')`

## Implementation Notes

### Enum Changes

```dart
enum _OnboardingStep {
  welcome,
  deviceRegistration,
  permissions,
  notificationSettings,
  complete,
}
```

### Permission Handling

通知と重大な通知の権限を同時に要求する変更:

```dart
// Before
await messaging.requestPermission();

// After
await messaging.requestPermission(
  alert: true,
  sound: true,
  badge: true,
  criticalAlert: true,
);
```

### File Structure

既存の `onboarding_page.dart` を拡張する。カスタム詳細画面は別ファイルとして追加:

```
app/lib/feature/onboarding/ui/
  onboarding_page.dart              # 既存ファイルを拡張
  onboarding_custom_settings_page.dart  # 新規: カスタム詳細画面（Placeholder）
```

### Dependencies

- `DeviceProvisioningNotifier` — デバイス登録処理
- `firebaseMessagingProvider` — FCM権限要求
- `Geolocator` — 位置情報権限要求
- `EewSettingsNotifier` — EEW通知設定保存
- `EarthquakeNotificationSettingsNotifier` — 地震情報通知設定保存
- `BackgroundLocationTracker` — 位置情報モニタリング開始

### Error Handling

- デバイス登録失敗: リトライボタン表示。自動リトライはしない（ユーザーアクション起点）
- 通知設定保存失敗: エラーメッセージ + リトライ可能。次へボタン無効のまま
- 権限拒否: スキップ可能。後から設定で変更できる旨を明示

### PRO Badge / Paywall

- 高度な設定のグレーアウトは `TODO` コメントで仮実装
- 課金状態の判定ロジックは実装しない
- 「課金について見る」ボタンは Placeholder リンク

## Out of Scope

- カスタム詳細設定画面の実際のUI実装（Placeholderのみ）
- 課金状態の判定ロジック
- 高度な設定の実際の設定UI
- EEW警報/予報分離のバックエンド変更
- `setCriticalThreshold` の完全実装
