# eqmonitor_map

EQMonitor専用のFlutter地図レンダラーです。

Flutter SceneをGPU描画基盤としてPMTiles/MVTの地物を描画し、ラベルはasset内の1つの地理anchorから、実測文字サイズとDPRに応じたscreen placement候補を生成してFlutterの`TextPainter`で描画します。MapLibre Style JSON互換ではなく、型付きの宣言的`MapNode`ツリーを利用します。

> [!IMPORTANT]
> #1589では、`BaseMapView`の恒等Scene cameraとtile/layer nodeの
> `localTransform`を正式なcamera経路とする。Line floodはcustom attributeの
> slot/stride不整合が原因であり、`texCoords`とviewport由来のNDC半線幅へ移行済み。
> ただし今回device/simulator/E2Eは実施していない。下記のiOS simulator観測は
> Task 10当時のBaseMap Fill/panの履歴であり、今回のextent、fallback、camera境界を
> 検証するものではない。

## appからの利用

`app`は`eqmonitor_map`へ依存し、デバッグページ「EQMonitor Map (Flutter Scene)」から
`BaseMapView`を表示します。`app/lib/feature/settings/children/config/debug/eqmonitor_map/`
配下の`eqmonitor_map_debug_source_provider.dart`が、`AssetPackRepository.resolveAsset`で
検証済みのbase map PMTilesを解決し(未準備なら`AssetPackNotReadyException`をエラー表示へ
流す。デバッグページ専用のmanual override経路も持つ)、そのarchiveのPMTiles headerから
実際の`minZoom`/`maxZoom`を読んで`MapBaseLayerLimits`を組み立てます。

`.fmat`はpackage rootの`hook/build.dart`がDart Data Assetとして生成します。`app`は
`pubspec.yaml`の`flutter: config: enable-dart-data-assets: true`で有効化済みのため、
マシンごとの`flutter config --enable-dart-data-assets`は**不要**です(CD配布バイナリで
`.fmat`が見つからない不具合の修正として追加されました。pubspecの`flutter: config:`は
マシンごとのglobal設定より優先されます)。未設定/未反映だと`Scene.initializeStaticResources()`
が失敗し`Flutter Scene is not ready to render.`が出続けます。詳細は
[`docs/knowledge/20260803_flutter_scene_dart_data_assets.md`](../../docs/knowledge/20260803_flutter_scene_dart_data_assets.md)を参照してください。

## 初期スコープ

- iOS / Android
- Flutter master channel
- 北固定・真上視点のパンとzoom
- ローカル / HTTPS PMTiles
- MVT Fill / Line
- TextPainterラベル
- 型付き動的Point / Circle / Polygon状態
- camera controller、fitBounds、座標変換、hit test
- 性能イベントとsnapshot

remote PMTilesのidentity encoding/strong validator付きrange合成、appがsigned sidecarまで検証したAsset Pack descriptor、producerのglobal semantic検証とruntimeのbounded per-tile検証は、実装stackで追加する計画です。現行manifestがsemantic validationを提供済みという意味ではありません。source revisionを跨いだtile fallbackは行いません。

設計の正本は[`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`](../../docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md)です。

## 設計原則

