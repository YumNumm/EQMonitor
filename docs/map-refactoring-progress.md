# Map機能修復 - 進捗レポート

## 概要

maplibre_gl から maplibre 0.3.0 への移行に伴うマップ機能の再実装。
宣言的APIを最大限活用し、HookConsumerWidgetベースで実装。

## 完了したTODO

### ✅ camera-model (完了)

**ファイル:**

- `app/lib/feature/home/data/model/map_camera_state.dart`

**内容:**

- `MapCameraState` モデルの作成
- Geographic, zoom, bearing, pitch, isAtHome をプロパティとして定義
- `MapCameraState.home()` ファクトリメソッドでデフォルト位置を提供

**技術的詳細:**

- `Geographic` は maplibre 0.3.0 の geobase パッケージから提供
- パラメータ名は `lon` (not `lng`) を使用
- freezed による immutable なモデル

### ✅ camera-provider (完了)

**ファイル:**

- `app/lib/feature/home/data/provider/map_camera_state_provider.dart`

**内容:**

- `HomeMapCameraState` Riverpod プロバイダーの実装
- EEW発生時の自動ズーム機能
- EEW終了時のホームポジション復帰機能
- `LngLatBounds` の計算ロジック

**技術的詳細:**

- `eewAliveTelegramProvider` をリスンして自動的にカメラ制御
- `LngLatBounds` のパラメータ名: `longitudeWest`, `longitudeEast`, `latitudeSouth`, `latitudeNorth`
- `MapController.fitBounds()` を使用したカメラ移動

### ✅ kyoshin-points-provider (完了)

**ファイル:**

- `app/lib/feature/home/data/provider/kyoshin_monitor_points_provider.dart`

**内容:**

- 強震モニタ観測点データを `Feature<Point>` に変換
- `KyoshinMonitorImageParseObservationPoint` からGeoJSON Feature形式へ変換
- RGB値から16進数カラーコードへの変換

**技術的詳細:**

