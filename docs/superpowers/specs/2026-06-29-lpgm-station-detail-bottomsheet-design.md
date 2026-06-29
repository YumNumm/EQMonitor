# LPGM観測点詳細BottomSheet

## 概要

地震詳細画面の長周期地震動階級ツリーにおいて、各観測点をタップすると BottomSheet で周期帯別の詳細情報を表示する。

GitHub Issue: #1349

## 背景

現在の LPGM ツリー表示では、市区町村の下に観測点名がカンマ区切りテキストで表示されるのみ。
データモデル上は各観測点に `sva`（最大絶対速度応答スペクトル）と `prePeriods`（band 1〜7 の周期帯別データ）が存在するが、UI では未使用。

## 変更箇所

### 1. 観測点リストのUI変更

**対象:** `_LpgmCityTile`（`region_intensity.dart`）

現在のカンマ区切り `Text` を、各観測点ごとの個別タップ可能ウィジェットに変更する。

- `Wrap` で横並び＋折り返し配置
- 各観測点は `ClipRRect`（角丸）→ `InkWell`（リップルエフェクト）でラップ
- チップ内に観測点名 + 小さい LPGM 階級アイコンを表示
- タップで `showModalBottomSheet` を呼び出す

### 2. BottomSheet の構成

新規ウィジェット: `LpgmStationDetailSheet`

#### ヘッダー

- 観測点名（`station.name.ja`）
- 最大 LPGM 階級アイコン（既存 `JmaLpgmIntensityIcon`）
- 最大 SVA 値（`XX.X cm/s` 形式）

#### 周期帯別テーブル

`Table` ウィジェットで 3行 × 8列（ヘッダー列 + band 1〜7）:

| | 1秒台 | 2秒台 | 3秒台 | 4秒台 | 5秒台 | 6秒台 | 7秒台 |
|---|---|---|---|---|---|---|---|
| **階級** | 3 | 2 | 1 | 0 | 0 | 0 | 0 |
| **SVA** | 26.7 | 29.4 | 10.1 | 6.4 | 3.5 | 2.9 | 2.0 |

- ヘッダー行（周期）: グレー背景
- 階級行: 各セルの背景色を `IntensityColorModel.fromJmaLpgmIntensity` で着色
- SVA行: 色なし、小さめフォントで数値のみ（単位 cm/s は行ラベルに含める）

#### 関連リンク Card

`Card` ウィジェットで気象庁の関連ページへのリンクを掲載する。

- ヘッダーに「気象庁ホームページ」と明記
- リンク一覧:
  - 「長周期地震動階級および長周期地震動階級関連解説表について」
    - https://www.jma.go.jp/jma/kishou/know/jishin/ltpgm_explain/about_level.html
  - 「固有周期と建物の関係について」
    - https://www.jma.go.jp/jma/kishou/know/jishin/ltpgm_explain/about_period.html

リンクは `url_launcher` パッケージで外部ブラウザを開く。

## データフロー

既存のデータモデルで必要な情報はすべて揃っている。新規 API 呼び出しは不要。

```
StationLpgmIntensityNode
  ├── station: EarthquakeParameterStationItem (name, code)
  └── intensity: IntensityStation
        ├── sva: double? (最大SVA)
        ├── maxLpgmIntensity: JmaLpgmIntensity?
        └── prePeriods: List<PrePeriod>?
              ├── band: double (1〜7)
              ├── lpgmIntensity: JmaLpgmIntensity
              └── sva: double
```

## ファイル構成

- `region_intensity.dart` — `_LpgmCityTile` の観測点表示を修正
- `lpgm_station_detail_sheet.dart` — 新規ファイル。BottomSheet のウィジェット

## スコープ外

- JMA 震度ツリー側の観測点詳細表示（今回は LPGM のみ）
- 地図上の観測点タップからの詳細表示
- prePeriods が null の場合は BottomSheet を開かない（タップ不可にする）
