# Flutter Scene map status report

## 1. Executive summary

- `eqmonitor_map` / Flutter Scene 系の設計PRは merge 済み。`docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-01-design.md`はPR #1565相当で、`git log --grep=eqmonitor-map`でも `7ed21d1e7 Merge pull request #1565` を確認した。
- 旧 `2026-08-02-eqmonitor-map-scene-spike.md` は明示的に廃止済みで、現行は `2026-08-03-eqmonitor-map-mise-and-spike-simplification.md`。Scene spike は #1566 後に #1574 で evidence gate を削除し、manual smoke harnessへ簡素化されている。
- planのチェックボックスは3計画とも全て未チェックのまま。`rg "\- \[[xX]\]"` は no match、未チェック数は旧spike 51、mise簡素化 38、base-layer 94。進捗はチェックボックスではなくmerge commit / README / TODOで判断する必要がある。
- `packages/eqmonitor_map` は存在し、Scene spike、Mercator/tile cover、strict MVT decoder、Fill/Line mesh、PMTiles reader、`BaseMapView`、appデバッグページ接続まで実装済み。関連履歴は #1566、#1574、#1579、#1580 と package履歴に残る。
- ベースレイヤーPMTiles縦切りは「デバッグページでFill/Lineをpan/zoom付き描画する」経路まで到達しているが、ステータスは partial。README上、iOS simulatorでFill/pan確認済み、物理端末・pinch確認・Line視覚確認は未完了。
- 既知不具合は当初のflood原因が後続調査で更新されている。最新TODOでは `setCustomAttribute` がshaderへ届かない件は `texCoords` 利用とNDC半線幅換算の修正コミット (`32377f2f3`, `14916951f`) で解消済み扱いだが、`BaseMapTileGeometry` がMVT extentを運ばないなど未解決ギャップが残る。
- `2026-08-02-seismicity-flutter-scene-design.md` は別機能の3D震源表示設計。`develop`に入ったFlutter master / `eqmonitor_map` Scene spikeを前提にするが、2D base map / Home移行の完了条件とは別スコープ。

## 2. Per-plan table

| Plan | Intended outcome | Status | Evidence |
| --- | --- | --- | --- |
| `/home/yumnumm/EQMonitor/docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` | EQMonitor専用Flutter Scene地図レンダラーの設計正本、delivery graph、移行条件を固定する | done as design / implementation partial | PR draft 01はdocumentation-onlyと明記。`7ed21d1e7 Merge pull request #1565 from YumNumm/codex/eqmonitor-map-01-design`。現実装はまだ設計全体ではなく、`BaseMapView`縦切りまで。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-spike.md` | 固定Flutter master + Flutter Sceneで最小package/example、evidence gate、profile/release device gateを作る | superseded / partially implemented historically | 冒頭で「2026-08-03に廃止」と記載。チェックボックス51件は全て未チェック。旧履歴として `768342a4e Merge pull request #1566`、`1dd350bb3 Package`、`382e01a19 Spike`、`0b4a5e8c5 Docs: Scene実機gate結果を記録` があるが、後続 #1574 でevidence gateは削除。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/plans/2026-08-03-eqmonitor-map-mise-and-spike-simplification.md` | YumNumm版 `mise-flutter` へ一本化し、evidence/validator/Dart defineを削除してmanual smoke harnessへ簡素化する | done | PR draft 02に「Flutter SDK導入をYumNumm版mise-flutterへ一本化」「evidence削除」「manual smoke NOT RUN」と明記。`4921a9b1e Merge pull request #1574`、`26eff3260`、`5401b1c22`、`97167bf2d`、`ea3d85862`。チェックボックス38件は未更新。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md` | デバッグページでAsset Pack配布PMTilesをFlutter Scene Fill/Lineとしてpan/zoom付き描画する縦切り | partial | 実装履歴は `aa586b69b` debug page、`7a6483883` MVT decoder、`335f103d8` Mercator/tile matrix、`6dfb4ace0` tile cover、`5f7c9608f` Fill、`bcef16e09` Line、`5967bf55e` Scene adapter、`7bf02d9d2` PMTiles repository、`ceac815b1` BaseMapView、`71f9a10d8` #1579、`26c915608` #1580。READMEはiOS simulatorでFill/pan確認済み、pinch/物理端末/Line見た目未確認。チェックボックス94件は未更新。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-01-design.md` | Design PR本文ドラフト | done / merged | Base `develop`、Head `codex/eqmonitor-map-01-design`、Validation clean。履歴で #1565 merge (`7ed21d1e7`) を確認。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md` | Scene spike / mise simplification PR本文ドラフト | done / merged, with manual smoke not run | 「Merged predecessors: #1565 design, #1566 Scene spike」「Head: codex/eqmonitor-map-mise-simplification」「Manual smoke status: NOT RUN」。履歴で #1574 merge (`4921a9b1e`) を確認。 |
| `/home/yumnumm/EQMonitor/docs/superpowers/specs/2026-08-02-seismicity-flutter-scene-design.md` | Flutter Sceneによる震源3D表示。200万件の震源を3Dで個別表示する別画面 | separate / not part of base map completion | 要件はMapLibreに依存しない独立3D画面。line 22相当で「developで導入済みのFlutter masterとeqmonitor_map Scene spikeを基盤」とするが、stacked PRはseismicity専用で、2D Home/base-layer移行とは別。 |

