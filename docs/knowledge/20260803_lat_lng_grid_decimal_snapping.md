# 緯度経度グリッドの小数境界スナップ

## 問題

グリッド index を `ceil(bound / interval)` / `floor(bound / interval)`
で直接求めると、IEEE 754 の丸め誤差により境界上の線を欠落させる。
たとえば `0.3 / 0.1` は `2.9999999999999996` になり得るため、
east / north 側の `floor()` が `0.3` の線を除外する。

## ルール

- 入力を検証した後、座標と間隔を 12 桁スケールの整数へ変換する。
- 正数・負数の双方で正しい整数 ceil / floor 除算から index 範囲を求める。
- 座標生成は整数 index と間隔の積を使い、浮動小数点の繰り返し加算はしない。
- 出力座標は小数点以下 12 桁で正規化し、`-0.0` は `0.0` にする。
- `±0.3` / interval `0.1` と `±0.05` / interval `0.025` を回帰テストに含める。

対象実装:
`app/lib/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart`

確認コマンド:

```bash
cd app
mise exec flutter@3.44.4-stable -- flutter test \
  test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart
mise exec flutter@3.44.4-stable -- flutter analyze \
  lib/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart \
  test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart
```

Android / iOS のビルドと Native callback 検証は別マシンで実行する。
手順は `docs/superpowers/plans/2026-08-02-flutter-maplibre-computed-geojson-source.md`
および `docs/superpowers/plans/2026-08-02-eqmonitor-lat-lng-grid.md` を参照する。
