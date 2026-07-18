# ESTIMATED_INTENSITY のアプリ反映先を実装する

## 背景

WebSocket payload と mapper は `ESTIMATED_INTENSITY` を `RealtimeEstimatedIntensityUpsertEvent` に変換しているが、通常 UI 側でこのイベントを購読して地震詳細や地図へ反映する consumer が見当たらない。

このため、推計震度 PMTiles が後から生成された場合、次回 REST refresh まで表示に反映されない可能性がある。

## 対応案

- `eventId` に紐づく地震履歴・詳細状態へ `estimatedIntensityTile` を upsert する
- 既に表示中の地震詳細画面で tile URL が追加された場合に map layer を更新する
- `RealtimeEstimatedIntensityUpsertEvent` の widget/provider テストを追加する