- `kyoshinMonitorProvider` の `analyzedPoints` を使用
- `observation.scaleToIntensity` で震度値を取得
- `observation.r/g/b` を16進数カラーコード (#RRGGBB) に変換
- maplibre の `Feature<Point>` と `Geographic(lon:, lat:)` を使用

### ✅ eew-points-provider (完了)

**ファイル:**

- `app/lib/feature/home/data/provider/eew_hypocenter_points_provider.dart`

**内容:**

- EEW震源位置データを `Feature<Point>` に変換
- キャンセルされていない有効なEEWのみをフィルタリング
- magnitude, depth, isLowPrecise をプロパティとして付加

**技術的詳細:**

- `eewAliveTelegramProvider` からデータ取得
- `Geographic(lon:, lat:)` を使用した座標指定
- 低精度判定: `isIpfOnePoint || isLevelEew || isPlum`

## 技術メモ

### maplibre 0.3.0 API の重要なポイント

1. **Geographic クラス**
   - パラメータ名: `lon` (longitude), `lat` (latitude)
   - 例: `Geographic(lon: 139.0, lat: 35.0)`

2. **LngLatBounds クラス**
   - パラメータ名: `longitudeWest`, `longitudeEast`, `latitudeSouth`, `latitudeNorth`
   - `fromPoints()` ファクトリメソッドも利用可能

3. **Feature<Point> クラス**
   - `geometry`: `Point(Geographic(...))`
   - `properties`: Map<String, dynamic> で任意のプロパティを付加

### Freezed の注意点

- `abstract class` を使用する必要がある
- 例: `@freezed abstract class MapCameraState with _$MapCameraState`

### ✅ map-view-base (完了)

**ファイル:**
- `app/lib/feature/home/ui/component/map/home_map_view.dart`

**内容:**
- `HomeMapView` を maplibre 0.3.0 の `MapLibreMap` ウィジェットベースに刷新
- `_MapContent` で MapLibreMap を構築
- `_MapHeader` でUIコントロール（強震モニタステータス、コントロールカード）を配置

**技術的詳細:**
- `MapOptions` のパラメータ名: `initCenter`, `initZoom`, `initBearing`, `initPitch`, `initStyle`
- `onMapCreated` コールバックで `MapController` を `HomeMapCameraStateProvider` に登録
- カメラ状態は `homeMapCameraStateProvider` から取得して初期値に設定
- ホームボタンは `returnToHome()` を呼び出し

### ✅ declarative-layers (完了)

**ファイル:**
- `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`
- `app/lib/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart`
- `app/lib/feature/home/ui/component/map/home_map_view.dart` (更新)

**内容:**
- 強震モニタ観測点レイヤーの実装（HookConsumerWidget + StyleController）
- EEW震源レイヤーの実装（HookConsumerWidget + StyleController）
- これらのレイヤーを HomeMapView に統合

**技術的詳細:**
- 組み込み`CircleLayer`/`MarkerLayer`は各Featureごとの動的プロパティに非対応
- 代わりに`StyleController`で`CircleStyleLayer`を追加し、data-driven styling使用
- `useEffect`でレイヤーの初期化とクリーンアップを管理
- `Point.position`は基底クラス`Position`を返すため、`x`/`y`プロパティを使用
- GeoJSON更新は`StyleController.updateGeoJsonSource()`使用
- 震源はシンプルな赤い円で表示（アイコンは後で追加予定）

### ✅ ps-wave-layer (完了)

**ファイル:**
- `app/lib/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart`

**内容:**
- P波とS波の到達範囲を円で表示
- 走時表を使用して時刻に応じた半径を計算
- 警報/予報で色分け（赤/オレンジ）
- 100msごとに自動更新

**技術的詳細:**
- P波とS波で別々のGeoJsonSourceを使用（maplibre 0.3.0ではfilterパラメータが使えないため）
- latlong2パッケージのDistance().offsetで円形ポリゴンの座標を計算
- Timer.periodicで定期的にGeoJSON更新
- LineStyleLayerとFillStyleLayerで線と塗りを表示
- data-driven stylingで色を動的設定（S波のみ）

### ✅ intensity-layer (完了)

**ファイル:**
- `app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart`

**内容:**
- 予想震度地域をレイヤーで表示
- 各予想震度ごとにFillStyleLayerを作成
- 地域コードごとに最大震度をグループ化
- 震度に応じた色で塗りつぶし

**技術的詳細:**
- 既存のベクトルタイルソース 'eqmonitor_map' を使用
- 各震度ごとにFillStyleLayerを作成（filter使用不可のため削除→再作成で更新）
- EstimatedIntensityPointから計測震度→予想震度への変換
- IntensityColorProviderから震度に応じた色を取得
- 地域コードごとの最大震度を計算してグループ化

## 次のステップ

以下のTODOを順次実装予定:
- [ ] camera-auto-control: カメラ自動制御機能の検証（既に実装済み）
- [ ] integration: 全体統合とアイコン追加
- [ ] analyze-fix: 最終調整

## コミット履歴

### 2025-10-28 (Commit 1): 基盤となるモデルとプロバイダーの実装

- MapCameraState モデルの作成
- カメラ制御プロバイダーの実装
- 強震モニタ観測点Featureプロバイダーの実装
- EEW震源Featureプロバイダーの実装
- dart analyze: エラー 0件

### 2025-10-28 (Commit 2): HomeMapViewの基本実装

- HomeMapView を maplibre 0.3.0 ベースに刷新
- MapLibreMap ウィジェットの統合
- MapOptions による初期カメラ位置設定
- MapController の登録
- dart analyze: エラー 0件

### 2025-10-28 (Commit 3): レイヤー実装

- KyoshinMonitorObservationLayer実装
- EewHypocenterLayer実装
- EewPsWaveLayer実装（リアルタイム波動伝播）
- dart analyze: エラー 0件
