# 地震履歴詳細ページ 震度データベース表示統合 設計書

日付: 2026-07-07
ステータス: ユーザー承認済み(実装は backend 側の SHINDO_DB_STATIONS 更新待ち)

## 背景と目的

地震イベントは `datasources` により3種類ある。

| 構成 | 期間の目安 | 現状の表示 |
|---|---|---|
| XML のみ | 2020/11/18〜(リンク不成立含む) | 各地の震度カード(jma/lpgm/estimated) |
| XML + 震度DB | 2020/11/18〜(リンク成立) | 上記 + 「震度データベース詳細」カード(生ダンプ) |
| 震度DB のみ | 1919〜2020/11/17 | 各地の震度カード + 「震度データベース詳細」カード |

「震度データベース詳細」カード(`EarthquakeCatalogCard`)は ExpansionTile の生ダンプで分かりにくい。
これを削除し、震度データベースの情報をページ全体(震源情報カード・各地の震度カード・地図レイヤー)に
データソース切り替えとして統合する。

## 決定事項(ユーザー合意済み)

1. シート最上部(CachedDataBanner の上)にデータソース切り替え(防災情報XML ⇔ 震度データベース)を配置。
   両ソースを持つイベントのみ表示。デフォルトは XML。
2. 切り替えはページ全体に連動: 震源情報カード・各地の震度カード・地図レイヤー。
3. DB のみのイベントは切り替え非表示で DB 表示固定。「各地の震度」見出しのすぐ右に
   少し小さめの文字で「データベース」と表示。
4. DB ソース時の各地の震度カードは階級ごとのツリー表示。観測点タップで詳細シート
   (長周期地震動階級の観測点詳細と同じ操作感)。
5. 震源の標準誤差等は震源情報カードに統合。津波規模・被害規模は震源情報カードの直下に
   Card なしの行として表示。
6. 歴史的階級(9/L/S/M/R/F/X)は専用表現でフル表示(ツリー・地図とも)。
7. `EarthquakeCatalogCard` と旧 sections/rows 生成コードは削除。
8. 観測点→市区町村マッチングは Repository 層で行う。重ければ `compute()` で isolate 化。
9. DB ツリーは詳細 Notifier とは別の Notifier で、DB 表示に切り替えたときに遅延計算する。

## 前提: 観測点→市区町村マッピング(検証済み)

`.memo/20260707/shindo-db-city-mapping-調査.md` の検証結果:

- 「観測点コード上5桁 = JMA AreaInformationCity コード」仮説は誤り(独自番号体系、直接照合 2.2%)。
- ただし「上5桁 = 市町村単位のID」という構造は正しい(code_p.dat 仕様書にも明記、1:1 で矛盾ゼロ)。
- 正解ルートは `earthquake_stations.json` の `no_code`(= 震度DBコード)結合。最新 code_p.dat では
  未解決 2 グループのみ(名前前方一致で1つ解決、残りは特殊観測点 53999 神戸市等阪神淡路地域)。
- 現行ローカル asset は最新 code_p.dat より 587 観測点古い(鮮度問題)。

**backend 側対応(別セッションで実装中)**: SHINDO_DB_STATIONS 生成を最新 code_p.dat 全件に更新し、
観測点ごとに市区町村コード(AreaInformationCity 体系)を事前計算フィールドとして付与する。

**アプリ側はこの事前計算済み `city_code` を信頼して結合する。** アプリ内での no_code 突合や
名前フォールバックは実装しない(生成時に解決済みのため)。`city_code` が null の観測点
(53999 等)は「市区町村不明」として扱う。

## 設計

### 1. データモデル

新規/変更(すべて `app/lib/feature/earthquake_history/data/model/`、API 型は UI・状態に露出させない):

