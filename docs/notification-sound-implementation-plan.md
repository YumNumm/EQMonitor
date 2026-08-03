# 通知音設定 実装計画書 v2

**作成日**: 2026-05-07  
**更新日**: 2026-05-07  
**対象ブランチ**: develop  
**関連調査**: [docs/notification-sound-research.md](./notification-sound-research.md)

---

## 概要

EQMonitor アプリでユーザーが通知音を自由に設定できる機能を実装する。

**実現したいこと**

- ユーザーが任意の音声ファイルをインポートして通知音として使用できる（HA iOS 方式）
- iOS システムサウンドを通知音として利用できる
- EEW の予想震度ごとに通知音・割り込みレベルを設定できる（複数ティア）
- 現在地への EEW 警報 → Critical 通知（DND 突破）を自動適用できる
- 予想震度 × 現在地マッチで音量・通知音を変えられる

**T5（Critical Alerts Entitlement）は取得済み**のため、すぐにクリティカル通知が送信できる。

---

## 現状の整理

### バックエンドアーキテクチャ

```
デバイス設定 (device_eew_settings)
  └─ notification_tiers: [{min_jma_intensity, sound, interruption_level}]
           ↓
notification-resolver
  └─ resolveNotificationTier(tiers, matchedIntensity)
           ↓ tier.sound / tier.interruption_level
buildApnsAlertPayload()
  └─ aps.sound = tier.sound (現状は文字列のみ)
     aps.interruption-level = tier.interruption_level
```

- `notification_tiers` はすでに **複数ティア** のスキーマ（昇順ソート済み配列）
- `resolveNotificationTier()` が対象震度で最上位のティアを選択する
- `matchedSettings` に `isCurrentLocation: boolean` が含まれているが、**現状は現在地を特別扱いしていない**
- APNs の `aps.sound` は現状**文字列のみ**（Critical alert の volume 対応なし）

### Flutter 現状

- `notification_tiers` のうち `interruption_level=critical` のティアを 1 つだけ送信（クリティカル閾値の on/off のみ）
- 通知音はすべて `'default'` にハードコード
- カスタム音声ファイルの同梱なし・インポート機能なし

---

## 変更範囲の全体像

```
[Flutter App]                [Backend]
  UI: SoundManager             notification-common
  UI: TierEditor           ←→  notification-tier.ts (volume 追加)
  UI: EewSettings              database/schema.ts (current_location_tiers 追加)
  Model: NotificationTier      api: EewSettingsRequest/Response (拡張)
  Model: EewSettings       ←→  notification-resolver (現在地ロジック + critical sound)
  iOS: ~/Library/Sounds/       apns.ts (critical sound オブジェクト形式対応)
  Android: res/raw/
```

---

## タスク一覧

### T1: バックエンド — 通知ティアに `volume` フィールドを追加

**担当**: backend / 優先度: High

#### `notification-common/src/types/notification-tier.ts`

```typescript
export const NotificationTierSchema = v.object({
  min_jma_intensity: JmaIntensitySchema,
  sound: v.string(),                          // ファイル名 or "default" or "none"
  volume: v.optional(v.pipe(                  // 追加: 音量 (0.0 - 1.0)
    v.number(), v.minValue(0), v.maxValue(1)
  )),
  interruption_level: InterruptionLevelSchema,
});
```

---

### T2: バックエンド — APNs Critical Alert を `sound` オブジェクト形式で送信

**担当**: backend / 優先度: High（T5 取得済みのため即時対応可）

#### `notification-resolver/src/resolver/payload-builder/apns.ts`

`buildApnsAlertPayload` 内の `sound` の組み立てを変更：

```typescript
// 変更前
sound: sound ?? 'default',

// 変更後
sound: buildApnsSound(sound, interruptionLevel, volume),
```

```typescript
function buildApnsSound(
  sound: string | undefined,
  interruptionLevel: string,
  volume?: number,
): string | Record<string, unknown> {
  const name = sound ?? 'default';
  if (name === 'none') return undefined;    // サウンドなし（呼び出し側で undefined チェック）
  if (interruptionLevel === 'critical') {
    return { critical: 1, name, volume: volume ?? 1.0 };
  }
  return name;
}
```

- `interruption_level === 'critical'` のときは APNs object 形式 `{critical: 1, name, volume}` で送信
- それ以外は文字列形式のまま

---

### T3: バックエンド — 現在地マッチ時の別ティア対応

**担当**: backend / 優先度: High

EEW で「現在地が対象地域に含まれ、かつ警報（isWarning）」の場合に別のティア設定を適用できるようにする。

