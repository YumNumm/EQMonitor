# EEW 震度推計: arv400 データ欠損

## 問題

`EstimatedIntensity` provider が EEW 到達時の予測震度を計算するために、
各地震観測点の `arv400`（工学的基盤 Vs=400m/s の増幅率）が必要だが、
現在の `earthquake_stations.json` API レスポンスにこのフィールドが含まれていない。

## 影響

- EEW 受信時に各地点の予測震度が計算されず、地図への震度表示が空になる。

## 根本原因

旧アーキテクチャ（Protobuf `jma_parameter_types`）では `EarthquakeParameterStationItem`
に `arv400` フィールドがあった。新アーキテクチャ（Freezed + JSON）へ移行する際、
`arv400` が `earthquake_stations.json` のスキーマから漏れた。

## 対応方針

### 方針 A（推奨）: バックエンドで `arv_400` を earthquake stations に追加

`earthquake_stations.json` の各 station オブジェクトに `"arv_400": <double>` を追加し、
`EarthquakeParameterStationItem` モデルに `@JsonKey(name: 'arv_400') required double? arv400`
フィールドを追加する。その後 `_generateCalculationPoints` を復元する。

### 方針 B: kyoshin observation points の arv400 を cross-reference

`KyoshinObservationPoint.arv400` を earthquake station コードと照合して使用する。
ただし、station コード体系が異なる（JMA 観測点 vs KiK-net/K-NET）ため、
マッピングテーブルが別途必要になる。

## 影響ファイル

- `app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart`
  - `_generateCalculationPoints` が空リストを返している
- `app/lib/feature/parameter/data/model/earthquake/earthquake_parameter.dart`
  - `EarthquakeParameterStationItem` に `arv400` フィールドがない