- **`EarthquakeCatalog`(作り直し)** — 現在の sections/rows 表示用モデルを廃止し、
  `api.Catalog` をミラーしたドメインモデルに置き換える。
  - `EarthquakeCatalog { hypocenters, stationRecords, damageScale, tsunamiScale, link }`
  - `EarthquakeCatalogHypocenter` — レコード種別・震源地名・発震時刻±標準誤差・座標・深さ±誤差・
    M(種別ごと複数)・決定フラグ・評価・補助情報・観測点数
  - `EarthquakeCatalogStationRecord` — 観測点コード・階級(`ShindoDbIntensityClass`)・計測震度・
    観測時刻・最大加速度(合成/NS/EW/UD)・最大加速度時刻・周期成分(NS/EW/UD の
    最大加速度周期/卓越周期)・観測回数
  - 付随 enum(被害規模・津波規模・照合方法等)もアプリ型に変換
- **`ShindoDbIntensityClass`(enum)** — 数値階級 1〜7、5弱(A)/5強(B)/6弱(C)/6強(D)、
  歴史的階級 震度不明(9)/局発(L)/小局発(S)/やや顕著(M)/顕著(R)/有感(F)/付近有感(X)。
  - 数値階級は `JmaIntensity?` への変換を持ち、色・アイコンを流用
  - 歴史的階級は日本語ラベル + グレー系表現(アイコンはグレー地にテキスト)
  - 表示順(orderIndex): 7 > 6強 > 6弱 > 6 > 5強 > 5弱 > 5 > 4 > 3 > 2 > 1 > 不明(9) >
    顕著(R) > やや顕著(M) > 小局発(S) > 局発(L) > 有感(F) > 付近有感(X)
- **`ShindoDbIntensityTree`** — `Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>>`。
  都道府県 > 市区町村 > 観測点の3層。観測点ノードは `EarthquakeCatalogStationRecord` +
  観測点名・緯度経度(shindoDbStations から解決)を持つ。
  市区町村不明の観測点は各階級の `unresolvedStations` に保持(データを失わない)。
- **`ShindoDbStationItem`(既存拡張)** — `cityCode`(nullable)を追加し JSON から読む。

### 2. Repository 層(マッチング + ツリー構築)

- `EarthquakeHistoryRepository.buildShindoDbIntensityTree({required EarthquakeCatalog catalog})`
  を追加。
  - `shindoDbStations` の `code → (name, location, cityCode)` を索引化
  - `earthquakeParameter` の `cityCode → (city, region, prefecture)` を索引化
  - stationRecords を階級 → 都道府県 → 市区町村に集約。cityCode 解決不可は unresolved へ
- まず同期実装で計測。大規模イベント(数千レコード)でジャンクする場合のみ `compute()` 化し、
  その際は `EarthquakeParameter` 丸ごとではなく事前構築した軽量索引のみを isolate に渡す。
- **既存バグ修正**: `intensity_tree_converter.dart` の `_cityIdentificationPrefixMap`
  (市区町村コード先頭5桁との誤った照合。偶然衝突で誤マッチする)を、
  `cityCode` フィールド直引きに置き換える。JMA/LPGM ツリーでの DB 観測点解決も同時に正される。

### 3. 状態管理

- ソース選択: 詳細ページの `useState<EarthquakeDataSource>`(ローカル状態、displayMode と同様)。
  既存 enum `EarthquakeDataSource` をそのまま使う。デフォルト `.jmaDisasterInformationXml`。
- **`shindoDbIntensityTreeProvider(eventId)`**(新規、1ファイル1公開Provider) —
  `earthquakeHistoryDetailsProvider(eventId)` を watch し、`earthquake.catalog` を Repository の
  変換に渡して `ShindoDbIntensityTree` を返す。DB 表示に切り替えて初めて watch されるため遅延計算。
- `EarthquakeHistoryDetailsNotifier` は変更なし(`Earthquake.catalog` が生ドメインモデルを保持)。

### 4. UI

- **ソース切り替え**: 既存 `CollapsibleSegmentedControl` を流用し、シート最上部に
  「防災情報XML / 震度データベース」。`dataSources` が XML と DB の両方を含み、かつ
  `catalog != null` のときのみ表示(DB のみ・XML のみのイベントでは非表示)。
- **震源情報カード**(`EarthquakeHypocenterInformationCard`): ソース連動。
  - XML 時: 現状のまま
  - DB 時: catalog 震源レコードの主レコード(seq 0)を表示 — 発震時刻±誤差、震源地名、
    深さ±誤差(フリー条件含む)、M(種別ごと)、決定フラグ・評価。複数レコードは折りたたみで追加表示。
    末尾に照合情報(照合信頼度)を小さく表示(XML+DB 結合イベントのみ)。
