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
- performance benchmarkと回帰閾値をCIで追跡し、Performance HUDとの計測差を検証
- 物理iOS/Androidのprofile/release各runで60秒partial update、回転/DPR、3回以上の
  lifecycle復帰・dispose/remountを採取
- AndroidはVulkanをprimary backendとし、support対象ではGLES fallbackと
  `Don't keep activities`によるActivity recreationも別途検証
- Flutter Scene upstreamにGPU completion、context generation、GPU resource disposalの
  public APIが追加された時点でAPI監査とschema/gateを更新し、4 runを再採取

実機手順、owner、受入条件、失敗時の扱いは
[`2026-08-02-eqmonitor-map-scene-physical-verification.md`](../superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md)
を正本とする。現Linux環境ではplatform build、物理端末、実GPU/lifecycle/memory検証は
`NOT RUN / BLOCKED`であり、このTODOの完了扱いにしない。

## 前提

`MapPerformanceSnapshot`と`MapPerformanceEvent`は初期実装で提供し、このTODOで計測方式を作り直さない。
