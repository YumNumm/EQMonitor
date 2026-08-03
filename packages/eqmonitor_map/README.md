# eqmonitor_map

EQMonitor専用のFlutter地図レンダラーです。

Flutter SceneをGPU描画基盤としてPMTiles/MVTの地物を描画し、ラベルはasset内の1つの地理anchorから、実測文字サイズとDPRに応じたscreen placement候補を生成してFlutterの`TextPainter`で描画します。MapLibre Style JSON互換ではなく、型付きの宣言的`MapNode`ツリーを利用します。

> [!WARNING]
> 現在はFlutter Sceneのscaffoldと実機spike harnessまでです。Linux環境には
> 物理iOS/Android端末とplatform build環境がないため、実機gateは
> `NOT RUN / BLOCKED`です。`03-foundation`へは進みません。

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
- Flutter Sceneはadapter内へ隔離し、固定revisionのiOS/Android実機spikeを実装gateにする。

## 固定toolchain

- Flutter framework: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter engine source: `b1e405a9c311d858bef870c472bb24c015f4bcf9`
- Flutter engine artifact: `73ac711b34da2a090d79ddb423918de40a7ffbf9`
- Dart source: `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
- Flutter Scene: `695c954f237fabef65d49fa7199002851d2dcd88`

```bash
mise bootstrap repos apply --yes
mise bootstrap repos status --missing
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter --version --machine
```

Flutter Scene型は`flutter_scene/` adapter内に隔離します。通常のdomain/runtime
modelは不変かつFreezedを原則としますが、frameごとのsnapshot/delta、packed buffer、
generation tokenはallocationとdeep equalityを避けるためversion付きhot-path型を使います。
この例外を公開DTOやJSON境界へ広げません。

`flutter --version --machine`の`engineRevision`はengine source、`engineContentHash`は
precache済みartifactのidentityとして別々にcompile-time manifestへ保存します。schema
v4 evidenceとgateは両方を上記固定値と照合し、欠落、blank、形式不正、不一致を
fail closedにします。

## Scene spike device gate

物理端末での採取手順とファイル名は
[`example/evidence/README.md`](example/evidence/README.md)、実施計画は
[`docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md`](../../docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md)
を参照してください。各runの前にcompile-time manifestを作り、profile/releaseの
canonical JSONを採取してからvalidatorを実行します。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run ../tool/write_scene_spike_defines.dart
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json

cd ../../..
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

現時点のvalidatorはexit 1でiOS/Androidのprofile/release 4 run欠落を返します。
さらにFlutter Sceneのpublic APIだけでは次を観測できず、各runで
`unavailablePublicApi/unobserved`となるためgateはpass不能です。

- `gpuCompletionOrSafeRetirement`
- `contextResourceRebuild`
- `explicitResourceDisposal`

`03-foundation`へ進むには、clean checkoutと上記固定revisionで4 runを物理端末から
採取し、全required capabilityをpublic APIに基づいて観測し、validatorがexit 0を返す
必要があります。3 APIが未提供の間はfoundationを止め、架空・手編集・固定値のpass
evidenceは作りません。

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
