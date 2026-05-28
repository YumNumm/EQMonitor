# EQMonitor データフロー仕様書

> 調査日: 2026-05-28  
> 対象: dmdata-websocket-proxy → EQMonitor アプリ表示までのエンドツーエンドデータフロー

---

## 1. システム概要

```
DMDATA (気象庁データプロバイダ)
  │  WebSocket v2  (JSON + binary)
  ▼
┌────────────────────────────┐
│  dmdata-websocket-proxy    │  Node.js / Hono
│  service/dmdata-websocket-proxy │
└────────┬───────────────────┘
         │
         ├─[WebSocket /ws]──────────────────────► telegram-db-writer
         │                                         │  PostgreSQL に書き込み
         │                                         │  Valkey Pub/Sub publish
         │                                         │    (realtime:broadcast:v1)
         │
         └─[Redis Streams: events]────────────────► notification-resolver
                                                    │  FCM / APNs 通知送信
                                                    │  Live Activity start/update/end
                                                    │  Valkey Pub/Sub publish
                                                    │    (realtime:broadcast:v1)
                                                    │
                         ┌──────────────────────────┘
                         │  Valkey Pub/Sub (realtime:broadcast:v1)
                         ▼
               ┌──────────────────────┐
               │  api/websocket       │  WebSocket サーバー (port 9787)
               │  GET /v2/realtime/ws │
               └──────────┬───────────┘
                          │  JWT チケット認証
                          ▼
               EQMonitor Flutter アプリ
```

---

## 2. コンポーネント詳細

### 2.1 dmdata-websocket-proxy
**役割**: DMDATA WebSocket v2 への単一上流接続を保持し、受信電文を下流へ配信する

| 項目 | 値 |
|------|-----|
| 接続先 | `wss://ws.api.dmdata.jp/v2/websocket` |
| 購読分類 | `telegram.earthquake`, `eew.forecast` |
| 受信電文種別 | VZSE40, VXSE42-45, VXSE47, VTSE41/51/52, VXSE51-53/56/60-62, VYSE60, IXAC41 |
| 下流 WebSocket | `/ws` エンドポイント (telegram-db-writer が接続) |
| Redis Streams 出力 | `events` ストリーム (EEW・地震情報・取消のみ) |
| IXAC41 処理 | Redis に分割チャンクを蓄積し BUFR 終端符号 `7777` で結合して下流送信 |

**上流 ping/pong**: DMDATA から `{type:"ping", pingId}` を受信し `{type:"pong", pingId}` を返送。  
**下流 ping/pong**: 接続クライアントへ 30 秒ごとに `{type:"ping", pingId}` を送信し、115 秒以内に pong がなければ切断。

### 2.2 telegram-db-writer
**役割**: proxy の WebSocket から電文を受信し PostgreSQL へ永続化する

| 入力 | `dmdata-websocket-proxy` の `/ws` |
|------|-----|
| 出力 | PostgreSQL (EEW, 地震情報, 津波情報, Feed テーブル) |
| Pub/Sub publish | `realtime:broadcast:v1` (earthquake / tsunami シグナル) |

処理するスキーマ種別:
- `eew-information` → EewTransformer → DB 書き込み
- `earthquake-information` → EarthquakeInformationTransformer → DB 書き込み + Pub/Sub
- `earthquake-hypocenter-update` → 同上
- `earthquake-explanation` / `earthquake-counts` / `earthquake-nankai` → Feed 書き込み
- `tsunami-information` → TsunamiTransformer → DB 書き込み + Pub/Sub

### 2.3 notification-resolver
**役割**: Redis Streams の `events` を購読し、デバイスへの通知とリアルタイム配信を制御する

| 入力ストリーム | `events`, `shake-detect-events`, `estimated-intensity-events`, `device-token-cleanup` |
|------|-----|
| 出力ストリーム | `fcm-notifications`, `apns-notifications`, `live-activity-broadcasts`, `notification-logs` |
| Pub/Sub publish | `realtime:broadcast:v1` (EEW / EARTHQUAKE / ESTIMATED_INTENSITY ブロードキャスト) |

**EEW 処理フロー**:
1. `eewHistoryManager` で重複・下位 serialNo を除外
2. DB から条件一致デバイスを取得（地域・震度設定マッチング）
3. serialNo == 1: pushToStart で Live Activity 開始 + 通常通知
4. serialNo > 1: Live Activity ブロードキャスト (update)
5. `isLastInfo == true` or `isCancel == true`: 3 分後に Live Activity 'end' ブロードキャスト

