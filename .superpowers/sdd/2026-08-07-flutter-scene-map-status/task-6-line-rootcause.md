# Task 6: Line rendering root-cause investigation

## 1. 症状ごとの結論

### 症状1: 線の幅が一定に見えない

**root cause 確定。**

現行 shader は `LineMeshBuilder` が tile-local 座標で計算した押し出し法線を `vertex.uv` 経由で受け取り、`base_map_line.fmat` の vertex stage で `vertex.world_position.xy += vertex.uv * half_width_ndc` として加算している。ここで `vertex.world_position` は `_combinedTransformFor` により `viewProjectionMatrixFor * tileMatrixFor` を適用済みの clip/NDC 相当空間であり、screen の Y 軸とは向きが逆である。

しかし `LineMeshBuilder` の法線は tile-local の Y-down 座標で `(-dy, dx) / length` として作られている。NDC 空間へ直接足すなら Y 成分を反転するか、MapLibre と同じく同一行列の線形部で押し出しベクトルを変換する必要があるが、現行実装は正の `half_width_ndc.y` をそのまま掛けている。その結果、水平・垂直線ではたまたま幅が正しく見える一方、斜め線では押し出し方向が線分に直交せず、45 度付近では幅がほぼ 0 まで潰れる。

これは単なる DPR や scalar NDC 換算の問題ではない。`halfLineWidthNdcFor` は既に x/y 別の `vec2` を返しており、非正方形 viewport の x/y NDC 換算自体は現在の式で補正されている。問題は「tile-local/screen Y-down の法線」を「clip/NDC Y-up のオフセット」として無変換で扱っていることにある。

### 症状2: タイルをまたぐと線がおかしくなる

**root cause は複数あり、主因は H2a + H2b が有力、H2d も構造的に確定。**

1つ目の主因は、tile ごとに line mesh を完全に独立生成していること。`BaseMapTileDecoder` は tile 内の `LineString` / `Polygon` ring を tile 単位で `LineMeshBuilder` へ渡し、`LineMeshBuilder` は開いた line の端点を butt cap として扱う。tile をまたぐ地物を別 tile 側の頂点と結合する処理や cross-tile join はない。producer 側で line が tile 境界または buffer 境界で分割されていれば、その分割点は通常の端点として処理される。

2つ目の主因は、MVT の extent 外座標や buffer 領域を保持する一方で、描画側に tile 単位の scissor/clip が見当たらないこと。`MvtDecoder` は座標を command delta から復元してそのまま `rings` に入れ、`FillMesh` の doc comment も extent 外座標を落とさず「tile境界のclipは描画側のscissorが担当する」としている。しかし `BaseMapView._nodesFor` は `scene.Node(localTransform: transform, mesh: mesh)` を作るだけで、tile 境界 clip/scissor を設定していない。buffer 領域の線が隣 tile 側へはみ出し、隣 tile の同一または類似 geometry と重なる可能性がある。

さらに、ancestor fallback 時の重複描画も構造的に存在する。`_rebuildSceneNodes` は cover 内の各要求 tile について `lookupWithFallback` し、親 fallback では `tileId: parent` と `transformFor(wrap, parent)` で node を追加する。複数の子 tile が同じ親へ fallback した場合、同じ親 geometry が同じ transform で複数回追加される。material は opaque なので色の濃さには出にくいが、同一平面の重複 draw / depth 挙動 / 不要 overdraw になり、境界表示の不安定要因になる。

## 2. データフローの逐次追跡

対象は 1 本の line segment の頂点。

1. **MVT decode: tile-local integer**
   - `mvt_decoder.dart` は `MoveTo` / `LineTo` の zig-zag delta を累積し、`Int32List` の `[x0, y0, x1, y1, ...]` として `MvtFeature.rings` に入れる。
   - 単位は MVT layer extent 座標。既定は 4096。負値や extent 超過値を clip する処理はない。

2. **LineMeshBuilder: center position + tile-local normal**
   - `LineMeshBuilder` は segment `d = (dx, dy)` に対し、`normal = (-dy / length, dx / length)` を作る。
   - 端点は隣接 segment が 1 つだけなのでこの normal をそのまま使う。内部頂点は `normalize(prevNormal + nextNormal) * miterLength`。
   - 出力 `positions` は中心線の tile-local 座標を同じ点につき plus/minus 2 頂点ぶん複製した `Float32List`。
   - 出力 `extrudes` は plus 側に `normal`、minus 側に `-normal` を入れる。単位は座標ではなく方向ベクトル。

