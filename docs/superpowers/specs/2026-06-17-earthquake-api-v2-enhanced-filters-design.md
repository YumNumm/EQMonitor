# /v2/earthquake 強化対応 — 設計仕様

## 背景

バックエンドの `/v2/earthquake` エンドポイントが大幅に強化された。
旧 `/v2/earthquake/epicenter/{code}` は削除され、震央地検索はメインリストエンドポイントの `epicenterCodes` クエリパラメータに統合された。
全検索エンドポイント（list, intensity/region, prefecture, city, station）が統一されたフィルタセットをサポートするようになった。

## スコープ

- 壊れた震央地検索の修正（`epicenterCodes` パラメータ使用に移行）
- 新フィルタの全レイヤー反映（Repository / DataSource / UI）
- UI をチップ集約型に刷新（検索モーダル削除）

## 新規 API パラメータ一覧

| パラメータ | 型 | 用途 |
|---|---|---|
| `epicenterCodes` | string / string[] | 震央地コードフィルタ |
| `epicenterDetailCode` | string | 震央地詳細コード |
| `earthquakeType` | enum (NORMAL/DISTANT/VOLCANO) | 地震種別 |
| `datasource` | enum (JMA_INTENSITY_DATABASE/JMA_DISASTER_INFORMATION_XML) | データソース |
| `telegramTypes` | enum[] | 電文タイプ |
| `originTimeGte/Lte` | DateTime | 発生時刻範囲 |
| `maxLpgmIntensityGte/Lte` | enum | 長周期地震動階級範囲 |
| `latitudeGte/Lte` | string | 緯度範囲 |
| `longitudeGte/Lte` | string | 経度範囲 |
| `sortBy` | enum (event_id/magnitude/max_intensity/depth/origin_time等) | ソート項目 |
| `sortOrder` | enum (asc/desc) | ソート順 |

今回 UI に露出させないもの: `latitudeGte/Lte`, `longitudeGte/Lte`, `telegramTypes`, `epicenterDetailCode`, `datasource`

---

## 1. モデル層

### 1a. `EarthquakeHistoryParameter` — 新フィルタフィールド追加

```dart
@freezed
abstract class EarthquakeHistoryParameter with _$EarthquakeHistoryParameter {
  const factory EarthquakeHistoryParameter({
    // 既存
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    List<TelegramStatus>? statuses,
    int? epicenterCode,
    String? epicenterName,
    RegionSearchType? regionSearchType,
    String? regionCode,
    String? regionName,
    JmaIntensity? regionIntensityLte,
    JmaIntensity? regionIntensityGte,
    // 新規
    EarthquakeType? earthquakeType,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) = _EarthquakeHistoryParameter;
}
```

### 1b. `EarthquakePartial`（app側）— `telegramTypes` 追加

```dart
required List<EarthquakeTelegramType> telegramTypes,
```

変換 extension にもマッピング追加。

### 1c. 新規 app 側 enum

- `EarthquakeSortBy` — event_id / magnitude / max_intensity / max_lpgm_intensity / depth / origin_time（API enum への変換付き）
- `SortOrder` — asc / desc（API enum への変換付き）
- `EarthquakeTelegramType` — VXSE51 / VXSE52 / VXSE53 / VXSE61 / VXSE62 / VXSE45_FORECAST / VXSE45_WARNING（API enum への変換付き）

既存: `EarthquakeType`, `EarthquakeDataSource`, `OriginTimePrecision`（変更不要）

### 1d. 削除

- `EpicenterSearchItem`（app Freezed クラス）
- `EpicenterSearchInfo`（app Freezed クラス）+ `epicenter_search_info.dart`
- `EpicenterInfoToApp` extension
- `EpicenterSearchResponseToApp` extension（`earthquake_search_response.dart` 内）

### 1e. update extension メソッド追加

既存パターンに倣い:
- `updateEarthquakeType(EarthquakeType? type)`
- `updateOriginTimeRange(DateTime? gte, DateTime? lte)`
- `updateLpgmIntensity(JmaLpgmIntensity? min, JmaLpgmIntensity? max)`
- `updateSort(EarthquakeSortBy? sortBy, SortOrder? sortOrder)`

---

