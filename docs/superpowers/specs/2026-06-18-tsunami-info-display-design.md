# 津波情報表示画面 設計書

## 概要

津波情報の詳細画面を実装する。マップ上に津波予報区・震源・観測点を表示し、シート内に警報ステータス・現在地情報・地域一覧・地震情報を配置する。

既存の地震履歴詳細画面 (`EarthquakeHistoryDetailsPage`) と同一の `Stack[MapView + BasicModalSheet]` パターンを踏襲する。

## ナビゲーション

- ホーム画面の津波情報カードからpush遷移
- ルーティングパラメータ: `tsunamiId` (UUID)
- GoRouter でルート定義

## データ取得

### API エンドポイント

`GET /v2/tsunami/:tsunamiId` -> `TsunamiState`

### TsunamiState の構造

```
TsunamiState
  id: String (UUID)
  eventIds: List<String> (DMDATA event IDs)
  isActive: bool
  isCanceled: bool
  updatedAt: DateTime
  earthquake: TsunamiStateEarthquake? (単一、nullable)
    originTime: DateTime
    hypocenter: TsunamiStateHypocenter
      value: CodeName (code, name)
      depth: Depth (type, value?)
      magnitude: Magnitude (type, value?)
      coordinates: Coordinate? (latitude, longitude)
      auxiliary: HypocenterAuxiliary?
    arrivalTime: DateTime?
  latestTelegrams: List<LatestTelegram>
    type: TelegramType (VTSE41/51/52)
    title: String
    pressAt: DateTime
    headline: String?
    serialNo: num?
    comments: TsunamiComments?
  forecastRegions: List<MergedForecastRegion>
    code: String
    name: String
    kind: TsunamiWarningKind (majorWarning/warning/advisory/forecast/none)
    kindCode: String?
    lastKind: TsunamiWarningKind?
    firstHeight: TsunamiForecastFirstHeight? (arrivalTime?, condition?)
    maxHeight: TsunamiForecastMaxHeight? (value?, over?, qualitative?, isImportant?)
    stations: List<TsunamiForecastStation>?
    observation: Observation? -> stations: List<TsunamiObservationStation>
      code, name, firstHeight (arrivalTime?, initial?, isUnidentifiable?, isMissing?),
      sensor?, maxHeight? (dateTime?, value?, over?, isRising?, condition?, isMissing?)
    estimation: Estimation? (firstHeight?, maxHeight?)
  offshoreObservations: List<MergedOffshoreObservation>
    stationCode, stationName, sensor?,
    firstHeight? (arrivalTime?, initial?, isUnidentifiable?, isMissing?),
    maxHeight? (dateTime?, value?, over?, isRising?, condition?, isMissing?)
```

### 状態管理

- `tsunamiDetailsProvider(tsunamiId)` -- AsyncNotifierProvider
- データ更新: 画面表示中は30秒間隔でAPI再取得（Timer + ref.invalidate）
- 現在地: 既存の位置情報プロバイダー
- 津波パラメータ（観測点位置情報）: 既存の `TsunamiParameter` プロバイダー

## ページ構成

```
TsunamiDetailsPage(tsunamiId: String)
  Scaffold
    body: Stack
      [0] TsunamiDetailsMapView          -- MapLibre 全画面
      [1] SafeArea > BasicModalSheet
            SingleChildScrollView > Column
              [0] TsunamiWarningStatusCard
              [1] CurrentLocationTsunamiCard  (現在地取得時のみ)
              [2] TsunamiRegionList
              [3] AdBanner                    (24h以上経過時)
              [4] TsunamiEarthquakeCard       (earthquake != null 時のみ)
      [2] 戻るボタン (Navigator.canPop 時)
```

## コンポーネント詳細

### 1. TsunamiWarningStatusCard

現在の最大警報レベルを表示するカード。

#### 表示内容

- ストライプパターン（上部8px）: 警報レベルに応じた色ペア
  - 大津波警報: 紫 + 黒
  - 津波警報: 赤 + 黒
  - 津波注意報: 黄 + 暗黄
  - 津波予報: ストライプなし
- ヘッダー部: 警報レベル名を背景色付きで表示
- ヘッドライン文（`latestTelegrams` の VTSE41 の `headline`）
- 最終更新時刻（`updatedAt`）
- 右端に「履歴」IconButton

#### ストライプパターンの汎用化

既存の `_EewStripePattern` / `_StripePainter` を汎用コンポーネント `WarningStripeDecoration` として切り出す。

```dart
class WarningStripeDecoration extends StatelessWidget {
  const WarningStripeDecoration({
    required this.colors,
    this.height = 8.0,
    this.stripeWidth = 8.0,
  });

  final List<Color> colors;
  final double height;
  final double stripeWidth;
}
```

EEWカード側もこれを利用するようリファクタリングする。

#### 履歴オーバーレイ

IconButton 押下で OverlayPortal / OverlayEntry を使ったフローティングポップオーバーを表示。

タイトル: 現在の最大警報レベルを反映。例: `大津波警報 が発表中`、解除後は `津波予報 解除済み`

