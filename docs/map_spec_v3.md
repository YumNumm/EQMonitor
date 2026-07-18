# マップ機能仕様書 (v3)

前バージョン: [v2.6.0](./map_spec_v2.6.0.md)

---

## 共通仕様

### マップエンジン

| 項目 | 値 |
|------|-----|
| ライブラリ | MapLibre GL (flutter-maplibre 0.3.x) |
| タイルソース | iOS/Android: `pmtiles://file://...`（`assets_util` で解決した絶対パス）、macOS/Web: `pmtiles://https://v2.map.eqmonitor.app/all.pmtiles` (ベクタータイル) |
| スタイル | ローカルファイルに書き出して参照 (ダーク/ライト別) |
| グリフ | `https://glyphs.geolonia.com/{fontstack}/{range}.pbf` |

### ベースレイヤー構成 (下から上の順)

| ID (`BaseLayer`) | ソースレイヤー | タイプ | 備考 |
|------------------|----------------|--------|------|
| `background` | — | background | テーマ背景色 |
| `countriesFill` | `countries` | fill | 世界の陸地 |
| `countriesLine` | `countries` | line | 国境線。zoom 3→0.5px, zoom 5.5→1px |
| `areaForecastLocalEFill` | `areaForecastLocalE` | fill | 日本の予報地域 (陸地色) |
| `areaForecastLocalEewLine` | `areaForecastLocalEew` | line | EEW 地域境界線 |
| `areaForecastLocalELine` | `areaForecastLocalE` | line | 予報地域細線。zoom 3→opacity 0, zoom 5→0.2, zoom 5.5→1。線幅 0.5px |
| `areaInformationCityQuakeLine` | `areaInformationCityQuake` | line | 市区町村境界線。線幅 0.5px。zoom 7→opacity 0, zoom 9.5→0.3 |

### カラーテーマ

- ライト/ダークで `MapColorScheme` が切り替わる
- 対象色: backgroundColor / worldLandColor / worldLineColor / japanLandColor / japanLineColor

---

## 1. ホーム画面マップ