### 2.4 api/websocket
**役割**: Flutter アプリへリアルタイムイベントを WebSocket で配信する

| 認証 | `api/api` の `GET /v2/realtime/ticket` で発行した JWT チケット |
|------|-----|
| エンドポイント | `GET /v2/realtime/ws?ticket=<JWT>` |
| 接続時 | Redis から `realtime:snapshot:v2` を読み込み `{type:"snapshot", data:{...}}` を送信 |
| リアルタイム | `realtime:broadcast:v1` Pub/Sub を subscribe し `{type:"realtime", data:{...}}` で転送 |
| ping/pong | 15 秒ごとに `{type:"ping"}` を送信し、15 秒以内に `{type:"pong"}` がなければ切断 |

### 2.5 EQMonitor Flutter アプリ
**役割**: WebSocket 接続を確立し、受信データを Riverpod プロバイダとして提供する

主要プロバイダチェーン:
```
eqmonitorWebSocketTicket (チケット取得・自動更新)
  └─ eqmonitorWebSocket (WebSocket 接続)
       └─ eqmonitorWsEventStream (raw WebSocketEvent ストリーム)
            └─ eqmonitorWsPayloadStream (WsMessage にパース)
                 ├─ EqMonitorWsStatus (ping → pong 応答・接続状態管理)
                 └─ eqMonitorWsDataSource (RealtimeEvent に変換)
                      └─ RealtimeEvents (keepAlive: true、全ソース集約)
```

---

## 3. 電文種別ごとのデータフロー

### 3.1 EEW (VXSE45)

```
DMDATA → dmdata-websocket-proxy
  │
  ├─[WebSocket]─► telegram-db-writer
  │                └─ eew_information テーブル, telegram テーブルに書き込み
  │
  └─[Redis Streams: events]─► notification-resolver
       │
       ├─ EEW serialNo==1:
       │    ├─ FCM/APNs 通知 (fcm-notifications / apns-notifications)
       │    └─ APNs Live Activity Start (apns-notifications, pushToStartToken 使用)
       │
       ├─ EEW serialNo>1 (update):
       │    ├─ Live Activity Broadcast update (live-activity-broadcasts)
       │    └─ Pub/Sub publish {type:"EEW", item: EewItemWithRelations}
       │         └─► api/websocket ─► Flutter
       │
       └─ EEW isLastInfo/isCancel:
            └─ 3 分後に Live Activity Broadcast end (live-activity-broadcasts)
```

**EventMessage** 変換対象電文: VXSE45 のみ。  
`status !== '通常'` (試験・訓練) および `type === '緊急地震速報配信テスト'` は除外。  
`isCancel: true` の場合は空 regions・空 maxIntensity で送信。

### 3.2 地震情報 (VXSE51/52/53/62)

```
DMDATA → dmdata-websocket-proxy
  │
  ├─[WebSocket]─► telegram-db-writer
  │                └─ earthquake_information テーブルに書き込み
  │                └─ Pub/Sub publish {type:"earthquake", operation:"upsert/delete", record: EarthquakePartial}
  │                     └─► api/websocket ─► Flutter
  │
  └─[Redis Streams: events]─► notification-resolver
       ├─ DB から条件一致デバイス取得 (地域コード + 震度閾値マッチング)
       ├─ EEW 通知済みデバイスへの伝播通知
       ├─ FCM/APNs 通知送信
       └─ Pub/Sub publish {type:"EARTHQUAKE", item: EarthquakePartial}
            └─► api/websocket ─► Flutter
```

**EventMessage 変換対象**:
| 電文種別 | 変換内容 |
|---------|---------|
| VXSE51 (震度速報) | regions + prefectures |
| VXSE52 (震源に関する情報) | hypocenter + magnitude + originTime |
| VXSE53 (震源・震度に関する情報) | regions + prefectures + cities + hypocenter |
| VXSE62 (長周期地震動) | regions のみ |

### 3.3 IXAC41 (BUFR / 推計震度)

