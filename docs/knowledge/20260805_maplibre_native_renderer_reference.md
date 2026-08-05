# MapLibre Native描画実装から参照する具体仕様

## 調査対象

- Repository: `maplibre/maplibre-native`
- Commit: `f1905c521577f009c70179fac53e3f4f67a3fa53` (2026-08-04)
- License: BSD-2-Clause
- 固定参照: https://github.com/maplibre/maplibre-native/tree/f1905c521577f009c70179fac53e3f4f67a3fa53

設計正本`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`はWeb Mercator、tile
cover、overzoom、world wrapをMapLibreの仕様・実装を正とする、と定めている。本書はその「正」の
実体を、コミットを固定したファイル単位で記録する。以下のパスはすべて上記commitのrepository
root相対である。

## 定数

`include/mbgl/util/constants.hpp`。

- `EXTENT = 8192`、`tileSize_D = 512`。設計正本の記述と異なりMVT extentは4096固定ではない。
  extentはMVT layerが自身で宣言する値であり、描画側はtileごとにlayer宣言値を読む。
  tippecanoe既定出力は4096なので、EQMonitorのbase PMTilesは4096になる。
  `s = worldSize / tileScale`から`s / extent`を作る際にこの宣言値を使う。
- zoomのpixel基準は`tileSize_D = 512`。vector sourceの1タイルは512 logical pixelに対応する。
  既存MapLibre実装と同じ見た目を保つため、EQMonitorも512を使う。

## 座標変換

`src/mbgl/map/transform_state.cpp`、`include/mbgl/util/projection.hpp`。

```cpp
double TransformState::zoomScale(double zoom) const { return std::pow(2.0, zoom); }
static double worldSize(double scale) noexcept { return scale * util::tileSize_D; }
static Point<double> project_(const LatLng& latLng, double worldSize) noexcept {
    return Point<double>{LONGITUDE_MAX + lng,
                         LONGITUDE_MAX - rad2deg(log(tan(PI/4 + lat*PI/DEGREES_MAX)))}
           * (worldSize / DEGREES_MAX);
}
```

tile配置行列は`TransformState::matrixFor`が2段で作る。

```cpp
const uint64_t tileScale = 1ull << tileID.canonical.z;
const double s = Projection::worldSize(scale) / tileScale;
matrix::translate(matrix, matrix,
    (tileID.canonical.x + tileID.wrap * tileScale) * s, tileID.canonical.y * s, 0);
matrix::scale(matrix, matrix, s / util::EXTENT, s / util::EXTENT, 1);
```

`clip = projMatrix * matrixFor(tileID) * vec4(tileLocalPos, 0, 1)`が最終形である。tile-local座標を
CPUでworld座標へ展開せず、行列で吸収する。頂点bufferがtile-local整数のまま再利用できるため、
EQMonitorもこの2段構成を踏襲する。

`getProjMatrix`はカメラをクォータニオンで持ち`getCameraToClipPerspective`を掛ける。pitch/bearing
非対応の初期実装では不要であり、正射影の2D行列で開始して後から差し替える。

## tile cover

`src/mbgl/util/tile_cover.cpp`。現行の主経路`tileCover(TileCoverParameters, ...)`はworld copyごとの
root AABBを四分木で分割し`Frustum::fromInvProjMatrix`との交差判定で枝刈りする3D LOD実装である。
pitch/bearingを持たないEQMonitorの初期要件には過剰であり、同ファイルに併存する旧実装
`scanTriangle`/`scanSpans`（画面4隅の投影点を2三角形に分けたscanline方式、中心からの距離でsort）
の粒度で足りる。どちらの経路も「中心に近いtileを先にロードする」ためのsortを最後に行う。

## tile ID

`include/mbgl/tile/tile_id.hpp`。3種の使い分けがEQMonitorの`TileKey`設計の根拠になる。

- `CanonicalTileID{z,x,y}`: データとして一意なtile座標。`scaledTo(z)`は`x >> (z-targetZ)`で親、
  `x << (targetZ-z)`で子相当へ変換する。`children()`は`childX = x*2`。
