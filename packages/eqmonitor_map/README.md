# eqmonitor_map

EQMonitor専用のFlutter地図レンダラーです。

Flutter SceneをGPU描画基盤としてPMTiles/MVTの地物を描画し、ラベルは事前計算済みアンカーからFlutterの`TextPainter`で描画します。MapLibre Style JSON互換ではなく、型付きの宣言的`MapNode`ツリーを利用します。

> [!NOTE]
> 現在は設計段階です。実装はstacked PRで段階的に追加します。

## 初期スコープ

- iOS / Android
- Flutter master channel
- 北固定・真上視点のパンとzoom
- ローカル / HTTP PMTiles
- MVT Fill / Line
- TextPainterラベル
- 型付き動的Point / Circle / Polygon状態
- camera controller、fitBounds、座標変換、hit test
- 性能イベントとsnapshot

設計の正本は[`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`](../../docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md)です。

## 設計原則

- データモデルは基本的にFreezed + `json_serializable`へ対応する。
- 描画経路でGeoJSONやJSON serializationを使わない。
- Feature単位のScene Nodeを作らず、tile/layer/material単位でbatchする。
- UI IsolateでMVT decodeやmesh構築を行わない。
- 2D初期実装でも座標モデルからZ軸を削除しない。
- 性能HUDより先に、軽量で常時利用できる観測基盤を実装する。
- MapLibre版は移行完了条件を満たすまで削除しない。

## Stacked PR

1. Design
2. Foundation
3. Tile pipeline
4. Flutter Scene renderer
5. Labels
6. Dynamic layers and interaction
7. Home Map integration

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