- runtimeの`MapNode`を含むデータモデルは不変かつ原則Freezedとし、JSONは明示的な保存・通信DTO/specだけに要求する。
- 描画経路でGeoJSONやJSON serializationを使わない。
- hot pathのsnapshot/deltaとpacked bufferはversion付きruntime型とし、JSONやgeometryのdeep equalityを使わない。deltaは`baseRevision`/`targetRevision`をatomicに検証し、gap時は完全検証済みのより新しいauthoritative full snapshotへresyncする。
- full snapshotは全内容の検証後だけatomic commitし、低revision、同一revisionのdigest競合、malformed snapshotを既存stateへ適用しない。新しいsource identityもfull commit成功後だけ交換する。
- 注入clockのwall/monotonic時刻をframeごとに1回だけ固定する。動的sourceのfresh/stale/expiredはload stateと分離し、staleはage/provenanceを公開、expired hazardと現在地はanimationを止めてfail closedする。
- Feature単位のScene Nodeを作らず、tile/layer/material単位でbatchする。
- 描画順とhit test順はphaseを含むcanonical `RenderSortKey`だけから決める。宣言順はphase内だけで有効とし、labelとleader lineは`labelForeground` phaseに置く。
- UI IsolateでMVT decodeやmesh構築を行わない。
- source identity、async incarnation、GPU completion/context generationを分離して管理する。
- Asset Pack manifest/trust/size/hashと、PMTiles隣の`*.eqmonitor-attestation.v1.json`の署名・expiry・sequenceはappが検証し、packageへimmutable verified source descriptorを渡す。sidecarがmissing/unknown/invalid/expiredなら新rendererはsourceをmountしない。`eqmonitor_map`は`app`へ依存しない。
- 2D初期実装でも座標モデルからZ軸を削除しない。
- 性能HUDより先に、軽量で常時利用できる観測基盤を実装する。
- MapLibre版と共有`lockBearing`設定は残存surfaceの移行完了まで削除しない。新Home rendererだけが回転を明示的に無効化する。
- Flutter Sceneはadapter内へ隔離し、iOS/Android実機のmanual smokeで主要操作を確認する。

## 固定toolchain

- Flutter: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene: `7f71993b7e2a0ab1d2f59726a406098709be7291`

```bash
mise install flutter
mise exec -- flutter --version --machine
```

Flutter SDKはYumNumm版`mise-flutter`と`mise.toml`、Flutter Sceneはpackageの
`pubspec.yaml`とroot lockfileを正本とします。Flutter/Dart commandは常に
`mise exec --`経由で実行します。