```
DMDATA → dmdata-websocket-proxy (分割受信)
  │   ┌─ Redis Hash に チャンク蓄積 (TTL: 120s)
  │   └─ BUFR 終端 "7777" 検知時に結合
  │
  ├─[WebSocket: 結合済 base64]─► telegram-db-writer
  │                               (IXAC41 はスキーマ不一致でスキップ)
  │
  └─[ixac41-pmtiles-generator]
       └─ Rust 製 ixac41_parser HTTP サーバーへ送信
       └─ PMTiles 生成 → SeaweedFS (S3) に保存
       └─[Redis Streams: estimated-intensity-events]
            └─► notification-resolver
                 ├─ EARTHQUAKE 通知済みデバイスへサイレント通知
                 └─ Pub/Sub publish {type:"ESTIMATED_INTENSITY", estimatedIntensity:{...}}
                      └─► api/websocket ─► Flutter
```

### 3.4 津波情報 (VTSE41/51/52)

```
DMDATA → dmdata-websocket-proxy
  └─[WebSocket]─► telegram-db-writer
       └─ TsunamiTransformer → tsunami テーブルに書き込み
       └─ Pub/Sub publish {type:"tsunami", operation:"upsert/delete", event_id}
            └─► api/websocket ─► Flutter
```

### 3.5 揺れ検知 (Kyoshin Monitor)

```
Kyoshin Monitor API (別サービスがポーリング)
  └─[Redis Streams: shake-detect-events]
       └─► notification-resolver
            ├─ EEW との相関チェック (EEW 検知時は通知抑制)
            ├─ DB 保存 (shake_detection_events)
            ├─ FCM/APNs 通知
            ├─ APNs Live Activity Start (shake_detection trigger)
            ├─ Live Activity Broadcast update (shake.all チャンネル)
            ├─ 2 分後に Live Activity end スケジュール
            └─ Pub/Sub publish ShakeDetectedPayload
                 └─► api/websocket ─► Flutter
```

---

## 4. Redis Streams / Pub/Sub チャンネル一覧

### Redis Streams

| ストリーム名 | Producer | Consumer | 用途 |
|------------|---------|---------|------|
| `events` | dmdata-websocket-proxy | notification-resolver | EEW・地震情報イベント |
| `shake-detect-events` | shake-detection service | notification-resolver | 揺れ検知イベント |
| `estimated-intensity-events` | ixac41-pmtiles-generator | notification-resolver | 推計震度完了通知 |
| `fcm-notifications` | notification-resolver | notification-sender (Go) | FCM 通知メッセージ |
| `apns-notifications` | notification-resolver | notification-sender (Go) | APNs 通知メッセージ |
| `live-activity-broadcasts` | notification-resolver | notification-sender (Go) | Live Activity ブロードキャスト |
| `notification-logs` | notification-resolver, notification-sender | aggregation-worker | 通知ログ |
| `dispatch-stats` | notification-sender | aggregation-worker | 配信統計 |
| `device-token-cleanup` | notification-sender | notification-resolver | 無効トークン削除要求 |

### Valkey Pub/Sub チャンネル

| チャンネル名 | Publisher | Subscriber | メッセージ型 |
|------------|---------|---------|-------------|
| `realtime:broadcast:v1` | telegram-db-writer, notification-resolver | api/websocket | `RealtimeEventEnvelope` |

### Valkey キー

| キー | 用途 | TTL |
|-----|------|-----|
| `realtime:snapshot:v2` | 接続時初期スナップショット (EEW + 地震情報 + 揺れ検知) | なし (上書き更新) |
| `telegram:chunk:<base64url>` | IXAC41 分割チャンク | 120 秒 |

---

## 5. WebSocket プロトコル詳細

### 5.1 クライアント接続フロー

```
Flutter app                    api/api           api/websocket
    │                             │                    │
    │── GET /v2/realtime/ticket ─►│                    │
    │   (x-eqmonitor-device-id)   │                    │
    │◄── {url, expiresAt} ────────│                    │
    │                             │                    │
    │── WS Connect ──────────────────────────────────►│
    │   ?ticket=<JWT>             │                    │
    │◄── {type:"snapshot", data:{revision, eews, earthquakes, shakes}} ──│
    │                             │                    │
    │◄── {type:"realtime", data:<envelope>} ─── (Pub/Sub) ───│
    │                             │                    │
    │◄── {type:"ping"} ──────────────────────────────│ (15秒ごと)
    │── {type:"pong"} ──────────────────────────────►│
```

チケット TTL: デフォルト 1800 秒、Flutter 側は expiry 30 秒前に自動更新。

### 5.2 WebSocket メッセージ型 (Flutter 側)

**受信メッセージ** (`WsMessage`):

