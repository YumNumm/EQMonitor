# eqmonitor_map

EQMonitor専用のFlutter地図レンダラーです。

Flutter SceneをGPU描画基盤としてPMTiles/MVTの地物を描画し、ラベルはasset内の1つの地理anchorから、実測文字サイズとDPRに応じたscreen placement候補を生成してFlutterの`TextPainter`で描画します。MapLibre Style JSON互換ではなく、型付きの宣言的`MapNode`ツリーを利用します。

> [!WARNING]
> 現在はFlutter Sceneのscaffoldとmanual smoke用exampleまでです。
> このLinux環境ではiOS/Android実機のprofile/release確認を実施して
> いません。未実施の実機確認はrenderer foundation実装の開始条件にしません。

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
Dart Data Assetです。machineごとに1度だけ次を実行してからbuildします。未設定の場合
`Scene.initializeStaticResources()`が失敗し、`Flutter Scene is not ready to render.`が
毎frame出力されます。詳細は
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