## 2. Repository 層

### 2a. `fetchEarthquakeList()` — シグネチャ拡張

```dart
Future<EarthquakeListResponse> fetchEarthquakeList({
  int? limit,
  String? cursor,
  // 既存
  double? magnitudeGte,
  double? magnitudeLte,
  int? depthGte,
  int? depthLte,
  JmaIntensity? intensityGte,
  JmaIntensity? intensityLte,
  List<api.TelegramStatus>? statuses,
  // 新規
  List<int>? epicenterCodes,
  api.EarthquakeType? earthquakeType,
  api.EarthquakeDatasource? datasource,
  DateTime? originTimeGte,
  DateTime? originTimeLte,
  api.JmaLpgmIntensity? maxLpgmIntensityGte,
  api.JmaLpgmIntensity? maxLpgmIntensityLte,
  api.EarthquakeSortBy? sortBy,
  api.SortOrder? sortOrder,
})
```

### 2b. intensity 検索メソッド — 同じフィルタ群追加

`searchByRegion`, `searchByPrefecture`, `searchByCity`, `searchByStation` の全てに同一の新規パラメータを追加。

### 2c. `searchByEpicenter()` — 削除

DataSource で `fetchEarthquakeList(epicenterCodes: [code])` に置き換え。

---

## 3. DataSource 層

### 3a. `_fetch()` ディスパッチロジック改修

旧ロジック:
1. `epicenterCode != null` → `searchByEpicenter()` ← 削除
2. `regionCode != null` → `searchByPrefecture()` / `searchByCity()`
3. else → `fetchEarthquakeList()`

新ロジック:
1. `regionCode != null` → `searchByPrefecture()` / `searchByCity()`（全フィルタ透過）
2. else → `fetchEarthquakeList()`（epicenterCodes 含む全フィルタ渡し）

### 3b. 共通フィルタの透過的パススルー

全ディスパッチパスで以下を共通的に渡す:
- `statuses`, `magnitudeGte/Lte`, `depthGte/Lte`, `intensityGte/Lte`（既存）
- `epicenterCodes`, `earthquakeType`, `originTimeGte/Lte`, `maxLpgmIntensityGte/Lte`, `sortBy`, `sortOrder`（新規）

---

## 4. UI 層 — チップ集約型フィルタ

### 4a. 検索モーダル削除

`earthquake_history_search_parameter_modal.dart` を削除。

### 4b. チップバー設計

水平スクロール可能なチップバーに全フィルタを配置。選択中チップは先頭にソート。

| チップ | 未選択時表示 | 選択時表示例 | 操作UI |
|---|---|---|---|
| 並び替え | `新しい順` | `M大きい順 ↓` | BottomSheet |
| 最大震度 | `最大震度` | `震度3〜5強` | BottomSheet |
| マグニチュード | `M` | `M3.0〜6.0` | BottomSheet |
| 震源の深さ | `深さ` | `0〜100km` | BottomSheet |
| 震央地 | `震央地` | `東京都23区` | BottomSheet |
| 地震種別 | `種別` | `遠地地震` | BottomSheet |
| 期間 | `期間` | `2024/01〜2024/06` | BottomSheet |
| 長周期階級 | `長周期` | `階級2〜4` | BottomSheet |
| ステータス | `通常` | `訓練` | BottomSheet |
| 地域の震度 | `地域` | `東京都 震度3〜` | BottomSheet |

### 4c. チップソートロジック

選択中チップを先頭に、同グループ内は定義順を維持:
```dart
chips.sort((a, b) {
  final aActive = a.isActive ? 0 : 1;
  final bActive = b.isActive ? 0 : 1;
  if (aActive != bActive) return aActive.compareTo(bActive);
  return a.defaultOrder.compareTo(b.defaultOrder);
});
```

選択中チップは `FilterChip(selected: true)` で視覚的に区別。

### 4d. 削除対象ファイル

- `earthquake_history_search_parameter_modal.dart`
- モーダル起動ボタン関連の UI

---

## コーディング規約

- Dart Dot Shorthands を積極使用（`.normal` 等）
- Freezed + JsonSerializable パターン踏襲
- API enum ↔ app enum の変換 extension は既存パターンに従う