#### DB スキーマ変更 (`database/src/schema/schema.ts`)

`device_eew_settings` テーブルに列を追加：

```typescript
// EEW通知設定テーブル（追記分）
currentLocationNotificationTiers: jsonb('current_location_notification_tiers')
  .$type<NotificationTierRow[]>()
  .default([])
  .notNull(),
```

> DB マイグレーションが必要。`current_location_notification_tiers` が空配列の場合は通常の `notification_tiers` にフォールバック。

#### API 変更 (`api/model/requests.ts` / `responses.ts`)

```typescript
// EewSettingsRequest
export const EewSettingsRequest = v.pipe(
  v.partial(v.object({
    enabled: v.boolean(),
    notification_tiers: NotificationTiersSchema,
    current_location_notification_tiers: v.optional(NotificationTiersSchema),  // 追加
    start_live_activity: v.boolean(),
  })),
  ...
);

// EewSettingsResponse
export const EewSettingsResponse = v.object({
  enabled: v.boolean(),
  notification_tiers: NotificationTiersSchema,
  current_location_notification_tiers: NotificationTiersSchema,  // 追加
  start_live_activity: v.boolean(),
});
```

#### notification-resolver の変更 (`repository/device.ts`)

`EewMatchedDevice` に `currentLocationNotificationTiers` を追加し、`getEewMatchedDevices()` でフェッチ。

#### 通知送信ロジックの変更 (`index.ts`)

```typescript
// ティア選択ロジック（修正後）
const hasCurrentLocationMatch = device.matchedSettings.some(
  s => s.isCurrentLocation,
);
const tiersToUse = (
  hasCurrentLocationMatch &&
  event.isWarning &&
  device.currentLocationNotificationTiers.length > 0
)
  ? device.currentLocationNotificationTiers
  : device.notificationTiers;

const tier = resolveNotificationTier(tiersToUse, maxMatchedSetting.matchedIntensity);
```

---

### T4: Flutter — 通知ティアのデータモデル拡張

**担当**: app / 優先度: High

#### アプリ側ティアモデル (`app/lib/feature/settings/features/notification_settings/data/model/`)

```dart
// notification_sound_tier.dart（新規）
@freezed
abstract class NotificationSoundTier with _$NotificationSoundTier {
  const factory NotificationSoundTier({
    required JmaIntensity minJmaIntensity,
    required String sound,         // ファイル名 or "default" or "none"
    required InterruptionLevel interruptionLevel,
    double? volume,                // 0.0-1.0、critical 時のみ有効
  }) = _NotificationSoundTier;
}
```

#### EewNotificationSettings の変更

```dart
// eew_notification_settings.dart（修正）
@freezed
abstract class EewNotificationSettings with _$EewNotificationSettings {
  const factory EewNotificationSettings({
    required bool enabled,
    required bool startLiveActivity,
    required List<NotificationSoundTier> tiers,                  // 変更: 複数ティア
    required List<NotificationSoundTier> currentLocationTiers,   // 追加
    required List<NotificationRegion> regions,
  }) = _EewNotificationSettings;
}
```

#### EarthquakeNotificationSettings の変更

```dart
@freezed
abstract class EarthquakeNotificationSettings with _$EarthquakeNotificationSettings {
  const factory EarthquakeNotificationSettings({
    required bool enabled,
    required List<NotificationSoundTier> tiers,          // 変更: 複数ティア
    required bool estimatedIntensityEnabled,
    required List<NotificationRegion> regions,
  }) = _EarthquakeNotificationSettings;
}
```

#### eqmonitor_api パッケージの更新

生成済みモデル (`packages/eqmonitor_api/`) を更新または OpenAPI 再生成：
- `EewSettingsRequest` に `currentLocationNotificationTiers` 追加
- `EewSettingsResponse` に `currentLocationNotificationTiers` 追加
- `NotificationTiers3` / `NotificationTiers4` に `volume` フィールド追加

---

### T5: Flutter — repository 層の更新

**担当**: app / 優先度: High

`device_notification_settings_repository.dart` の変換ロジックを、次のように複数ティア対応にする。

