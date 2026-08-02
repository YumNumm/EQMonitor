# EQMonitor専用Flutter地図レンダラー設計

## 目的

MapLibre Nativeへの描画依存を段階的に置き換えるため、Flutter SceneをGPU描画基盤とするEQMonitor専用地図パッケージ`packages/eqmonitor_map`を新設する。

PMTiles内のMVTと型付き動的データをDart側で解釈し、Fill・Line・Point・CircleをFlutter Sceneで描画する。ラベルは事前計算済みアンカーを使い、Flutterの`TextPainter`で描画する。

## 確定事項

- 初期対象はiOSとAndroidのみ。
- 初期カメラは北固定・真上視点とし、bearingとpitchは実装しない。
- Flutter master channelとFlutter Sceneの利用を許容する。
- MapLibre Style JSON互換は持たず、型付きの独自レイヤー定義を使う。
- ラベルアンカーはPMTiles生成時に専用Pointレイヤーへ事前格納する。
- 動的更新でGeoJSONを介さない。
- 主要データモデルはFreezedと`json_serializable`へ対応する。
- FlutterのWidget型は使わず、Widget/Elementに似た宣言と実体の分離を採用する。
- 性能HUDは後続実装とするが、性能観測基盤は初期実装に含める。
- 将来の3D、地下震源、断層表示に備え、座標モデルからZ軸を削除しない。
- 既存MapLibre実装は機能・障害時挙動の同等性を確認するまで残す。
- 実装は依存順のstacked PRで提供する。

## 対象外

初期実装では次を対象外とする。

- bearing、pitch、透視投影
- 3D地形、地下震源、断層面
- Web、macOS、Windows、Linux
- 線上ラベル
- 任意のMapLibre Style JSON
- 汎用地図パッケージとしての公開
- Performance HUD
- Widget、Golden、実機性能試験の完成

## 公開API

利用側は不変な`MapScene`を宣言し、`EqmonitorMapView`へ渡す。

```dart
final scene = MapScene(
  children: [
    PmTilesSourceNode(
      key: const MapNodeKey('base-map'),
      source: baseMapSource,
      children: [
        FillLayerNode(
          key: const MapNodeKey('countries-fill'),
          spec: countriesFillSpec,
        ),
        LineLayerNode(
          key: const MapNodeKey('region-line'),
          spec: regionLineSpec,
        ),
        LabelLayerNode(
          key: const MapNodeKey('city-label'),
          spec: cityLabelSpec,
        ),
      ],
    ),
    ObservationPointLayerNode(
      key: const MapNodeKey('observations'),
      data: observationSnapshot,
    ),
    WaveCircleLayerNode(
      key: const MapNodeKey('ps-wave'),
      data: waveSnapshot,
    ),
  ],
);

EqmonitorMapView(controller: controller, scene: scene);
```

主要公開境界は`EqmonitorMapView`、`EqmonitorMapController`、`MapScene`、各`MapNode`、型付きsource/layer/featureモデルとする。

## モデルと実行時オブジェクト

座標、カメラ、source、layer、feature、ラベル候補、hit test結果、エラー、性能snapshotはFreezedモデルとし、JSONへ変換できるようにする。

Flutter SceneのGeometry/Material、GPU buffer、`TextPainter`、Controller、Repository、HTTP clientなど、状態や外部資源を持つ実行時オブジェクトはモデルに含めず、JSON対応の対象外とする。

動的データは安定したFeature IDとrevisionを持つ。reconcilerはrevisionで更新有無を判定し、変更時だけFeature ID単位の差分を適用する。描画経路でJSONへの変換は行わない。

## 宣言的Nodeツリー

Flutter内部APIへ結合せず、地図専用の軽量reconcilerを実装する。

```text
MapNode            不変な宣言、Freezed/JSON
  ↓ keyとnode型でreconcile
MapElement         mount/update/unmountと実行状態
  ↓ command queue
MapRenderObject    CPU meshとGPU resource
```

`MapNode`は毎回再生成してよい。同じkeyとnode型なら`MapElement`を更新し、異なる場合はunmount後にmountする。ネットワーク取得やGPU操作は宣言の組み立て中に実行せず、command queueをrender tickで適用する。

設定変更はstyleのみ、filter/source layer、動的feature、source交換に分類し、必要な範囲だけ再構築する。GPU resourceの解放は描画中の参照を避けるためframe終了後に行う。

## 座標系

MapLibre Nativeの座標変換を参考に、次の段階を明示する。

```text
WGS84 Geographic
  → normalized Web Mercator world
  → Z/X/Y tile
  → MVT tile-local extent
  → camera-relative world
  → clip
  → screen
```

参考: https://maplibre.org/maplibre-native/docs/book/design/coordinate-system.html

地理座標は経度、緯度、`altitudeMeters`を保持する。地表は0、地下は負、地上は正とする。初期描画は正射影でも頂点を常にXYZで扱い、将来の投影変更でfeatureモデルを変更しない。

高zoomや将来の3DでGPU float精度を失わないよう、カメラ中心を原点とするorigin rebasingをrenderer境界で行う。高度からworld Zへの変換はprojection層へ集約し、メートルとMercator単位を混在させない。

## 静的タイルデータフロー

