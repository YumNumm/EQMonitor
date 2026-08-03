# eqmonitor_mapの延期検証を実施する

## 背景

現在はFlutter Sceneの最小manual smoke exampleとunit testを提供している。
実機確認は未実施だが、renderer foundation実装の開始条件にはしない。

## 未完了事項

- Performance HUDの実装と、metrics収集自体のCPU/memory overhead・event drop検証
- パン、pinch zoom、loading、degraded表示のWidget test
- 固定PMTiles、viewport、DPR、theme、text scaleを使うFill/Line/labelのGolden test
- frame、queue待機、decode、mesh build、GPU、cacheのperformance benchmarkと回帰閾値
- 物理iOS/Android端末のprofile/releaseで、package READMEのmanual smoke
  checklistをそれぞれ実施する

## 実機確認の最低範囲

- procedural mesh、custom material、`TextPainter` overlayの描画
- portrait/landscape回転とsurface/labelの追従
- partial position/color updateの開始・停止
- background/foreground復帰後の継続動作
- app resource rebuildとdispose/remount後の再描画
- frame、partial update、resume、remount、rebuild、exception counterと端末log

実施環境、device/OS、build mode、失敗時のlogは変更記録へ残す。
固定値や手編集で実行結果を代替しない。
