# 強震モニタ data 層の残作業

`refactor/kyoshin-monitor-data-layer` でディレクトリと計算の分離は入れた。以下は未着手。

## 高優先

- `KyoshinMonitorNotifier._fetchAndAnalyzeImage` を private のままにせず、専用クラスへ切り出す
- 毎秒 `AsyncLoading` に戻さない（表示が点滅し、遅延判定の回帰が取りづらい）
- 補正量の正本を Settings と Adjustment で二重に持たない（永続化は Repository へ）
- `timer_stream` が NTP 補正済み `appClock.now()` から再度 NTP を引いていないか検証する（`time_sync_test` の端末時計 +30 秒ケースを維持）

## 中優先

- `KyoshinMonitorTimerNotifier` の Timer / StreamController 混在と `unawaited` バーストを整理する
- `delayAdjustType` の 4 値を実際の 2 挙動に合わせる
- `lastUpdatedAt: DateTime.now()` を `appClock` に揃える
- 未使用の色マップ関連 3 ファイルの削除可否を確認する

## 低優先

- 遅延設定 UI を `home` から `kyoshin_monitor/ui` へ移す
- Mutation 化、`data/flow/` は画面遷移が必要になってから
