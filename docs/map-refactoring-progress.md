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

## 次のステップ

以下のTODOを順次実装予定:
- [ ] declarative-layers: 宣言的レイヤーの統合（CircleLayer, MarkerLayer）
- [ ] ps-wave-layer: P/S波レイヤー（HookConsumerWidget）
- [ ] intensity-layer: 予想震度レイヤー（HookConsumerWidget）
- [ ] camera-auto-control: カメラ自動制御機能
- [ ] integration: 全体統合
- [ ] analyze-fix: 最終調整

## コミット履歴

### 2025-01-XX (Commit 1): 基盤となるモデルとプロバイダーの実装

- MapCameraState モデルの作成
- カメラ制御プロバイダーの実装
- 強震モニタ観測点Featureプロバイダーの実装
- EEW震源Featureプロバイダーの実装
- dart analyze: エラー 0件

### 2025-01-XX (Commit 2): HomeMapViewの基本実装

- HomeMapView を maplibre 0.3.0 ベースに刷新
- MapLibreMap ウィジェットの統合
- MapOptions による初期カメラ位置設定
- MapController の登録
- dart analyze: エラー 0件
