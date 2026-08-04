# Live Activity 仕様書

## 概要

EQMonitorアプリにおけるiOS Live Activity機能の実装仕様を定義します。
Live Activityは、ロック画面やDynamic Islandにリアルタイムな地震情報を表示する機能です。

### 参考ドキュメント

- [live_activities パッケージ (Flutter)](https://pub.dev/packages/live_activities)
- [Apple ActivityKit ドキュメント](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications)

---

## 1. Live Activity開始トリガー

Live Activityは以下の2つのトリガーで開始されます。

### 1.1 揺れ検知（Shake Detection）

| 項目 | 内容 |
|------|------|
| トリガー条件 | ユーザの通知条件を満たす かつ APNs設定でLive Activityが有効 |
| 更新条件 | 揺れの強さ（Level）が変更された場合 |
| 終了条件 | 揺れ検知イベントが終了した場合（最終更新から60秒間新規データなし） |
| 終了タイミング | Live Activity開始時に`stale-date`を設定（開始から10分後）。終了条件を満たしたら`dismissal-date`を送信 |

#### 表示内容 (ShakeDetectionContentState)

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `eventId` | `string` | イベントID（Primary Key） |
| `level` | `ShakeDetectionLevel` | 観測した揺れの強さ |
| `detectedAt` | `ISO8601 string?` | 検知した日時（JSTで表示） |
| `location` | `LocationInfo?` | 現在地情報（現在地で検知された場合） |

#### LocationInfo (揺れ検知用)

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `regionName` | `string` | 現在地の地域名 |
| `intensity` | `number?` | 現在地の揺れの強さ |

```typescript
// ShakeDetectionLevel
type ShakeDetectionLevel =
  | "Weaker"   // 微弱な揺れ
  | "Weak"     // 弱い揺れ (震度1未満)
  | "Medium"   // 揺れ (震度1以上)
  | "Strong"   // 強い揺れ (震度3程度以上)
  | "Stronger" // 非常に強い揺れ (震度5弱程度以上)
```

### 1.2 緊急地震速報（EEW: Earthquake Early Warning）

| 項目 | 内容 |
|------|------|
| トリガー条件 | ユーザの通知条件を満たす かつ APNs設定でLive Activityが有効 |
| 更新条件 | 続報が発表された場合 |
| 終了条件 | 最終報が発表されてから180秒経過 |

#### 表示内容 (EewContentState)

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `eventId` | `string` | イベントID（Primary Key） |
| `serialNo` | `number?` | 報番号 |
| `headline` | `string?` | 見出し（後述のルールで生成） |
| `hypocenterName` | `string?` | 震源地名（キャンセル時はnull） |
| `magnitude` | `number?` | マグニチュード（キャンセル時はnull） |
| `depth` | `number?` | 震源の深さ (km)（キャンセル時はnull） |
| `time` | `ISO8601 string?` | 発生時刻または検知時刻（キャンセル時はnull） |
| `isOriginTime` | `boolean?` | 発生時刻かどうか（falseの場合は検知時刻） |
| `maxIntensity` | `JmaIntensity?` | 予想最大震度（キャンセル時はnull） |
| `isFinal` | `boolean?` | 最終報かどうか |
| `isWarning` | `boolean?` | 警報かどうか |
| `isCanceled` | `boolean?` | キャンセル報かどうか |
| `isPlum` | `boolean?` | PLUM法による検知かどうか |
| `isLevel` | `boolean?` | レベル法による検知かどうか |
| `isOnePoint` | `boolean?` | 1点検知かどうか |
| `location` | `LocationInfo?` | 現在地情報（揺れが予想される場合） |

#### 検知方法フラグ

緊急地震速報には複数の検知方法があり、それぞれ以下のフラグで判定する。

| フラグ | 説明 | 判定条件 |
|--------|------|----------|
| `isPlum` | PLUM法による検知 | `condition === "仮定震源要素"` かつ `originTime`がある |
| `isLevel` | レベル法による検知 | `condition === "仮定震源要素"` かつ `originTime`がない かつ `epicenters[0] === "1"` |
| `isOnePoint` | 1点検知（IPF法1点） | `epicenters[0] === "1"` かつ `condition`がない |

> **Note:** PLUM法・レベル法は仮定震源要素を使用するため、震源位置の精度は低くなります。1点検知は通常のIPF法ですが、観測点が1点のみのため精度は低くなります。これらのフラグはクライアント側で表示内容を調整するために使用します。

#### 時刻フィールド

`time`フィールドには発生時刻（originTime）または検知時刻（arrivalTime）が格納されます。`isOriginTime`フラグでどちらの時刻かを判別します。

| `isOriginTime` | `time`の内容 | 表示例 |
|----------------|-------------|--------|
| `true` | 発生時刻（originTime） | 「16:10:00発生」 |
| `false` | 検知時刻（arrivalTime） | 「16:10:00検知」 |

**時刻の決定ロジック:**

1. `originTime`（発生時刻）がある場合 → `time = originTime`, `isOriginTime = true`
2. `originTime`がない場合 → `time = arrivalTime`, `isOriginTime = false`
3. キャンセル報の場合 → `time = null`, `isOriginTime = false`

> **Note:** PLUM法やレベル法では発生時刻が特定できない場合があります。その場合は検知時刻を使用し、`isOriginTime = false`となります。クライアント側ではこのフラグを参照して「発生」「検知」の表示を切り替えてください。

#### headline生成ルール

`headline`フィールドはサーバ側で以下のルールに従って生成する。

1. 基本文言の決定
   - `hypocenterReduceName`（短縮震源名）がある場合：「{hypocenterReduceName}で地震」
   - ない場合：「地震発生」

2. 強い揺れの追記（警報時のみ）
   - `zones`（警報対象地域）が1件以上ある場合：基本文言 + 「 で強い揺れ」
   - `zones`が0件または存在しない場合：基本文言のみ

例：

- 警報あり（zones > 0）・震源名あり：「能登地方で地震 で強い揺れ」
- 警報なし（zones = 0）・震源名あり：「千葉県東方沖で地震」
- キャンセル報（震源名なし）：「地震発生」

#### LocationInfo (EEW用・揺れが予想される場合)

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `regionName` | `string` | 現在地の地名（細分化地域名） |
| `forecastIntensity` | `JmaIntensity?` | 予想最大震度 |
| `forecastLpgmIntensity` | `JmaLpgmIntensity?` | 予想最大長周期地震動階級 |
| `arrivalTime` | `ISO8601 string?` | 到達予想時刻（nullable） |
| `intensity` | `number?` | 実測震度（EEWでは使用しない、nullで送信） |

> **Note:** 現在地情報はすべてサーバ側で計算します。APNsペイロードサイズ制限（4KB）を考慮し、クライアント側での計算は行いません。ユーザの現在地（regionId）は通知設定から取得します。`LocationInfo`はEEWと揺れ検知で共通の型ですが、EEWでは`forecastIntensity`/`forecastLpgmIntensity`/`arrivalTime`を使用し、揺れ検知では`intensity`を使用します。

---

## 2. アーキテクチャ概要

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              Flutter App                                 │
├─────────────────────────────────────────────────────────────────────────┤
│  1. アプリ起動時: pushToStartTokenを取得                                  │
│  2. pushToStartTokenをサーバに登録 (device_apns_token テーブル)           │
│  3. Live Activity開始後: updateTokenを取得                               │
│  4. updateTokenをサーバに登録 (live_activity_update_token テーブル)       │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                              Backend Server                              │
├─────────────────────────────────────────────────────────────────────────┤
│  1. イベント発生を検知（揺れ検知 / EEW）                                   │
│  2. 対象ユーザを抽出（通知条件 + Live Activity有効）                       │
│  3. pushToStartTokenでLive Activityを開始 (APNs Push)                    │
│  4. updateTokenでLive Activityを更新 (APNs Push)                         │
│  5. 終了条件を満たしたらLive Activityを終了 (APNs Push)                   │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                                 APNs                                     │
├─────────────────────────────────────────────────────────────────────────┤
│  Push通知を受信し、iOSデバイスにLive Activityを表示                       │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 3. データベーススキーマ

### 3.1 device_apns_token

pushToStartトークンを含むAPNsトークンを管理します。

```sql
CREATE TYPE device_apns_token_type AS ENUM (
  'NOTIFICATION',        -- 通常のプッシュ通知用トークン
  'LIVE_ACTIVITY_START'  -- Live Activity開始用トークン (pushToStart)
);

CREATE TABLE device_apns_token (
  device_id VARCHAR(128) NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
  type device_apns_token_type NOT NULL,
  token TEXT NOT NULL UNIQUE,
  PRIMARY KEY (device_id, type)
);

CREATE INDEX device_apns_token_token_idx ON device_apns_token (token);
```

### 3.2 earthquake_event_link

揺れ検知、EEW、地震情報を紐付けるテーブルです。

```sql
CREATE TABLE earthquake_event_link (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shake_detection_event_ids UUID[] NOT NULL DEFAULT '{}',
  eew_event_id DECIMAL(14),
  earthquake_event_id DECIMAL(14),
  started_at TIMESTAMPTZ NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 3.3 live_activity_update_token

Live ActivityのUpdate Tokenを管理します。アプリからLive Activity開始後にupdateTokenを受け取り、以降の更新・終了に使用します。

```sql
CREATE TABLE live_activity_update_token (
  device_id VARCHAR(128) NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
  live_activity_id VARCHAR(128) NOT NULL,  -- iOS側で生成されるLive ActivityのID
  token TEXT NOT NULL,
  event_id VARCHAR(64) NOT NULL,           -- 紐づくイベントID（EEW eventId または 揺れ検知 eventId）
  start_trigger live_activity_start_trigger NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (device_id, live_activity_id)
);

CREATE INDEX live_activity_update_token_event_id_idx
  ON live_activity_update_token (event_id);
CREATE INDEX live_activity_update_token_token_idx
  ON live_activity_update_token (token);
```

### 3.4 live_activity_session（参考：イベント紐付け管理用）

揺れ検知/EEW/地震情報を紐付けてLive Activityのライフサイクルを管理します。

```sql
CREATE TYPE live_activity_start_trigger AS ENUM (
  'shake_detection',
  'eew'
);

CREATE TYPE live_activity_status AS ENUM (
  'active',
  'ended',
  'expired',
  'dismissed'
);

CREATE TABLE live_activity_session (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  device_id VARCHAR(128) NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
  earthquake_event_link_id UUID NOT NULL REFERENCES earthquake_event_link(id) ON DELETE CASCADE,
  update_token TEXT NOT NULL,
  status live_activity_status NOT NULL DEFAULT 'active',
  start_trigger live_activity_start_trigger NOT NULL,
  last_update_sent_at TIMESTAMPTZ,
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX live_activity_session_device_id_idx ON live_activity_session (device_id);
CREATE INDEX live_activity_session_status_idx ON live_activity_session (status);
CREATE INDEX live_activity_session_device_status_idx ON live_activity_session (device_id, status);
```

### 3.4 device_notification_settings

Live Activity有効/無効設定を含む全般通知設定です。

```sql
CREATE TABLE device_notification_settings (
  device_id VARCHAR(128) PRIMARY KEY REFERENCES devices(id) ON DELETE CASCADE,
  tsunami_enabled BOOLEAN NOT NULL DEFAULT true,
  training_enabled BOOLEAN NOT NULL DEFAULT false,
  shake_detection_live_activity_enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 3.5 device_eew_settings

EEW通知設定（Live Activity開始設定を含む）です。

```sql
CREATE TABLE device_eew_settings (
  device_id VARCHAR(128) PRIMARY KEY REFERENCES devices(id) ON DELETE CASCADE,
  enabled BOOLEAN NOT NULL DEFAULT true,
  override_silent_mode BOOLEAN NOT NULL DEFAULT false,
  sound_mode intensity_sound_mode NOT NULL DEFAULT 'max_intensity',
  sound_map JSONB,
  start_live_activity BOOLEAN NOT NULL DEFAULT true,  -- Live Activity開始設定
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

## 4. API仕様

### 4.1 pushToStartトークン登録

Live Activity開始用のpushToStartトークンをサーバに登録します。

**Endpoint:** `PUT /api/v1/devices/{deviceId}/apns-token`

**Request Body:**

```json
{
  "type": "LIVE_ACTIVITY_START",
  "token": "pushToStartToken..."
}
```

**Response:** `204 No Content`

### 4.2 Live Activity updateToken登録

Live Activity開始後、アプリからupdateTokenをサーバに登録します。

**Endpoint:** `PUT /api/v1/devices/{deviceId}/live-activity/{liveActivityId}/token`

**Request Body:**

```json
{
  "token": "updateToken...",
  "eventId": "20240101123456",
  "startTrigger": "shake_detection" | "eew"
}
```

**Response:** `204 No Content`

### 4.3 Live Activity updateToken削除

Live Activityが終了した場合、アプリからサーバにトークン削除を通知します。

**Endpoint:** `DELETE /api/v1/devices/{deviceId}/live-activity/{liveActivityId}/token`

**Response:** `204 No Content`

### 4.4 デバイスのアクティブなLive Activity一覧取得

**Endpoint:** `GET /api/v1/devices/{deviceId}/live-activity`

**Response:**

```json
{
  "liveActivities": [
    {
      "liveActivityId": "ios-live-activity-id",
      "eventId": "20240101123456",
      "startTrigger": "eew",
      "createdAt": "2024-01-01T16:10:00+09:00"
    }
  ]
}
```

---

## 5. APNs Push Notification Payload

EEWと揺れ検知では異なる`attributes-type`を使用します。

| Live Activityの種類 | attributes-type | content-stateの型 |
|---------------------|-----------------|------------------|
| EEW | `EewLiveActivityAttributes` | `EewContentState` |
| 揺れ検知 | `ShakeDetectionLiveActivityAttributes` | `ShakeDetectionContentState` |

### 5.1 EEW Live Activity開始 (Push-to-Start)

```json
{
  "aps": {
    "timestamp": 1704067200,
    "stale-date": 1704069000,
    "event": "start",
    "content-state": {
      "eventId": "20240101123456",
      "headline": "能登地方で地震 で強い揺れ",
      "hypocenterName": "石川県能登地方",
      "magnitude": 7.6,
      "depth": 16,
      "time": "2024-01-01T16:10:00+09:00",
      "isOriginTime": true,
      "maxIntensity": "7",
      "serialNo": 1,
      "isFinal": false,
      "isWarning": true,
      "isCanceled": false,
      "isPlum": false,
      "isLevel": false,
      "isOnePoint": false,
      "location": {
        "regionName": "東京都23区",
        "forecastIntensity": "4",
        "forecastLpgmIntensity": "2",
        "arrivalTime": "2024-01-01T16:12:30+09:00",
        "intensity": null
      }
    },
    "attributes-type": "EewLiveActivityAttributes",
    "attributes": {
      "id": "959D7057-505A-4DDA-B14A-D72F96DF9F6F",
      "eventId": "20240101123456"
    },
    "alert": {
      "title": "緊急地震速報（警報）",
      "body": "石川県能登地方 M7.6 最大震度7"
    }
  }
}
```

### 5.2 EEW Live Activity更新

```json
{
  "aps": {
    "timestamp": 1704067260,
    "stale-date": 1704067860,
    "event": "update",
    "content-state": {
      "eventId": "20240101123456",
      "headline": "能登地方で地震 で強い揺れ",
      "hypocenterName": "石川県能登地方",
      "magnitude": 7.6,
      "depth": 16,
      "time": "2024-01-01T16:10:00+09:00",
      "isOriginTime": true,
      "maxIntensity": "7",
      "serialNo": 5,
      "isFinal": false,
      "isWarning": true,
      "isCanceled": false,
      "isPlum": false,
      "isLevel": false,
      "isOnePoint": false,
      "location": {
        "regionName": "東京都23区",
        "forecastIntensity": "5-",
        "forecastLpgmIntensity": "3",
        "arrivalTime": "2024-01-01T16:12:30+09:00",
        "intensity": null
      }
    },
    "alert": {
      "title": "緊急地震速報（警報）第5報",
      "body": "石川県能登地方 M7.6 最大震度7"
    }
  }
}
```

### 5.3 EEW Live Activity終了

```json
{
  "aps": {
    "timestamp": 1704067800,
    "event": "end",
    "dismissal-date": 1704067800,
    "content-state": {
      "eventId": "20240101123456",
      "headline": "能登地方で地震 で強い揺れ",
      "hypocenterName": "石川県能登地方",
      "magnitude": 7.6,
      "depth": 16,
      "time": "2024-01-01T16:10:00+09:00",
      "isOriginTime": true,
      "maxIntensity": "7",
      "serialNo": 10,
      "isFinal": true,
      "isWarning": true,
      "isCanceled": false,
      "isPlum": false,
      "isLevel": false,
      "isOnePoint": false,
      "location": null
    }
  }
}
```

### 5.4 EEW Live Activityキャンセル

緊急地震速報がキャンセルされた場合のペイロードです。`isCanceled`が`true`となり、震源情報などがnullになります。

```json
{
  "aps": {
    "timestamp": 1704067800,
    "event": "end",
    "dismissal-date": 1704067800,
    "content-state": {
      "eventId": "20240101123456",
      "headline": "地震発生",
      "hypocenterName": null,
      "magnitude": null,
      "depth": null,
      "time": null,
      "isOriginTime": false,
      "maxIntensity": null,
      "serialNo": 2,
      "isFinal": true,
      "isWarning": false,
      "isCanceled": true,
      "isPlum": false,
      "isLevel": false,
      "isOnePoint": false,
      "location": null
    }
  }
}
```

### 5.5 揺れ検知 Live Activity開始 (Push-to-Start)

```json
{
  "aps": {
    "timestamp": 1704067200,
    "stale-date": 1704067800,
    "event": "start",
    "content-state": {
      "eventId": "shake-event-uuid",
      "level": "Strong",
      "detectedAt": "2024-01-01T16:10:00+09:00",
      "location": {
        "regionName": "東京都23区",
        "forecastIntensity": null,
        "forecastLpgmIntensity": null,
        "arrivalTime": null,
        "intensity": 3.2
      }
    },
    "attributes-type": "ShakeDetectionLiveActivityAttributes",
    "attributes": {
      "id": "A1B2C3D4-E5F6-7890-ABCD-EF1234567890",
      "eventId": "shake-event-uuid"
    },
    "alert": {
      "title": "揺れを検知しました",
      "body": "強い揺れ - 東京都23区"
    }
  }
}
```

### 5.6 揺れ検知 Live Activity更新

```json
{
  "aps": {
    "timestamp": 1704067260,
    "stale-date": 1704067560,
    "event": "update",
    "content-state": {
      "eventId": "shake-event-uuid",
      "level": "Stronger",
      "detectedAt": "2024-01-01T16:10:00+09:00",
      "location": {
        "regionName": "東京都23区",
        "forecastIntensity": null,
        "forecastLpgmIntensity": null,
        "arrivalTime": null,
        "intensity": 4.5
      }
    },
    "alert": {
      "title": "揺れの強さが変化しました",
      "body": "非常に強い揺れ - 東京都23区"
    }
  }
}
```

### 5.7 揺れ検知 Live Activity終了

```json
{
  "aps": {
    "timestamp": 1704067800,
    "event": "end",
    "dismissal-date": 1704067800,
    "content-state": {
      "eventId": "shake-event-uuid",
      "level": "Strong",
      "detectedAt": "2024-01-01T16:10:00+09:00",
      "location": {
        "regionName": "東京都23区",
        "forecastIntensity": null,
        "forecastLpgmIntensity": null,
        "arrivalTime": null,
        "intensity": 3.2
      }
    }
  }
}
```

---

## 6. シーケンス図

### 6.1 初期設定フロー

```
┌──────┐          ┌──────────┐          ┌────────┐
│ App  │          │  Server  │          │  APNs  │
└──┬───┘          └────┬─────┘          └───┬────┘
   │                   │                    │
   │  1. アプリ起動     │                    │
   │──────────────────>│                    │
   │                   │                    │
   │  2. pushToStartToken取得               │
   │<──────────────────────────────────────│
   │                   │                    │
   │  3. PUT /devices/{id}/apns-token      │
   │──────────────────>│                    │
   │                   │                    │
   │  4. 204 No Content│                    │
   │<──────────────────│                    │
   │                   │                    │
```

### 6.2 Live Activity開始〜更新〜終了フロー

```
┌──────┐          ┌──────────┐          ┌────────┐          ┌─────────┐
│ App  │          │  Server  │          │  APNs  │          │  iOS    │
└──┬───┘          └────┬─────┘          └───┬────┘          └────┬────┘
   │                   │                    │                    │
   │  1. イベント発生（EEW/揺れ検知）         │                    │
   │                   │                    │                    │
   │                   │  2. Push-to-Start  │                    │
   │                   │───────────────────>│                    │
   │                   │                    │                    │
   │                   │                    │  3. Live Activity開始
   │                   │                    │───────────────────>│
   │                   │                    │                    │
   │  4. updateToken取得                     │                    │
   │<────────────────────────────────────────────────────────────│
   │                   │                    │                    │
   │  5. PUT /devices/{id}/live-activity/{id}/token              │
   │──────────────────>│                    │                    │
   │                   │                    │                    │
   │  6. 204 No Content│                    │                    │
   │<──────────────────│                    │                    │
   │                   │                    │                    │
   │  7. 更新イベント発生                    │                    │
   │                   │                    │                    │
   │                   │  8. Update Push    │                    │
   │                   │───────────────────>│                    │
   │                   │                    │                    │
   │                   │                    │  9. Live Activity更新
   │                   │                    │───────────────────>│
   │                   │                    │                    │
   │  10. 終了条件を満たす                   │                    │
   │                   │                    │                    │
   │                   │  11. End Push      │                    │
   │                   │───────────────────>│                    │
   │                   │                    │                    │
   │                   │                    │  12. Live Activity終了
   │                   │                    │───────────────────>│
   │                   │                    │                    │
```

---

## 7. アプリ側実装

### 7.1 必要なFlutter依存関係

```yaml
dependencies:
  live_activities: ^2.4.3
```

### 7.2 初期化

```dart
final liveActivities = LiveActivities();

Future<void> initialize() async {
  await liveActivities.init(
    appGroupId: 'group.net.yumnumm.eqmonitor',
    urlScheme: 'eqmonitor',
  );

  // pushToStartトークンの監視
  liveActivities.pushToStartTokenUpdateStream.listen((token) {
    // サーバにトークンを登録
    await _registerPushToStartToken(token);
  });

  // Live Activity更新の監視
  liveActivities.activityUpdateStream.listen((event) {
    event.map(
      active: (activity) {
        // updateTokenをサーバに登録
        await _registerUpdateToken(
          activityId: activity.activityId,
          updateToken: activity.activityToken,
        );
      },
      ended: (activity) {
        // セッション終了を通知
        await _notifySessionEnded(activity.activityId);
      },
      unknown: (_) {},
    );
  });
}
```

### 7.3 iOS Widget Extension

Widget Extension内でLive Activity用のAttributesを定義します。**EEWと揺れ検知で別々のAttributesを使用します。**

#### attributes-typeの指定

APNsペイロードの`attributes-type`フィールドで、使用するAttributesを次のように指定する。

| Live Activityの種類 | attributes-type |
|---------------------|-----------------|
| EEW | `EewLiveActivityAttributes` |
| 揺れ検知 | `ShakeDetectionLiveActivityAttributes` |

#### EEW用 (EewLiveActivityAttributes)

```swift
import ActivityKit
import SwiftUI

struct EewLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = EewContentState
    public var id = UUID()
    let eventId: String
}

struct EewContentState: Codable, Hashable {
    let eventId: String
    let hypocenterName: String?
    let magnitude: Double?
    let depth: Int?
    let time: String?
    let isOriginTime: Bool?
    let maxIntensity: String?
    let serialNo: Int?
    let isFinal: Bool?
    let isWarning: Bool?
    let isCanceled: Bool?
    let headline: String?
    let isPlum: Bool?
    let isLevel: Bool?
    let isOnePoint: Bool?
    let location: LocationInfo?

    // Computed Properties
    var intensityValue: IntensityValue? {
        guard let maxIntensity = maxIntensity else { return nil }
        return IntensityValue(rawValue: maxIntensity)
    }

    var timeDate: Date? {
        guard let time = time else { return nil }
        return ISO8601DateFormatter().date(from: time)
    }

    var timeLabel: String {
        (isOriginTime ?? true) ? "地震発生" : "地震検知"
    }
}
```

#### 揺れ検知用 (ShakeDetectionLiveActivityAttributes)

```swift
import ActivityKit
import SwiftUI

struct ShakeDetectionLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = ShakeDetectionContentState
    public var id = UUID()
    let eventId: String
}

struct ShakeDetectionContentState: Codable, Hashable {
    let eventId: String
    let level: String?
    let detectedAt: String?
    let location: LocationInfo?

    // Computed Properties
    var shakeLevel: ShakeDetectionLevel? {
        guard let level = level else { return nil }
        return ShakeDetectionLevel(rawValue: level)
    }

    var detectedDate: Date? {
        guard let detectedAt = detectedAt else { return nil }
        return ISO8601DateFormatter().date(from: detectedAt)
    }
}

enum ShakeDetectionLevel: String, Codable, CaseIterable {
    case weaker = "Weaker"
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
    case stronger = "Stronger"

    var displayString: String {
        switch self {
        case .weaker: return "微弱な揺れ"
        case .weak: return "弱い揺れ"
        case .medium: return "揺れ"
        case .strong: return "強い揺れ"
        case .stronger: return "非常に強い揺れ"
        }
    }
}
```

#### 共通型 (LocationInfo)

EEWと揺れ検知で共通のLocationInfo型を使用します。用途に応じて使用するフィールドが異なります。

```swift
struct LocationInfo: Codable, Hashable {
    let regionName: String
    let forecastIntensity: String?    // EEW用: 予想震度
    let forecastLpgmIntensity: String? // EEW用: 予想長周期地震動階級
    let arrivalTime: String?           // EEW用: 到達予想時刻
    let intensity: Double?             // 揺れ検知用: 実測震度

    // Computed Properties
    var forecastIntensityValue: IntensityValue? {
        guard let forecastIntensity = forecastIntensity else { return nil }
        return IntensityValue(rawValue: forecastIntensity)
    }

    var arrivalDate: Date? {
        guard let arrivalTime = arrivalTime else { return nil }
        return ISO8601DateFormatter().date(from: arrivalTime)
    }
}
```

| フィールド | EEWでの使用 | 揺れ検知での使用 |
|-----------|------------|-----------------|
| `regionName` | ✅ 使用 | ✅ 使用 |
| `forecastIntensity` | ✅ 使用 | ❌ null |
| `forecastLpgmIntensity` | ✅ 使用 | ❌ null |
| `arrivalTime` | ✅ 使用 | ❌ null |
| `intensity` | ❌ null | ✅ 使用 |

> **Important:** 各Attributesは`Identifiable`プロトコルに準拠しているため、APNs Push-to-Startのペイロードの`attributes`オブジェクトには`id`フィールド（UUID文字列）を含める必要があります。サーバー側でUUIDを生成して送信します。

---

## 8. サーバ側実装

### 8.1 対象ユーザ抽出ロジック

#### 揺れ検知の場合

```sql
SELECT dat.token, d.id as device_id
FROM device_apns_token dat
JOIN devices d ON d.id = dat.device_id
JOIN device_notification_settings dns ON dns.device_id = d.id
JOIN device_shake_detection_settings dsds ON dsds.device_id = d.id
WHERE dat.type = 'LIVE_ACTIVITY_START'
  AND dns.shake_detection_live_activity_enabled = true
  AND (
    dsds.sub_region_id IS NULL  -- すべての揺れ検知を通知
    OR dsds.sub_region_id = :detected_sub_region_id
  )
  AND :event_level >= dsds.min_level;
```

#### EEWの場合

```sql
SELECT dat.token, d.id as device_id
FROM device_apns_token dat
JOIN devices d ON d.id = dat.device_id
JOIN device_eew_settings des ON des.device_id = d.id
JOIN device_eew_notification_setting dens ON dens.device_id = d.id
WHERE dat.type = 'LIVE_ACTIVITY_START'
  AND des.enabled = true
  AND des.start_live_activity = true
  AND :max_intensity >= dens.min_jma_intensity
  AND (
    dens.region_id = 0  -- すべての地域
    OR dens.region_id = :affected_region_id
  );
```

### 8.2 APNs送信

```typescript
import * as apn from 'apn';

const provider = new apn.Provider({
  token: {
    key: 'path/to/AuthKey.p8',
    keyId: 'KEY_ID',
    teamId: 'TEAM_ID',
  },
  production: true,
});

async function sendLiveActivityStart(
  pushToStartToken: string,
  payload: LiveActivityPayload,
): Promise<void> {
  const notification = new apn.Notification();
  notification.topic = 'net.yumnumm.eqmonitor.push-type.liveactivity';
  notification.pushType = 'liveactivity';
  notification.priority = 10;
  notification.payload = payload;

  await provider.send(notification, pushToStartToken);
}

async function sendLiveActivityUpdate(
  updateToken: string,
  payload: LiveActivityPayload,
): Promise<void> {
  const notification = new apn.Notification();
  notification.topic = 'net.yumnumm.eqmonitor.push-type.liveactivity';
  notification.pushType = 'liveactivity';
  notification.priority = 10;
  notification.payload = payload;

  await provider.send(notification, updateToken);
}
```

---

## 9. 終了条件とタイミング

### 9.1 stale-dateとdismissal-dateについて

| パラメータ | 説明 |
|-----------|------|
| `stale-date` | Live Activity開始時に設定。この時刻を過ぎると「古い情報」として扱われる |
| `dismissal-date` | Live Activity終了時に設定。この時刻にLive Activityが画面から削除される |

### 9.2 揺れ検知

| イベント | stale-date | dismissal-date |
|---------|------------|----------------|
| 開始時 | 開始から10分後 | - |
| 更新時 | 更新から5分後に延長 | - |
| 終了時（イベント終了） | - | 即時（現在時刻） |
| 終了時（タイムアウト） | - | 最終更新から60秒後 |

**イベント終了判定:** 最終更新から60秒間新規データがない場合

### 9.3 緊急地震速報

| イベント | stale-date | dismissal-date |
|---------|------------|----------------|
| 開始時 | 開始から30分後 | - |
| 更新時 | 更新から10分後に延長 | - |
| 終了時（最終報発表） | - | 最終報発表から180秒後 |
| 終了時（地震情報とリンク） | - | 地震情報発表から120秒後 |
| 終了時（タイムアウト） | - | 最終更新から30分後 |

---

## 10. エラーハンドリング

### 10.1 トークン無効時

APNsから`InvalidProviderToken`や`Unregistered`エラーを受信した場合：

1. `device_apns_token`からトークンを削除
2. `live_activity_session`のステータスを`expired`に更新

### 10.2 セッション重複時

同一デバイスで同一イベントに対して複数のセッションが作成されようとした場合：

1. 既存のセッションを使用
2. 新しいupdateTokenで既存セッションを更新

---

## 11. 制限事項

- iOS 16.1以上が必要
- Live Activityは1デバイスあたり最大5つまで同時に表示可能
- 画像サイズは4KB以下
- Live Activityの最大持続時間は8時間

---

## 12. 今後の拡張予定

- [ ] 地震情報発表時のLive Activity開始
- [ ] 津波警報/注意報のLive Activity対応
