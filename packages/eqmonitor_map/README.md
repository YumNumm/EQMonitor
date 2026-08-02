# eqmonitor_map

EQMonitor専用のFlutter地図レンダラーです。

Flutter SceneをGPU描画基盤としてPMTiles/MVTの地物を描画し、ラベルはasset内の1つの地理anchorから、実測文字サイズとDPRに応じたscreen placement候補を生成してFlutterの`TextPainter`で描画します。MapLibre Style JSON互換ではなく、型付きの宣言的`MapNode`ツリーを利用します。

> [!NOTE]
> 現在は設計段階です。実装はstacked PRで段階的に追加します。

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

remote PMTilesのstrong validator付きrange合成、appが検証したAsset Pack descriptor、producerのglobal semantic検証とruntimeのbounded per-tile検証は、実装stackで追加する計画です。現行manifestがsemantic validationを提供済みという意味ではありません。source revisionを跨いだtile fallbackは行いません。

設計の正本は[`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`](../../docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md)です。

## 設計原則

- runtimeの`MapNode`を含むデータモデルは不変かつ原則Freezedとし、JSONは明示的な保存・通信DTO/specだけに要求する。
- 描画経路でGeoJSONやJSON serializationを使わない。
- hot pathのsnapshot/deltaとpacked bufferはversion付きruntime型とし、JSONやgeometryのdeep equalityを使わない。deltaは`baseRevision`/`targetRevision`をatomicに検証し、gap時はfull snapshotへresyncする。
- Feature単位のScene Nodeを作らず、tile/layer/material単位でbatchする。
- UI IsolateでMVT decodeやmesh構築を行わない。
- source identity、async incarnation、GPU completion/context generationを分離して管理する。
- Asset Pack manifest/trust/size/hashはappが検証し、packageへimmutable verified source descriptorを渡す。`eqmonitor_map`は`app`へ依存しない。
- 2D初期実装でも座標モデルからZ軸を削除しない。
- 性能HUDより先に、軽量で常時利用できる観測基盤を実装する。
- MapLibre版と共有`lockBearing`設定は残存surfaceの移行完了まで削除しない。新Home rendererだけが回転を明示的に無効化する。
- Flutter Sceneはadapter内へ隔離し、固定revisionのiOS/Android実機spikeを実装gateにする。

## Delivery graph

`eqmonitor-backend`でmanifest/item schema v1と既存asset IDを維持した`BASE_MAP_PMTILES`へ後方互換なlabel Point layer、global validator、digest-bound schema/summary、releaseを先行して独立に完了します。backend branchはEQMonitor branchを祖先にしません。

EQMonitor repositoryのstackは次の順です。

1. Design
2. Minimal compilable package/example scaffold and Flutter Scene device spike
3. Foundation and render contracts
4. Trusted tile pipeline
5. Label Asset Pack integration
6. Flutter Scene renderer
7. Labels and semantics
8. Dynamic layers and interaction
9. Home Map integration with north-fixed rotation disabled

## TODO

- Performance HUD
- Widget test
- Golden test
- iOS / Android実機性能試験と基準端末の選定
- bearing / pitch
- 透視投影と3D camera
- 3D地形・地物
- 地下震源要素
- 断層面・断層モデル
- Web / macOS / Windows / Linux
- 線上ラベル
- 汎用パッケージ化

プロジェクトTODOは`docs/todo/`にも登録します。
