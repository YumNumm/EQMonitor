# Live Activity 実装レビュー

> このドキュメントは 2026-04-30 時点のコードを読んだ実装レビュー結果です。
> 設計仕様書（正式版）は [`backend/docs/live-activity-specification.md`](../backend/docs/live-activity-specification.md) および
> [`backend/docs/apns-live-activity-broadcast.md`](../backend/docs/apns-live-activity-broadcast.md) を参照してください。

---

## 1. 全体アーキテクチャ（現在の実装）

```text
┌─────────────────────────────────────────────────────────────────┐
│                     iOS App (Flutter)                            │
│                                                                  │
│  EQMLiveActivityUtil (Swift/ActivityKit FFI)                     │
│  ├─ pushToStartToken()         ─→ DeviceRepository              │
│  │    └─ ActivityKit static token (iOS 17.2+)                   │
│  ├─ observeEewActivityPushTokenUpdates()  ─→ Riverpod stream    │
│  └─ observeShakeDetectionActivityPushTokenUpdates()             │
│                                                                  │
│  liveActivityTokenSyncWiring (起動時に listen 開始)              │
│  └─ token 更新 → PUT /v2/device/{id}/live-activity/{laId}/token │
└───────────────────────────────────┬─────────────────────────────┘
                                    │ HTTPS
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                     API (Hono/Node.js)                           │
│                                                                  │
│  PATCH /v2/device/{id}/apns/liveActivityStart                   │
│    └─ pushToStartToken を device_apns_token テーブルに保存        │
│                                                                  │
│  PUT /v2/device/{id}/live-activity/{laId}/token                 │
│    1. live_activity_update_token.token を UPDATE                 │
│    2. Valkey HSET la:update:{eventId} {deviceId}:{laId} {token} │
└────────────┬────────────────────────────────────────────────────┘
             │ PostgreSQL / Valkey
             ▼
┌─────────────────────────────────────────────────────────────────┐
│              notification-resolver (Node.js)                     │
│                                                                  │
│  Redis Streams consumer ← EVENTS / SHAKE_DETECTION_EVENTS       │
│                                                                  │
│  EEW (EventMessage):                                             │
│    serialNo == 1 → pushToStartToken で start 送信               │
│    serialNo  > 1 → broadcast channel へ update 送信             │
│    最終報/キャンセル → 3分後に broadcast channel へ end 送信      │
│                                                                  │
│  揺れ検知 (ShakeDetectedPayload):                                │
│    初回通知 → pushToStartToken で start 送信                     │
│    更新     → shake.all チャンネルへ broadcast update            │
│    終了     → 2分後に shake.all チャンネルへ broadcast end       │
│                                                                  │
│  → Redis Streams (APNS_NOTIFICATIONS / LIVE_ACTIVITY_BROADCASTS)│
└────────────┬────────────────────────────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────────────────────────────┐
│              notification-sender (Go)                            │
│  → APNs へ Live Activity push を送信                             │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. 初回 Live Activity 開始フロー

### 2.1 pushToStartToken の登録（アプリ起動時）

| ステップ | 処理 | 実装箇所 |
| -------- | ---- | -------- |
| 1 | `EQMLiveActivityUtil.pushToStartToken()` で ActivityKit から静的トークン取得 | `packages/live_activity_util/ios/.../EQMLiveActivityUtil.swift:11` |
| 2 | `observePushToStartTokenUpdates()` でトークン変化を監視 | 同上 :22 |
| 3 | Flutter 側 `notificationTokenStreamProvider` がトークンを収集 | `app/lib/feature/settings/features/notification/data/provider/notification_token_stream.dart` |
| 4 | `DeviceRepository.syncPushTokens()` が `PATCH /v2/device/{id}/apns/liveActivityStart` を呼び出し | `app/lib/feature/devices/data/repository/device_repository.dart:182` |

> **注意**: `EQMLiveActivityUtil` は `Activity<MockLiveActivityAttributes>` からトークンを取得しているが、APNs Push-to-Start トークンは App 単位で共通なためこれで正しく動作する。

### 2.2 EEW serialNo==1 受信時（バックエンド）

```text
Valkey EVENTS stream
  └─ parseEventMessage → handleEventMessage
       ├─ EEW更新条件チェック (checkEewUpdateCondition)
       ├─ getMatchedDevices (PostgreSQL)
       └─ generateNotificationMessages
            ├─ shouldStartLiveActivity = true (serialNo==1)
            ├─ buildEewLiveActivityContentState()
            ├─ liveActivityId = crypto.randomUUID()
            ├─ inputPushChannel = channelSyncService.getApnsChannelId(
            │    `eew.region.{matchedRegion.regionId}`, environment)
            ├─ buildApnsLiveActivityStartMessage(pushToStartToken, ...)
            │    payload.aps.event = "start"
            │    payload.aps["attributes-type"] = "EewLiveActivityAttributes"
            │    payload.aps.attributes = { id: liveActivityId, eventId }
            │    header["input-push-channel"] = inputPushChannel (APNs UUID)
            └─ liveActivityTokenRepository.createLiveActivityTokens()
                 └─ live_activity_update_token に token='' で INSERT
