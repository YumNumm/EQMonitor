# Map機能アーキテクチャドキュメント

## 概要

このドキュメントは、EQMonitorアプリのマップ機能のアーキテクチャを説明します。
maplibre 0.3.0を使用し、宣言的APIとHookConsumerWidgetベースで実装されています。

## アーキテクチャ概要

### 設計原則

1. 宣言的優先: maplibre 0.3.0の宣言的APIを最大限活用
2. HookConsumerWidget: StatefulWidgetは使用せず、Hooksで状態管理
3. レイヤー分離: 各機能を独立したレイヤーWidgetとして実装
4. Riverpod: データフローと状態管理
5. 型安全: dynamic型の使用を禁止する

### ディレクトリ構成

```
app/lib/feature/home/
├── data/
│   ├── model/
│   │   └── map_camera_state.dart              # カメラ状態モデル
│   └── provider/
│       ├── map_camera_state_provider.dart     # カメラ制御
│       ├── kyoshin_monitor_points_provider.dart  # 強震モニタFeature変換
│       └── eew_hypocenter_points_provider.dart   # EEW震源Feature変換
└── ui/
    └── component/
        └── map/
            ├── home_map_view.dart             # メインマップビュー
            └── layer/
                ├── kyoshin_monitor_observation_layer.dart  # 強震モニタレイヤー
                ├── eew_hypocenter_layer.dart              # EEW震源レイヤー
                ├── eew_ps_wave_layer.dart                 # P/S波レイヤー
                └── eew_estimated_intensity_layer.dart     # 予想震度レイヤー
```

## コンポーネント詳細

### 1. HomeMapView

メインのマップビューコンポーネント。

**責務:**

- MapLibreMapウィジェットの表示
- MapConfigurationからスタイル取得
- 各レイヤーの配置
- MapControllerの初期化

**主要コード:**

```dart
MapLibreMap(
  options: MapOptions(
    initCenter: cameraState.center,
    initZoom: cameraState.zoom,
    initStyle: styleString,
  ),
  onMapCreated: (controller) {
    ref.read(homeMapCameraStateProvider.notifier).setController(controller);
  },
  children: [
    const EewEstimatedIntensityLayer(),
    const KyoshinMonitorObservationLayer(),
    const EewPsWaveLayer(),
    const EewHypocenterLayer(),
    const SafeArea(child: _MapHeader()),
  ],
)
```

### 2. MapCameraState Provider

カメラの状態管理と自動制御。

**責務:**

- カメラ位置の状態管理
- EEW発生時の自動ズーム
- EEW終了時のホーム復帰
- 境界計算

**データフロー:**

```
eewAliveTelegramProvider
  ↓ listen
HomeMapCameraState
  ↓ fitBounds
MapController
```

**主要メソッド:**

- `setController(MapController)`: MapControllerの登録
- `_fitToEews(List<EewV1>)`: EEWに合わせてカメラ移動
- `_returnToHome()`: ホームポジションに復帰
- `returnToHome()`: 外部から呼び出し可能なホーム復帰

### 3. レイヤー実装

#### 3.1 KyoshinMonitorObservationLayer

強震モニタの観測点を円で表示。

**技術:**

- GeoJsonSource + CircleStyleLayer
- data-driven styling: `['get', 'color']`
- zoom-based interpolation

**プロパティ:**

- `color`: 観測点ごとの色（RGB値から16進数）
- `intensity`: 震度値（scaleToIntensity）
- `name`: 観測点名

#### 3.2 EewHypocenterLayer

EEW震源を赤い円で表示（シンプル実装）。

**技術:**

- GeoJsonSource + CircleStyleLayer
- 固定色（赤）

**プロパティ:**

- `magnitude`: マグニチュード
- `depth`: 深さ
- `isLowPrecise`: 低精度フラグ

#### 3.3 EewPsWaveLayer

P波とS波の到達範囲を円で表示。

**技術:**

- 2つの独立したGeoJsonSource（P波用、S波用）
- LineStyleLayer + FillStyleLayer
- Timer.periodicで100msごとに更新
- latlong2で円形ポリゴン生成

**更新フロー:**

1. 走時表から距離を計算
2. 円形ポリゴン座標を生成（360度、4度刻み）
3. GeoJSONを更新

#### 3.4 EewEstimatedIntensityLayer

予想震度を地域ごとに塗りつぶし表示。

