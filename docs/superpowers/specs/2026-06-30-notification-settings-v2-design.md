# 通知設定 v2 — スロット統合アーキテクチャ設計

## 概要

バックエンドの通知API大幅変更（スロット統合モデル、Free/Proプラン制約）に対応し、アプリ側の通知設定画面・データ層を全面的に書き直す。

### 背景

- バックエンド Issue: [#723](https://github.com/YumNumm/eqmonitor-backend/issues/723)
- 旧アーキテクチャ: EEW / 地震情報 / 揺れ検知 / 一般が完全分離（Notifier・Repository・APIエンドポイントが別々）
- 新バックエンド: スロット統合モデル（1スロットにEEW・地震情報が同居）、プラン制約、EEW警報分離

### スコープ

- 通知設定画面（CustomNotificationSettingsPage）の書き直し
- スロット詳細画面（SlotDetailPage）の新規作成
- データ層（Notifier / Repository / モデル）の全置き換え
- オンボーディングの通知設定ステップの更新
- 揺れ検知（Shake Detection）はスコープ外

---

## データモデル層

API型（`eqmonitor_api`の生成コード）はUI層で直接使用しない。アプリ固有のFreezedモデルを定義し、Repository層でAPI型⇔アプリ型の変換を行う。

### NotificationSlot

```dart
@freezed
class NotificationSlot {
  String id;
  SlotType slotType;        // enum: currentLocation, nationwide, region
  int? regionId;
  String? regionName;
  String? cityCode;
  String? cityName;
  int displayOrder;
  bool eewEnabled;
  JmaIntensity? eewMinIntensity;
  List<NotificationOverride>? eewOverrides;
  bool earthquakeEnabled;
  JmaIntensity? earthquakeMinIntensity;
  List<NotificationOverride>? earthquakeOverrides;
}
```

### NotificationOverride

```dart
@freezed
class NotificationOverride {
  JmaIntensity minJmaIntensity;
  String sound;
  InterruptionLevel interruptionLevel;
}
```

### GlobalNotificationSettings

```dart
@freezed
class GlobalNotificationSettings {
  bool eewEnabled;
  bool earthquakeEnabled;
  bool startLiveActivity;
  bool eewOnePointEnabled;
  bool eewCollapseNotification;
  bool earthquakeEstimatedIntensityEnabled;
  bool earthquakeCollapseNotification;
  String eewDefaultSound;
  InterruptionLevel eewDefaultInterruptionLevel;
  String earthquakeDefaultSound;
  InterruptionLevel earthquakeDefaultInterruptionLevel;
}
```

### EewWarningSettings

```dart
@freezed
class EewWarningSettings {
  EewWarningTarget target;  // currentLocationOnly / currentLocationAndNationwide
  InterruptionLevel? nationwideInterruptionLevel;
}
```

### プリセット

```dart
enum NotificationPreset { recommended, custom }
```

---

## Notifier / Provider 層

Riverpodの実験的Mutation APIを使用。UI層でMutationを変数に展開せず、そのまま使う。

### NotificationSlots

```dart
@Riverpod(keepAlive: true)
class NotificationSlots extends _$NotificationSlots {
  // State: AsyncValue<List<NotificationSlot>>

  static final putCurrentLocationMutation = Mutation<void>();
  static final deleteCurrentLocationMutation = Mutation<void>();
  static final putNationwideMutation = Mutation<void>();
  static final deleteNationwideMutation = Mutation<void>();
  static final addRegionMutation = Mutation<void>();
  static final updateRegionMutation = Mutation<void>();
  static final removeRegionMutation = Mutation<void>();

  // build(): GET /v2/device/me/settings/slots → List<NotificationSlot>
  // 各メソッド: API呼び出し → 成功後 ref.invalidateSelf()
  // 現在地スロット追加/削除時: BackgroundLocationTracker の start/stop
}
```

### NotificationGlobalSettings

```dart
@Riverpod(keepAlive: true)
class NotificationGlobalSettings extends _$NotificationGlobalSettings {
  // State: AsyncValue<GlobalNotificationSettings>
  static final updateMutation = Mutation<void>();

  // build(): GET /v2/device/me/settings/notification → GlobalNotificationSettings
  // update({...}): PATCH → invalidateSelf
}
```

### EewWarningConfig

```dart
@Riverpod(keepAlive: true)
class EewWarningConfig extends _$EewWarningConfig {
  // State: AsyncValue<EewWarningSettings>
  static final updateMutation = Mutation<void>();

  // build(): GET /v2/device/me/settings/eew-warning → EewWarningSettings
  // update({target, nationwideInterruptionLevel}): PATCH → invalidateSelf
}
```

### NotificationPresetState

```dart
@Riverpod(keepAlive: true)
class NotificationPresetState extends _$NotificationPresetState {
  // State: NotificationPreset
  // SharedPreferencesで永続化
  // 推奨選択時: current_locationスロットをデフォルト閾値でPUT（他スロットは削除せず保持、配信制御はサーバー側）
}
```

### プラン制約

Start APIのレスポンスに含まれる `PlanConstraints` を既存の Start プロバイダーから参照。

- `maxRegions` → 地域スロット追加の活性/非活性
- `overridesAllowed` → 震度別オーバーライドの表示/グレーアウト
- `eewWarningNationwide` → EEW警報「全国」の表示
- `isPro` → Proバッジ表示

---

## Repository層

```dart
class NotificationSettingsRepository {
  final ApiClient _api;

  // スロット操作（API型 → アプリ型変換）
  Future<List<NotificationSlot>> getSlots();
  Future<NotificationSlot> putCurrentLocation({...});
  Future<void> deleteCurrentLocation();
  Future<NotificationSlot> putNationwide({...});
  Future<void> deleteNationwide();
  Future<NotificationSlot> addRegion({...});  // 402ハンドリング
  Future<NotificationSlot> updateRegion(String slotId, {...});
  Future<void> removeRegion(String slotId);

  // グローバル設定
  Future<GlobalNotificationSettings> getGlobalSettings();
  Future<GlobalNotificationSettings> patchGlobalSettings({...});

  // EEW警報
  Future<EewWarningSettings> getEewWarningConfig();
  Future<EewWarningSettings> patchEewWarningConfig({...});
}
```

---

## UI構成

### 画面遷移

```
/settings/notification          → NotificationSettingsPage（推奨/カスタム選択）
/settings/notification/custom   → CustomNotificationSettingsPage
/settings/notification/slot/:id → SlotDetailPage
/settings/notification/region-picker → RegionPickerPage
/settings/notification/history  → NotificationHistoryPage（既存流用）
```

### NotificationSettingsPage

- 推奨設定 / カスタム設定 の2択ラジオ
- 通知履歴、テスト通知、Android通知チャンネル設定
- カスタム選択時 → CustomNotificationSettingsPage へ遷移

### CustomNotificationSettingsPage

- 基本設定セクション: EEW予報ON/OFF、地震情報ON/OFF、推計震度、Live Activity、1点検知(Pro)
- EEW警報セクション: 対象選択（現在地のみ / 現在地+全国[Pro]）
- 通知地域セクション: スロットリスト（現在地・全国・地域×N）
  - Free超過分: グレーアウト + Proバッジ、削除のみ可能
  - 追加ボタン: 上限表示（Free=1, Pro=5）
- デフォルト通知音セクション(Pro)

### SlotDetailPage

- EEW予報: 有効/無効、最小震度、震度別オーバーライド(Pro)
- 地震情報: 有効/無効、最小震度、震度別オーバーライド(Pro)
- regionスロットのみ: 削除ボタン

### Pro/Free UI制御

- `PlanConstraints` をwatchし、各UI要素の活性/非活性を制御
- Free超過スロット: `display_order` 先頭の `maxRegions` 件が有効、超過分はグレーアウト
- Pro限定機能: 🔒アイコン + 「Proで利用可能」テキスト
- 402エラー: Proアップグレードダイアログ表示

---

## オンボーディング

- 推奨 / カスタムの2択に統一（旧「高度な設定(PRO)」は廃止）
- カスタム選択時: `CustomNotificationSettingsPage` を再利用
- 推奨選択時: current_locationスロットをデフォルト閾値で自動作成 + 位置情報権限要求

---

## 削除対象

### データ層

- `data/model/eew_notification_settings.dart`
- `data/model/earthquake_notification_settings.dart`
- `data/model/notification_region.dart`
- `data/notifier/eew_settings_notifier.dart`
- `data/notifier/earthquake_notification_settings_notifier.dart`
- `data/notifier/general_notification_settings_notifier.dart`
- `data/repository/device_notification_settings_repository.dart`

### UI層

- `ui/page/eew_settings_page.dart`
- `ui/page/earthquake_settings_page.dart`
- `ui/page/notification_settings_page.dart`（書き直し）

### ルーティング

- `/settings/notification/eew` → 廃止
- `/settings/notification/earthquake` → 廃止
- `/settings/notification/slot/:id` → 新規

### 残すもの

- `shake_detection_settings_notifier.dart` / `shake_detection_settings_page.dart`（スコープ外）
- 通知履歴、テスト通知関連（既存流用）
- `notification_settings_step_page.dart`（書き直し）

---

## エラーハンドリング

- 402 Payment Required: Proアップグレードダイアログ
- ネットワークエラー: AsyncValueのerror状態で表示
- Mutation経由でエラーハンドリング（`ref.listen` でMutationErrorを検知）
- 楽観的更新はしない: API成功後にinvalidateSelfで再取得