```

APNs start を受信した iOS デバイスは、`input-push-channel` ヘッダーで指定されたチャンネルを自動購読する（iOS 18+ Broadcast）。`apns-channel-id` は update/end の Broadcast 送信時に使うヘッダーであり、start 時の購読指定には使わない。

### 2.3 揺れ検知初回通知時

```text
Valkey SHAKE_DETECTION_EVENTS stream
  └─ parseShakeStreamPayload → handleShakeDetectionEvent
       ├─ EEWとの相関チェック (correlationService.tryCorrelateShake)
       │    └─ 相関あり → DBに記録のみ、通知スキップ
       ├─ getShakeDetectionMatchedDevices
       ├─ shouldNotifyShakeDetection (lastLevel==null → 初回)
       └─ buildApnsLiveActivityStartMessage(pushToStartToken,
              inputPushChannel: 'shake.all',   ← ※バグ: APNs UUID ではない
              contentState: { level, eventId })
```

---

## 3. Update Token のやりとり

### 3.1 クライアント → サーバ

Live Activity が開始されると iOS は `pushTokenUpdates` async sequence を通じて update token を発行する。

```swift
// EQMLiveActivityUtil.observeEewActivityPushTokenUpdates
for await activity in Activity<EewLiveActivityAttributes>.activityUpdates {
  for await tokenData in activity.pushTokenUpdates {
    onUpdate(activity.id, hexToken)
  }
}
```

この callback は Riverpod の `liveActivityPushTokenUpdatesProvider` (Stream) に流れ、
`liveActivityTokenSyncWiring` が `ref.listen` で受信し、`DeviceRepository.syncLiveActivityUpdateToken` を呼ぶ。

```http
PUT /v2/device/{deviceId}/live-activity/{liveActivityId}/token
Body: { "token": "hexUpdateToken..." }
```

API 側 (`backend/api/api/src/features/device/routes/live-activity.ts`) の処理:

1. `datasource.getLiveActivityToken(deviceId, liveActivityId)` で存在確認
2. `datasource.updateLiveActivityToken(...)` で `live_activity_update_token.token` を UPDATE
3. Valkey に `HSET la:update:{eventId}` `{deviceId}:{liveActivityId}` `{token}` を書き込む（TTL 30分）

### 3.2 サーバ側での更新報処理（update token は未使用）

**重要**: serialNo > 1 のEEW更新・揺れ検知更新では、update token は使わず APNs Broadcast チャンネルを使用する。

```text
DB の live_activity_update_token テーブル
  → 書き込まれるが、notification-resolver からは一切読まれない

Valkey の la:update:{eventId} ハッシュ
  → API から書き込まれるが、notification-resolver からは一切読まれない

getDevicesWithUpdateToken() / getUpdateTokensForDevices() などの
LiveActivityTokenRepository のメソッド群も呼び出し元が存在しない
```

この設計は `backend/docs/apns-live-activity-broadcast.md` に記載された通り、
iOS 18 以降の Broadcast 方式では update token が不要になるため意図的な状態と思われる。
ただし **update token 登録 API とテーブルが廃止されていないまま残っている**点は整理が必要。

---

## 4. Valkey（Redis）とのやりとり

| キー | 用途 | 書き込み元 | 読み取り元 |
| ---- | ---- | ---------- | ---------- |
| `notified:{eventId}` | EEW 通知済みデバイスID集合 (SET, TTL 24h) | notification-resolver | notification-resolver |
| `shake:level:{eventId}:{deviceId}` | 揺れ検知最終通知レベル (STRING, TTL 1h) | notification-resolver | notification-resolver |
| `la:update:{eventId}` | Live Activity update token (HASH, TTL 30min) | API endpoint | **未使用** |
| Redis Streams `events` | EEW/地震情報イベント | dmdata-websocket-proxy | notification-resolver |
| Redis Streams `shake-detection-events` | 揺れ検知イベント | dmdata-websocket-proxy | notification-resolver |
| Redis Streams `apns-notifications` | 個別 APNs 送信キュー | notification-resolver | notification-sender (Go) |
| Redis Streams `live-activity-broadcasts` | Broadcast APNs 送信キュー | notification-resolver | notification-sender (Go) |

---

## 5. 更新報の処理

### 5.1 EEW 更新報 (serialNo > 1)

```typescript
// index.ts generateNotificationMessages()
const shouldUpdateLiveActivity = event.type === 'EEW' && event.serialNo > 1;