3. **BaseMapGeometryFactory: Flutter Scene attributes**
   - `positions` は `MeshGeometry.fromArrays(positions:)` 用に `(x, y, 0)` へ拡張される。
   - `extrudes` は custom attribute ではなく `texCoords:` へそのまま渡され、shader では `vertex.uv` として読む。

4. **Node transform: tile-local -> clip/NDC 相当**
   - `_combinedTransformFor` は `viewProjectionMatrixFor(camera, viewport) * tileMatrixFor(tileId, zoom, extent: mvtDefaultExtent)` を `localTransform` に焼き込む。
   - `tileMatrixFor` は tile-local を world pixel へ写す。scale は `worldSizeForZoom(zoom) / 2^canonicalZ / extent`。
   - `viewProjectionMatrixFor` は camera 中心を引き、Y 反転し、正射影へ入れる。`worldHalfHeight = viewport.logicalSize.height / 2` なので、centerline 自体は screen 上で 1 world px = 1 logical px になる。
   - Scene 側 camera は `_IdentityCameraProjection` なので、`Vertex()` 呼び出し時点の `vertex.world_position` は実質 clip/NDC 相当。

5. **base_map_line.fmat vertex stage: NDC offset**
   - 現行式は `vertex.world_position.xy += vertex.uv * material_params.half_width_ndc`。
   - `half_width_ndc = (2h / viewportWidth, 2h / viewportHeight)`。`h` は logical px 単位の半線幅。
   - shader で足した clip offset を screen logical px へ戻すと、`screenOffset = (uv.x * h, -uv.y * h)` になる。screen y は `clip_y` と逆向きだからである。

6. **幅の算術**
   - tile-local segment `d = (dx, dy)`, `L = sqrt(dx^2 + dy^2)`。
   - 現行 `uv = (-dy/L, dx/L)`。
   - 現行 screen offset は `p = h * (-dy/L, -dx/L)`。
   - screen 上での正しい法線は `n = (-dy/L, dx/L)`。
   - 見かけの半幅は `|dot(p, n)| = h * |(dy^2 - dx^2) / (dx^2 + dy^2)|`。
   - 水平線 `dy=0` と垂直線 `dx=0` は `h` になるが、45 度線 `|dx|=|dy|` は `0` になる。したがって「線の幅が一定に見えない」は orientation 依存として説明できる。

## 3. 各仮説の検証結果

### H1a: scalar NDC half-width が非正方形 viewport で aspect ratio 依存を生む

**現行コードでは否定。**

`base_map_line.fmat` の parameter は `vec2 half_width_ndc`、`halfLineWidthNdcFor` は `(2h / width, 2h / height)` を返す。`base_map_geometry_factory_test.dart` にも 400x800 viewport で `(0.005, 0.0025)` を期待する test がある。scalar 同一値を x/y に掛ける状態ではない。

ただし、この test は「NDC 換算値が x/y 別である」ことだけを見ており、`vertex.uv` の Y 向きが clip/NDC 空間と一致するかは検証していない。

### H1b: tile-local normal が screen 空間で正しく変換されていない

**確定。**

tile-local normal は Y-down 座標で作られる。現行 shader はそれを viewProjection の線形部に通さず、clip/NDC 空間へ直接足しているため、Y 軸反転が反映されない。これにより斜め線の押し出しが screen 上で線分に直交しない。

MapLibre の式では `projected_extrude = u_matrix * vec4(dist / u_ratio, 0.0, 0.0)` として押し出しベクトル自体を同じ行列で変換するため、Y 反転や scale は線形部として自然に効く。

### H1c: material/viewport の half width と tile transform scale の不一致

**主因としては否定、fallback 時の位置差は別問題として残る。**

現行の押し出しは tile transform 後の clip/NDC 相当空間へ固定 logical px 由来の offset を足すため、tile の canonical zoom や ancestor fallback の tile scale は幅には直接効かない。material も line layer 単位で共有され、viewport 変更時に `_applyLineHalfWidthToAllMaterials` で再設定される。

