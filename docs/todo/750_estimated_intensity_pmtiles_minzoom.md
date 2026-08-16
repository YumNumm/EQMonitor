# 推計震度 PMTiles が zoom 5 未満で表示されない

## 現象

地震履歴詳細・ライブモニタの推計震度レイヤー（PMTiles）は、マップの zoom が 5 未満のとき何も描画されない。

## 原因

- backend の `service/ixac41-pmtiles-generator/src/pmtiles-generator.ts` が tippecanoe を
  `-Z 5 -z 14 --minimum-zoom=5 --maximum-zoom=14` で実行しており、zoom 5 未満のタイルが
  アーカイブに存在しない。
- MapLibre（gl-js / native とも）はソースの maxzoom を超えた場合は overzoom（親タイルの拡大表示）を
  行うが、minzoom 未満の underzoom は行わないため、zoom < 5 ではレイヤーが一切描画されない。
- アプリ側のレイヤー定義（`EarthquakeHistoryEstimatedIntensityStyle`）には minzoom 指定はなく、
  アプリ側で回避する手段はない（タイルデータ自体が存在しないため）。

確認例（`https://tiles.eqmonitor.app/ixac41/20260728162718.pmtiles` のヘッダ）:

```text
min_zoom 5 / max_zoom 14
generator_options: tippecanoe ... -Z 5 -z 14 --minimum-zoom=5 --maximum-zoom=14 ...
```

## 対応（backend リポジトリ側）

1. `runTippecanoe` の `-Z 5` / `--minimum-zoom=5` を引き下げる（例: `-Z 2`）。
   1 イベントあたりのフィーチャ数は震度階級ごとの数個の Polygon のみなので、低ズームタイルの
   追加コストはごく小さい。
2. 既に生成・配信済みの `ixac41/*.pmtiles` は minzoom 5 のままなので、過去イベント分も低ズームで
   表示したい場合は再生成が必要。

## 備考

- アプリ側の詳細マップのデフォルト zoom は 5.0 / 震央 zoom 6.5（`docs/map_spec_v3.md` 2-9）で、
  ピンチアウトすると zoom 5 を下回るため、ユーザー操作で普通に到達する範囲。
