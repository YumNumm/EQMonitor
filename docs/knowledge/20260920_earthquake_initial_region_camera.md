# 震度速報の初期表示範囲

- 震度速報は観測点を持たないため、`intensity.regions` に含まれる細分区域の境界を使う。
- `jmaMapProvider` の読み込みと地図Widgetのレイアウトサイズ確定後に初期カメラを計算する。
- `eqmonitor_map` の `MapCameraBoundsFitter` は MapLibre 互換の中心・ズーム計算を持つ。画面サイズと余白には論理ピクセルを渡す。DPRによってカメラは変わらない。
- 計算結果は `MapOptions.initCenter` / `initZoom` に渡す。表示後の `fitBounds` では初期表示の移動が見えてしまうため、初期表示用途には使わない。
- 利用中の Fork の `MapOptions` に `initBounds` はないが、Android 実装は `initCenter` / `initZoom` をネイティブ地図生成時の `CameraPosition` に設定する。今回の用途で Fork の変更は不要。
- 対象境界が得られない場合はエラー表示にし、固定位置へフォールバックしない。

既存テストの実行例（ワークスペースルートから）:

```sh
mise exec -- flutter test --no-pub app/test/feature/earthquake_history/data/logic/earthquake_history_map_bounds_calculator_test.dart packages/eqmonitor_map/test/geo/map_camera_bounds_fitter_test.dart app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart
```