## 3. Spec vs implementation gaps

- 宣言的 `MapScene` / `MapNode` / `MapElement` / `MapRenderObject` の公開APIとreconcilerは未実装。現行公開APIは `BaseMapView`、`MapCamera`、`VerifiedPmTilesSource`、mesh/decode limit等で、設計正本の全面APIではない。
- ラベル系は未実装。設計はPMTiles label Point layer、TextPainter placement/collision/leader line/semanticsを要求するが、現行はScene spikeの単一overlay proofとBaseMapViewのFill/Lineまで。
- 動的hazard layer、現在地、P/S波、atomic typed delta、fresh/stale/expired、hit testは未実装。READMEの「初期スコープ」には列挙があるが、実装済みなのはベース地図縦切り中心。
- remote PMTilesのidentity encoding / strong validator付きrange合成、signed sidecar attestation、producer semantic validationは未実装。READMEにも「実装stackで追加する計画」「現行manifestがsemantic validationを提供済みという意味ではない」とある。
- `BaseMapView`はMVT `extent`をtile geometryまで運ばず、tile行列へ `mvtDefaultExtent` (4096) を渡している。実archiveでは4096で破綻しないが、設計正本の「tileごとにlayer宣言値を読む」に対する具体的ギャップ。
- 実機検証が未完了。Scene exampleの物理iOS/Android profile/release manual smoke、BaseMapViewの物理端末確認、pinch-zoom確認、Line幅・tile境界の目視確認、祖先fallbackの実機確認が未確認としてREADME/TODOに残る。
- `FlutterSceneSpikeView` / `BaseMapMaterialPreflightView` の `NodeCamera + EqmonitorOrthographicProjection` 経路が実際に描画されるかは未確認。TODOでは `BaseMapView` は別配線で描画されると記録。
- Widget/golden/performance benchmark/HUDは未実装。`packages/eqmonitor_map/test/widget/base_map_view_test.dart` はGestureから分離したpure関数のみ検証し、BaseMapView本体のWidget testではない。
- MapLibre surface移行は未着手。`docs/todo/780_eqmonitor_map_maplibre_surface_migrations.md` の全surfaceチェックボックスが未チェックで、Home Mapすら移行完了していない。

## 4. Open TODOs ranked by priority/blocking

1. **P800 / blocking for renderer confidence:** `/home/yumnumm/EQMonitor/docs/todo/800_eqmonitor_map_deferred_verification.md`
   - 物理iOS/Android profile/release manual smoke、Widget/Golden/performance benchmark、HUD。
   - Task 10由来の具体ギャップ: properties/feature ID decode、bevel/round/dash、Douglas-Peucker、scissor、非正規varint拒否、実tile hole fixture、extent伝搬、fallback重複描画排除。
   - `BaseMapTileGeometry` extent未伝搬は設計違反に近く、次のbase-layer安定化で優先して潰すべき。
2. **P780 / blocking for MapLibre removal:** `/home/yumnumm/EQMonitor/docs/todo/780_eqmonitor_map_maplibre_surface_migrations.md`
   - Home、bounds selector、Live Monitor、EEW details、Earthquake History、Intensity History、Region picker、Tsunami、Seismicity、Hi-net debug、Shake Detection historyの全移行が未チェック。
   - `lockBearing` UI/設定とMapLibre package削除は全surface完了まで不可。
3. **P650 / future 3D and seismicity relation:** `/home/yumnumm/EQMonitor/docs/todo/650_eqmonitor_map_3d_camera.md`
   - bearing/pitch、透視投影、地形、地下震源、断層面。2D base mapの次 milestone ではなく、3D seismicityや将来camera設計時の対象。
4. **P450 / future product surface:** `/home/yumnumm/EQMonitor/docs/todo/450_eqmonitor_map_future_surface.md`
   - Performance HUD、desktop/Web、線上ラベル、汎用package化。初期iOS/Androidの性能・障害時挙動確立後。

## 5. Recommended next milestone

次のmilestoneは「`BaseMapView` stabilization slice」として、Home統合やMapNode全面実装へ進む前に、`docs/todo/800_eqmonitor_map_deferred_verification.md` のうちベースレイヤーに直接効く項目を閉じるのがよい。具体的には MVT extentを`BaseMapTileGeometry`へ伝搬し、pinch/ancestor fallback/Line幅/tile境界をiOS simulatorだけでなく少なくとも物理Androidまたは物理iOS profileで確認し、現在のREADMEの古いflood記述と修正済みコミット後の実態を再同期する。その後に labels / dynamic layers / Home integration のstackへ進む方が、生命に関わる表示の移行として根拠を保ちやすい。
