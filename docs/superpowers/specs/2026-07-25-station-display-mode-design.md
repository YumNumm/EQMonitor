# 地震履歴詳細画面 観測点表示モード切替 設計

日付: 2026-07-25

## 背景

地震履歴詳細画面の観測点アイコンは、データソースによって表示パターンが異なる。

- XML(電文)由来: `EarthquakeHistoryStationIntensityLayer`
  (`app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart`)
  が既定の `StationDisplayMode.maxFocused` で動作し、最大震度観測点のみ数字入り
  (`JmaIntensity.small.*`)、他は色のみの小円 (`JmaIntensity.smallWithoutText.*`)。
  円レイヤー・ラベルレイヤーを含む3層構成。
- 震度データベース由来: `EarthquakeHistoryShindoDbStationLayer`
  (`app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`)
  は全観測点が常に数字入り (`cls.mapIconId`)。シンボルレイヤー1枚のみ。

この不一致を解消し、表示パターンをユーザーが選択できるようにする。

## 要件

観測点アイコンの表示モードを4種から選択可能にする。XML・震度DB両レイヤーに適用する。

1. **自動 (既定)**: ズームが閾値未満では最大震度観測点のみ数字入り・他は色のみ。
   閾値以上ではすべて数字入り。
2. **最大震度のみ数字入り**: ズームに関係なく最大震度観測点のみ数字入り。
3. **すべて数字入り**: 全観測点に数字入りアイコン。
4. **すべて色のみ**: 全観測点を色のみの円で表示。

- 切替UIは詳細画面の「マップレイヤー」モーダル
  (`earthquake_history_details_map_layer_modal.dart`) に追加し、設定は永続化する。
- DB固有階級の扱い: 旧5/旧6は数字系モードでラベル入り・色のみモードでは色付き円。
  震度不明は数字系モードでラベル入りグレー円・色のみモードではラベルなしグレー円。

## 設計

### 1. データモデル・設定

- `StationDisplayMode` (`earthquake_history_config_model.dart:42`) に `auto` を追加。
  `auto / maxFocused / normal / allMinimized` の4値。既定は `auto`。
- `EarthquakeHistoryConfig` に `details` セクション
  (`EarthquakeHistoryDetailsConfig`、`@Default` 付き) を新設し
  `stationDisplayMode` を保持。保存済みJSONに `details` キーが無くても
  デフォルト値で復元できること (後方互換)。
- `EarthquakeHistoryMapLayerParameter` に `stationTextZoom` (`@Default(9)`) を追加。
  自動モードで全観測点が数字入りになるズーム閾値。既存デバッグモーダル
  (`earthquake_history_debug_modal.dart`) にスライダーを追加。

### 2. GeoJSON・レイヤー (コア)

GeoJSONは**モード非依存**とする。両ビルダーが各観測点featureに常に付与:

- `iconIdFull`: 数字入りアイコンID (`JmaIntensity.small.*` /
  `ShindoDbIntensityClass.small.*` / LPGM時は `JmaLpgmIntensity.small.*`)
- `iconIdPlain`: 色のみアイコンID (各 `smallWithoutText` 変種)
- `isMax`: その地震の最大震度観測点か (bool)

`icon-image` 式をモードから組み立てる共通ヘルパーを新設し、両レイヤーで共用する:

| モード | icon-image式 |
|---|---|
| auto | `['step', ['zoom'], ['case', ['get','isMax'], ['get','iconIdFull'], ['get','iconIdPlain']], stationTextZoom, ['get','iconIdFull']]` |
| maxFocused | `['case', ['get','isMax'], ['get','iconIdFull'], ['get','iconIdPlain']]` |
| normal | `['get','iconIdFull']` |
| allMinimized | `['get','iconIdPlain']` |

- モード切替時はGeoJSON再構築なし。layoutプロパティの更新のみ。
- XML側の円レイヤー・ラベルレイヤー・ズーム連動アイコンサイズは現状維持。
- LPGM表示時も同じ仕組み (最大は `maxLpgmIntensity` 基準)。
- XML側の既存 `iconIdForStation` / `StationDisplayMode` によるGeoJSON側出し分け
  (`earthquake_history_station_intensity_layer.dart:281-293`) はこの方式に置き換える。

**検証タスク (実装の最初)**: `step` + `case` 合成式が `icon-image` で
iOS/Android両方で動作するかを確認する。動作しない場合は案C
(minZoom/maxZoomで分割した2枚のシンボルレイヤー) にフォールバックする。

### 3. 震度DB側

- `EarthquakeHistoryShindoDbStationLayer` に `stationDisplayMode` パラメータを追加し、
  同じ式ヘルパーを適用。
- `isMax`: 震度ツリー内で `orderIndex` 最大の階級に属する観測点。
- DB固有階級用の色のみバリアントを新設:
  - `ShindoDbIntensityClassMapIcon` に文字なし描画を追加。
  - 画像ID `ShindoDbIntensityClass.smallWithoutText.<name>` で登録
    (`shindoDbIntensityIconProvider` が数字入り・色のみ両方を生成)。
  - 現行階級 (1〜7) はXML側と共通の既存 `JmaIntensity.smallWithoutText.*` を流用。
- DB側はシンボルレイヤー1枚のまま (円レイヤーは追加しない)。

### 4. UI

「マップレイヤー」モーダルに「観測点」セクションを追加。既存 `_LocationCard` と
同様のカードUIで4択 (自動 / 最大震度のみ / すべて数字入り / 色のみ)。
選択は `EarthquakeHistoryConfigNotifier.save` で即永続化し、
詳細画面の地図はRiverpod watch経由で即時反映。
`earthquake_history_details_map_view.dart` は設定から `stationDisplayMode` を
両レイヤーへ受け渡す。

### 5. テスト

- 両GeoJSONビルダー: `isMax` / `iconIdFull` / `iconIdPlain` の付与
  (XML / LPGM / DB、DB固有階級の旧5・旧6・震度不明を含む)。
- 式ヘルパー: 4モードそれぞれの式構造。
- `ShindoDbIntensityClass` の `smallWithoutText` 版 `mapIconId`。
- 設定JSONの後方互換 (`details` キー欠如時のデフォルト復元)。

## スコープ外

- 震度DBレイヤーへの円レイヤー・観測点名ラベルレイヤーの追加
- ホーム画面や他画面の観測点表示
- `EarthquakeHistoryFillMode` (塗りつぶしモード) の設定UI化
