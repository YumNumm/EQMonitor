# eqmonitor_mapの描画・性能検証を拡充する

## 背景

初期実装は座標、tile、MVT、reconciler、label、hit testなどの単体テストを優先する。Widget test、Golden test、実機性能試験は性能観測APIが安定した後に追加する。

## 実施内容

- パン、pinch zoom、loading、degraded表示のWidget test
- 固定PMTiles、viewport、DPRを使うFill/Line/labelのGolden test
- Light/Darkとtext scale 1.0/1.5/2.0のGolden test
- iOS/Androidの基準端末と地図fixtureの選定
- 高速移動、offline復帰、background復帰、memory pressureの実機試験
- context loss/rebuildとframes-in-flight resource retirementの反復・長時間実機試験
- frame、queue待機、decode、mesh build、GPU submission/completion、cacheの回帰基準策定
- metrics収集自体のCPU/memory overhead上限とevent drop検証

## 前提

`MapPerformanceSnapshot`と`MapPerformanceEvent`は初期実装で提供し、このTODOで計測方式を作り直さない。