```dart
// EEW レスポンス → アプリモデル
EewNotificationSettings _eewFromResponse(
  api.EewSettingsResponse resp,
  List<NotificationRegion> regions,
) => EewNotificationSettings(
  enabled: resp.enabled,
  startLiveActivity: resp.startLiveActivity,
  tiers: resp.notificationTiers.map(_tierFromApi).toList(),
  currentLocationTiers:
      resp.currentLocationNotificationTiers?.map(_tierFromApi).toList() ?? [],
  regions: regions,
);

// ティア送信ロジック: ユーザー設定をそのまま送信（ハードコードを廃止）
List<api.NotificationTiers4> _toEewApiTiers(
  List<NotificationSoundTier> tiers,
) => tiers.map((t) => api.NotificationTiers4(
  minJmaIntensity: t.minJmaIntensity.toApiMinJmaIntensity!,
  sound: t.sound,
  volume: t.volume,
  interruptionLevel: t.interruptionLevel.toApi(),
)).toList();
```

---

### T6: Flutter — カスタム通知音の管理 UI（HA iOS 方式）

**担当**: app / 優先度: High

`app/lib/feature/settings/features/notification_sound/` ディレクトリを新規作成。

#### ファイル構成

```
notification_sound/
  data/
    model/
      sound_category.dart        # bundled / imported / system
      available_sound.dart       # {fileName, displayName, url, category}
    repository/
      notification_sound_repository.dart
  ui/
    page/
      notification_sound_manager_page.dart   # サウンド管理ページ
    component/
      sound_list_tile.dart       # サウンド行（プレビュー再生 + コピー）
      sound_picker_sheet.dart    # 通知音選択ボトムシート
```

#### サウンドカテゴリ

```dart
enum SoundCategory { bundled, imported, system }

@freezed
abstract class AvailableSound with _$AvailableSound {
  const factory AvailableSound({
    required String fileName,      // APNs に送るファイル名
    required String displayName,   // UI 表示名
    required Uri uri,              // 再生・コピー元 URI
    required SoundCategory category,
  }) = _AvailableSound;
}
```

#### NotificationSoundRepository

```dart
class NotificationSoundRepository {
  // bundled: Bundle 内 Assets に同梱した WAV ファイル一覧
  List<AvailableSound> getBundledSounds();

  // imported: iOS ~/Library/Sounds/*.wav
  Future<List<AvailableSound>> getImportedSounds();

  // system: /System/Library/Audio/UISounds 以下をコピーして提供 (iOS only)
  Future<int> importSystemSounds();  // コピー済み件数を返す

  // ファイルピッカーでインポート
  Future<void> importFromFilePicker(List<Uri> uris);

  // Files アプリ / File Sharing からインポート
  Future<int> importFromFileSharing();

  // 削除
  Future<void> deleteImportedSound(String fileName);

  // プレビュー再生
  Future<void> play(AvailableSound sound);
  void stopPlayback();
}
```

#### iOS サウンドストレージ

- インポートしたファイルは `~/Library/Sounds/` に WAV 形式で保存
- `file_picker` パッケージでファイルを選択後、`AudioKit` 相当の変換は **Flutter 側では不要**（変換は Platform Channel 経由で Swift コードに委譲、または `.wav` のみ受付）
- APNs は `~/Library/Sounds/` を優先してサウンドを解決するため、インポートしたファイル名をそのまま `sound` フィールドに指定すれば動作する

#### Android

- プッシュ通知のカスタム音は **チャンネル作成時のみ設定可能**
- 動的なカスタム音インポートは Android では対応しない
- 代わりに「同梱済みサウンドのみ選択可能」として UI でも Android ではシステムサウンドセクションを非表示にする

#### UI: `NotificationSoundManagerPage`

```
┌────────────────────────────────────┐
│ 通知音の管理                  [?]   │
│ ─────────────────────────────────  │
│ [同梱] [インポート済み] [システム]   │  ← SegmentedButton
│                                    │
│ 同梱セクション:                     │
│  ▶ eqmonitor_eew_warning.wav       │  (再生 + コピー)
│  ▶ eqmonitor_eew_forecast.wav      │
│  ▶ eqmonitor_earthquake.wav        │
│                                    │
│ インポート済みセクション:           │
│  ▶ my_alert.wav           [削除]   │
│  + ファイルを選択してインポート     │
│  + File Sharing からインポート      │
│                                    │
│ システムセクション (iOS):           │
│  + iOS システムサウンドをインポート  │
└────────────────────────────────────┘
```

---

### T7: Flutter — 通知ティアエディタ UI

**担当**: app / 優先度: High

#### `NotificationSoundTierEditorPage`（新規）

ティアの一覧編集・追加・削除ができるページ。EEW 設定ページ・地震設定ページからナビゲート。

