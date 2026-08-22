# EEW履歴の報切替時に警報レイヤーを維持する

## 原則

EEW履歴詳細の警報モードでは、選択報が変わっても MapLibre の警報区域
fill / line layer を削除・再追加しない。警報モード中はレイヤーを維持し、
報番号の変更を契機に `StyleController.updateFilter` で対象区域だけを更新する。

警報区域がない報もレイヤーを削除せず、空の区域コードで filter を更新する。
これにより「警報あり → なし → あり」の切替でも、最後の報の区域を確実に
再描画できる。

## 確認コマンド

```shell
cd app
mise exec -- flutter test test/feature/eew/data/logic/eew_forecast_region_warning_filter_updater_test.dart
mise exec -- flutter analyze \
  lib/feature/eew/data/logic/eew_forecast_region_warning_filter_updater.dart \
  lib/feature/eew/ui/components/eew_forecast_region_layer.dart \
  test/feature/eew/data/logic/eew_forecast_region_warning_filter_updater_test.dart
```