ただし、ancestor fallback では低 zoom の geometry を親 tile の transform で描くため、隣接する exact child tile と fallback parent tile の間で線の位置・簡略化度・地物の切れ方が変わる可能性はある。これは「幅が tile scale で変わる」というより、境界で geometry が揃わない問題。

### H1d: DPR / logical-pixel vs physical-pixel mismatch

**否定。**

`halfLineWidthNdcFor` は `viewport.logicalSize` を使う。`tile_matrix_test.dart` には DPR を変えても screen corner が同じ logical px に写る test がある。DPR は projection の logical px 換算に入っていない。今回の orientation 依存は DPR では説明できない。

### H2a: tile ごとに line mesh が独立で、tile edge で butt cap / join 不在

**構造的に確定。**

`BaseMapTileDecoder` は 1 tile の `MvtTile` だけを `LineMeshBuilder` へ渡す。`LineMeshBuilder` は開いた line の始点・終点を butt cap として扱い、隣 tile の ring/part は見ない。cross-tile join は存在しない。

producer が tile 境界または buffer 境界で line を分割しているか、どの buffer 幅かはこのコードからは不明。確認した範囲では、consumer 側でそれを補正する処理はない。

### H2b: MVT buffer 領域を clip せず、隣 tile へ overdraw する

**有力かつ実装上は確定。**

`MvtDecoder` は extent 外座標を拒否せず、そのまま `rings` に保持する。`FillMesh` の doc comment は「tile境界のclipは描画側のscissorが担当」と明記している。しかし `BaseMapView._nodesFor` は Scene node に transform と mesh を設定するだけで、tile 境界ごとの scissor/clip は設定していない。`rg` でも `packages/eqmonitor_map/lib/src` に scissor 実装は見つからなかった。

このため、buffer 領域の geometry が隣 tile 領域へ描かれる。隣 tile 側も同じ地物を持っていれば、互いの buffer geometry が重なり、境界付近で線が太い・ずれる・途切れるように見える可能性が高い。

### H2c: ancestor fallback で隣 tile が異なる zoom level で描かれる

**位置・形状差として有力、幅差としては未確定/主因ではない。**

`BaseMapTileCache.lookupWithFallback` は exact がなければ children、次に ancestor を返す。`BaseMapView._rebuildSceneNodes` は parent fallback の場合、親 geometry を親 tileId の transform で描く。したがって、隣接 tile の一方が exact child、もう一方が parent fallback なら、同じ地物が異なる zoom の geometry として隣り合う。

線幅そのものは NDC offset なので tile zoom に比例して変わる実装ではない。しかし、低 zoom tile の簡略化・切断・buffer が高 zoom tile と一致しない場合、境界で線の位置や形状がずれる。

### H2d: 複数 visible tile が同じ ancestor に fallback して重複描画

**構造的に確定。視覚影響は一部未確定。**

`_rebuildSceneNodes` は `resolved` の各 entry をそのまま node 化する。複数の要求 tile が同じ parent fallback を返しても、`(wrap, parentTileId, styleLayerId)` で dedupe しない。`transformCache` は transform 行列を再利用するだけで node 追加の重複は防がない。

material は `blending: opaque` なので単純な alpha 加算で濃くなるとは限らない。ただし同一平面・同一 z の mesh を複数回描くため、depth/rasterization の不安定さや不要 overdraw の原因にはなる。

## 4. MapLibre との差分

- MapLibre は `projected_extrude = u_matrix * vec4(dist / u_ratio, 0, 0)` として、押し出しベクトルを centerline と同じ行列の線形部で変換してから `gl_Position` へ足す。EQMonitor は既に viewProjection 適用済みの `vertex.world_position` に `vertex.uv * half_width_ndc` を直接足しており、Y 反転を含む線形変換を通していない。
- MapLibre は `u_ratio` で zoom に伴う tile coordinate scale を補正する。EQMonitor は NDC へ直接換算しているため `u_ratio` 相当は持たない。この設計自体は正射影・固定 logical px 幅なら成立し得るが、押し出し方向の座標系変換を別途正しく行う必要がある。
- MapLibre の line generator は miter / bevel / flip bevel / round / cap variants / line distance を持つ。EQMonitor は miter と butt cap のみで、miter limit 超過時も bevel 三角形ではなく長さ clamp だけである。これは鋭角 join の見た目差になり得るが、今回の「斜めで幅が潰れる」主因ではない。
- 提供された MapLibre reference には tile scissor/clip の詳細は記録されていない。一方 EQMonitor 側のコードには「描画側 scissor が担当」とする前提だけがあり、実装が見当たらない。ここは少なくとも EQMonitor 内部の設計と実装が食い違っている。
- MapLibre の tile lifecycle と同様に fallback を探す意図はあるが、EQMonitor の `_rebuildSceneNodes` は同じ ancestor fallback の node 重複を dedupe しない。

