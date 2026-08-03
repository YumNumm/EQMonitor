# Asset Pack v0.0.1 が 9MB に縮んだ原因

## 症状

- `asset-pack-v0.0.0.zip`: **88.4 MB**（`map/all.pmtiles` 104.9 MB）
- `asset-pack-v0.0.1.zip`: **9.0 MB**（`map/all.pmtiles` 9.5 MB）
- `parameters/*.json` は両バージョンで同一。地図タイルだけが壊れている

## 欠落内容（z8 日本 bbox で確認）

| レイヤ | v0.0.0 | v0.0.1 |
|---|---|---|
| `areaInformationCityQuake` | 1894 | **65** |
| `areaForecastLocalE` | 188 | 187（兵庫県北部欠落） |
| `areaForecastLocalEew` | 56 | 55（兵庫欠落） |

## 原因（backend `f49af2c9`）

1. `tools/base-map-pmtiles/build_pmtiles.py` の `max_zoom` が **z10 → z8** に変更された
   tippecanoe `--drop-densest-as-needed` と組み合わさり、市区町村ポリゴンが大量ドロップされた
2. `COORDINATE_PRECISION=7` を CI の **GDAL 3.8.4** で使うと、一部ポリゴンが `GeometryCollection` になり tippecanoe が読み捨てる
   （ローカル GDAL 3.13 では再現しない。Docker `ghcr.io/osgeo/gdal:ubuntu-small-3.8.4` で再現）

## 対応方針

- 暫定: `upload-asset-pack.yaml` で **v0.0.0 を再アップロード**
- 恒久: backend で `max_zoom=10` に戻し、`COORDINATE_PRECISION` を GDAL 3.8 では使わない（または CI GDAL を 3.9+ に上げる）。リリース前に PMTiles 内地物数を検証する

## 確認コマンド例

```bash
gh release view asset-pack-v0.0.1 --repo YumNumm/eqmonitor-backend \
  --json assets --jq '.assets[] | "\(.name) \(.size)"'
```
