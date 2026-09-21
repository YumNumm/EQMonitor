# 地図レンダラの固定参照と採用範囲

独自実装の前に対象分野の参照実装を確認する。commit と license は以下に固定し、更新時は差分を再評価する。
EQMonitor の実装・未完了項目は [設計契約](map_renderer.md) と TODO で確認する。

## MapLibre Native

- Repository: [maplibre/maplibre-native](https://github.com/maplibre/maplibre-native/tree/f1905c521577f009c70179fac53e3f4f67a3fa53)
- Commit: `f1905c521577f009c70179fac53e3f4f67a3fa53` / License: BSD-2-Clause。
- Web Mercator、tile cover、overzoom、world wrap、MVT fill/line、tile edge 処理の参照先。
- `include/mbgl/util/constants.hpp`: zoom は 512 logical pixel 基準。内部 `EXTENT=8192` と MVT layer の extent は別であり、4096 固定にしない。
- `src/mbgl/map/transform_state.cpp`: `clip = projection * tileMatrix * tileLocalPosition`。tile 平行移動と extent scale を行列にし、CPU で毎回全頂点を world 座標へ展開しない。
- `src/mbgl/util/tile_cover.cpp`: 中心に近い tile を優先する。初期 2D では scanline 相当を参考にし、3D frustum 四分木を無条件に移植しない。
- `include/mbgl/tile/tile_id.hpp`: canonical、overscaled、world-wrap 付き描画 ID を分離する。
- `src/mbgl/gfx/fill_generator.cpp`: winding で外形/穴を分類して earcut、16-bit index の segment 上限を守る。入力 geometry の妥当性検査は別途必要。
- `src/mbgl/gfx/polyline_generator.cpp`: 隣接法線から miter を作り、長すぎる join を bevel 等へ切り替える。cap と line distance も頂点生成側の責務。
- `shaders/line.vertex.glsl`: 押し出しベクトルを行列の線形成分で変換して投影後に加算し、zoom scale と AA を補正する。座標空間を material と一緒に検証する。
- int16/uint8 packing、dash、shader 内 zoom 補間は参考であり、未検証の GPU format を前提に導入しない。
- `src/mbgl/renderer/tile_pyramid.cpp`: 親子 fallback、保持集合、obsolete job の破棄を参考にする。同じ画面領域への親子重複描画を避ける。
- `platform/default/src/mbgl/storage/pmtiles_file_source.cpp`: PMTiles の 127-byte header・Hilbert TileID・leaf traversal の参照先。Dart 側は所有する strict reader を使う。

## KEVi

- Repository: [ingen084/KyoshinEewViewerIngen](https://github.com/ingen084/KyoshinEewViewerIngen/tree/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f)
- Commit: `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f` / License: MIT、Copyright © 2019 ingen084。
- geometry cache の追加調査だけは `cc5ce50b19e0a68b18bcc3a7caa0df413bd8ed05`。
- `MapControl.cs` / `MapLayer.cs`: UI/render snapshot、refresh と継続更新の区別。typed dirty reason は EQMonitor 側の追加方針。
- `MapLayerHost.cs`: phase 内の宣言順と逆順 hit test。global order は EQMonitor の canonical sort を使う。
- `PointLayoutCache.cs` / `NormalizedPointSet.cs` / `HoverTracker.cs`: array-backed projection cache、更新後の要素照合。immutable index と stable feature ID は EQMonitor 側で定義する。
- `MapLayerLabelRenderer.cs`: 実測ラベルと screen placement。alternate 地理 anchor を採用したことにはしない。
- `Data/PolygonFeature.cs` / `PolylineFeature.cs`: `baseZoom=ceil(zoom)` の整数 zoom geometry を `2^(zoom-baseZoom)` で変換し、線幅を逆補正する。微小 zoom ごとに mesh を再生成しない。
- 非同期三角形化と近隣 zoom の代替表示、未使用 cache 解放を参考にする。実装は TopoJSON 由来の arc 共有・MessagePack/LZ4 であり PMTiles engine ではない。
- stroke は Skia に委譲されている。太線 mesh、Miller projection、単純 wrap、camera 変更ごとの全 cache 破棄、次 frame での GPU dispose は移植しない。

## dashmap

- Repository: [bdero/dashmap](https://github.com/bdero/dashmap/tree/a6ff92edd999e922f81d26d209d8f589faee3fd0)
- Commit: `a6ff92edd999e922f81d26d209d8f589faee3fd0` / License: MIT。
- Flutter Scene の raster terrain / imagery / building デモ。PMTiles、MVT、vector stroke、label、glyph atlas の正本にはしない。
- `lib/map/terrain/tile_mesh_worker.dart` / `terrain_streamer.dart`: mesh job へ scale を明示、worker/in-flight cap/backoff、coarse-to-fine fallback を分離する。
- `assets/globe_terrain.fmat` / `globe_solid.fmat`: material parameter と shader の座標空間を一体で確認する。
- `heightfield_mesh.dart`: tile 境界は renderer policy。skirt をそのまま MVT clip の解決策としない。
- terrain/building streamer: upload を frame budget 化し、mesh upload と visibility/transform/scene 差分を分離する。
- `lib/map/geo/floating_origin.dart`: 将来の 3D で Mercator meter・altitude・render-local float を分ける参考。
- live 未検証 tile、架空の height/jitter、hot path JSON、hole 非対応の三角形化、無制限 disk cache、無条件 culling 無効化は採用しない。

参照 repository は作業用一時ディレクトリへ取得し、EQMonitor 内へコピーしない。ライセンス表記と pin を保ち、参照先の設計と EQMonitor 固有の追加要件を区別する。