**技術:**

- 既存ベクトルタイルソース ('eqmonitor_map') を使用
- 各予想震度ごとにFillStyleLayerを作成
- レイヤー削除→再作成で更新（filter更新不可のため）

**処理フロー:**

1. EstimatedIntensityPointを地域コードでグループ化
2. 各地域の最大震度を計算
3. 震度→JmaForecastIntensityへ変換
4. 震度別にレイヤー更新

## データフロー

```
Raw Data Providers                Feature Converters              Layers
┌──────────────────┐             ┌──────────────────┐           ┌─────────────────┐
│ eewAliveTelegram │──watch──────│ eewHypocenter    │──watch────│ EewHypocenter   │
│                  │             │ Points           │           │ Layer           │
└──────────────────┘             └──────────────────┘           └─────────────────┘

┌──────────────────┐             ┌──────────────────┐           ┌─────────────────┐
│ kyoshinMonitor   │──watch──────│ kyoshinMonitor   │──watch────│ KyoshinMonitor  │
│                  │             │ Points           │           │ ObservationLayer│
└──────────────────┘             └──────────────────┘           └─────────────────┘

┌──────────────────┐                                            ┌─────────────────┐
│ eewAliveNormal   │──read (100ms)──────────────────────────────│ EewPsWaveLayer  │
│ Telegram         │                                            │ (timer)         │
└──────────────────┘                                            └─────────────────┘

┌──────────────────┐                                            ┌─────────────────┐
│ estimatedIntensity│──watch────────────────────────────────────│ EewEstimated    │
│                  │                                            │ IntensityLayer  │
└──────────────────┘                                            └─────────────────┘

┌──────────────────┐                                            ┌─────────────────┐
│ eewAliveTelegram │──listen─────────────────────────────────────│ HomeMapCamera   │
│                  │                                            │ State (auto zoom)│
└──────────────────┘                                            └─────────────────┘
```

## 技術的な制約と解決策

### 1. maplibre 0.3.0の制約

**制約:**

- 組み込み`CircleLayer`/`MarkerLayer`は全体に単一スタイルのみ適用可能
- `StyleLayer`に`filter`パラメータがない

**解決策:**

- `StyleController`で`CircleStyleLayer`/`SymbolStyleLayer`を直接追加
- data-driven styling: `['get', 'property']` で動的プロパティ指定
- 異なるデータタイプには別々のSourceを使用

### 2. Position型

**制約:**

- `Point.position`は基底クラス`Position`を返す
- `Geographic`ではなく`Position`型

**解決策:**

- `Position.x`（lon相当）と`Position.y`（lat相当）を使用
- GeoJSON coordinates: `[coords.x, coords.y]`

### 3. 型パラメータ

**制約:**

- `Geographic`のコンストラクタは`lon`/`lat`（`lng`ではない）
- `LngLatBounds`は4つの個別パラメータ

**解決策:**

```dart
Geographic(lon: 139.0, lat: 35.0)
LngLatBounds(
  longitudeWest: 128.8,
  longitudeEast: 145.1,
  latitudeSouth: 30,
  latitudeNorth: 45.8,
)
```

## パフォーマンス最適化

### 実装済み

1. Riverpod依存関係追跡: 必要最小限の再描画
2. useEffect依存配列: 依存関係指定により不要な再実行を防止
3. Feature変換のメモ化: Providerレベルで変換結果をキャッシュ

### 今後の最適化候補

1. GeoJSON更新頻度の調整: P/S波の更新間隔を動的に変更
2. 表示範囲外の観測点フィルタリング: 画面外のデータを除外
3. レイヤー更新の最適化: 差分更新の検討

## エラーハンドリング

### 現在の実装

- StyleControllerがnullの場合は処理をスキップ
- データがnullの場合は空のFeatureCollectionを設定
- 座標が不正な場合はその要素をスキップ

### 今後の改善

- エラー時のユーザー通知
- リトライ機構
- フォールバック表示

## まとめ

本実装により、以下を達成しました：

✅ maplibre_gl から maplibre 0.3.0 への完全移行
✅ 宣言的APIの最大限活用
✅ 型安全なコード（dynamic型なし）
✅ HookConsumerWidgetベースの保守性の高い実装
✅ 全機能の動作（強震モニタ、EEW、予想震度）
✅ dart analyze: エラー 0件



