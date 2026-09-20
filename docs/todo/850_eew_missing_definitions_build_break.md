# EEW 関連の未解決参照によるコンパイル失敗

PR #1808 への develop (`d88ac8882`) 取り込み時に確認。対象の EEW / home ファイルは develop から変更していない。

- `feature/home/ui/component/map/layer/eew_area_filter.dart` が存在しないが、複数レイヤーが import している。
- `EewForecastRegionIntensityFilterUpdater.intensityLevels` / `detailLayerId` の参照が解決できない。
- `eewEstimatedRegionCalculatorProvider` の参照が解決できない。
- 関連実装・生成コード・参照元を整合させ、以下の既存 Widget テストがコンパイルできるようにする。

```sh
mise exec -- flutter test --no-pub app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart
```
