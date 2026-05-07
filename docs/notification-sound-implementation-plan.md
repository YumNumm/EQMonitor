# 通知音設定 実装計画書

**作成日**: 2026-05-07  
**対象ブランチ**: develop  
**関連調査**: [docs/notification-sound-research.md](./notification-sound-research.md)

---

## 概要

EQMonitor アプリで通知音をユーザーが設定できる機能を実装する。バックエンド API には既に `notification_tiers[].sound` フィールドが存在するため、主な作業は Flutter アプリ側 UI の実装と iOS/Android への音声ファイル同梱である。

---

## 対象スコープ

| 通知種別 | iOS 音設定 | Android 音設定 |
|----------|-----------|---------------|
| EEW（緊急地震速報） | ○ | △（制限あり、後述） |
| 地震情報 | ○ | △ |
| 津波・一般通知 | 将来対応 | 将来対応 |

---

## 実装タスク一覧

### T1: 通知音ファイルの同梱

**優先度**: High  
**担当**: アプリ側

#### iOS

1. 専用の通知音 WAV ファイルを作成・収集し `app/ios/Runner/Sounds/` に配置
2. Xcode プロジェクト (`Runner.xcodeproj`) の Build Phase → Copy Bundle Resources に追加
3. `FcmServiceExtension` ターゲットにも同じファイルを追加（Extension から参照するため）

```
app/ios/Runner/Sounds/
  eqmonitor_eew_warning.wav     # EEW 警報（最重要、インパクトが大きい音）
  eqmonitor_eew_forecast.wav    # EEW 予報
  eqmonitor_earthquake.wav      # 地震情報
  eqmonitor_default.wav         # 汎用（default の代替）
```

- 形式: WAV, 48kHz, 32-bit（Apple 推奨）
- 長さ: 30 秒以内（APNs 制限）

#### Android

Android の通知チャンネルは **初回作成後にサウンドを変更できない**制約がある。  
対応方針：

- **Phase 1（本実装）**: 重要度ごとに固定音をチャンネルに紐付け（`eew_warning` チャンネルには最大音量の専用 MP3/OGG を設定）
- **Phase 2（将来）**: チャンネルを `_v2` サフィックスで新規作成しサウンド変更に対応

```
app/android/app/src/main/res/raw/
  eqmonitor_eew_warning.mp3
  eqmonitor_eew_forecast.mp3
  eqmonitor_earthquake.mp3
```

---

### T2: Flutter データモデルの拡張

**優先度**: High

#### 2-1. アプリ内サウンド定義モデル

`app/lib/feature/settings/features/notification_sound/` に新規作成：

```dart
// notification_sound.dart
enum NotificationSound {
  systemDefault('default', 'デフォルト'),
  eewWarning('eqmonitor_eew_warning.wav', 'EEW警報'),
  eewForecast('eqmonitor_eew_forecast.wav', 'EEW予報'),
  earthquake('eqmonitor_earthquake.wav', '地震情報'),
  none('none', 'なし');

  const NotificationSound(this.soundFileName, this.label);
  final String soundFileName;
  final String label;
}
```

#### 2-2. EEW / 地震 通知設定モデルへの sound 追加

```dart
// eew_notification_settings.dart（修正）
@freezed
abstract class EewNotificationSettings with _$EewNotificationSettings {
  const factory EewNotificationSettings({
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required String sound,              // 追加: 例 "eqmonitor_eew_warning.wav"
    required String criticalSound,      // 追加: クリティカル通知の音
    required List<NotificationRegion> regions,
  }) = _EewNotificationSettings;
}
```

同様に `EarthquakeNotificationSettings` にも `sound` / `criticalSound` を追加。

---

### T3: バックエンド API 連携の修正

**優先度**: High

#### 3-1. `_toEewApiTiers` / `_toEarthquakeApiTiers` の修正

`device_notification_settings_repository.dart` 内のハードコード `sound: 'default'` を、ユーザー設定値に置き換える：

```dart
List<api.NotificationTiers4> _toEewApiTiers({
  required JmaIntensity? threshold,
  required String normalSound,
  required String criticalSound,
}) {
  final tiers = <api.NotificationTiers4>[];
  // 通常通知ティア（interruption_level: active）
  tiers.add(api.NotificationTiers4(
    minJmaIntensity: api.MinJmaIntensity.value1,
    sound: normalSound,
    interruptionLevel: api.InterruptionLevel.active,
  ));
  // クリティカルティア（設定されている場合）
  if (threshold != null) {
    final apiIntensity = threshold.toApiMinJmaIntensity;
    if (apiIntensity != null) {
      tiers.add(api.NotificationTiers4(
        minJmaIntensity: apiIntensity,
        sound: criticalSound,
        interruptionLevel: api.InterruptionLevel.critical,
      ));
    }
  }
  return tiers;
}
```

#### 3-2. レスポンスからの sound 読み取り

`_eewFromResponse` で `notificationTiers` から `sound` を復元：

```dart
EewNotificationSettings _eewFromResponse(
  api.EewSettingsResponse resp,
  List<NotificationRegion> regions,
) {
  final normalTier = resp.notificationTiers.firstWhereOrNull(
    (t) => t.interruptionLevel == api.InterruptionLevel.active,
  );
  final criticalTier = resp.notificationTiers.firstWhereOrNull(
    (t) => t.interruptionLevel == api.InterruptionLevel.critical,
  );
  return EewNotificationSettings(
    enabled: resp.enabled,
    criticalThreshold: _extractCriticalThresholdFromTiers3(resp.notificationTiers),
    sound: normalTier?.sound ?? 'default',
    criticalSound: criticalTier?.sound ?? 'default',
    regions: regions,
  );
}
```

