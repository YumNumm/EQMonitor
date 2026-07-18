# WebSocket ready を Pub/Sub 購読完了後に送る

## 背景

`backend/api/websocket/src/index.ts` は `connectionManager.startSubscription(redis)` の直後に `ready` を送信している。
一方で `ConnectionManager.startSubscription()` は `Redis.subscribe()` の完了を await していない。

仕様では `ready` 受信後に REST 初期同期すれば WebSocket 購読開始前後の取りこぼしを避けられる前提になっているため、初回接続 pod では `ready` と実際の Pub/Sub 購読完了の間にイベントが漏れる可能性がある。

## 対応案

- `startSubscription()` が `subscribe(REALTIME_PUBSUB_CHANNEL)` 完了まで resolve するようにする
- subscriber が再接続中・未購読の場合は `ready` を送らない、または購読復旧後に送る
- `ready` が subscribe 完了後にのみ送られる統合テストを追加する

