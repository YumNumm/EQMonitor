# マップ機能仕様書 (v2.6.0)

調査対象:
- `app/lib/feature/home/features/map/viewmodel/main_map_viewmodel.dart`
- `app/lib/feature/earthquake_history_details/component/earthquake_map.dart`

---

## 共通仕様

### マップエンジン

| 項目 | 値 |
|------|-----|
| ライブラリ | MapLibre GL (flutter-maplibre) |
| タイルソース | `https://map.eqmonitor.app/tiles/tiles.json` (ベクタータイル) |
| スタイル (Web) | `https://map.eqmonitor.app/tiles/style.json` |
| スタイル (Native) | ローカルファイルに書き出して参照 (ダーク/ライト別) |
| グリフ | `https://glyphs.geolonia.com/{fontstack}/{range}.pbf` |

### ベースレイヤー構成 (下から上の順)

| ID (`BaseLayer`) | ソース レイヤー | タイプ | 備考 |
|------------------|----------------|--------|------|
| `background` | — | background | テーマ背景色 |
| `countriesFill` | `countries` | fill | 世界の陸地 |
| `countriesLines` | `countries` | line | 国境線。zoom 3→0.5px, zoom 5.5→1px |
| `areaForecastLocalEFill` | `areaForecastLocalE` | fill | 日本の予報地域 (陸地色) |
| `areaForecastLocalEewLine` | `areaForecastLocalEew` | line | EEW地域境界線。zoom 3→0.5px, zoom 5.5→1px |
| `areaForecastLocalELine` | `areaForecastLocalE` | line | 予報地域細線。zoom 3→opacity 0, zoom 5→0.2, zoom 5.5→1。線幅 0.5px |
| `areaInformationCityQuakeLine` | `areaInformationCityQuake` | line | 市区町村境界線。線幅 0.5px。zoom 7→opacity 0, zoom 9.5→0.3 |

### カラーテーマ

- ライト/ダークで `MapColorScheme` が切り替わる
- 対象色: backgroundColor / worldLandColor / worldLineColor / japanLandColor / japanLineColor

---

## 1. ホーム画面マップ (`MainMapViewModel`)

### 1-1. 状態管理

```
MainMapViewmodelState {
  isHomePosition: bool   // ユーザーが地図を動かしていない状態か
  homeBoundary: LatLngBounds  // 現在のホーム表示領域
}
```

- ユーザーがカメラを動かすと `isHomePosition = false`
- EEW活性時は自動的にカメラを移動し `isHomePosition = true` に戻す

### 1-2. デフォルト表示境界

```
SW: (30.0°N, 128.8°E)
NE: (45.8°N, 145.1°E)
```
日本本州〜九州・北海道をカバーする範囲。

### 1-3. レイヤー構成（上から下）

```
[EEW震源シンボル (hypocenter-low-precise)]
[EEW震源シンボル (hypocenter)]
[Kmoni観測点サークル (kmoni-circle)]
--- areaForecastLocalELine ---
[EEW推定震度フィル (各JmaForecastIntensity別)]
--- areaForecastLocalEewLine ---
[countriesFill]
[background]
```

### 1-4. 強震モニタ (Kmoni) レイヤー

| 項目 | 値 |
|------|-----|
| ソース ID | `kmoni-circle` |
| レイヤータイプ | CircleLayer |
| 表示条件 | `kmoniSettings.useKmoni == true` かつ `intensityValue != null` |
| 最低表示震度 | `kmoniSettings.minRealtimeShindo` で設定 (null = 全点表示) |

**サイズ補間:**

| zoom | 半径 (px) | ストローク幅 (px) |
|------|----------|----------------|
| 3 | 1 | 0.2 |
| 10 | 10 | 1.0 |

**プロパティ:**
- `color`: リアルタイム震度に対応したカラーコード
- `intensity`: 震度値 (サークルのソートキーに使用。高震度が上)
- ストローク色: グレー

### 1-5. EEW震源マーカーレイヤー

| 項目 | 値 |
|------|-----|
| ソース ID | `hypocenter` |
| レイヤータイプ | SymbolLayer × 2 |
| 表示対象 | キャンセルされていない、座標あり EEW |

**アイコン種別:**

| 条件 | アイコン ID |
|------|------------|
| 通常震源 | `hypocenter` |
| 低精度震源 (IPF1点 / レベル法 / PLUM) | `hypocenter-low-precise` |

**サイズ補間:**

| zoom | iconSize |
|------|----------|
| 3 | 0.3 |
| 20 | 2.0 |

**不透明度補間 (通常時):**

| zoom | opacity |
|------|---------|
| 6 | 1.0 |
| 10 | 0.5 |

**点滅アニメーション:**
- 毎ティック (≒1秒) で `DateTime.now().millisecondsSinceEpoch % 1000 < 500` を判定
- `true` → opacity 1.0、`false` → opacity 0.5
- 状態変化がない場合はスキップ (冗長更新防止)

**GeoJSON プロパティ:**
- `depth`: 震源深さ (km)
- `magnitude`: マグニチュード
- `isLowPrecise`: 低精度フラグ

