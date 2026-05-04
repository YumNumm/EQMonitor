---
name: Live Activity Docs
overview: EEW Live Activity の start/update/end フローを実装に沿って整理し、通知パイプライン全体の監視設計をドキュメント化します。今回はドキュメント更新を主目的にし、Grafana の実体管理は home8s 側、メトリクス実装は TODO として分離します。
todos:
  - id: update-review-doc
    content: "`docs/live-activity-implementation-review.md` の start/update 記述を実装に合わせて修正する"
    status: pending
  - id: update-backend-broadcast-doc
    content: "`backend/docs/apns-live-activity-broadcast.md` に EEW 現行フロー・既知リスク・監視設計を追記する"
    status: pending
  - id: update-knowledge-link
    content: "`docs/knowledge/20260501_live_activity_input_push_channel.md` に参照先と確認観点を追加する"
    status: pending
  - id: add-observability-todo
    content: EEW・揺れ検知・通知配信全体の監視実装 TODO ドキュメントを追加する
    status: pending
  - id: add-grafana-design
    content: Grafana で見るダッシュボード/アラート設計をドキュメントに追加する
    status: pending
  - id: review-doc-consistency
    content: 更新後に関連ドキュメント間のヘッダー名・環境・監視方針・home8s 前提の整合を確認する
    status: pending
isProject: false
---

# Live Activity と通知監視のドキュメント更新計画

## 主要な調査結果

- EEW Live Activity は `serialNo === 1` で device push-to-start により開始し、`serialNo > 1` では APNs Broadcast channel へ `update`、最終報/キャンセルでは遅延 `end` を送る構成です。
- start は `device.apnsEnvironment` を使いますが、update/end 側は現在 `production` 固定です。開発環境や sandbox 端末では「開始されるが更新されない」直接原因になり得ます。
- start の購読チャンネルヘッダーは `input-push-channel` です。既存レビュー文書の一部に `apns-channel-id` と書かれており、実装・ナレッジと矛盾しています。
- `notification-resolver` の EEW 経路には OTel メトリクスがありますが、揺れ検知イベントは同じ処理時間・生成数メトリクスに載っていません。
- `notification-sender` の通常 APNs/FCM は `notification_sender_sent_total` などを記録していますが、`event_type` や Live Activity `phase` では切れません。Broadcast 送信では成功/失敗 Counter/Histogram も未記録です。
- Grafana のダッシュボードやアラート定義の実体はこのリポジトリではなく `home8s` 側で管理する前提にします。このリポジトリには計測点、メトリクス名、PromQL 例、アラート方針、実装 TODO を残します。

確認した実装の要点:

```typescript
// backend/service/notification-resolver/src/index.ts
const apnsChannelId = channelSyncService!.getApnsChannelId(eqmonitorChannelId, 'production');
// ...
environment: 'production',
event: 'update',
```

```typescript
// backend/service/notification-resolver/src/resolver/payload-builder/apns.ts
...(inputPushChannel ? { 'input-push-channel': inputPushChannel } : {}),
// ...
'apns-channel-id': apnsChannelId,
```

## 更新するドキュメント

- [`docs/live-activity-implementation-review.md`](docs/live-activity-implementation-review.md)
  - EEW start フローの `header["apns-channel-id"]` を `input-push-channel` に修正。
  - start は device 環境、update/end は現状 production 固定であることを明記。
  - 「開始されるが更新されない」調査観点に、環境不一致・チャンネル未同期・Broadcast 送信メトリクス不足を追加。

- [`backend/docs/apns-live-activity-broadcast.md`](backend/docs/apns-live-activity-broadcast.md)
  - 現在の EEW start/update/end 実装フローを、`notification-resolver` と `notification-sender` の責務分担として追記。
  - `input-push-channel` と `apns-channel-id` の使い分け、`eew.region.{code}` / `eew.region.0` のチャンネル決定ルールを整理。
  - sandbox/production の注意点を追加し、現状の production 固定を既知リスクとして明記。

- [`docs/knowledge/20260501_live_activity_input_push_channel.md`](docs/knowledge/20260501_live_activity_input_push_channel.md)
  - 既存ナレッジに関連ドキュメントへのリンクと、更新が届かない時の最短確認観点を少しだけ追加。

