# 通知音設定 調査レポート

**作成日**: 2026-05-07  
**調査対象**: [home-assistant/iOS](https://github.com/home-assistant/iOS)

---

## 1. Home Assistant iOS の通知音実装

### 1.1 サウンドのカテゴリ

HA iOS では通知音を 3 カテゴリに分類している。

| カテゴリ | 説明 | 保存場所 |
|----------|------|---------|
| **bundled** | アプリに同梱された音声ファイル | `Bundle.main` (`.wav`) |
| **imported** | ユーザーが任意にインポートした音声 | `~/Library/Sounds/*.wav` |
| **system** | iOS システムサウンド (`/System/Library/Audio/UISounds`) | `~/Library/Sounds/*.caf` (コピー後) |

同梱サウンド数は 127 ファイル（Alexa, Assist, Generic, MorganFreeman の 4 ディレクトリ）。

### 1.2 APNs ペイロードにおける `sound` フィールド

Apple Push Notification Service の `aps.sound` は 2 形式をサポートする。

```jsonc
// 通常サウンド（文字列）
{ "aps": { "sound": "custom_sound.wav" } }

// クリティカルアラート（オブジェクト）— DND/サイレントを突破
{ "aps": { "sound": { "critical": 1, "name": "custom.wav", "volume": 0.5 } } }

// サウンドなし
{ "aps": { } }  // "none" を指定するとバックエンドで除去
```

- サウンドファイル名を指定すると `~/Library/Sounds/` または Bundle から検索される。
- `"default"` を指定するとデバイスのデフォルト通知音が鳴る。
- クリティカルアラートは Apple の **Critical Alerts entitlement** が必要。

### 1.3 バックエンド (Push Server) の処理

`NotificationParserLegacy.swift` の該当箇所は以下のとおりである。

```swift
if let sound = data["sound"] {
    aps["sound"] = sound   // data.push.sound をそのまま aps.sound に転送
}
if (aps["sound"] as? String)?.lowercased() == "none" {
    aps["sound"] = nil     // "none" はサウンドなしに変換
}
```

HA の Push Server は `data.push.sound` の値を APNs ペイロードの `aps.sound` にそのまま渡す。クライアント側から送信するのは **ファイル名文字列** または **`{critical, name, volume}` オブジェクト** だけでよい。

### 1.4 Android の通知音

Android では `AndroidNotificationChannel` の `sound` プロパティで通知チャンネルごとにサウンドを指定する。チャンネルは初回作成後は変更不可のため、**チャンネルを分けて作成** するか、チャンネルを削除して再作成する必要がある（ユーザー体験に影響するトレードオフがある）。

### 1.5 NotificationService Extension

HA iOS の Service Extension は特別な処理を行っていない。サウンド指定は APNs ペイロードに依存しており、OS が自動的に処理する。

---

## 2. EQMonitor の現状

### 2.1 通知の種類

- EEW（緊急地震速報）: `eew_warning` / `eew_forecast` チャンネル
- 地震情報: `VXSE51` 〜 `VYSE52` の複数チャンネル
- 揺れ検知: Shake Detection
- 一般: 津波、訓練報

### 2.2 バックエンド API（既存）

`NotificationTiers2` / `NotificationTiers3` / `NotificationTiers4` には、すでに `sound` フィールドが次のように存在する。

```dart
// 例: EewSettingsRequest の notification_tiers[]
{
  "min_jma_intensity": "4",
  "sound": "default",              // ← すでに API 仕様に存在
  "interruption_level": "critical"
}
```

現在の Flutter 実装では `sound: 'default'` とハードコードしており、ユーザーが変更できない。

### 2.3 iOS 通知サービス拡張

`FcmServiceExtension/NotificationService.swift` は現状ほぼ素通しで、サウンドに関する処理は何もしていない。

### 2.4 同梱サウンドファイル

iOS/Android ともに独自の通知音ファイルは**存在しない**。`'default'` のみ使用中。

---

## 3. 参考: HA iOS が採用しているアーキテクチャのまとめ

```
[HA Backend / Home Assistant]
  → data.push.sound = "filename.wav" or {critical:1, name:..., volume:...}
       ↓ Push Server がそのまま APNs に転送
[APNs]
  → aps.sound = "filename.wav"
       ↓ iOS が ~/Library/Sounds/ または Bundle から検索
[デバイス]
  → 音声再生
```

UI 側は次の手順で処理する。
1. ユーザーが利用可能なサウンドの一覧を表示（bundled / imported / system）
2. 選択したファイル名を通知設定としてバックエンドに送信
3. バックエンドが APNs ペイロードの `aps.sound` に埋め込む
