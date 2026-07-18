# WebSocket broadcast の運用 alert を整備する

## 背景

WebSocket broadcast は `bufferedAmount` 上限超過 close と `/ready` の起動時 Redis 初期化を実装済み。
一方で、数万人規模の接続で異常を早期検知する alert はまだ整備していない。

## 対応案

- broadcast loop の最大処理時間・失敗率を alert にする
- `websocket_broadcast_log` と Prometheus metrics のどちらを SLO 判定に使うか決める
- home8s / production の dashboard に slow broadcast と close code `1013` を追加する
