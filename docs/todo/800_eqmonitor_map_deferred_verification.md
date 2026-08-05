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
- `BaseMapTileGeometry`はdecodeに使ったMVT `extent`を保持しないため、
  `BaseMapView`はtile行列へ`mvtDefaultExtent`(4096)を固定値として渡している。
  実archive(z0/0/0、z4/14/6、z6/57/25で実測)は全layerが`extent=4096`
  だったため現状は破綻しないが、これは計画の漏れであり、4096以外の`extent`を
  宣言するsource layerを持つarchiveでは壊れる潜在的な脆さが残っている。
  layerごとの実際の`extent`を`BaseMapTileGeometry`まで伝播する必要がある。
- tile coverの複数tileが同じ祖先へfallbackした場合の重複描画排除
  (`_BaseMapController._rebuildSceneNodes`)。現状は同じtileが複数回
  描画されても`baseMapLayerSpecs`の色が全て不透明なため見た目には現れないが、
  半透明色を導入する場合は排除が必要になる。

## 既知の不具合(Task 10の実機確認で発見、flood発生元のlayerを特定・未修正)

**海(land以外の領域)が`areaForecastLocalEwLine`(source layer:
`areaForecastLocalEew`, 名目色`0xFFFF7043`のオレンジ)の色で塗られたように
見える不具合がある。**

当初「`countriesLine`のLine meshに縮退した巨大三角形が2枚混入している」
という仮説を報告したが、**この仮説は別agentの検証により反証された。**
問題の三角形の座標は`(4096,4176)→(0,4176)`であり、`y=4176 = extent(4096) +
buffer(80)`と一致する、MVT tile bufferのclip辺という正当な地物だった
(南極付近のWeb Mercator clip辺)。独立実装によるring分離の再検証でも
`crossRingViolations=0`、`bigTriCount=0`が確認されており、
**`LineMeshBuilder`と`_polygonFeatureAsClosedLines`は正常と確定した。**

`BaseMapMaterialLibrary`をlayerごとに独立したmaterial instanceを持つ設計へ
変更し(`spec.color`が実際に反映されるようにした)、zoom=4のデバッグページを
screenshot確認したところ、**画面の海に見える領域全体が`areaForecastLocalEwLine`
の名目色(オレンジ`0xFFFF7043`)そのもので塗りつぶされていた。** land部分は
正しい`countriesFill`/`areaForecastLocalEFill`のベージュ系色で、他のLine layer
(`countriesLine`のグレー、`areaForecastLocalELine`のグレー等)の色は画面上に
確認できなかった。

以上より、flood(画面のほぼ全域を単一のLine layerの色が覆う現象)の原因は
`areaForecastLocalEwLine`(source layer `areaForecastLocalEew`)のLine mesh
生成、またはその元になるMVT座標に何らかの異常がある可能性が高いと推測される
が、**具体的な原因(ring境界か、座標スケールか、tile座標の解釈かなど)は
未特定であり、これ以上の追跡は行っていない。** 該当layerを扱うコードが
`lib/src/mesh/`・`lib/src/tile/`(Task 10の変更対象外)にあるため、修正は
別途担当agent/taskへ引き継ぐ。
