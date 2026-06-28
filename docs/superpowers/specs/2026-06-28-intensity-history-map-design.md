# 地域別 最大震度マップ 設計書

作成日: 2026-06-28

## 1. 目的・背景

過去の地域ごとの最高震度を地図で俯瞰できる画面を新設する。

- **Lv1(都道府県)**: 全都道府県を過去最高震度で色分けしたコロプレス図を表示。
- **Lv2(市区町村)**: 都道府県を選択するとその都道府県にフォーカス(他地域をディム + ズーム)し、市区町村ごとの最高震度を色分け表示。
- **Lv3(詳細)**: 市区町村をタップするとモーダルでサマリ + その市区町村の過去地震一覧を表示。

ホーム下部シートからの導線、および他画面からの直接フォーカス遷移(ディープリンク)を提供する。

## 2. 利用する backend API(実装済み・再生成不要)

コミット済みの `packages/eqmonitor_api` に既に生成済みのクライアントを利用する(本機能のためのコード再生成は行わない)。

| 用途 | メソッド(`EarthquakeApiClient`) | エンドポイント | 返却 |
|---|---|---|---|
| Lv1 都道府県の最高震度 | `getV2EarthquakeIntensityPrefectureHighest()` | `GET /v2/earthquake/intensity/prefecture/highest` | `HighestIntensityResponse` |
| Lv2 市区町村の最高震度 | `getV2EarthquakeIntensityPrefectureCodeCityHighest(code:)` | `GET /v2/earthquake/intensity/prefecture/{code}/city/highest` | `HighestIntensityResponse` |
| Lv3 市区町村の地震一覧 | `getV2EarthquakeIntensityCityCode(code:, limit:, cursor:, ...)` | `GET /v2/earthquake/intensity/city/{code}` | `IntensityCitySearchResponse` |

`HighestIntensityItem = { code, name, intensity: JmaIntensity, count, earthquake: EarthquakePartial }`。

- `code` は気象庁防災情報XMLフォーマットの地域コード。
- 市区町村コードは都道府県コードを接頭辞に持つ(backend は `code >= prefectureCode AND code < prefectureCode+1` で抽出)。
- `count` は同一最高震度を観測した地震件数、`earthquake` はその最高震度を観測した直近の地震イベント。

## 3. 地図レンダリング戦略

地図ソースは既存の `eqmonitor_map`(`pmtiles://https://v2.map.eqmonitor.app/all.pmtiles`)を再利用する。PMTiles に含まれるポリゴンレイヤは `countries` / `areaForecastLocalE` / `areaForecastLocalEew` / `areaInformationCityQuake`。**都道府県専用のポリゴンレイヤは存在しない。**

既存パターン(`earthquake_history_region_intensity_layer.dart`)に倣い、`StyleController.addLayer` で `FillStyleLayer` を動的追加し、`['match', ['get','code'], code1, color1, ...]` 式で色を割り当てる(該当なしは透明)。

### Lv1: 都道府県コロプレス
- `areaForecastLocalE` を `match` 式で塗る。`prefecture/highest` の各 `code` → その最高震度色。
- `areaForecastLocalE` のフィーチャは都道府県コードでマッチ可能(`forecastLocalEIntensityPairs` が `pref.prefecture.prefecture.code` を `areaForecastLocalE` の code として使用している前例あり)。
- 実装時に `prefecture/highest` の code 粒度が `areaForecastLocalE` フィーチャと一致しないことが判明した場合は、`earthquake.prefectures[].regions[].code`(細分区域コード)へ展開して match 式を構築する(マッピングデータはパラメータから取得可能)。この検証は実装プランの最初のタスクで行う。

### Lv2: 市区町村コロプレス + フォーカス
- `areaInformationCityQuake` に `FillStyleLayer` を追加し、`city/highest` の各 `code` → 最高震度色で塗る。
- 他都道府県のディム: 選択都道府県以外を覆うディムオーバーレイ(半透明 fill)、または Lv1 の塗りの opacity を下げる。`areaForecastLocalELine` 等の境界線も薄くする。
- ズーム: 選択都道府県の範囲に `fitBounds`。bounds は `jmaMapProvider` のポリゴン(`JmaMap_JmaMapData`)から該当都道府県構成区域の bounds を union して算出。

### タップ判定
- `MapController.queryLayers(screenPoint)` で命中フィーチャの `code` / `sourceLayer` を取得(既存 `earthquake_history_details_map_view.dart` のパターン)。
- Lv1: `areaForecastLocalE` 命中 → code を都道府県コードへ正規化 → 当該都道府県へフォーカス(Lv2 へ)。
- Lv2: `areaInformationCityQuake` 命中 → 市区町村コード → Lv3 モーダル表示。

## 4. ディレクトリ構成 `app/lib/feature/intensity_history/`

`eew_history` / `earthquake_history` の構成を踏襲する。

