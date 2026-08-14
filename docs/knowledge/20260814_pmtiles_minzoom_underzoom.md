# PMTiles / ベクタソースの minzoom は underzoom されない

## 要点

- MapLibre はソース（TileJSON / PMTiles ヘッダ）の **maxzoom を超えた場合のみ overzoom**
  （親タイルを拡大して描画）する。**minzoom 未満では何も描画されない**（underzoom は存在しない）。
- したがって tippecanoe の `-Z`（最小ズーム）より低いズームでは、レイヤー側の設定に関係なく
  そのソースのフィーチャは一切表示されない。
- 「低ズームでレイヤーが消える」場合は、まずアーカイブのヘッダを確認すること。

## PMTiles ヘッダ・メタデータの確認方法

```bash
curl -s -o data.pmtiles "https://tiles.eqmonitor.app/ixac41/<eventId>.pmtiles"
python3 - <<'EOF'
import struct, gzip, json
data = open('data.pmtiles','rb').read()
u64 = lambda off: struct.unpack_from('<Q', data, off)[0]
print('min_zoom', data[100], 'max_zoom', data[101])
meta = data[u64(24):u64(24)+u64(32)]
if data[97] == 2:  # gzip
    meta = gzip.decompress(meta)
print(json.dumps(json.loads(meta), indent=1, ensure_ascii=False))
EOF
```

メタデータの `generator_options` に tippecanoe の実行引数（`-Z` / `-z`）がそのまま残るため、
生成側の設定ミスを特定できる。`tilestats.layers[].attributes` で各フィーチャの属性と値の
一覧（例: 推計震度タイルの `name` = `intensity:4`〜`intensity:7`）も確認できる。

## 関連

- 推計震度 PMTiles（ixac41）は backend の `ixac41-pmtiles-generator` が `-Z 5 -z 14` で生成して
  おり、zoom 5 未満で表示されない問題がある → `docs/todo/750_estimated_intensity_pmtiles_minzoom.md`
- 推計震度タイルの `fill` 属性には JMA 標準色が焼き込まれているため、アプリのテーマ色で描画する
  場合は `name` 属性（震度階級）を match 式でテーマ色にマッピングする
  （`earthquake_history_details_estimated_intensity_layer.dart`）。
