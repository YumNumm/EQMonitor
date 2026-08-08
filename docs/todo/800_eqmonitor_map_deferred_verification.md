# eqmonitor_mapの延期検証を実施する

## 背景

現在はFlutter Sceneの最小manual smoke exampleとunit testを提供している。
実機確認は未実施だが、renderer foundation実装の開始条件にはしない。

## 未完了事項

- Performance HUDの実装と、metrics収集自体のCPU/memory overhead・event drop検証
- パン、pinch zoom、loading、degraded表示のWidget test
- 固定PMTiles、viewport、DPR、theme、text scaleを使うFill/Line/labelのGolden test
- frame、queue待機、decode、mesh build、GPU、cacheのperformance benchmarkと回帰閾値
- 物理iOS/Android端末のprofile/releaseで、package READMEのmanual smoke
  checklistをそれぞれ実施する

## 実機確認の最低範囲

- procedural mesh、custom material、`TextPainter` overlayの描画
- portrait/landscape回転とsurface/labelの追従
- partial position/color updateの開始・停止
- background/foreground復帰後の継続動作
- app resource rebuildとdispose/remount後の再描画
- frame、partial update、resume、remount、rebuild、exception counterと端末log

実施環境、device/OS、build mode、失敗時のlogは変更記録へ残す。
固定値や手編集で実行結果を代替しない。

## Task 10 (ベースレイヤーPMTiles描画)で先送りした項目

`docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md`の
縦切りで、Task 1〜10の範囲外として意図的に残した項目。

- properties(tag/key/value)とfeature IDのdecode。wire上は読み飛ばしている
  (`lib/src/tile/mvt/mvt_decoder.dart`)。
- bevel/round join、round cap、dash、`linesofar`。`LineMeshBuilder`はmiter
  joinとbutt capのみ実装している。
- Douglas-Peucker等の頂点間引き。decodeした座標をそのままmesh化している。
- MVT extentを超えるbuffer領域のscissor。`FillMesh`/`LineMesh`はtile境界外の
  頂点も落とさず含み、描画側でのclipはまだない。
- 非正規(冗長桁)varintの明示的拒否。`pmtiles_v3`のvarint decoderはこれを行うが、
  MVT decoder側では同等の検証を追加していない。
- Polygonの穴(hole)を持つ実tile fixtureの不在。既存testは`MvtFixtureBuilder`
  で手組みしたfixtureのみで検証している。
- 反転法線fallbackの正式なtest。
- `pmtiles_v3_tile_id_test`の出典コメントに`protomaps/PMTiles`のコミットSHAが
  無い。
- Task 3の`mvt_decoder_test.dart`のコメント「外周は反時計回り」がMVT仕様の
  視覚的表現(時計回り)と逆で紛らわしい。
- MapLibreの6 byte packing(頂点属性の圧縮)は未採用。`FillMesh`/`LineMesh`は
  float32属性のまま。
- ラベル描画、動的レイヤー、remote source、Asset Pack以外のsource、
  attestation検証、hit test、性能HUD、widget/golden testは
  `BaseMapView`のスコープ外。

## Task 10で観測したfloodの真因(特定済み、修正は別コミット)

Task 10の実機確認で「海(land以外の領域)が単一のLine layerの色で塗り潰される」
現象が観測された。当初は`areaForecastLocalEewLine`のLine mesh生成、または
ring境界処理の不具合と推測していたが、**いずれも反証され、真因はGPUへの
頂点属性の受け渡しにあった。**

### 反証された仮説(記録として残す)

以下はすべて測定によって否定された。同じ仮説が再燃したときの参照用に残す。

- **ring境界を越えた頂点接続**: production非依存の独立実装で可視6タイル全数を
  照合し、`crossRingViolations=0`。`LineMeshBuilder.build`は`localOffset`で
  ringを正しく分離している。当初「巨大三角形2枚」と見えたものは、tile buffer
  のclip辺(`y = extent 4096 + buffer 80`)という正当な地物であり、報告値
  16384と4096の差はhalfWidth 4と1の違いで完全に説明できた。
- **MVT extentのハードコード**: `base_map_view.dart`がtile行列へ
  `mvtDefaultExtent`(4096)を固定で渡しているが、実archiveの全layerが
  `extent=4096`であり縮尺の破綻はない(後述の潜在的脆さは別項)。
- **miter limit clampの漏れ**: 可視6タイル全layerの全頂点で押し出し長は
  `[1.0, 4.0000002]`に収まり、上限超過は0件。
- **world空間での過大三角形**: `tileMatrixFor`適用後のworld座標で測っても
  最大534px^2(viewport面積の0.15%以下)であり、画面を覆う規模の三角形は
  1件も存在しない。

### 真因: `setCustomAttribute`の値がshaderへ届かない

`Geometry.setCustomAttribute('extrude', ...)`で渡した押し出し法線がshaderへ
届かず、**代わりに同じ頂点の`position`データが読まれていた**(slot/stride
不整合)。

GPUレベルの実験で確認した。`base_map_line.fmat`のfragment shaderを
`base_color = vec4(abs(extrude.x), abs(extrude.y), 0, 1)`へ差し替えて描画した
ところ、本来`extrude`は`(0, ±1)`の単位ベクトルなので緑一色の帯になるはずが、
**画面中央でぴったり0(黒)、上下端へ向かって単調増加するV字グラデーション**が
画面全高に出た。これはorigin rebasing後の`position`の振る舞い(camera中心で0、
外側へ増加)と完全に一致し、値も数万オーダー(zoom 5のworld pixel座標)で
ランダムノイズではなかった。

これで全症状が説明できる。

- 押し出しが巨大化したlayerは画面を塗り潰す(`areaForecastLocalEewLine`)
- 別のlayerは画面外へ飛んで見えない(`countriesLine`、`areaForecastLocalELine`)
- **Fillはcustom attributeを使わないため正常に描画される**

実験の詳細とevidence画像は
`.superpowers/sdd/2026-08-05-eqmonitor-map-base-layer-pmtiles/extrude-gpu-probe-report.md`
にある(このディレクトリはgit管理外)。

## spike/preflight camera配線は#1593で検証する

上記の実験中に別の不具合が判明した。**`scene_spike_camera.dart`と同型の
camera配線(`scene.NodeCamera` + `EqmonitorOrthographicProjection`)は、この
環境で可視レンダリングを一切生成しない。** production実績のある
`base_map_fill.fmat`を使っても何も描画されず、`BaseMapMaterialPreflightView`
をそのままマウントしても同様だった。段階的なsanity checkで、組み込み
geometry/material + `PerspectiveCamera`は正常に描画され、custom `.fmat` +
`MeshGeometry.fromArrays` + `PerspectiveCamera`も正常に描画されるが、camera
だけを`NodeCamera` + 正射影へ替えた瞬間に黒へ戻ることを確認している。

つまり **Task 1の`BaseMapMaterialPreflightView`は、実際に画面へ何かが出ることを
一度も目視確認されていない。** Task 1では`.fmat`がimpellercでコンパイルされ
shaderbundleに`in vec2 extrude;`が入ることまでは確認したが、描画そのものは
確認していなかった。#1589では`BaseMapView`の恒等cameraとnode transform経路だけを
正式化する。spike/preflightのcamera配線は#1589のsupported routeではない。

`FlutterSceneSpikeView`と`BaseMapMaterialPreflightView`の可視出力、GPU lifecycle、
context recovery、resizeは#1593で一緒に確認する。
