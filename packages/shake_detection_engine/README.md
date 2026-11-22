# shake_detection_engine

強震モニタの観測点ごとのリアルタイム震度から、揺れの広がりをイベントとして検知する純 Dart パッケージ。

検知ロジックは [KyoshinEewViewer for ingen](https://github.com/ingen084/KyoshinEewViewerIngen) の `ShakeDetectionEngine`（MIT License）を移植したもの。

## 使い方

```dart
final engine = ShakeDetectionEngine(stations: stations);
engine.seedBaseline(ShakeBaseline(values: baseline, isReliable: true));
final events = engine.process(time: observedAt, intensities: intensities);
```

- `intensities` は `stations` と同じ順序で渡す。欠測は `null`。
- `seedBaseline` は履歴が空の状態（生成直後・`reset` 直後）で呼ぶ。平常値との差で 1 フレーム目から検知できる。
- 直前のフレームを後から入手できた場合は、`reset` → `seedBaseline` → 古い順に `process` で履歴を作り直し、
  `adoptEventIds` に作り直す前の `events` を渡して ID を引き継ぐ。
- 5 秒以上の時刻の飛びがあった場合は `reset` してから `seedBaseline` し直す。

## 移植元との差分

- `seedBaseline`（平常値の投入）は移植元に無い。投入した平常値が窓に残る 9 フレームの間は、
  数十秒から数分の緩やかな雑音の変動を拾うため、Medium 以上のイベントだけを確定する。
- 固定値の平常値（`ShakeBaseline.constant`）では故障観測点を区別できないため、同じ間は離島の単独検知を行わない。
- 観測点はイベントの終了まで外さない。移植元は上昇が止まり検知期限が過ぎた観測点を個別に外すが、
  本パッケージはすべての観測点の検知期限が過ぎた時点でイベントを終了する。観測点数は終了まで減らない。
- 観測点ごとに、イベント中の最大震度（`peakIntensity`）を保持する。
- 観測点ごとの表示用の状態（`stationStatuses`）を返す。異常値として除外中は `outlier`、直近 10 フレームに実測があり
  最新フレームが欠測の場合は `lost`。固定値の平常値は実測として数えない。
- 最高レベルを検知した地域の集合（`PeakLevelRegions`）とデバッグ用の値は持たない。
