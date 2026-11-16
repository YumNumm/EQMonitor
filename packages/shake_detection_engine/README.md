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
- 5 秒以上の時刻の飛びがあった場合は `reset` してから `seedBaseline` し直す。
