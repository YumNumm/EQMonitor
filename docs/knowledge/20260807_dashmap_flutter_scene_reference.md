# dashmap Flutter Scene実装から参照する設計知見

## 調査対象

- Repository: `bdero/dashmap`
- Commit: `a6ff92edd999e922f81d26d209d8f589faee3fd0` (2026-08-06)
- License: MIT
- 固定参照: https://github.com/bdero/dashmap/tree/a6ff92edd999e922f81d26d209d8f589faee3fd0
- `flutter_scene`: `pubspec.yaml`では`../../flutter_scene/packages/flutter_scene`へのpath依存、`pubspec.lock`上は`0.18.1`

dashmapは`flutter_scene`上で動く、raster terrain + satellite imagery + Overpass building extrusionの3Dデモである。PMTiles engineでもMVT rendererでもない。
PMTiles、MVT、vector line stroking、tile extent handling、map label描画は確認した範囲では存在しない。したがってEQMonitorの2D base map rendererの正本にはせず、Flutter Sceneを実運用する際の局所的な設計知見として参照する。

## 採用するパターン

- `lib/map/terrain/terrain_streamer.dart` / `lib/map/terrain/tile_mesh_worker.dart`:
  tile scaleはmesh jobへ明示的に渡す。入力データのscaleを隠れた定数にしない点を、`packages/eqmonitor_map/lib/src/widget/base_map_view.dart`の`mvtDefaultExtent`=4096固定除去へ適用する。`packages/eqmonitor_map/lib/src/tile/mvt/mvt_decoder.dart`はlayerの`extent`を読んでいるため、`BaseMapTileGeometry`またはlayer geometry metadataへ伝搬する。
- `assets/globe_terrain.fmat` / `assets/globe_solid.fmat`:
  shader座標空間はmaterial parameterとセットで検証する。dashmapは`curve_center` / `focus_merc_yn`を渡し、vertex stageで相対Mercator座標を扱う。EQMonitorでは`packages/eqmonitor_map/assets/base_map_line.fmat`と`packages/eqmonitor_map/lib/src/flutter_scene/base_map_geometry_factory.dart`の`half_width_ndc` / `texCoords` extrude修正を、座標空間のregression test対象として固定する。
- `lib/map/terrain/heightfield_mesh.dart` / `lib/map/terrain/terrain_streamer.dart`:
  tile境界の見た目はデータ任せにせずrenderer policyとして持つ。dashmapはskirt geometryで隙間を隠し、imagery textureに`clampToEdge`を使う。EQMonitorのMVT buffer clip問題は同じ実装では解けないが、line/fillのtile visible rectに対するclip/scissor/discard方針を明文化する根拠になる。
- `lib/map/terrain/terrain_streamer.dart` / `lib/map/buildings/building_streamer.dart` / `lib/map/buildings/building_mesh.dart`:
  GPU uploadをframe budget化する。dashmapはterrainを3 tiles/frame、buildingを1 chunk/frameで適用し、building chunkは`kBuildingChunkVertexBudget = 24000`に分割する。EQMonitorの`packages/eqmonitor_map/lib/src/widget/base_map_view.dart`は`_rebuildSceneNodes`で`sceneGraph.removeAll()`→`addAll(nodes)`を行うため、将来はmesh upload、visibility/transform更新、scene graph差分適用を分離する。
- `lib/map/terrain/tile_mesh_worker.dart` / `lib/map/buildings/building_worker.dart` / `lib/map/terrain/tile_selector.dart`:
  mesh構築はworker isolateへ逃がし、in-flight cap、exponential backoff、coarse-to-fine ancestor stand-inを組み合わせる。dashmapのrender setは重複なし、load setはancestor pyramidを含む。EQMonitorの`BaseMapTileCache.lookupWithFallback`周辺も、親子tileを同じscreen areaへ重複描画しない不変条件をtest化する。
- `lib/map/geo/floating_origin.dart` / `lib/map/map_camera.dart` / `lib/map/map_screen.dart`:
  Web Mercator meter + floating originでfloat32精度を保つ。現行2D rendererへ混ぜないが、`docs/todo/650_eqmonitor_map_3d_camera.md`の将来3D camera、地下震源、断層面、terrain表現では、地理座標、Mercator meter、altitude meter、render-local floatの境界設計に使える。

## 参考にしないもの

- live第三者データをrender pathへ入れる構造。dashmapはAWS Open Data Terrarium、Esri World Imagery、Overpass API、Photon APIへlive HTTPする。EQMonitorのbase mapはAsset Pack attestationとPMTiles digest/sidecar検証が前提であり、未検証network tileをrendererが直接読む構造は採用しない。
- OSM default heightと`(building.id % 7)`のheight jitter。dashmapは見た目のためにdefault heightや決定的jitterを使うが、EQMonitorは生命に関わる情報を扱うため、震源・断層・hazard表現で推測値を事実のように描かない。
- JSONをhot render pathへ置く設計。dashmapのbuilding cacheはgzipped JSONで、Overpass parseは`Map<String, dynamic>`を通る。EQMonitorの描画経路ではGeoJSON/JSON serializationを使わない。
- StatefulWidget中心の大きなscreen controller。dashmapの`MapScreen`はdemoとして妥当だが、EQMonitorではHookWidget/HookConsumerWidget、repository/provider、Action/Flow分離に合わせる。
- hole未対応のear clipping。dashmapの`lib/map/buildings/building_mesh.dart`はbuilding roof専用で、multipolygon holesはTODOである。EQMonitorのMVT polygon fillでは`dart_earcut`とring winding/holes対応済みの方針を維持する。
- `frustumCulled = false`の無条件コピー。dashmapはglobe wrapで通常boundsが壊れるためmanual horizon cullingとセットで無効化している。EQMonitorの2D tileで同じことをすると描画負荷だけが増える可能性がある。
- unbounded disk cache。dashmapの`TileByteCache`には`TODO(cache-eviction)`があり、長時間roamingで蓄積する可能性がある。EQMonitorのAsset Pack / PMTiles cacheはmanifest policyとsize limitを持つべきである。

## EQMonitorでの適用境界

dashmapはMVT fill/line、PMTiles range fetch、vector tile extent、tile buffer clipping、label placement、glyph atlasの参考実装ではない。これらはMapLibre NativeやEQMonitor独自実装を正本にする。

一方で、Flutter Scene上でmesh生成とGPU uploadを分割する方法、`.fmat` material parameterの座標空間検証、tile境界をrenderer policyとして扱う姿勢、worker isolateとframe budget、floating originは再利用価値が高い。既知のocean flood / line-width / tile-clip問題に対しては、dashmapのvector実装ではなく「scaleを固定値に隠さない」「shader座標空間をmaterial設定と一緒に確認する」「tile境界処理をrenderer policyとして持つ」の3点だけを持ち込む。

## 再取得方法

参照実装はrepository外の`/tmp/refs`へcloneする。workspaceを汚さないため、EQMonitor配下には置かない。

```bash
mkdir -p /tmp/refs
git clone --depth 50 https://github.com/bdero/dashmap.git /tmp/refs/dashmap
cd /tmp/refs/dashmap
git rev-parse HEAD
git log -1 --format='%H %cI'
```

必要に応じて固定commitへ移動する。

```bash
git -C /tmp/refs/dashmap checkout a6ff92edd999e922f81d26d209d8f589faee3fd0
```