ホーム画面マップの仕様は [v2.6.0 Section 1](./map_spec_v2.6.0.md#1-ホーム画面マップ-mainmapviewmodel) を参照。

---

## 2. 地震履歴詳細マップ

### 2-1. アーキテクチャ概要

Widget ベースのレイヤー構成。各レイヤーは `HookConsumerWidget` として実装され、`MapLibreMap.children` に配置する。
レイヤーの追加・削除は `useEffect` 内で `styleController.addLayer()` / `removeLayer()` を呼び出す。

```
MapLibreMap
  ├─ EarthquakeHistoryFillLayer          // 地域・市区町村の震度塗りつぶし
  ├─ EarthquakeHistoryDetailsEstimatedIntensityLayer  // 推計震度 (PMTiles)
  ├─ EarthquakeHistoryHypocenterErrorLayer  // 震央誤差矩形
  ├─ EarthquakeHistoryHypocenterLayer    // 震央マーカー（z順は設定で変動）
  └─ EarthquakeHistoryStationIntensityLayer  // 観測点（ドット + アイコン + ラベル）
```

### 2-2. 設定モデル (`EarthquakeHistoryDetailConfig`)

| フィールド | 型 | デフォルト | 説明 |
|-----------|-----|----------|------|
| `fillMode` | `EarthquakeHistoryFillMode` | `auto` | 塗りつぶしモード |
| `stationDisplayMode` | `StationDisplayMode` | `maxFocused` | 観測点の表示方法 |
| `hypocenterDisplayMode` | `HypocenterDisplayMode` | `zoomFade` | 震央マーカーの表示方法 |
| `showHypocenterError` | `bool` | `false` | 震央誤差矩形を表示するか |
| `showStationLabel` | `bool` | `false` | 観測点名ラベルを表示するか |
| `useEstimatedIntensityWhenAvailable` | `bool` | `true` | 推計震度データがある場合に自動で推計震度モードにするか |
| `showLegend` | `bool` | `true` | 震度凡例を表示するか |
| `showingLpgmIntensity` | `bool` | `false` | 長周期地震動階級モード |
| `showStation` | `bool` | `true` | 観測点レイヤーを表示するか |

永続化: `SharedPreferences` (JSON)

### 2-3. 塗りつぶしモード (`EarthquakeHistoryFillMode`)

| 値 | 動作 |
|----|------|
| `none` | 塗りつぶしなし |
| `auto` | 広域表示 (zoom < `regionToCity`) では細分化地域、ズームイン (zoom ≥ `regionToCity`) では市区町村を塗りつぶし。市区町村データがなければ細分化地域にフォールバック。**市区町村は最大ズームまで維持される。** |
| `region` | 全ズームレベルで細分化地域のみ塗りつぶし |
| `city` | 全ズームレベルで市区町村のみ塗りつぶし。市区町村データがなければ細分化地域にフォールバック |

#### ズーム境界 (`EarthquakeHistoryMapLayerZoomThresholds`)

| パラメータ | デフォルト値 | 説明 |
|-----------|-------------|------|
| `regionToCity` | 8.0 | auto モードで細分化地域 → 市区町村に切り替わるズームレベル |

#### opacity 制御 (auto モード)

**regionFillOpacity:**
```
[step, [zoom], visibleOpacity(0.6), regionToCity, 0.0]
```
→ zoom < 8: 0.6, zoom ≥ 8: 0.0

**cityFillOpacity:**
```
[step, [zoom], 0.0, regionToCity, visibleOpacity(0.6)]
```
→ zoom < 8: 0.0, zoom ≥ 8: 0.6（最大ズームまで維持）

#### モード解決 (`resolveFillLayerMode`)

`EarthquakeHistoryFillMode` × データ可用性 → `EarthquakeHistoryMapLayerMode`:

| fillMode | region ✓ city ✓ | region ✓ city ✗ | region ✗ city ✓ | region ✗ city ✗ |
|----------|-----------------|-----------------|-----------------|-----------------|
| `auto` | `auto` | `region` | `city` | `none` |
| `region` | `region` | `region` | `none` | `none` |
| `city` | `city` | `region` (FB) | `city` | `none` |
| `none` | `none` | `none` | `none` | `none` |

FB = フォールバック

### 2-4. 塗りつぶしレイヤー (`EarthquakeHistoryFillLayer`)

#### region レイヤー

| 項目 | 値 |
|------|-----|
| レイヤータイプ | FillStyleLayer + LineStyleLayer (震度レベルごと) |
| ソース | `eqmonitor_map` ベクタータイル |
| ソースレイヤー | `areaForecastLocalE` |
| フィルタ | `['in', ['get', 'code'], ['literal', [codes...]]]` |
| 配置 | `areaForecastLocalELine` より下 |
| Fill opacity | 0.6 (auto モードではズーム式で制御) |
| Line color | `#ffffff`, width 0.5px, opacity 0.8 |
| レイヤー ID | `eq-history-jma-{intensityName}-region-fill` / `-region-line` |

#### city レイヤー

| 項目 | 値 |
|------|-----|
| レイヤータイプ | FillStyleLayer (震度レベルごと) |
| ソース | `eqmonitor_map` ベクタータイル |
| ソースレイヤー | `areaInformationCityQuake` |
| フィルタ | `['in', ['get', 'regioncode'], ['literal', [codes...]]]` |
| 配置 | `areaInformationCityQuakeLine` より下 |
| Fill opacity | 0.6 (auto モードではズーム式で制御) |
| レイヤー ID | `eq-history-jma-{intensityName}-city-fill` |

#### LPGM (長周期地震動) レイヤー

region / city と同構成。レイヤー ID プレフィックスは `eq-history-lpgm-{lpgmIntensityName}`。

### 2-5. 観測点レイヤー (`EarthquakeHistoryStationIntensityLayer`)

`config.showStation == true` の場合のみ表示。

#### サブレイヤー構成

| レイヤー ID | タイプ | minZoom | 条件 |
|------------|--------|---------|------|
| `eq-history-station-intensity-circle` | Circle | 8 | 常時 |
| `eq-history-station-intensity-icon` | Symbol | 8 | `iconData != null` |
| `eq-history-station-intensity-label` | Symbol | 9 | `showStationLabel == true` |

#### Circle レイヤー

**`stationDisplayMode` ごとのサイズ:**

| モード | zoom 4 | zoom 10 | 備考 |
|--------|--------|---------|------|
| `allMinimized` | 4 | 10 | 全観測点同サイズ (大きめ) |
| `normal` | 2 | 8 | 全観測点同サイズ |
| `maxFocused` | 1〜3 | 7〜10 | `isFocused` (最大震度) を強調 |

- `circle-color`: GeoJSON properties の `color` (震度カラー)
- `circle-stroke-color`: `#ffffff`
- `circle-stroke-width`: zoom 4→0.3, zoom 10→1.5 (interpolate)
- `circle-sort-key`: 高震度が上に描画

#### Icon レイヤー

- `icon-image`: GeoJSON properties の `iconId` (`JmaIntensity.small.{name}` / `JmaIntensity.smallWithoutText.{name}`)
- `icon-size`: zoom 3→0.025, zoom 7→0.18, zoom 20→0.6 (interpolate)
- `icon-allow-overlap`: true
- `icon-ignore-placement`: true

#### Label レイヤー

- `text-field`: GeoJSON properties の `name` (観測点名)
- `text-size`: 10
- `text-offset`: [0, 1.2]
- `text-color`: `#ffffff`, halo: `#000000` width 1

### 2-6. 震央マーカーレイヤー (`EarthquakeHistoryHypocenterLayer`)

| 項目 | 値 |
|------|-----|
| ソースタイプ | GeoJSON |
| レイヤータイプ | SymbolLayer |
| アイコン | `Assets.images.map.normalHypocenter` |
| サイズ | zoom 3→0.15, zoom 20→0.4 (interpolate) |

**`HypocenterDisplayMode`:**

| モード | opacity | z 順 |
|--------|---------|------|
| `zoomFade` | zoom < 8: 1.0, zoom ≥ 8: 0.6 | 観測点の上 |
| `alwaysOpaque` | 1.0 | 観測点の上 |
| `belowStations` | 1.0 | 観測点の下 |

### 2-7. 震央誤差矩形レイヤー (`EarthquakeHistoryHypocenterErrorLayer`)

| 項目 | 値 |
|------|-----|
| レイヤータイプ | LineLayer |
| 表示条件 | `showHypocenterError == true` |
| スタイル | 白/黒の破線 (dash array [4, 2]) |
| opacity | zoom < 8: 0.0, zoom ≥ 8: 1.0 |

### 2-8. 推計震度レイヤー (`EarthquakeHistoryDetailsEstimatedIntensityLayer`)

| 項目 | 値 |
|------|-----|
| 表示条件 | `estimatedIntensityTileUrl != null` |
| ソース | VectorSource (PMTiles URL) |
| ソースレイヤー | `seismic_intensity` |
| レイヤータイプ | FillStyleLayer |
| Fill opacity | 0.65 |
| Fill color | GeoJSON properties の `fill` |
| 配置 | `areaForecastLocalELine` より下 |

### 2-9. カメラ

| 定数 | 値 |
|------|-----|
| デフォルト中心 | `Geographic(lon: 138, lat: 36.5)` |
| デフォルト zoom | 5.0 |
| 震央 zoom | 6.5 |
| フォーカス zoom | 8.0 |

**初期カメラ:**
- 震央座標あり → center: 震央, zoom: 6.5
- 震央座標なし → center: デフォルト, zoom: 5.0

### 2-10. タップ操作

| タップ対象 | レイヤー/ソースレイヤー判定 | ポップアップ内容 |
|-----------|--------------------------|----------------|
| 観測点 (circle) | `eq-history-station-intensity-circle` | 観測点名, 震度, 長周期震度 |
| 市区町村 (fill) | ソースレイヤー `areaInformationCityQuake` | 地域名, 最大震度 |
| 細分化地域 (fill) | ソースレイヤー `areaForecastLocalE` | 地域名, 最大震度 |

---

## ホーム画面 vs 地震履歴詳細 比較

| 機能 | ホーム画面マップ | 地震履歴詳細マップ |
|------|---------------|-----------------|
| リアルタイム更新 | あり (Kmoni / EEW) | なし (静的表示) |
| 強震モニタ | あり | なし |
| PS 波圏 | あり | なし |
| EEW 推定震度 | あり | なし |
| 推計震度 (PMTiles) | なし | あり (設定による) |
| 震源マーカー | EEW 震源 (複数/点滅) | 地震震源 (1 点/固定) |
| 震度塗りつぶし | EEW 予報地域 | 地域/市区町村 (設定による) |
| LPGM 表示 | なし | あり (設定による) |
| 観測点 | なし | あり (ドット + アイコン + ラベル) |
| 回転/チルト | 有効 | 無効 |
| カメラ自動追従 | EEW 連動 | なし (手動ホーム戻りのみ) |