- 新規または既存 TODO ドキュメント
  - 監視・改善を別実装タスクとして追えるよう、`docs/todo/085_notification_observability.md` のような TODO を追加します。
  - 内容は「resolver の EEW/揺れ検知/推計震度メトリクス統一」「sender の event_type / framework / Live Activity phase ラベル」「Broadcast 送信メトリクス」「dispatch_summary の揺れ検知対応」「Grafana/Alerting は home8s で管理」の実装項目にします。

- 新規または既存の監視設計ドキュメント
  - `backend/docs/notification-observability.md` のような設計書を追加するか、`backend/docs/apns-live-activity-broadcast.md` に章として追加します。
  - Grafana で見たい画面、PromQL 例、アラート閾値の考え方を、実装先と分けて記述します。

## 監視設計として書く内容

### イベント処理メトリクス

- `notification_resolver_events_processed_total{event_type=EEW|SHAKE_DETECTION|ESTIMATED_INTENSITY,outcome}`
- `notification_resolver_event_processing_duration_seconds{event_type}`
- `notification_resolver_notifications_generated_total{event_type,framework=FCM|APNS|APNS_BROADCAST}`
- `notification_resolver_messages_enqueued_total{event_type,stream}`
- `notification_resolver_events_skipped_total{event_type,reason}`

### 通知送信メトリクス

- `notification_sender_sent_total{framework=FCM|APNS|APNS_BROADCAST,event_type,status}`
- `notification_sender_send_duration_seconds{framework,event_type}`
- `notification_sender_errors_total{framework,event_type,error_code}`
- `notification_sender_retry_total{framework,event_type}`
- `notification_sender_dlq_total{framework,event_type}`
- `notification_sender_queue_size{stream}` / `notification_sender_processing_messages{stream}`

### Live Activity 専用メトリクス

- `live_activity_push_sent_total{phase=start|update|end,status,environment,start_trigger}`
- `live_activity_push_errors_total{phase,error_code,environment,start_trigger}`
- `live_activity_push_duration_seconds{phase,environment,start_trigger}`
- `live_activity_broadcast_generated_total{event_type,start_trigger}`
- `live_activity_channel_lookup_total{event_type,environment,result=hit|miss|fallback}`

### 計測点

- resolver:
  - EEW: `handleEventMessage` / `generateNotificationMessages`
  - 揺れ検知: `handleShakeDetectionEvent`
  - 推計震度: `handleEstimatedIntensityEvent`
  - Live Activity: start/update/end message 生成と channel lookup
- sender:
  - FCM: `internal/sender/fcm.go`
  - APNs 通常/Live Activity start: `internal/sender/apns.go`
  - APNs Broadcast update/end: `internal/consumer/broadcast_consumer.go` または `internal/broadcast/apns_broadcast.go`
- 集計:
  - 既存 `dispatch_summary` は EEW 中心。揺れ検知も同じテーブルに載せるか、別集計にするかを TODO として残します。

### Grafana ダッシュボード案

- Event pipeline overview:
  - EEW / 揺れ検知 / 推計震度の処理件数、処理時間 p50/p95/p99、skip reason、Redis enqueue 数
- Notification delivery:
  - FCM / APNS / APNS_BROADCAST の成功数、失敗数、成功率、error_code 上位、送信時間 p95/p99
- Live Activity:
  - start/update/end 別成功率、Broadcast 生成数、channel lookup miss、sandbox/production 別の送信結果
- Queue health:
  - Redis stream 消費数、queue size、processing messages、DLQ、retry

### アラート例

- resolver の `event_processing_duration_seconds` p95 が一定時間しきい値超過
- sender の `send_duration_seconds` p95/p99 が一定時間しきい値超過
- EEW / 揺れ検知の送信成功率が一定時間で低下
- Broadcast update/end の 5xx/送信失敗率が閾値超過
- `serialNo > 1` の EEW で Broadcast 生成数が 0
- channel lookup miss / fallback が急増
- DLQ または retry が急増
- カーディナリティ方針:
  - `eventId`, `deviceId`, `eqmonitorChannelId`, `apnsChannelId` はメトリクスラベルに入れずログ/trace に寄せる。

## 実施範囲

今回の実装は Markdown ドキュメントの作成・更新のみです。Go/TypeScript のメトリクス実装、production 固定の修正、Grafana ダッシュボード/アラート定義の実体追加は、ドキュメントに残した TODO と `home8s` 側の後続タスクとして扱います。