```
type: "snapshot"  → WsSnapshotMessage
  data:
    revision: number
    updatedAt: DateTime
    eews: List<EewItemWithRelations>
    earthquakes: List<EarthquakePartial>
    shakes: List<WsSnapshotShakeEntry>
      ├─ eventId, createdAt, level, isReplay, pointCount, region
      ├─ changeReasons: List<String>
      └─ points: List<WsShakeObservationPoint>  ← 観測点データ

type: "realtime"  → WsRealtimeMessage
  data: RealtimeEventEnvelope  (discriminated union by type)
    "EEW"                → EewItemWithRelations
    "EARTHQUAKE"         → EarthquakePartial  (broadcast)
    "earthquake"         → upsert/delete + EarthquakePartial
    "tsunami"            → upsert/delete
    "shake_detected"     → 揺れ検知データ (points含む)
    "ESTIMATED_INTENSITY"→ estimatedIntensityKey

type: "ping"      → WsPingMessage
  (EqMonitorWsStatusNotifier が {type:"pong"} を自動返送)
```

### 5.3 スナップショット取得ウィンドウ

接続時、過去 60 秒以内のデータのみを初期スナップショットとして送信:
- EEW: `report_time >= (now - 60s)` でフィルタ
- 地震情報: `origin_time >= (now - 60s)` でフィルタ (origin_time が null の場合は含める)
- 揺れ検知: `createdAt >= (now - 60s)` でフィルタ

---

## 6. 発見した実装不備・型不整合

### Bug 1 [修正済み 🟢] — スナップショットフィルタの camelCase/snake_case 不整合

**場所**: `backend/api/websocket/src/index.ts` L158-159  
**問題**: `e.reportTime`（camelCase）を参照していたが、TypeScript 型 `EewItem` のフィールド名は `report_time`（snake_case）。実行時に `undefined` → `new Date(undefined)` = `Invalid Date` → 比較が常に `false` → 接続時スナップショットの EEW・地震情報が常に空  
**修正内容**:
- EEW: `e.reportTime` → `e.report_time`
- 地震情報: `e.reportTime`（存在しないフィールド）→ `e.origin_time ?? 0`

### Bug 2 [修正済み 🟢] — EEW 取消電文が Redis Streams に未送信

**場所**: `backend/service/dmdata-websocket-proxy/src/event-transformer.ts`  
**問題**: `infoType === '取消'` の EEW を即座に `null` 返却して `events` ストリームに送信しない。`notification-resolver` の `isCancel` フラグが機能せず、Live Activity が取消時に終了されない可能性  
**修正内容**: `serialNo` がある取消電文は `isCancel: true, isLastInfo: true` を含む `EventMessage` を返却し、Live Activity end をトリガー可能にした

### Bug 3 [修正済み 🟢] — telegram-db-writer の型安全でないキャスト (2 箇所)

**場所**: `backend/service/telegram-db-writer/src/index.ts` L238, L257  
**問題**: `EarthquakeHypocenterUpdate.v1_0_0.Cancel/Public` を `as unknown as EarthquakeInformation.v1_1_0.*` にキャスト。実際には `TelegramTransformer` の `SupportedTelegrams` union 型に `EarthquakeHypocenterUpdate` が含まれており、キャストは不要  
**修正内容**:
- `transformer.ts:243`: `transformEarthquakeCancel` の `telegram` 引数型を `Cancel | EarthquakeHypocenterUpdate.v1_0_0.Cancel` に拡張
- `index.ts` L238, L257: `as unknown as` キャストを削除

### Bug 5 [修正済み 🟢] — 揺れ検知の観測点データが Flutter モデルに欠落

**場所**: `packages/eqmonitor_websocket/lib/src/`  
**問題**: バックエンドの `ShakeDetectedPayload` に含まれる `points`（観測点一覧）フィールドが `WsShakeDetectedRealtimeEvent` / `WsSnapshotShakeEntry` に存在せず、受信データが破棄されていた  
**修正内容**: `WsShakeObservationPoint` / `WsShakeObservationLocation` モデルを新規作成し、両クラスに `@Default([]) List<WsShakeObservationPoint> points` フィールドを追加。`melos run generate` でコード生成済み

### 未修正の設計上の注意点

| # | 場所 | 内容 |
|---|------|------|
| A | `realtime_event_envelope.dart` | `WsTsunamiRealtimeEvent.record` が `Map<String, dynamic>?` で型なし。津波情報の構造化モデルが未実装 |
| B | `event-transformer.ts` | VXSE45 以外の EEW 電文種別 (VXSE42/43/44) は受信リストに含まれるが、event-transformer では変換対象外 |
