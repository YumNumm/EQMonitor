# ready 後の初期 REST 同期を全 realtime 表示で統一する

## 背景

WebSocket 仕様は、接続直後の初期状態は送らず、`ready` 受信後に REST API で初期状態を取得する前提になっている。

アプリ側では EEW は `RealtimeReadyEvent` で `_eewRestProvider` を invalidate しているが、地震履歴は `ready` を見ず、初回 fetch・5分 timer・resume・upsert event に依存している。津波は `RealtimeTsunami*` の consumer が通常 UI 側に見当たらない。

## 対応案

- EEW / 地震 / 津波 / 推計震度の初期同期方針を `ready` 起点に統一する
- 地震履歴は `RealtimeReadyEvent` 受信時に先頭ページを再検証する
- 津波は `group_id` があれば `GET /v2/tsunami/:group_id`、なければ active 再同期を行う consumer を追加する