```text
camera change
  → TileCoverCalculator
  → TileScheduler
  → PmTilesTileRepository
  → MVT bytes
  → worker isolateでdecode/geometry/label candidate生成
  → TransferableTypedData
  → UI isolateでFlutter Scene Geometryとlabel stateを更新
```

`TileKey`はsource、Z/X/Y、world wrapを持つ。source zoomは連続camera zoomから決定し、sourceのmin/max zoomで制限する。max zoom超過時は親タイルをoverscaleする。

中心に近いタイルを優先し、同じタイルの重複取得を抑止する。カメラ移動で不要になった処理はキャンセルし、generation IDが古いworker結果をGPUへアップロードしない。

MVT decode結果と描画データを分離する。再利用可能な頂点、layer別index、material bucket、Feature IDとgeometry rangeの対応を保持し、色や表示状態の変更でMVTを再decodeしない。

## 描画

Flutter SceneのScene GraphをFeature単位では使用しない。`tile × layer × material`単位でmeshを結合し、GPU bucketを生成する。

- Fillは穴付きPolygonをtriangulationする。
- Lineはjoin/cap/widthを反映したmeshへ展開する。
- 観測点はinstance bufferを利用する。
- 震源や震度アイコンはtexture付きquadを利用する。
- P/S波は中心と半径から直接円meshを更新する。
- 区域状態変更はFeature IDに対応するindex rangeを再構成する。

## ラベル

PMTilesの専用Pointレイヤーは、安定ID、アンカー、文字列、優先度、zoom範囲を持つ。表示対象tileから候補を収集し、安定IDで重複排除した後、screen座標へ投影する。

`TextPainter`は文字列、style、locale、text scale、DPRでcacheする。カメラ移動時は原則再layoutせず、screen位置とcollisionだけを更新する。優先度順にcollision gridへ配置し、採用されたラベルをFlutter Sceneの前景`CustomPainter`で画面正立に描画する。

直前frameで表示されたラベルへ配置上の継続性を与え、zoom境界のちらつきを抑える。

## Hit test

screen座標をworld、tile、tile-local座標へ逆変換する。静的featureはtileごとの空間index、動的featureは専用indexで候補を絞り、実geometryで判定する。結果は描画順の上側から返し、現在の`queryLayers`相当のAPIを提供する。

## Cacheとエラー

PMTiles bytes、decoded MVT、GPU meshを独立したLRUで管理する。容量、先読み、並列取得、retryは設定モデルへ明示し、隠れた固定fallbackを設けない。

読み込み中や部分的な取得失敗では、直前に正常描画されたtileまたは有効な親tileを維持する。壊れたPMTiles/MVTを空tileとして扱わず、失敗データをcacheしない。古い処理のcancelはエラーにしない。

エラーはsource、TileKey、失敗段階、再試行可能性を持つFreezed unionとして通知する。集約状態は`ready`、`loading`、`degraded`、`failed`とし、一部tile失敗で地図全体や動的レイヤーを消さない。

## 性能観測

初期実装からframe reconciliation、tile cover、label placement、render submission、tile request、decode、mesh build、GPU uploadを計測する。cache使用量、tile queue、GPU bucket、label候補/採用数、動的feature差分数も集約する。

Controllerは`ValueListenable<MapPerformanceSnapshot>`と`Stream<MapPerformanceEvent>`を公開する。観測レベルとsnapshot更新間隔は`MapPerformancePolicy`で設定可能にし、通常時は軽量集約、デバッグ時はtile単位イベントを利用できるようにする。

HUD、Widget/Golden test、実機性能試験は後続TODOとするが、後から計測方式を変更しない。

## 初期検証

初期実装では純粋ロジックの単体テストを必須とする。

- WGS84、Mercator、tile-local、screenの往復
- tile cover、overscale、world wrap
- MVT Point/LineString/Polygonと穴付きPolygon
- extent外buffer geometry
- Node/Elementのmount/update/reorder/unmount
- revisionとFeature IDによる差分
- ラベル重複排除、優先度、衝突、text scale
- hit test、stale generation破棄、cache eviction

## Stacked PR

後続PRは前のPRだけへ依存させ、各stackを単独でreview可能にする。

1. `01-design`: 設計書、README、将来TODO
2. `02-foundation`: package scaffold、モデル、座標、Node/Element、性能観測
3. `03-tile-pipeline`: PMTiles、MVT、worker、tile scheduler、cache
4. `04-scene-renderer`: Flutter Scene、Fill/Line、GPU resource管理
5. `05-labels`: ラベル候補、collision、TextPainter overlay
6. `06-dynamic-interaction`: 動的feature、camera、fitBounds、hit test
7. `07-home-integration`: Home Mapのデバッグ切り替えと並行検証

各PRで生成、format、analyze、対象単体テスト、`git diff --check`を実行する。後続branchは直前stackから分岐し、base PR取り込み時はstackを順番にrebaseする。

## 移行完了条件

Home Mapでベース地図、ラベル、観測点、震源、P/S波、区域状態、camera、hit test、障害時表示が既存実装と同等になり、性能観測で継続利用可能と判断できるまでMapLibreを削除しない。その後も地図画面を一つずつ移行する。