---

### T4: UI 実装

**優先度**: High

#### 4-1. 通知音選択ウィジェット

`app/lib/feature/settings/features/notification_sound/ui/notification_sound_picker.dart`：

```dart
// 通知音一覧を表示し、選択 + プレビュー再生ができる ListTile ウィジェット
class NotificationSoundPickerTile extends StatelessWidget {
  const NotificationSoundPickerTile({
    super.key,
    required this.label,
    required this.currentSound,
    required this.onChanged,
    this.availableSounds = NotificationSound.values,
  });
  // ...
}
```

機能：
- 現在の選択サウンド名を表示
- タップでボトムシートを開き、サウンド一覧を表示
- 各サウンド項目にはプレビュー再生ボタン（`AudioPlayer` または `just_audio` パッケージ）
- iOS: `~/Library/Sounds/` にある `.wav` ファイルも追加で表示（ユーザーインポート対応は Phase 2）

#### 4-2. EEW 設定ページへの組み込み

`eew_settings_page.dart` に以下のセクションを追加：

```dart
const SettingsSectionHeader(text: '通知音'),
_SoundSection(settings: settings),
```

```dart
class _SoundSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      NotificationSoundPickerTile(
        label: '通常通知音',
        currentSound: settings.sound,
        onChanged: (sound) => /* patchEewSettings */,
      ),
      NotificationSoundPickerTile(
        label: 'クリティカル通知音',
        currentSound: settings.criticalSound,
        onChanged: (sound) => /* patchEewSettings */,
      ),
    ]);
  }
}
```

同様に `earthquake_settings_page.dart` にも追加。

#### 4-3. サウンドのプレビュー再生

- `just_audio` パッケージ（既存依存関係に含まれていれば利用、なければ追加）
- または Flutter 標準の `url_launcher` + `AudioPlayer`
- Bundle 内ファイルへのアクセス: `rootBundle` 経由でアセットを一時ファイルに書き出して再生

---

### T5: iOS Critical Alerts 対応（オプション）

**優先度**: Medium（Apple 審査が必要）

クリティカルアラートは DND（おやすみモード）やサイレントスイッチを無効化して通知音を鳴らす機能。EEW 警報には強く推奨される。

#### 手順

1. Apple Developer Portal で **Critical Alerts Entitlement** を申請
2. `app/ios/Runner/Runner.entitlements` に追加：
   ```xml
   <key>com.apple.developer.usernotifications.critical-alerts</key>
   <true/>
   ```
3. APNs ペイロードの `aps.sound` をオブジェクト形式で送信（バックエンド側対応が必要）：
   ```json
   { "critical": 1, "name": "eqmonitor_eew_warning.wav", "volume": 1.0 }
   ```
4. バックエンドで `interruption_level: critical` のティアを検知した場合、`sound` をオブジェクト形式に変換する処理を追加

---

### T6: Android 通知チャンネルへのサウンド設定

**優先度**: Medium

`app/lib/core/fcm/channels.dart` の `AndroidNotificationChannel` に `sound` を追加：

```dart
AndroidNotificationChannel(
  'eew_warning',
  '緊急地震速報(警報)',
  sound: RawResourceAndroidNotificationSound('eqmonitor_eew_warning'),
  importance: Importance.max,
  // ...
),
```

> **注意**: すでにチャンネルが作成済みのデバイスでは変更が反映されない。  
> 新チャンネル ID（例: `eew_warning_v2`）での移行が必要。移行ロジックを `main.dart` の初期化処理に追加する。

---

## 実装の依存関係と順序

```
T1（音声ファイル同梱）
  ↓
T2（モデル拡張）  →  T3（API 連携修正）
  ↓
T4（UI 実装）
  ↓
T5（Critical Alerts）  ←  Apple 審査が必要（並行して申請）
T6（Android チャンネル）  ← T1 と並行可能
```

---

## 技術的考慮事項

### iOS APNs サウンドの解決ルール

APNs がサウンドを解決する優先順位：
1. `~/Library/Sounds/` 内のファイル（ユーザーインポート）
2. アプリ Bundle 内のファイル（同梱サウンド）
3. システムサウンド

EQMonitor は Bundle 内ファイルで十分（Phase 1）。ユーザーインポートは Phase 2 で対応。

### Android のチャンネル制限

Android 8.0 以降、通知チャンネルの `sound` は **作成時にのみ設定可能**。  
既存ユーザーへの移行には：
- 旧チャンネルを `deleteNotificationChannel` で削除
- 新チャンネルを作成

ただし、ユーザーがチャンネルごとに設定したカスタム設定（バイブ・LED 等）がリセットされる点に注意。

### FCM と APNs の連携

EQMonitor は Firebase Cloud Messaging 経由で APNs に push している。FCM の `notification` オブジェクトではなく、`data` ペイロード経由で配信することで APNs の `aps.sound` を自由に制御できる（EQMonitor はすでにこの方式を採用済み）。

---

## 完了条件

- [ ] T1: iOS/Android に通知音ファイルが同梱されている
- [ ] T2: `EewNotificationSettings` / `EarthquakeNotificationSettings` に `sound` フィールドが追加されている
- [ ] T3: バックエンドへのリクエストで `sound` が正しく送信される
- [ ] T4: EEW / 地震設定ページで通知音の選択・プレビューができる
- [ ] T5: Critical Alerts entitlement が取得済みで EEW 警報に適用されている（オプション）
- [ ] T6: Android 通知チャンネルに専用サウンドが設定されている
- [ ] `dart analyze` がエラーなしで通過する
- [ ] EEW・地震通知設定の UI で選択した音がバックエンドに保存・復元できる