```
┌────────────────────────────────────┐
│ 通知ティアの設定                    │
│ ─────────────────────────────────  │
│ ティア 1                  [削除]   │
│   震度: 震度1以上                   │
│   通知音: eqmonitor_eew.wav  [>]   │
│   割り込みレベル: 時間重要          │
│                                    │
│ ティア 2                  [削除]   │
│   震度: 震度4以上                   │
│   通知音: eqmonitor_eew_warn [>]   │
│   割り込みレベル: クリティカル      │
│   音量: ─────●──── 0.8            │ ← critical 時のみ表示
│                                    │
│ + ティアを追加                      │
│                                    │
│ ※ 複数ティアは震度の昇順に保持      │
└────────────────────────────────────┘
```

#### 割り込みレベル表示名

| 値 | 日本語表示 | 動作 |
|----|-----------|------|
| `passive` | 通常 | 通知バナーなし（通知センターのみ） |
| `active` | アクティブ | 通常通知 |
| `time_sensitive` | 時間重要 | 集中モードを突破 |
| `critical` | クリティカル | DND・サイレントスイッチを突破、音量指定可 |

---

### T8: Flutter — EEW 設定ページの拡張

**担当**: app / 優先度: High

`eew_settings_page.dart` を以下の構成に拡張：

```
┌────────────────────────────────────┐
│ 緊急地震速報の通知                  │
│                                    │
│ [通知の有効化]                      │
│   緊急地震速報の通知    ○           │
│                                    │
│ [通知ティア]                        │
│   ティア設定            [>]        │ ← NotificationSoundTierEditorPage へ
│   震度1以上: eqmonitor_eew.wav      │
│   震度5弱以上: eqmonitor_eew_w...   │
│                                    │
│ [現在地マッチ時の優先設定]          │ ← 新規セクション
│   現在地で警報 → 別ティアを適用     │
│   現在地ティア設定      [>]        │
│   (未設定の場合は通常ティアを使用)  │
│                                    │
│ [通知地域]                          │
│   ...                              │
└────────────────────────────────────┘
```

- 通常ティア: 地域設定で登録した全地域で使用
- 現在地ティア (`current_location_tiers`): 現在地が対象地域に含まれ、かつ警報の場合に優先使用

例：現在地ティアに `{震度1以上, critical, eqmonitor_eew_warning.wav, volume:1.0}` を設定 → 現在地への EEW 警報は常に DND 突破の最大音量で通知

---

### T9: Flutter — 地震情報設定ページの拡張

**担当**: app / 優先度: Medium

`earthquake_settings_page.dart` に通知ティアセクションを追加：

```
┌────────────────────────────────────┐
│ 地震情報の通知                      │
│                                    │
│ [通知の有効化] / [推計震度通知]     │
│                                    │
│ [通知ティア（予想震度別）]          │ ← 新規セクション
│   ティア設定            [>]        │
│   震度1以上: デフォルト             │
│   震度4以上: eqmonitor_eq.wav       │
│   震度5弱以上: critical, 音量0.9   │
│                                    │
│ [通知地域]                          │
└────────────────────────────────────┘
```

---

### T10: アプリへの通知音ファイル同梱

**担当**: app / 優先度: High

#### iOS

```
app/ios/Runner/Sounds/
  eqmonitor_eew_warning.wav     # EEW 警報用（インパクト大）
  eqmonitor_eew_forecast.wav    # EEW 予報用
  eqmonitor_earthquake.wav      # 地震情報用
```

- Xcode: Build Phase → Copy Bundle Resources に追加
- `FcmServiceExtension` ターゲットにも同じファイルを追加
- 形式: WAV, 48kHz, 32-bit, mono, 最大 30 秒

#### Android

```
app/android/app/src/main/res/raw/
  eqmonitor_eew_warning.mp3
  eqmonitor_eew_forecast.mp3
  eqmonitor_earthquake.mp3
```

#### Flutter アセット登録

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/sounds/eqmonitor_eew_warning.wav
    - assets/sounds/eqmonitor_eew_forecast.wav
    - assets/sounds/eqmonitor_earthquake.wav
```

---

### T11: Android 通知チャンネルの移行

**担当**: app / 優先度: Medium

既存チャンネルは作成済みのためサウンド変更不可。バージョン管理付きの新チャンネルを作成。

```dart
// channels.dart
const AndroidNotificationChannel(
  'eew_warning_v2',           // 新チャンネル ID
  '緊急地震速報(警報)',
  sound: RawResourceAndroidNotificationSound('eqmonitor_eew_warning'),
  importance: Importance.max,
),
```

- `main.dart` の初期化処理で旧チャンネル (`eew_warning`) を `deleteNotificationChannel()` してから新チャンネルを登録
- バックエンドの `NotificationChannel.EEW_WARNING` の値も `eew_warning_v2` に更新が必要

---

## 実装の依存関係と順序

```
T1（tier に volume 追加）
  ↓