if (shouldUpdateLiveActivity && contentState && channelSyncService) {
  const isEnding = event.isLastInfo || event.isCancel;

  if (isEnding) {
    // 最終報/キャンセル: 3分後に end を遅延送信 (LiveActivityEndScheduler)
    endScheduler.scheduleEewEnd(async () => {
      // for each channel:
      buildApnsBroadcastMessageFn({ event: 'end' /* ... */ });
    }, event.eventId, 3 * 60 * 1000);
  } else {
    // 通常 update: 即時 broadcast
    // for each channel in (event.regions ∪ 'eew.region.0'):
    broadcastMessages.push(buildApnsBroadcastMessageFn({ event: 'update' /* ... */ }));
  }
}
```

EEW の更新は APNs Broadcast によりチャンネルを購読しているすべてのデバイスへ届く。
最終報後 3 分間は端末が update token を登録できる猶予として残す設計。

現状の EEW 更新・終了ブロードキャストは `production` 環境のチャンネルだけを解決し、`buildApnsBroadcastMessageFn` にも `environment: 'production'` を渡している。start はデバイスごとの `device.apnsEnvironment` を使うため、sandbox 端末では Live Activity が開始されても update/end が届かない可能性がある。

### 5.2 揺れ検知 更新

```typescript
// index.ts handleShakeDetectionEvent()
// broadcast update to shake channels (iOS 18+)
const shakeChannels = new Set(['shake.all']);
for (const ch of shakeChannels) {
  buildApnsBroadcastMessageFn({
    eqmonitorChannelId: ch,
    apnsChannelId: ch,   // ← ※バグ: APNs UUID ではない
    event: 'update', /* ... */
  });
}

// 2 分後に end を遅延送信
endScheduler.scheduleShakeEnd(/* ... */, payload.eventId, 2 * 60 * 1000);
```

### 5.3 contentState の構築

EEW の contentState は `buildEewLiveActivityContentState(event, jaTranslator)` で生成される。
揺れ検知の contentState は `{ level: payload.level, eventId: payload.eventId }` のシンプルな形式。

---

## 6. 実装上の問題点

### 🔴 バグ: 揺れ検知 Live Activity の APNs チャンネル ID が未解決

**場所**: `backend/service/notification-resolver/src/index.ts:1144, 1158-1178`

EEW では `channelSyncService.getApnsChannelId('eew.region.{code}', env)` を呼び出して
APNs が発行した UUID を取得しているが、揺れ検知では文字列 `'shake.all'` をそのまま
`inputPushChannel` および `apnsChannelId` に使用している。

```typescript
// 誤った実装（現在）
inputPushChannel: `shake.all`,  // NG: eqmonitor channel ID をそのまま使用