### 1-6. PS波レイヤー

| 項目 | 値 |
|------|-----|
| ソース ID | `ps-wave` |
| 更新タイミング | 毎ティック (≒1秒) |
| 対象 EEW | 通常震源 (IPF1点/レベル法/PLUM を除く) |

**波形計算:**
- 走時テーブル (`TravelTimeDepthMap`) から深さ・経過時間でP/S波到達距離を線形補間
- 円は 91点 (4度刻み, 0〜360°) のポリゴンで表現
- 距離単位: m (`距離km × 1000`)

**レイヤー一覧:**

| レイヤー ID | タイプ | 色 | 線幅 | 不透明度 | 条件 |
|------------|--------|----|------|----------|------|
| `p-wave-line` | LineLayer | `Colors.blueAccent` | — | — | type == pWave |
| `s-wave-line-true` | LineLayer | `Colors.redAccent` | 2px | — | type == sWave, is_warning == true |
| `s-wave-line-false` | LineLayer | `Colors.orangeAccent` | 2px | — | type == sWave, is_warning == false |
| `s-wave-fill-true` | FillLayer | `Colors.red` | — | 0.2 | type == sWave, is_warning == true |
| `s-wave-fill-false` | FillLayer | `Colors.orangeAccent` | — | 0.2 | type == sWave, is_warning == false |

> P波フィルレイヤーはコードアウト (無効)。

**表示 EEW が 0 件になった後:**
- 最初の 0件ティックで GeoJSON を空更新し、以後はスキップ (`didUpdatedSinceZero` フラグ)

### 1-7. EEW推定震度レイヤー

| 項目 | 値 |
|------|-----|
| ソース | `eqmonitor_map` ベクタータイルの `areaForecastLocalE` レイヤー |
| レイヤー数 | `JmaForecastIntensity` 全値 × 1 FillLayer |
| レイヤー名 | `_EewEstimatedIntensityService-fill-{intensity}` |
| 配置 | `areaForecastLocalELine` より下 |

**変換ロジック:**
1. EEW電文の `regions` を地域コードでグループ化
2. 同一地域に複数予報震度がある場合、最大値を採用
3. `Map<JmaForecastIntensity, List<地域コード>>` に変換してフィルター更新

### 1-8. カメラ制御

| 操作 | メソッド | アニメーション | padding |
|------|---------|--------------|---------|
| デフォルト位置へ即時移動 | `moveCameraToDefaultPosition()` | なし | パラメータ指定 |
| デフォルト位置へアニメーション | `animateCameraToDefaultPosition()` | 250ms | bottom: 50px |
| ホーム境界へアニメーション | `animateToHomeBoundary()` | 250ms | bottom: 150, 他: 10px |
| ホーム境界へ即時移動 | `moveToHomeBoundary()` | なし | bottom: 100, 他: 10px |

**EEW活性時の自動ズーム:**
- 震源座標を中心に ±3° のバウンディングボックスを計算
- `changeHomeBoundaryWithAnimation()` を呼び出し (duration: 250ms, padding: bottom 50, 左右上 20)
- `isForce=true` (EEW件数変化時): 現在の `isHomePosition` 状態に関わらず強制移動
- `isForce=false`: `isHomePosition == true` の場合のみアニメーション実行

---

## 2. 地震履歴詳細マップ (`EarthquakeMapWidget`)

### 2-1. 基本仕様

| 項目 | 値 |
|------|-----|
| 回転ジェスチャー | 無効 |
| チルトジェスチャー | 無効 |
| 初期 zoom | 7 |
| 最大 zoom | 6 (初期ロード中) → スタイルロード完了後 12 |

### 2-2. 初期カメラ位置

**優先順位:**

1. `regionsItem` が存在する場合
   - 各地域の境界ボックスをマージ
   - 震源座標を含むように拡張
   - padding: 全方向 10px
2. `regionsItem` が null かつ震源座標あり
   - 震源座標 zoom=2
3. 震源座標も null
   - (35°N, 139°E) zoom=6

**「ホームに戻る」ボタン:** 上記 `cameraUpdate` で `animateCamera()` を呼び出す

### 2-3. データ計算 (isolate)

`_compute()` は `Flutter compute()` で isolate 実行:

| データ | 元フィールド | 用途 |
|--------|------------|------|
| `regionsItem` | `intensityRegions` | 予報地域別震度 |
| `citiesItem` | `intensityCities` | 市区町村別震度 |
| `stationsItem` | `intensityStations` + JMAパラメータ | 観測点別震度 (座標付き) |
| `regionsLpgmItem` | `lpgmIntensityRegions` | 予報地域別LPGM震度 |
| `stationsLpgmItem` | `lpgmIntenstiyStations` + JMAパラメータ | 観測点別LPGM震度 |

- 地域コードは `padLeft(3, '0')` でゼロ埋め

### 2-4. 表示モード (`EarthquakeHistoryDetailConfig`)