T2（APNs critical sound オブジェクト化）
T3（DB: current_location_tiers 追加）
  ↓
T10（音声ファイル同梱）
  ↓
T4（Flutter モデル拡張）
  ↓
T5（repository 更新）
  ↓
T6（Sound Manager UI）
T7（Tier Editor UI）
  ↓
T8（EEW 設定ページ拡張）
T9（地震設定ページ拡張）
  ↓
T11（Android チャンネル移行）
```

バックエンド（T1-T3）と Flutter（T10-T11）は並行して進められる。

---

## API スキーマ変更まとめ

### EewSettingsResponse（拡張後）

```json
{
  "enabled": true,
  "notification_tiers": [
    {"min_jma_intensity": "1", "sound": "eqmonitor_eew_forecast.wav", "interruption_level": "time_sensitive"},
    {"min_jma_intensity": "5-", "sound": "eqmonitor_eew_warning.wav", "volume": 0.8, "interruption_level": "critical"}
  ],
  "current_location_notification_tiers": [
    {"min_jma_intensity": "1", "sound": "eqmonitor_eew_warning.wav", "volume": 1.0, "interruption_level": "critical"}
  ],
  "start_live_activity": true
}
```

### APNs ペイロード（critical tier 時）

```json
{
  "aps": {
    "alert": { "title": "緊急地震速報（警報）", "body": "..." },
    "sound": { "critical": 1, "name": "eqmonitor_eew_warning.wav", "volume": 1.0 },
    "interruption-level": "critical"
  }
}
```

### APNs ペイロード（通常 tier 時）

```json
{
  "aps": {
    "alert": { "title": "緊急地震速報（予報）", "body": "..." },
    "sound": "eqmonitor_eew_forecast.wav",
    "interruption-level": "time-sensitive"
  }
}
```

---

## 技術的考慮事項

### iOS サウンド解決の優先順位

APNs がサウンドを解決する順：
1. `~/Library/Sounds/` 内（ユーザーインポート ← **今回対応**）
2. アプリ Bundle 内（同梱サウンド ← **今回対応**）
3. システムサウンド（インポートして `~/Library/Sounds/` にコピー ← **今回対応**）

### カスタム音ファイルとの通信

- ユーザーがインポートした音のファイル名（例: `my_alarm.wav`）をそのまま `sound` フィールドに設定
- バックエンドはファイル名を検証せず、APNs に渡すだけ（既存の動作を維持）
- 端末上に存在しないファイル名が `sound` に設定された場合、iOS はデフォルトサウンドで再生

### `notification_tiers` の昇順制約

バックエンドに既存のバリデーション:
```typescript
v.check(tiers => /* 昇順チェック */, 'must be sorted by ascending intensity')
```
Flutter 側の Tier Editor もこの制約を UI で強制する（同じ震度の重複を禁止、追加時に自動ソート）。

### Android の制限と UX

- Android では通知チャンネルのサウンドをユーザーが事後変更できない（OS 仕様）
- チャンネル移行（`v2` 接尾辞）でサウンドをリセットするが、ユーザーがカスタマイズしていた場合もリセットされる
- Sound Manager UI で「Android はプッシュ通知の音を変更できません」と明示

---

## 完了条件

- [ ] T1: `NotificationTierSchema` に `volume` フィールドが追加されている
- [ ] T2: `interruption_level=critical` の APNs ペイロードが `sound` オブジェクト形式になっている
- [ ] T3: `device_eew_settings` に `current_location_notification_tiers` カラムが追加され、API に公開されている
- [ ] T4: Flutter モデルが複数ティアに対応している
- [ ] T5: repository が全ティアを送受信できる
- [ ] T6: 通知音管理ページ（インポート・プレビュー・削除）が実装されている
- [ ] T7: ティアエディタ UI が実装されている
- [ ] T8: EEW 設定ページに通常ティア + 現在地ティアのセクションが追加されている
- [ ] T9: 地震情報設定ページにティアセクションが追加されている
- [ ] T10: iOS/Android に通知音ファイルが同梱されている
- [ ] T11: Android 通知チャンネルが `v2` で再作成されている
- [ ] 現在地マッチ + EEW 警報で Critical Alert が届く（DND 突破・音量指定）
- [ ] `dart analyze` がエラーなしで通過する
- [ ] `pnpm check-types` がエラーなしで通過する