内容:
```
大津波警報 が発表中

2024/01/01 16:10ごろ 津波警報発表
.... 大津波警報に引き上げ
.... 津波警報に引き下げ
.... 津波注意報に引き下げ
..... 津波予報解除 (見込み)
```

データソース: `latestTelegrams` の VTSE41 を `pressAt` 順にソートし、各電文の最大 `kind` の変化を抽出。`kind` が前回と同じ場合は変遷エントリに含めない。

#### 解除済み (`isCanceled: true`) の場合

- ストライプなし
- 背景: `surfaceCard` (デザインシステム標準)
- 「解除済み」の表示

### 2. CurrentLocationTsunamiCard

現在地付近の津波情報を表示するカード。位置情報が取得できない場合は非表示。

#### 構造

```
WarningStripeDecoration (8px、警報レベル色)
ヘッダー (警報レベル色背景)
  <予報区名>  <警報区分>
ボディ
  現在地付近の津波情報
  海岸線まで約Nkm           -- 整数表示
  (海上の場合は「海岸線まで約Nkm (海上)」)

  観測状況
    [観測点カード]
    [観測点カード]
```

#### 現在地判定

- `JmaMapUtility.findNearestItem(AREA_TSUNAMI)` で最寄り予報区を特定
- `distanceToCoastlineKm` で海岸線までの距離を取得（整数に丸める）
- 内陸/海上判定: 座標がJMA海岸線ポリゴンの内側（陸地）か外側（海上）かを判定
  - 海上の場合は距離表示に `(海上)` を付与

#### 観測点表示

予報区内の `observation.stations` から観測データのある観測点のみ表示。

```
石巻港
 第一波: 16:22到達 (押し)
 最大波: 1.5m (16:45) 上昇中

鮎川
 第一波: 16:28到達 (引き)
 最大波: 0.8m (16:52)
```

- `firstHeight.arrivalTime` + `firstHeight.initial` (PUSH=押し, PULL=引き)
- `maxHeight.value` + `maxHeight.dateTime` + `maxHeight.isRising` (上昇中)
- 観測データのない観測点は表示しない
- `firstHeight.isUnidentifiable` = true の場合: 「第一波: 識別不能」
- `firstHeight.isMissing` = true の場合: 表示しない

#### カードデザイン

- EEWカードのヘッダー構造を踏襲
- `RoundedSuperellipseBorder(borderRadius: 16)`
- デザインシステムの `outlineSoft` ボーダー

### 3. TsunamiRegionList

全予報区を警報レベル > 予報区 > 観測点の3段階で表示。

#### 階層構造

```
[大津波警報] -- グループヘッダー (紫系背景帯)
  [岩手県沿岸] -- 予報区カード
    予想最大波高: 10m超
    到達予想: 第一波到達中
    > 観測点を表示 (展開)
      [宮古] 第一波: 16:18到達 (押し) / 最大波: 2.3m (16:45) 上昇中
      [大船渡] 第一波: 16:20到達 (押し) / 最大波: 1.8m (16:50)

  [宮城県沿岸] -- 予報区カード
    ...

[津波警報] -- グループヘッダー (赤系背景帯)
  [福島県沿岸]
    ...

[津波注意報] -- グループヘッダー (黄系背景帯)
  ...
```

#### グループヘッダー

- 警報レベル名 + 左ボーダーまたは背景帯で色付け
  - 大津波警報: 紫
  - 津波警報: 赤
  - 注意報: 黄
  - 予報: 青系
- `kind == TsunamiWarningKind.none` の予報区は表示しない

#### 予報区カード

各予報区について:

- `name` -- 予報区名
- `maxHeight` -- 予想最大波高
  - `value` があれば数値表示 (例: "3m")
  - `over == true` の場合: "3m超"
  - `qualitative` があれば定性的表現 ("巨大" / "高い")
  - どちらもない場合は表示しない
- `firstHeight` -- 到達予想
  - `condition == ARRIVING`: "第一波到達中"
  - `condition == FIRST_WAVE_CONFIRMED`: "第一波確認"
  - `condition == IMMINENT`: "まもなく到達"
  - `arrivalTime` があれば時刻表示
  - どちらもない場合は表示しない

#### 観測点展開

「観測点を表示」タップで展開（ExpansionTile 的な挙動）。

各 `TsunamiObservationStation` について:
- 観測点名 (`name`)
- 第一波: `firstHeight.arrivalTime` + `firstHeight.initial` (押し/引き)
- 最大波: `maxHeight.value` (m) + `maxHeight.dateTime` + `maxHeight.isRising` (上昇中)
- `maxHeight.condition`:
  - `MINOR`: 微弱 → 特に強調しない
  - `OBSERVING`: 観測中
  - `IMPORTANT`: 重要 → 強調表示
- `maxHeight.over == true`: "〜超" 付与
- 観測データのある地点のみ表示

### 4. TsunamiEarthquakeCard

津波を引き起こした地震の情報を小型カードで表示。

#### 条件

- `TsunamiState.earthquake != null` の場合のみ表示
- `earthquake` は単一オブジェクト（リストではない）