| 設定 | デフォルト | 説明 |
|------|----------|------|
| `intensityFillMode` | `fillCity` | 塗りつぶし粒度 |
| `showIntensityIcon` | `true` | 観測点アイコン表示 |
| `showingLpgmIntensity` | `false` | 長周期地震動モード (JSONからは常にfalse) |

**`IntensityFillMode` 値:**

| 値 | 動作 |
|----|------|
| `fillCity` | `citiesItem` あり → 市区町村単位塗り、なし → 地域単位塗り |
| `fillRegion` | 地域単位塗りのみ |
| `none` | 塗りつぶしなし |

**表示モード変更時:** 現在のアクションを全 dispose → 新アクションを init

### 2-5. アクション詳細

#### `_HypocenterAction` (震源マーカー)

- 常に表示 (震源座標がある場合)
- ソース: `hypocenter` GeoJSON
- レイヤー: SymbolLayer `hypocenter`、アイコン: `hypocenter`
- サイズ: zoom 3→0.3, zoom 20→1.0
- 不透明度: zoom 6→1.0, zoom 10→0.8

#### `_FillRegionAction` (地域単位震度塗り)

- ソース: `eqmonitor_map` ベクタータイル `areaForecastLocalE`
- JmaIntensity 別に Fill + Line レイヤーを追加
- Fill: 震度背景色
- Line: 線幅 0.4px, 震度前景色, opacity 0.8
- 配置: `areaForecastLocalEewLine` より下

#### `_FillCityAction` (市区町村単位震度塗り)

- ソース: `eqmonitor_map` ベクタータイル `areaInformationCityQuake`
- JmaIntensity 別に Fill + Line レイヤー
- Line: 線幅 0.4px, opacity 0.2
- 配置: `areaForecastLocalEewLine` より下

#### `_StationAction` (通常震度観測点)

- ソース: GeoJSON `station-intensity`
- ズームによる表示切り替え:

| zoom | レイヤー | アイコン | サイズ |
|------|---------|---------|--------|
| < 7 | `station-intensity-{type}-circle` | `intensity-{type}-fill` | zoom 3→0.04, zoom 7→0.3 |
| ≥ 7 | `station-intensity-{type}` | `intensity-{type}` | zoom 3→0.2, zoom 20→1.0 |

- zoom 9 以上でラベル表示 (`station-intensity-symbol`)
  - フォント: `Noto Sans CJK JP Bold`、サイズ 13
  - 色: 黒、ハロー: 白 幅 2
  - オフセット: [0, 2]

#### `_FillRegionLpgmIntensityAction` (LPGM地域塗り)

- `_FillRegionAction` と同構成、LPGMデータ使用
- ソース: `areaForecastLocalE`
- レイヤー名プレフィックス: `areaForecastLocalE-LPGM-`

#### `_StationIntensityLpgmAction` (LPGM観測点)

- ソース: GeoJSON `station-lpgm-intensity`
- ズームによる表示切り替え:

| zoom | レイヤー | アイコン | サイズ |
|------|---------|---------|--------|
| < 7 | `station-lpgm-intensity-{type}-circle` | `lpgm-intensity-{type}-fill` | zoom 3→0.1, zoom 7→0.4 |
| ≥ 7 | `station-lpgm-intensity-{type}` | `lpgm-intensity-{type}` | zoom 3→0.3, zoom 20→1.0 |

- zoom 10 以上でラベル表示 (`station-lpgm-intensity-symbol`)
  - サイズ 12、ハロー: 白 幅 0.5

### 2-6. 初期化フロー

```
onStyleLoadedCallback()
  → addImage(hypocenter, ...)
  → addImage(intensity-{type} × 全震度)
  → addImage(intensity-{type}-fill × 全震度)
  → addImage(lpgm-intensity-{type} × 全LPGM震度)
  → addImage(lpgm-intensity-{type}-fill × 全LPGM震度)
  → initActions(currentActions)  // アクション初期化
  → moveCamera(cameraUpdate)     // 初期カメラ位置
  → maxZoomLevel = 12            // ズーム上限解放
```

- スタイルロード完了前は `CircularProgressIndicator.adaptive()` を表示
- 以下が全て揃うまでロード表示:
  - `earthquakeParams` (JMAパラメータ)
  - 震度アイコン全種 (通常/塗り/LPGM/塗り)
  - `jmaMap`
  - `hypocenterIconRender`
  - スタイルファイルパス

---

## 差分まとめ

| 機能 | ホーム画面マップ | 地震履歴詳細マップ |
|------|---------------|-----------------|
| リアルタイム更新 | あり (Kmoni / EEW) | なし (静的表示) |
| 強震モニタ | あり | なし |
| PS波圏 | あり | なし |
| EEW推定震度 | あり | なし |
| 震源マーカー | EEW震源 (複数/点滅) | 地震震源 (1点/固定) |
| 震度塗り | EEW予報地域 | 地域/市区町村/観測点 (設定による) |
| LPGM表示 | なし | あり (設定による) |
| 観測点アイコン | なし | あり (設定による) |
| 回転/チルト | 有効 | 無効 |
| 最大zoom | 制限なし | 12 |
| カメラ自動追従 | EEW連動 | なし (手動ホーム戻りのみ) |