- `OverscaledTileID{overscaledZ, wrap, CanonicalTileID}`: 「実際に取得・parseするzoom」と「表示上
  要求されているzoom」を分離する。`overscaleFactor() = 1u << (overscaledZ - canonical.z)`。source
  max zoom超過時はこの倍率でtile内を拡大表示する。
- `UnwrappedTileID{wrap, CanonicalTileID}`: world copyを含む描画位置。`matrixFor`の入力はこれ。

## Fill頂点生成

`src/mbgl/gfx/fill_generator.cpp`、`src/mbgl/renderer/buckets/fill_bucket.hpp`。

- `classifyRings`で外形と穴をグルーピングし、`limitHoles(polygon, 500)`で穴数を制限した後、
  `mapbox::earcut(polygon)`へ穴込みで渡して三角形化する。
- 頂点は`attributes::pos`の`int16_t[2]`のみ。法線もUVもない。tile-local座標をそのまま持つ。
- index bufferが16bitのため、`totalVertices > uint16_t::max()`で`GeometryTooLongException`を投げ、
  segment単位でも`vertexLength + totalVertices > uint16_t::max()`で新segmentへ切る。
- fillの複雑さはすべて頂点生成側にあり、shaderは`gl_Position = u_matrix * vec4(a_pos,0,1)`だけ。

## Line頂点生成

`src/mbgl/gfx/polyline_generator.cpp`、`src/mbgl/renderer/buckets/line_bucket.hpp`。EQMonitorが
最も参照すべき箇所である。

各頂点で隣接segmentの単位法線`prevNormal`/`nextNormal`から`joinNormal = unit(prev+next)`を作り、
`miterLength = 1/cosHalfAngle`を求める。`miterLength > miterLimit`で`Bevel`、さらに`> 2`で
`FlipBevel`、round joinは`< roundLimit`なら実質miterへ丸め`<= 2`で`FakeRound`（20°ごとの扇形三角形）
へ落とす。capは`Butt`/`Square`/`Round`で`endLeft`/`endRight`のoffset値を変えるだけである。

頂点packingは6 byte/頂点。

```cpp
using LineLayoutVertex = gfx::Vertex<TypeList<attributes::pos_normal, attributes::data<uint8_t,4>>>;
static LineLayoutVertex layoutVertex(Point<int16_t> p, Point<double> e, bool round, bool up,
                                     int8_t dir, int32_t linesofar = 0) {
  return LineLayoutVertex{
    {{ (p.x*2)|(round?1:0), (p.y*2)|(up?1:0) }},
    {{ clamp(round(63*e.x)+128,0,255), clamp(round(63*e.y)+128,0,255),
       (((dir==0?0:(dir<0?-1:1))+1) | ((linesofar & 0x3F)<<2)),
       (linesofar >> 6) }}};
}
static const int8_t extrudeScale = 63;
```

座標を2倍して最下位bitへround/upフラグを同居させ、押し出し法線を±63へ量子化しoffset 128で
uint8化し、線に沿った距離を14bitでz/wへ分割する。CPU側`LINE_DISTANCE_SCALE = 1.0f/2.0f`と
shader側`#define LINE_DISTANCE_SCALE 2.0`が相殺して元の距離へ戻る。距離が
`MAX_LINE_DISTANCE/2`を超えたら0へリセットして頂点を打ち直す。

index bufferは直近3頂点`e1,e2,e3`から`TriangleElement(e1,e2,e3)`を都度追加する明示的なtriangle
listである。triangle stripではない。

## Line shader

`shaders/line.vertex.glsl`。押し出しの本質は次の3行である。

```glsl
mediump vec2 dist = outset * a_extrude * scale;                 // scale = 1/63
vec4 projected_extrude = u_matrix * vec4(dist / u_ratio, 0.0, 0.0);
gl_Position = u_matrix * vec4(pos + offset2 / u_ratio, 0.0, 1.0) + projected_extrude;
```

押し出しを変換前の座標へ足すのではなく、押し出しベクトルを同じ`u_matrix`で変換して**変換後に
加算**する。`u_matrix`の線形部だけが押し出しへ効くため、perspectiveがあっても線幅が歪まない。
`u_ratio`はzoom変化に伴うtile座標系scaleの補正係数である。