- **津波・被害規模**: DB ソース時のみ、震源情報カード直下に Card なしの行として表示。
- **各地の震度カード**(`EarthquakeIntensityCard`):
  - XML 時: 現状の3モード(各地の震度/長周期階級/推計震度)そのまま
  - DB 時: カード内トグル非表示。`ShindoDbIntensityContent` を表示 —
    階級セクション → 都道府県 → 市区町村 → 観測点チップ(Wrap)、LPGM 表示と同じ操作感
  - DB のみのイベント: 見出し「各地の震度」の右に小さめ文字で「データベース」
- **`ShindoDbStationDetailSheet`**(新規、観測点チップタップで表示):
  階級アイコン + 観測点名 + 計測震度、観測時刻、最大加速度表(合成/NS/EW/UD + 時刻)、
  周期成分表(NS/EW/UD の最大加速度周期・卓越周期)、観測回数、気象庁「震度データ」ページへのリンク。
  歴史的階級の場合は階級の説明文(例: 局発地震 = 最大有感距離100km未満)を併記。
- **削除**: `EarthquakeCatalogCard`、旧 `earthquake_catalog.dart` の sections/rows 生成コード。

### 5. 地図レイヤー

- ソース選択を地図ビューに渡し、DB ソース時は既存の displayMode 分岐(fill/station/estimated)を
  適用せず DB レイヤー群を表示する:
  - 塗り分け: 既存 `EarthquakeHistoryFillLayerBuilder` の仕組みを流用し、DB ツリー由来の
    「階級 → 市区町村コード群 / 細域コード群」を渡す(細域は市区町村→細域の集約)。
    数値階級のみ塗る。歴史的階級・市区町村不明は塗らない
  - 観測点: DB 観測点の座標で描画。数値階級は既存の震度色、歴史的階級はグレー。
    タップで既存ポップアップ(名称 + 階級ラベル)
  - 凡例: 数値階級 + 「不明(グレー)」
  - 震央レイヤーは現状のまま(DB のみイベントの hypocenter はサーバが catalog から構築済み)
- XML ソース時: 現状のまま(fill/station/estimated の displayMode 分岐も不変)

### 6. エッジケース

- `catalog == null` なのに datasources に DB を含む → XML 扱い(切り替え非表示)
- `intensity == null` の DB のみイベント → DB 表示固定で各地の震度カードは DB ツリーを表示
- 観測点コードが shindoDbStations に無い → 名称は観測点コードで代替、座標なしは地図から除外、
  ツリーでは市区町村不明へ
- 歴史的階級のみのイベント(1919〜1996 の一部) → 塗りなし・グレー観測点のみでも成立すること

### 7. テスト

- `ShindoDbIntensityClass`: API enum からの変換・orderIndex・ラベルのユニットテスト
- `buildShindoDbIntensityTree`: フィクスチャ(数値階級 + 歴史的階級 + 市区町村不明を含む)で
  集約結果を検証
- `EarthquakeCatalog` ドメインモデル変換のユニットテスト
- 既存 `intensity_tree_converter` の cityCode 直引き化に対する回帰テスト

### 8. スコープ外

- backend の SHINDO_DB_STATIONS 生成更新(別セッションで実装中。city_code フィールド追加 +
  最新 code_p.dat 反映)
- 震度 DB イベントの検索・一覧側の変更
- `_TelegramListButton` の DB のみイベントでの挙動

## 実装順序(参考)

1. モデル(`ShindoDbIntensityClass` / `EarthquakeCatalog` 作り直し / ツリーモデル /
   `ShindoDbStationItem.cityCode`)
2. Repository のツリー構築 + `_cityIdentificationPrefixMap` 置き換え + テスト
3. `shindoDbIntensityTreeProvider`
4. UI(ソース切り替え → 震源情報カード → 各地の震度カード + 詳細シート → 旧カード削除)
5. 地図レイヤー
6. 統合確認(XML のみ / XML+DB / DB のみ / 歴史的階級イベント)
