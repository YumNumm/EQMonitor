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

## 原因の訂正（2026-08-04 追記）

上記「原因 1」の `max_zoom` z10 → z8 は**真因ではない**。同じ入力・同じ
オプションでローカル再現したところ、tippecanoe **2.79.0 では z8 のままドロップが
発生せず**、全 1894 市区町村を保持して 11.6MB に収まった。

真因は **CI の tippecanoe が distro パッケージで固定されていなかったこと**。
Ubuntu 24.04 の tippecanoe 2.49.0 は z6–z8 のタイル予算を `dropped_by_rate` で
解決してしまう。`-z8` 自体は意図的な設計なので戻す必要はない。

| build | tippecanoe | maxzoom | z8 の distinct `regioncode` | サイズ |
|---|---|---|---|---|
| ローカル | 2.79.0 | 8 | 1894 | 11.6MB |
| CI v0.0.2 | 2.49.0 | 8 | 65 | 9.5MB |
| CI v0.0.0 | 2.49.0 | 10 | 1894 | 104.9MB |

`asset-pack-v0.0.2.zip` も 9,470,108 bytes で同じ欠落を抱えている。
修正 PR: <https://github.com/YumNumm/eqmonitor-backend/pull/980>。
詳細は `docs/todo/500_asset_pack_city_polygons_dropped.md`。

なお「原因 2」の GDAL 3.8.4 + `COORDINATE_PRECISION` は別問題として実在し、
`areaForecastLocalE` の `530`（兵庫県北部）と `areaForecastLocalEew` の
`9280`（兵庫）が欠落する。tippecanoe の固定では解消しない。

## 確認コマンド例

Release の zip サイズで一次判定する（`parameters/*.json` は不変なので差は地図タイル）:

```bash
for v in 0.0.0 0.0.1 0.0.2; do
  gh release view "asset-pack-v$v" --repo YumNumm/eqmonitor-backend \
    --json assets --jq '.assets[] | "\(.name) \(.size)"'
done
```

`all.pmtiles` 単体を検証するときは metadata の `strategies` を見る。
`dropped_by_rate` があれば tippecanoe が地物を捨てている:

```bash
python3 -c "
import json,struct,gzip,sys
f=open(sys.argv[1],'rb'); h=f.read(127)
off,ln=struct.unpack('<QQ',h[24:40]); f.seek(off)
md=json.loads(gzip.decompress(f.read(ln)))
print('minzoom/maxzoom:', h[100], h[101])
print('generator_options:', md['generator_options'])
print('strategies:', json.dumps(md.get('strategies')))
" app/android/app/src/debug/assets/eqmonitor_assets/map/all.pmtiles
```

実機に展開済みの pack が manifest と一致しているかは sha256 で確認できる:

```bash
adb shell run-as net.yumnumm.eqmonitor \
  sha256sum files/eqmonitor_assets/map/all.pmtiles
adb shell run-as net.yumnumm.eqmonitor cat files/eqmonitor_assets/manifest.json
```

なおこの sha256 一致は「Release の中身をそのまま展開できている」ことしか保証しない。
タイル自体が欠落している今回のケースは sha256 では検出できないので、
必ず `strategies` / 地物数の側で検証する。
