# ベース地図の市区町村ポリゴンは z6 未満に存在しない

`all.pmtiles` の `areaInformationCityQuake` は **z6 以上のタイルにしか地物が無い**。
低ズームで市区町村を塗ろうとすると、例外もログも出ないまま「何も塗られない」。

## 実測値（ローカルビルドの pack, tippecanoe 2.79.0）

| zoom | 地物数 | distinct `regioncode` |
| --- | --- | --- |
| z0〜z5 | 0 | 0 |
| z6 | 2174 | 1894 |
| z7 | 3201 | 1894 |
| z8 | 7197 | 1894 |

## 原因は意図的な per-feature minzoom

backend `tools/base-map-pmtiles/convert_to_geojson.py` が市区町村の全 feature へ
`tippecanoe: {minzoom: 6}` を注入している（`CITY_QUAKE_FEATURE_MINZOOM`）。
低ズームタイルの肥大化と tippecanoe の feature drop を避けるための設計。

**PMTiles metadata の `vector_layers[].minzoom` は 0 のまま**なので、
メタデータからこの制約は読み取れない。判定するにはタイルを実際に覗くこと。

```bash
# 特定タイルの中身を見る（z/x/y）
tippecanoe-decode /path/to/all.pmtiles 5 28 12 | jq -r '.features[].properties.layer'

# strategies（feature drop の有無）を見る
mise exec -- uv run --project tools/base-map-pmtiles python -c "
from pmtiles.reader import MmapSource, Reader
with open('/path/to/all.pmtiles','rb') as f:
    print(Reader(MmapSource(f)).metadata().get('strategies'))
"
```

## アプリ側の規約

- 閾値は `app/lib/feature/map/data/model/base_map_tile_spec.dart` の
  `BaseMapTileSpec.cityMinZoom` を単一の参照元にする。backend の
  `CITY_QUAKE_FEATURE_MINZOOM` と同じ値を保つこと。
- 市区町村を参照する塗りつぶしは、このズーム未満では細分区域
  (`areaForecastLocalE`) の塗りつぶしにフォールバックさせる。
- ズーム閾値のパラメータは `effectiveRegionToCityZoom` で下限まで切り上げる。
  切り上げないと、永続化済みの古い設定値やデバッグスライダーの操作で
  「細分区域も市区町村も塗られない帯」ができる。

## ハマりどころ

`EarthquakeHistoryMapLayerParameter.regionToCity` の既定値が `0` だったため、
auto モードの region 側 opacity 式 `['step', ['zoom'], 0.6, regionToCity, 0.0]` が
**全ズームで 0.0** になり、細分区域のフォールバックが無効化されていた。
デバッグモーダルのスライダー範囲は 3〜15 なので UI からは復旧できない値だった。

## build_runner の `--build-filter` は使わない

生成ファイルの一部だけ作り直そうと `--build-filter` を付けると、
**フィルタ外の生成ファイルが削除される**（47 ファイル / 約 20000 行の削除が発生）。
フィルタなしの `dart run build_runner build` で全体を作り直すこと。
なお `--delete-conflicting-outputs` は現行 build_runner では削除済みオプション。
