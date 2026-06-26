# Earthquake Detail: Layer Debug Params + Intensity Display Mode

## Overview

地震履歴詳細画面に対する3つの改善:

1. 既存の表示設定モーダルを削除し、全パラメータをデバッグ専用UIに移行
2. 塗りつぶし透明度・観測点サイズ・震央マーカーサイズ等の追加パラメータをデバッグから編集可能に
3. 推計震度デフォルト表示 + アニメーション付き折りたたみSegmentedControlでモード切替

## 1. 既存設定モーダルの削除 + デバッグパラメータ統合

### 削除対象

| ファイル/コンポーネント | アクション |
|---|---|
| `EarthquakeHistoryMapDisplayModeModal` | ファイルごと削除 |
| `EarthquakeHistoryDetailConfig` のユーザー向けフィールド群 | デフォルト値で固定化 |
| `EarthquakeHistoryConfigNotifier` | 不要になるため削除 |
| マップ右上「レイヤー」ボタン | デバッグボタンに置き換え |

固定化されるデフォルト値:

- `fillMode`: `.auto`
- `stationDisplayMode`: `.maxFocused`
- `hypocenterDisplayMode`: `.zoomFade`
- `showHypocenterError`: `false`
- `showStationLabel`: `false`
- `showStation`: `true`
- `showLegend`: `true`

### 新規モデル: `EarthquakeHistoryMapLayerParameter`

```dart
@freezed
class EarthquakeHistoryMapLayerParameter {
  const factory EarthquakeHistoryMapLayerParameter({
    // --- ズーム閾値 ---
    @Default(8) double regionToCity,
    @Default(8) double stationMinZoom,
    @Default(9) double stationLabelMinZoom,
    @Default(8) double hypocenterFadeZoom,
    @Default(8) double hypocenterErrorMinZoom,

    // --- 塗りつぶし透明度 ---
    @Default(0.6) double regionFillOpacity,
    @Default(0.8) double regionLineOpacity,
    @Default(0.6) double cityFillOpacity,

    // --- 観測点サイズ (circle-radius) ---
    @Default(2) double stationCircleRadiusMin,   // z4
    @Default(8) double stationCircleRadiusMax,   // z10

    // --- 観測点アイコンサイズ (icon-size) ---
    @Default(0.025) double stationIconSizeMin,   // z3
    @Default(0.18) double stationIconSizeMid,    // z7
    @Default(0.6) double stationIconSizeMax,     // z20

    // --- 震央マーカー ---
    @Default(0.15) double hypocenterIconSizeMin, // z3
    @Default(0.4) double hypocenterIconSizeMax,  // z20
    @Default(0.6) double hypocenterFadeOpacity,  // zoomFade時の半透明度
  }) = _EarthquakeHistoryMapLayerParameter;
}
```

Notifier: `EarthquakeHistoryMapLayerParameterNotifier`
- SharedPreferences に永続化
- デフォルト値リセットメソッド付き

### アクセス制御

条件: `kDebugMode || (debugProvider.value == true)`

アクセス経路:
1. **地震履歴詳細画面 マップ右上**: 虫アイコンボタン表示 → タップでスライダーモーダル
2. **`/debug` ページ**: 「地震履歴 レイヤーパラメータ」ListTile → パラメータ確認/リセット画面

### z-order修正

City fill layers の `belowLayerId` を `areaInformationCityQuakeLine` から `areaForecastLocalELine` に変更。震度塗りつぶし(fill/line)は全て Region baseline の下に配置。

## 2. 推計震度デフォルト + SegmentedControl + カード分離

### IntensityDisplayMode enum

```dart
enum IntensityDisplayMode { jma, lpgm, estimated }
```

- `jma`: 各地の震度 — 常に利用可能
- `lpgm`: 各地の長周期地震動階級 — `maxLpgmIntensity != null` の場合のみ
- `estimated`: 推計震度 — `estimatedIntensityTileUrl != null` の場合のみ

### デフォルト選択ロジック

```
estimated available → estimated
else → jma
```

画面ローカル state (`useState`)。永続化しない。

### カードとマップの連動

| モード | カードヘッダー | カード内容 | マップ |
|---|---|---|---|
| `jma` | 各地の震度 | JMA震度ツリー | JMA fill + station layers |
| `lpgm` | 各地の長周期地震動階級 | LPGMツリー | LPGM fill + station layers |
| `estimated` | 推計震度 | 簡易メッセージ | 推計震度ラスタータイル |

### コンポーネント分離

```
EarthquakeIntensityCard（外殻: BorderedContainer + ヘッダー行）
├── ヘッダー行: タイトルテキスト + CollapsibleSegmentedControl
└── コンテンツ（IntensityDisplayMode で差し替え）
    ├── JmaIntensityContent   — 現在のツリー表示を抽出
    ├── LpgmIntensityContent  — lpgmIntensityTree ベースのツリー
    └── EstimatedIntensityContent — 簡易テキスト表示
```

### CollapsibleSegmentedControl

**折りたたみ時:**
- 選択中のモード名だけ表示（コンパクトChip + ▼）
- ヘッダー行の右端に配置

**展開時 (AnimatedSize):**
- タップで全セグメントが右端起点で左方向に水平展開
- ヘッダーの「各地の震度」テキストに重なってOK
- 位置固定: `jma` 左 / `lpgm` 中央(あれば) / `estimated` 右(あれば)
- セグメント選択 or 外側タップで折りたたみに戻る
- アニメーション: ~200ms ease-in-out

**ラベル:**
- `jma`: 各地の震度
- `lpgm`: 長周期階級
- `estimated`: 推計震度

## 影響範囲

### 変更ファイル

- `earthquake_history_config_model.dart` — 削除 or 大幅簡素化
- `earthquake_history_config_notifier.dart` — 削除
- `earthquake_history_map_display_mode_modal.dart` — 削除
- `earthquake_history_details_map_view.dart` — config依存をparameter依存に置換、displayMode連動
- `earthquake_history_fill_layer.dart` — parameter参照、z-order修正
- `earthquake_history_station_intensity_layer.dart` — parameter参照
- `earthquake_history_hypocenter_layer.dart` — parameter参照
- `earthquake_history_hypocenter_error_layer.dart` — parameter参照
- `earthquake_history_details_estimated_intensity_layer.dart` — displayMode連動
- `earthquake_history_details_page.dart` — displayMode state管理、Card差し替え
- `region_intensity.dart` — EarthquakeIntensityCard + 各Content widgetに分離
- `earthquake_history_map_layer_mode.dart` — ZoomThresholds → parameter内に統合

### 新規ファイル

- `earthquake_history_map_layer_parameter.dart` — freezed model
- `earthquake_history_map_layer_parameter_notifier.dart` — Riverpod notifier
- `earthquake_history_debug_modal.dart` — デバッグ用スライダーモーダル
- `intensity_display_mode.dart` — enum定義
- `collapsible_segmented_control.dart` — アニメーション付き折りたたみコントロール
- `jma_intensity_content.dart` — JMAツリー表示
- `lpgm_intensity_content.dart` — LPGMツリー表示
- `estimated_intensity_content.dart` — 推計震度簡易表示
- `earthquake_intensity_card.dart` — 外殻カード

### debug_page.dart への追加

```dart
ListTile(
  title: const Text('地震履歴 レイヤーパラメータ'),
  leading: const Icon(Icons.layers_outlined),
  onTap: () => /* パラメータ確認/リセット画面へ遷移 */,
),
```