```
data/
  model/
    highest_intensity_entry.dart      # HighestIntensityItem の app 用ラッパ(Freezed)
    intensity_history_state.dart      # フォーカス状態(Lv1/Lv2 + 選択中 prefecture)(Freezed)
  repository/
    intensity_highest_repository.dart # 3 つの API をまとめる薄いラッパ(Riverpod)
  notifier/
    intensity_history_controller.dart # フォーカス状態管理 Notifier(Riverpod generator)
    prefecture_highest_provider.dart  # prefecture/highest をキャッシュ
    city_highest_provider.dart        # family(prefectureCode) で city/highest
    city_intensity_list_data_source.dart # Lv3 過去地震一覧(GroupedDataSource ページネーション)
ui/
  intensity_history_page.dart         # 地図全面 + フローティングパネル + 戻る制御
  layer/
    prefecture_intensity_fill_layer.dart
    city_intensity_fill_layer.dart
    dim_overlay_layer.dart
  components/
    region_floating_panel.dart        # 現在地域名・最高震度・件数の浮遊パネル
    city_detail_modal.dart            # サマリ + 過去地震一覧
    intensity_history_legend.dart     # 震度色凡例
```

色は既存の `intensityColorProvider`(`IntensityColorModel`)を利用。

## 5. 状態・データフロー

`intensity_history_controller`(Riverpod Notifier)が画面状態を保持:

```
IntensityHistoryState =
  | Prefecture()                                   # Lv1
  | City(prefectureCode, prefectureName)           # Lv2 フォーカス中
```

- 画面表示: `prefectureHighestProvider` を watch → Lv1 fill を描画。フローティングパネルは「全国」表示。
- 都道府県選択(タップ or ディープリンク): state を `City(...)` に。`cityHighestProvider(prefectureCode)` を watch → Lv2 fill 描画 + ディム + `fitBounds`。
- 市区町村タップ: `showModalBottomSheet` で `CityDetailModal` 表示。モーダル内で `cityIntensityListDataSource(cityCode)` をページネーション。
- 戻る: state を `Prefecture()` に戻し、Lv2 レイヤ除去 + 全国へズームアウト。端末の戻るボタンでも Lv2→Lv1 を優先処理(`PopScope`)。

## 6. ナビゲーション

### ルート
```dart
@TypedGoRoute<IntensityHistoryRoute>(path: '/intensity-history')
class IntensityHistoryRoute extends GoRouteData with $IntensityHistoryRoute {
  const IntensityHistoryRoute({this.prefectureCode, this.cityCode});
  final String? prefectureCode; // 指定時は当該都道府県にフォーカス起動
  final String? cityCode;       // 指定時はさらに市区町村モーダルを自動表示
}
```
- `prefectureCode` 指定 → 起動時に Lv2 フォーカス。
- `cityCode` 指定 → Lv2 フォーカス + 当該市区町村モーダルを自動 push。

### 導線(主)
- HomeSheet のアクションカード(`home_page.dart` の `_SheetBody`、設定/デバッグ ListTile と同列)に「都道府県別 最大震度」ListTile を追加。

### ディープリンク(代表 1 箇所)
- 地震履歴詳細マップのポップアップ(`earthquake_history_map_popup.dart` 系)に「この地域の最大震度履歴」アクションを追加し、タップ地域の都道府県/市区町村コードを `IntensityHistoryRoute` に渡して遷移。

## 7. エラー・ローディング・空状態

- `prefecture/highest` / `city/highest` 失敗: 地図上に `ErrorCard` + リトライ(既存コンポーネント流用)。
- Lv3 過去地震一覧: `Skeletonizer` でスケルトン、失敗時 `ErrorCard`、空時「震度の記録がありません」。
- 地図レイヤ追加/除去は例外を握り潰さず `talker.log`(既存パターン)。

## 8. テスト方針(`app/test/feature/intensity_history/`)

- `intensity_highest_repository` の変換(API モデル → app モデル)。
- 細分区域↔都道府県、市区町村↔都道府県のコード対応(純粋関数)。
- match 式構築関数(code→color ペア生成)の単体テスト。
- `intensity_history_controller` のフォーカス遷移(Lv1↔Lv2)単体テスト。
- `city_detail_modal` / フローティングパネルのスモークテスト(`ProviderScope` override)。

## 9. スコープ外(本 PR では実装しない)

- `eqmonitor_api` の最新 backend(OpenAPI 3.1)への再生成・同期(別途対応)。
- highest 系のフィルタ(時間範囲等)。API がクエリ非対応のため Lv1/Lv2 は全期間集計のみ。
- ディープリンクの配線先を地震履歴詳細以外へ拡張すること。

## 10. 受け入れ条件

1. HomeSheet から本画面に遷移でき、全都道府県が過去最高震度で色分け表示される。
2. 都道府県をタップ/選択すると当該都道府県にズーム・他地域がディムし、市区町村ごとの最高震度が色分け表示される。
3. 市区町村をタップするとモーダルでサマリ + 過去地震一覧(ページネーション)が表示される。
4. 地震履歴詳細マップのポップアップから当該地域にフォーカスした状態で本画面に直接遷移できる。
5. `dart analyze` 警告ゼロ、関連ユニットテストがパス、生成ファイルをコミット。
6. iOS ビルド(deploy-app workflow / Deploy iOS)が成功する。
