# WebSocket の backpressure と ready probe の運用を明確化する

## 背景

WebSocket サーバは broadcast 時に全 connection へ同期的に `send()` しているが、低速 client の `bufferedAmount` 監視や上限超過 close がない。
数万人規模の接続では、遅い接続が pod メモリを押し上げるリスクがある。

また `/ready` は Redis が初期化済みかつ ready の場合のみ 200 を返すが、Redis 初期化は初回 WebSocket 接続時に行われる。現行 Kubernetes probe は `/health` のため直接影響しないが、将来 `/ready` を readinessProbe に使うと初回接続前に 503 が続く可能性がある。

## 対応案

- `bufferedAmount` 上限と slow client close 方針を決める
- broadcast loop の最大処理時間・失敗率を alert にする
- `/ready` を使うならサーバ起動時に Redis 接続を初期化するか、probe 用の意味を `/health` と分離して文書化する