Flutter Sceneのbase shader bundleと`assets/map_spike.fmat`はbuild hookが生成する
Dart Data Assetです。**`packages/eqmonitor_map/example`は独自の`pubspec.yaml`を持ち、
`app`のような`flutter: config: enable-dart-data-assets: true`をまだ持たないため**、
example配下でbuildする場合は引き続きmachineごとに1度だけ次を実行してからbuildします。
未設定の場合`Scene.initializeStaticResources()`が失敗し、
`Flutter Scene is not ready to render.`が毎frame出力されます。詳細は
[`docs/knowledge/20260803_flutter_scene_dart_data_assets.md`](../../docs/knowledge/20260803_flutter_scene_dart_data_assets.md)
を参照してください。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter config --enable-dart-data-assets
```

Flutter Scene型は`flutter_scene/` adapter内に隔離します。通常のdomain/runtime
modelは不変かつFreezedを原則としますが、frameごとのsnapshot/delta、packed buffer、
generation tokenはallocationとdeep equalityを避けるためversion付きhot-path型を使います。
この例外を公開DTOやJSON境界へ広げません。

## Scene exampleのmanual smoke

物理iOS/Android端末のdevice IDを`mise exec -- flutter devices`で確認し、
example directoryからprofileとreleaseをそれぞれ起動します。

```bash
cd packages/eqmonitor_map/example
mise exec -- flutter run --profile -d <device-id>
mise exec -- flutter run --release -d <device-id>
```

各build modeで次を画面と端末logの両方から確認します。結果のJSONや
pass/fail artifactは生成しません。

- procedural meshの三角形とcustom materialの色が表示される。
- Flutterの`TextPainter`で描画したlabel overlayがmeshの上に表示される。
- portrait/landscapeの回転後もsurfaceとlabelの位置・サイズが追従する。
- `Start partial updates`でposition/colorが更新され、`Stop partial updates`で停止する。
- backgroundへ移行してforegroundへ復帰した後、resume counterが増え、描画とpartial updateが継続する。
- `Rebuild app resources`後にrebuild counterが増え、procedural mesh、custom material、labelが再表示される。
- `Dispose and remount`後にremount counterが増え、各counterを維持したまま操作を続行できる。
- 各操作の前後でexception counterが増えず、端末logにFlutter/Scene例外や連続エラーがない。

## #1589の自動受け入れ結果とcamera境界

- source layerごとのMVT extentはdecodeから`BaseMapTileLayerGeometry.extent`、
  Scene非依存のrender planを経てlayer nodeの行列まで伝播する。2048/8192 fixture、
  祖先fallback後のtransform入力、行列testで確認している。
- fallbackは要求cover/decodeを保ったまま`UnwrappedTileId`で重複排除する。同一の
  祖先を重ねないことはunit testで確認している。
- #1589の正式なcameraは、`BaseMapView`の恒等`scene.NodeCamera`と
  `baseMapTileViewProjectionMatrixFor(...)`をnodeの`localTransform`へ一度だけ
  設定する経路だけである。
- `createSceneSpikeCameraSetup()`が返す`NodeCamera` +
  `FlutterSceneOrthographicProjection`、`FlutterSceneSpikeView`、
  `BaseMapMaterialPreflightView`は可視出力未確認のdiagnostic pathであり、#1589の
  supported routeではない。削除・再配線・resize/lifecycle検証は#1593で扱う。

Android/iOS GPU、実際のpinch、祖先fallbackの画面差し替え、非4096 archiveのGPU表示は
残余platform riskである。device/simulator、golden、E2Eは今回実施していない。

## Task 10当時の`BaseMapView` simulator観測

これはTask 10での観測履歴であり、現在の#1589変更の受け入れ結果ではない。iPhone 17 Pro
simulator (iOS 27.0)を使い、appのデバッグページ
「EQMonitor Map (Flutter Scene)」から`BaseMapView`を実際に開いて確認しました。
使ったPMTilesはAsset Pack未準備時のデバッグ専用override経路
(`eqmonitor_map_debug_source_provider.dart`)で読み込んだ、本番相当の
`app/android/app/src/debug/assets/eqmonitor_assets/map/all.pmtiles`
(11,640,567 byte、zoom 0..8)です。

### 確認できたこと

- デバッグページを開くと、日本の海岸線が正確な形状でFillレイヤーとして描画される
  (screenshotで本州・四国・九州の実際の地形と一致することを目視確認)。
- 1本指ドラッグ(pan)でcamera中心が実際に動き、表示される地物も追従して変化する。
  HUDの`visibleTiles`/`decoding`もtile読み込みに応じて変化し、0へ収束する。
- zoomはarchiveのheaderから実測した範囲(このarchiveでは`[0, 8]`)でclampされる。

### この観測で確認できなかったこと

- pinch-zoom(2本指)の実機/simulator確認。simulator操作に使ったmouseベースの
  自動操作は単一pointerしか扱えず、2本指のscale gestureを合成できませんでした。
- `ColoredBox`のbackground色(layer仕様の`background`行の色)、線幅や色の見た目、
  tile境界の隙間・重複の視覚的確認。当時のLine floodの影響で判別できませんでした。
- iOS/Android物理端末での確認(simulatorのみ実施)。
- `BaseMapTileCache.lookupWithFallback`の祖先fallback(overscale)が実際に
  画面上で発動する様子。z4のtileには`countriesFill`/`countriesLine`が空の
  layerとして含まれており(=exact hitで、fallbackは発動していない)、その
  zoomで見えている陸地は`areaForecastLocalEFill`が描いています。祖先
  fallback自体はunit test(`base_map_tile_cache_test.dart`)で検証済みですが、
  実機のscreenshot上でfallbackが実際に効いている場面を具体的に特定・
  確認してはいません(以前の版のこのREADMEには、これをoverscale確認済みと
  誤って記載していました。team-leadの指摘により訂正しています)。

### 修正済み: Line floodの原因

海(land以外の領域)が`areaForecastLocalEwLine`(source layer:
`areaForecastLocalEew`, 名目色`0xFFFF7043`のオレンジ)の色で塗られたように見えた。

当初「`countriesLine`のLine meshに縮退した巨大三角形が2枚混入している」と
報告しましたが、**この仮説は別agentの検証により反証されました。** 問題の
三角形の座標は`(4096,4176)→(0,4176)`で、`y=4176 = extent(4096) + buffer(80)`
と一致する、MVT tile bufferのclip辺という正当な地物でした。独立実装による
ring分離の再検証でも`crossRingViolations=0`・`bigTriCount=0`が確認されており、
**`LineMeshBuilder`と`_polygonFeatureAsClosedLines`は正常と確定しています。**

真因はcustom attributeのslot/stride不整合で、shaderが意図したattributeではなく
positionを読んでいたことだった。Lineは`texCoords`とviewport由来のNDC半線幅へ移行済みで
ある。これは自動テストの受け入れ範囲だが、修正後のGPU可視出力は今回確認していない。

### Task 10で確認できなかったLine layer

`areaForecastLocalELine`/`areaForecastLocalEewLine`/`areaInformationCityQuakeLine`
が、Task 10のscreenshot上のどの位置でも視覚的に確認できませんでした。実際に画面へ
表示されていたはずのtileを座標から逆算して直接decodeしたところ、これらの
layerには非空・十分な量の頂点データが実在していました(例:
`areaInformationCityQuakeLine`が1 tileあたり84780頂点)。これは当時の可視出力の
観測であり、現在のLine実装のGPU可視性を検証するものではない。今回の自動確認だけでは
Line layerごとの見た目を結論づけず、GPU可視性は残余platform riskとして扱う。

### 修正済み: decode中は上位zoomのtileを表示し続ける(zoom窓の非対称化)

`BaseMapTileCache`のzoom窓は元々`|entry.z - activeZoom| > 1`という対称な
±1窓だった。pinchでzoomが2段以上一気に動く(例: z4→z6)と、要求tileの
祖先(z4)がまだdecode済みであっても即座に窓の外へ出て破棄され、
`lookupWithFallback`の`maxParentSteps`引数をどれだけ大きくしても遡る先が
無くなる、という計画上の矛盾があった(decode中に粗いtileを表示し続けたい
というユーザー要求を満たせない)。

`BaseMapTileCache`のconstructorに`maxParentFallbackSteps`を追加し、窓を
非対称にした: 上方向は`activeZoom + 1`のまま、下方向は
`activeZoom - maxParentFallbackSteps`まで保持する(低zoomのtileは1archive
あたりの総数が指数的に少ないため、深く保持してもメモリ増分は小さい)。
`test/tile/base_map_tile_cache_test.dart`にzoom跳躍後も祖先が残り
`lookupWithFallback`が祖先を返すこと、`maxParentFallbackSteps`を超えた
祖先はそれでも破棄されることのunit testを追加し、対称±1へ戻すbug
injectionで新規testが落ちることも確認した。

**この修正の効果(decode中に粗いtileが表示され続けること)は、
unit testでは検証済みだが、実機/simulatorのscreenshotでは確認していない。**
pinch-zoomがこのセッションのtooling(mouseベースの`cliclick`、
`device-interaction` skillの実ツール未提供)では再現できず、zoomの
瞬間的な遷移を伴う実機確認ができなかったため。

## Delivery graph

`eqmonitor-backend`のB1でmanifest/item schema v1と既存asset IDを維持した`BASE_MAP_PMTILES`へ後方互換なlabel Point layer、global validator、version付きsigned sidecarの生成・署名/mutation fixture、releaseを先行して独立に完了します。backend branchはEQMonitor branchを祖先にしません。

EQMonitor repositoryのstackは次の順です。

1. Design
2. Minimal compilable package/example scaffold and Flutter Scene device spike
3. Foundation and render contracts
4. Trusted tile pipeline（identity encoding/range body length fixtureを含む）
5. Label Asset Pack integration（sidecar signature/readback/replay/rollback fixtureを含む）
6. Flutter Scene renderer
7. Labels and semantics
8. Dynamic layers and interaction
9. Home Map integration with north-fixed rotation disabled

## TODO

- Performance HUD
- Widget / Golden / performance testとbenchmark
- iOS / Android実機性能試験、基準端末、memory/frame timing基準の選定
- PMTiles / MVTのtrusted tile pipeline
- 宣言的`MapNode` / `MapElement` treeとreconciler
- label placement / collision / semantics
- 将来の3D camera・3D地形・地物
- 地下震源要素
- 断層面・断層モデル

bearing / pitch、Web / desktop、汎用package化は初期scopeに含めません。このpackageは
iOS / Android向けのEQMonitor専用rendererとして維持します。

プロジェクトTODOは`docs/todo/`にも登録します。
