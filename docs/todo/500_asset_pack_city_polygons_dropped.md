# Asset Pack v0.0.2 で市区町村ポリゴンが欠落している

配信中の `asset-pack-v0.0.2` の `map/all.pmtiles` に市区町村ポリゴンがほぼ入っておらず、
市区町村単位の塗りつぶしが描画されない。

backend 側の修正 PR: <https://github.com/YumNumm/eqmonitor-backend/pull/980>

## 影響

以下がすべて機能しない:

- `earthquake_history_fill_layer.dart` の `buildCityLayer`
  （`eq-history-jma-*-city-fill` / `eq-history-lpgm-*-city-fill`）
- `intensity_fill_layer.dart` の `intensity-history-lv2-city-fill`

いずれも `source-layer: areaInformationCityQuake` を
`['in', ['get', 'regioncode'], ['literal', codes]]` で絞り込むため、
タイル側に地物が無いと無音で「塗りつぶしゼロ」になる（例外も出ない）。

細分区域単位（`areaForecastLocalE`）は残っているため、
「区域は塗れるが市区町村は塗れない」という症状になる。

アプリ側の実装・フィルタ・属性キーはいずれも正しく、修正は不要。

## 原因

**CI の tippecanoe が distro パッケージ（Ubuntu 24.04 = 2.49.0）で固定されていなかったこと。**

同じ入力・同じオプション（`-Z0 -z8 --drop-densest-as-needed`）で
tippecanoe のバージョンだけを変えて比較した結果:

| build | tippecanoe | maxzoom | z8 の distinct `regioncode` | サイズ | strategies |
|---|---|---|---|---|---|
| ローカル再現 | **2.79.0** | 8 | **1894** | **11.6MB** | `tiny_polygons` のみ |
| CI v0.0.2 | 2.49.0 | 8 | 65 | 9.5MB | z6–z8 に `dropped_by_rate` |
| CI v0.0.0 | 2.49.0 | 10 | 1894 | 104.9MB | `tiny_polygons` のみ |

2.49.0 は z6–z8 のタイル予算を `dropped_by_rate`（2162 / 2281 / 2607 件）で解決するが、
2.79.0 は同じ入力を tiny-polygon 削減で処理し全 1894 を保持する。

当初は `max_zoom` の z10 → z8 変更が原因と考えたが、これは誤り。
`-z8`（約38m精度）は backend commit `f49af2c9` での意図的な設計であり、
tippecanoe 2.79.0 なら z8 のままサイズも小さく完全な被覆が得られる。

## `tilestats.count` は検証に使えない

壊れている v0.0.2 の方が値が大きいため、gate に使うと**素通りする**:

| レイヤ | v0.0.0（正常） | v0.0.2（欠落） |
|---|---|---|
| `areaInformationCityQuake` | 1910 | **1914** |
| `countries` | 177 | **257** |

`tilestats` は入力 GeoJSON の地物数を反映しており、タイルに実際に書かれた地物数ではない。
`build_pmtiles.py` の `verify_layers` も `vector_layers` の **id 有無**しか見ていない。
これが v0.0.1 / v0.0.2 がリリースされてしまった直接の理由で、PR #980 で
`strategies` を検査する gate を追加した。

## 併せて判明した別問題（兵庫県北部・兵庫が塗れない）

CI の GDAL 3.8.4 と `COORDINATE_PRECISION=7` の組み合わせにより、
以下がタイルに存在せず**一切塗りつぶせない**。tippecanoe の固定では解消しない。

| レイヤ | code | 名称 |
|---|---|---|
| `areaForecastLocalE` | `530` | 兵庫県北部 |
| `areaForecastLocalEew` | `9280` | 兵庫 |

backend 側 todo: `docs/todo/600_base_map_gdal_geometrycollection_loss.md`

## 暫定対応（ローカル / 検証）

正常な v0.0.0 を明示ステージする:

```bash
GH_TOKEN=... tool/asset_pack/stage_from_release.sh \
  --version 0.0.0 --target android-debug
adb shell pm clear net.yumnumm.eqmonitor   # 展開キャッシュを破棄
```

`.version` marker は versionCode 単位なので `pm clear` が必須
（`docs/todo/400_android_asset_pack_followups.md` の 3 番と同じ理由）。
ただし v0.0.0 は 88MB（`all.pmtiles` 104.9MB）で、`countries` が ne_110m の
旧仕様なので、恒久対応は PR #980 マージ後の新しい pack を使うこと。

## 併せて検討したいこと

アプリ側の `regionToCity` 既定値は 8 で、タイルの `maxzoom` も 8。
市区町村塗りつぶしが overzoom されたタイルにのみ依存する構成なので、
今後 maxzoom を下げる変更をする場合は市区町村の被覆率を必ず実測する。