## 5. 提案する修正方針（適用しない）

この調査では修正は適用しない。提案のみ記録する。

1. 線幅の orientation 依存は、押し出しベクトルを centerline と同じ変換の線形部で扱う形へ戻すのが最も安全。MapLibre に寄せるなら、tile-local の `extrude * halfWidthInTileUnits` を `viewProjection * tileMatrix` の w=0 ベクトルとして変換し、変換後に加算する。Flutter Scene material の制約で行列を shader parameter として渡せない場合でも、最低限 current NDC 直接加算では `uv.y` の符号を clip/NDC 向けに反転する必要がある。
2. NDC 直接加算を継続するなら、`screenOffset = (uv.x * h, uv.y * h)` になるよう shader 側で `vertex.world_position.xy += vec2(vertex.uv.x * half_width_ndc.x, -vertex.uv.y * half_width_ndc.y)` とする方向が候補。ただし将来 pitch/bearing/perspective を入れるなら MapLibre 型の「同じ行列で押し出しベクトルを変換」が必要になる。
3. tile 境界は、MVT buffer を使う前提なら tile ごとの clip/scissor を実装する。Flutter Scene で scissor が難しい場合は、tile 境界 clip 用の mask/clip geometry、または CPU 側で line/fill を tile bounds へ clip する設計を検討する。
4. fallback parent は `(wrap, parentCanonicalTileId, styleLayerId)` 単位で node 追加を dedupe する。exact child と parent fallback の混在については、同一 screen 領域で親と子を同時に描かないポリシーも確認する。
5. LineString の tile edge butt cap は、producer の buffer と描画 clip が整えば目立ちにくくなる可能性がある。なお cross-tile join 自体を consumer 側で作るのは大きな設計変更なので、まずは MapLibre と同じ buffer/clip 前提を満たすべき。

## 6. 追加すべきテスト

- `LineMeshBuilder` + shader 相当の pure arithmetic test: 水平・垂直・45 度線について、clip/NDC 加算後の screen 上の押し出しが centerline に直交し、半幅が常に `h` になることを検証する。現行式なら 45 度で失敗する。
- `halfLineWidthNdcFor` の値だけでなく、`vertex.uv * half_width_ndc` を `SpikeScreenProjector` 相当で logical px に戻した時の向きと長さを検証する test。
- `BaseMapView._rebuildSceneNodes` 相当の pure 化または helper 化 test: 複数 cover tile が同じ ancestor fallback を返しても、同じ `(wrap, parentTileId, styleLayerId)` の node を重複追加しないこと。
- extent 外座標 / buffer 領域を持つ line fixture を使い、tile 境界 clip/scissor が効くことを確認する test。現状は描画側 scissor が存在しないため、この挙動を検出する test がない。
- LineString が tile 境界で分割された fixture を用意し、butt cap が tile edge に出る現象を明示する regression/characterization test。修正方針によって期待値は「clip されて隣 tile と重ならない」または「join 方針を別途定義する」のどちらかにする。
- non-default MVT layer extent の integration test。`MvtDecoder` は layer extent を読む test があるが、`BaseMapView` は `mvtDefaultExtent` を `tileMatrixFor` に固定で渡している。実データが 4096 固定なら問題化しないが、renderer が layer extent を保持しない設計のため、将来の入力に対する test がない。

## 調査で確認したが未実行のこと

- 指示に従い `flutter test` / `flutter pub get` は実行していない。
- 実機/シミュレータの画像はこの調査では取得していない。
- PMTiles producer が実際にどの buffer 幅・clip 方針で出力しているかは、このコードだけでは不明。consumer 側が buffer 座標を保持し、描画側 clip を実装していないことまでは確認した。