正射影かつpitch 0の2D行列では、この加算はworld空間での押し出しと等価になる。したがって
`dist`をworld単位の半線幅として与えれば、screen上で一定幅の線になる。EQMonitorの初期実装は
この等価性を使って`.fmat`の`vertex{}`ブロックで`world_position`を押し出す。

AA幅の補正は
`v_gamma_scale = length(dist) / length(projected_extrude.xy / gl_Position.w * u_units_to_pixels)`。
perspectiveで押し出しが伸縮する分をfragment側のblur幅へ戻す。正射影では定数になる。

`shaders/_prelude.vertex.glsl`の`unpack_mix_vec2`/`unpack_mix_color`と`u_<prop>_t`は、頂点属性へ
2 zoom stop分の値をpackしuniformの補間係数で`mix`する仕組みである。CPU側で
`zoom_t = (zoom - stopA) / (stopB - stopA)`を毎frame計算する。EQMonitorの初期実装ではCPU側で
現zoomの値を確定しuniform定数として渡し、shaderでは補間しない。

## PMTiles

`platform/default/src/mbgl/storage/pmtiles_file_source.cpp`、`vendor/pmtiles.cmake`。MapLibre自身は
自前parserを書かず`protomaps/PMTiles`のheader-onlyライブラリをvendorする。

- URL scheme判定は`url.starts_with("pmtiles://")`。
- headerは固定offset 0、固定長127 byte。
- tile addressは`pmtiles::zxy_to_tileid(z,x,y)`のHilbert曲線ベース単一IDを`pmtiles::find_tile`へ
  渡し、entryがleaf directoryを指す場合は`header.leaf_dirs_offset + entry.offset`で再帰する。
- directory cacheは`MAX_DIRECTORY_CACHE_ENTRIES = 100`のLRUである。

EQMonitorは`packages/seismicity_pmtiles`で既にPMTiles v3 strict readerを自前実装しており、
`pmtiles`パッケージのprivate APIへ依存しない判断を済ませている。この判断は維持する。

## tileのライフサイクル

`src/mbgl/renderer/tile_pyramid.cpp`、`src/mbgl/algorithm/update_renderables.hpp`、
`src/mbgl/tile/geometry_tile.cpp`。

ideal tileが未ロードなら、まず子tile 4枚を見て4枚揃えば子で埋め、揃わなければ`overscaledZ`を
1段ずつ下げて`scaledTo`で親を探し、最初に見つかったrenderableな親で打ち切る。それでも無ければ
prefetch済みtileで埋める。前frameで描画していてideal集合から外れたtileは`holdForFade()`が真の間
render setへ残す。集合外のtileは`retain`に無ければ`TileCache`へ移し、`needsRelayout`なら破棄する。
`wrap`変化時は`handleWrapJump()`が既存tileのIDを付け替えて再利用しflickerを防ぐ。

parseは`Actor<GeometryTileWorker>`でthread pool上で行い、完了時に`onLayout`がmain threadへ届いて
`GeometryTileRenderData::upload(gfx::UploadPass&)`でGPUへ上げる。`markObsolete()`＝
`mailbox->abandon()`が古い結果を無視する。EQMonitorはこれをIsolate + incarnation tokenで再現し、
Actor modelそのものは移植しない。

## 採用しないもの

- pitch/bearing/perspective前提の`getProjMatrix`、frustum-AABB四分木tile cover。正射影の2D行列と
  scanline相当のtile coverで開始する。
- shader内のzoom依存property補間（`unpack_mix_*`と`u_<prop>_t`）。CPUで確定した定数uniformを使う。
- 6 byte packingのint16/uint8正規化頂点属性。`gpu.VertexFormat`のint16/uint8正規化対応が未検証
  のため、初期実装はfloat32属性で行う。packing方式自体は後段の最適化候補として残す。
- miter以外のjoinとbutt以外のcap、`linesofar`とdash。基本形の描画が出た後に足す。