// 正しい実装
inputPushChannel: channelSyncService.getApnsChannelId('shake.all', device.apnsEnvironment ?? 'production'),
```

`apns-channel-id` ヘッダーには APNs が発行した UUID を設定する必要がある。
`'shake.all'` では APNs 側で channel が見つからず push が失敗する。
broadcast update/end も同様に `apnsChannelId: 'shake.all'` としており、Broadcast 配信も機能しない。

**修正方針**: push-to-start および broadcast 送信の両方で `channelSyncService.getApnsChannelId('shake.all', env)` を使うよう修正する。

### 🟡 整理不足: update token の書き込みは残っているが読み取りは削除済み

`live_activity_update_token` テーブルおよび Valkey の `la:update:*` キーは、
Broadcast 方式移行後に廃止予定とドキュメントには書かれているが、実際には書き込みのみが残っている状態。

Broadcast 方式が正式に採用されているなら、以下を整理すべき:

1. `PUT .../live-activity/{laId}/token` API エンドポイントを廃止
2. `live_activity_update_token` テーブルを廃止
3. Flutter 側の `syncLiveActivityUpdateToken()` 呼び出しを削除
4. `LiveActivityTokenRepository` の unused メソッドを削除

### 🟡 運用リスク: EEW Broadcast 更新の環境が production 固定

EEW の push-to-start は `device.apnsEnvironment` を使って APNs URL と `input-push-channel` を決める。一方で、`serialNo > 1` の update と最終報/キャンセル時の end は、`channelSyncService.getApnsChannelId(..., 'production')` と `environment: 'production'` で固定されている。

このため、development/sandbox の push-to-start token では Live Activity が開始されても、更新チャンネルが production 側に送られて update/end を受け取れない可能性がある。開発ビルドで「開始されるが更新されない」場合は、まず以下を確認する。

1. start 送信ログの `environment` と `inputPushChannel`
2. update/end Broadcast メッセージの `environment` と `apns-channel-id`
3. `ChannelSyncService` が development と production の両方でチャンネル同期しているか
4. `eew.region.{code}` と `eew.region.0` のチャンネル解決に miss が出ていないか

### 🟡 可観測性不足: Live Activity と通知配信の成功率を分離して追えない

`notification-sender` には `notification_sender_sent_total` / `notification_sender_send_duration_seconds` があるが、現状のラベルは `framework` 中心で、EEW / 揺れ検知 / Live Activity phase までは分離できない。さらに APNs Broadcast 経路は通常 APNs と同じ成功/失敗 Counter/Histogram に乗っていない。

後続の監視設計は `backend/docs/notification-observability.md` にまとめる。Grafana ダッシュボードとアラート定義の実体は `home8s` 側で管理し、このリポジトリではメトリクス仕様・PromQL 例・実装 TODO を管理する。

---

## 7. 正常に動作している部分

| 機能 | 状態 | 備考 |
| ---- | ---- | ---- |
| pushToStartToken の取得と登録 | ✅ 正常 | iOS 17.2+ / iOS 16.1 の判定も実装済み |
| EEW serialNo==1 の Live Activity 開始 | ✅ 正常 | チャンネル指定・contentState 生成ともに正常 |
| EEW serialNo>1 の Broadcast update | 🟡 要確認 | 全地域チャンネル + 影響地域チャンネルへ配信。ただし現状は production 固定 |
| EEW 最終報後 3 分遅延 end | 🟡 要確認 | `LiveActivityEndScheduler` で実装済み。ただし現状は production 固定 |
| 揺れ検知 initial push-to-start | 🔴 バグあり | `shake.all` を APNs UUID と誤用 |
| 揺れ検知 Broadcast update/end | 🔴 バグあり | 同上 |
| update token の DB/Valkey への書き込み | ✅ 動作する | ただし実質的に使われていない |
| EEW contentState の `isLevel`/`isOnePoint` | ✅ 正常 | `eew-content-state.ts` では `event.isLevel/isOnePoint` を直接使用 |
| `LiveActivityEndScheduler` | ✅ 正常 | EEW 3min / 揺れ検知 2min の遅延終了 |

---

## 8. 関連ファイル一覧

### Flutter App

| ファイル | 役割 |
| -------- | ---- |
| `packages/live_activity_util/ios/.../EQMLiveActivityUtil.swift` | ActivityKit FFI ブリッジ |
| `app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart` | update token Riverpod stream |
| `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart` | token → API 同期サービス |
| `app/lib/feature/devices/data/repository/device_repository.dart` | API 呼び出し |
| `app/ios/Widget/LiveActivity/Eew/EewLiveActivityAttributes.swift` | EEW Live Activity Widget |
| `app/ios/Widget/LiveActivity/ShakeDetection/ShakeDetectionLiveActivityAttributes.swift` | 揺れ検知 Live Activity Widget |

### Backend

| ファイル | 役割 |
| -------- | ---- |
| `backend/api/api/src/features/device/routes/live-activity.ts` | update token CRUD API |
| `backend/service/notification-resolver/src/index.ts` | メインの通知解決処理 |
| `backend/service/notification-resolver/src/live-activity/eew-content-state.ts` | EEW contentState ビルダー |
| `backend/service/notification-resolver/src/live-activity/end-scheduler.ts` | 遅延終了スケジューラ |
| `backend/service/notification-resolver/src/broadcast/channel-sync.ts` | APNs Broadcast チャンネル管理 |
| `backend/service/notification-resolver/src/repository/live-activity-token.ts` | DB トークン CRUD |
| `backend/service/notification-resolver/src/repository/redis.ts` | Valkey キャッシュ操作 |