#### 表示内容

```
[Card]
  <震源名>
  <発生時刻>  M<magnitude>  深さ<depth>km
```

例:
```
石川県能登地方
2024/01/01 16:10  M7.6  深さ16km
```

- 震源名: `earthquake.hypocenter.value.name`
- 発生時刻: `earthquake.originTime` をフォーマット
- マグニチュード: `earthquake.hypocenter.magnitude.value` (type=UNKNOWN の場合は "不明")
- 深さ: `earthquake.hypocenter.depth.value` (type=UNKNOWN の場合は "不明")

#### デザイン

- `RoundedSuperellipseBorder(borderRadius: 16)`
- 背景: `surfaceCard` (震度情報がないため色分けなし)
- タップで地震詳細画面へ遷移（`eventIds` の先頭を使用）

### 5. TsunamiDetailsMapView

MapLibre による全画面マップ。

#### レイヤー

1. **津波予報区ポリゴン**: JMAマップデータの `AREA_TSUNAMI` を警報レベルで塗りつぶし
   - 大津波警報: 紫 (半透明)
   - 津波警報: 赤 (半透明)
   - 注意報: 黄 (半透明)
   - 予報: 青系 (半透明)
   - ボーダー: 実線
   - `kind == none` の予報区はレイヤーに含めない

2. **震源マーカー**: `earthquake.hypocenter.coordinates` がある場合に表示（既存の震源マーカー実装を再利用）

3. **観測点マーカー**: 最大波高で色分けした小円ドット
   - 色分け:
     - `condition == IMPORTANT` or `value >= 1.0`: 赤
     - `condition == OBSERVING` or `isRising == true`: オレンジ
     - `condition == MINOR` or `value < 1.0`: 黄
     - 未到達（観測データなし）: グレー
   - 枠線付き（コントラスト確保）
   - ズーム拡大時: Callout バブルで観測点名 + 最大波高を表示

4. **現在地マーカー**: 位置情報取得時のみ

#### カメラ

- 初期表示: 全予報区のboundsにフィット（padding付き）
- 震源がある場合はそれも含む

#### インタラクション

- 予報区タップ: シートの該当予報区セクションまでスクロール
- 観測点タップ: Calloutで詳細表示

### 6. AdBanner

- `updatedAt` から24時間以上経過した場合のみ表示
- 既存の `AdBanner` ウィジェットを再利用

## 色定義

| 警報レベル | ストライプ色 | ヘッダー背景 | マップ塗りつぶし |
|---|---|---|---|
| 大津波警報 | 紫 + 黒 | RGB(128, 0, 128) 系 | 紫 (半透明) |
| 津波警報 | 赤 + 黒 | RGB(179, 26, 26) | 赤 (半透明) |
| 津波注意報 | 黄 + 暗黄 | RGB(204, 153, 0) 系 | 黄 (半透明) |
| 津波予報 | なし | RGB(30, 90, 160) 系 | 青 (半透明) |
| 解除/NONE | なし | surfaceCard | 表示しない |

具体的な色値は気象庁の津波警報配色ガイドラインおよびデザインシステムとの整合性を考慮して実装時に確定する。

## ファイル構成

```
app/lib/feature/tsunami/
  data/
    notifier/
      tsunami_details_notifier.dart
  ui/
    tsunami_details_page.dart
    components/
      tsunami_details_map_view.dart
      tsunami_warning_status_card.dart
      tsunami_warning_history_overlay.dart
      current_location_tsunami_card.dart
      tsunami_region_list.dart
      tsunami_earthquake_card.dart

app/lib/core/component/decoration/
  warning_stripe_decoration.dart       -- 汎用ストライプパターン
```

## エッジケース

- `earthquake == null`: 地震カードセクション非表示、マップに震源マーカーなし
- 位置情報未取得: 現在地カード非表示
- `isCanceled == true`: ストライプなし、「解除済み」表示、マップレイヤーなし（全予報区 kind=none）
- `forecastRegions` が空: 地域一覧セクション非表示
- `observation` が null: 予報区内の観測点展開は表示不可（展開ボタン自体を非表示）
- `isActive == false` かつ `isCanceled == false`: 有効期限切れ扱い（解除済みと同様のグレー表示）
- `maxHeight.qualitative == ENORMOUS`: "巨大" と表示（大津波警報時、具体的数値が不明な場合）
- `maxHeight.qualitative == HIGH`: "高い" と表示（津波警報時、具体的数値が不明な場合）

## テスト方針

- Widget テスト: 各コンポーネントに対してモックデータを注入しレンダリング確認
- 過去事例テスト: 2024/01/01 能登半島地震、2022/01/15 トンガ噴火津波のAPIレスポンスを fixtures として保存し、表示の網羅テスト
- マップレイヤーテスト: ユニットテストで予報区→色マッピングのロジックを検証
- 現在地判定テスト: `JmaMapUtility.findNearestItem` の結果に対する表示分岐のテスト

## 絵文字ルール

通知以外の要素において絵文字の使用を禁止する。アイコンは Material Icons を使用する。
