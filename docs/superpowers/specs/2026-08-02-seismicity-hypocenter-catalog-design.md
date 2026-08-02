# 全震源カタログを使う地震活動表示 設計

- 日付: 2026-08-02
- ステータス: 設計承認済み・仕様書レビュー待ち
- 対象: EQMonitor Flutterアプリ、Backend submodule、生成OpenAPIクライアント

## 背景

現在の公開版「地震活動」は、`GET /v2/seismicity/manifest` が指す直近1・3・12か月のGeoJSONを取得し、有感地震を震央分布図と分析チャートへ表示している。

Backend `main` には、気象庁の全震源カタログ取り込み、PMTiles生成、次のAPIが追加済みである。

- `GET /v2/hypocenters/manifest`: MapLibre向けPMTilesアーカイブ一覧
- `GET /v2/hypocenters`: 期間・Polygon・マグニチュード・深さ等による個別震源検索

調査の結果、manifest全体のrevisionと検索対象partitionのrevisionは意味と生成方法が異なり、現行契約だけではPMTilesと分析結果のsnapshot一致を検証できない。本設計では既存2エンドポイントへ最小限のrevision契約を追加する。

親リポジトリは調査時点でBackend commit `b2a2780992610390761694528898dfde44f5c133` を参照しており、震源カタログを含む `origin/main` の `fb16a19d8f6a7b49c448829a86d10f47a7547c83` より古い。実装ではBackend submoduleをこの機能を含む `main` commitへ更新し、OpenAPIクライアントを再生成する。

## 目的

公開版「地震活動」に次の2モードを設ける。

1. `全震源`: 新しい震源カタログのPMTilesを地図表示し、矩形分析はAPIの全件結果で計算する。
2. `有感地震`: 現行のGeoJSON表示と1・3・12か月選択を維持する。

画面を開いたときは `全震源` を既定とし、manifestに存在する最新の `DAY` アーカイブ1件を選択する。選択状態は永続化せず、画面を開き直すたびに初期状態へ戻す。

## 採用方式

PMTilesとAPIを役割分担するハイブリッド方式を採用する。

```text
[有感地震]
/v2/seismicity/manifest -> GeoJSON -> SeismicityEvent -> 地図・分析

[全震源: 地図]
/v2/hypocenters/manifest -> 選択PMTiles -> MapLibre

[全震源: 矩形分析]
選択アーカイブのperiod + 選択Polygon
  -> /v2/hypocentersを全ページ取得
  -> SeismicityEvent
  -> M-T図・積算/日別ヒストグラム・深さ断面図
```

APIのみでは複数年の全震源を地図用に取得する負荷が大きい。PMTilesのみでは低zoomのclusterとロード済みタイルしか参照できず、矩形内の正確な分析結果を作れない。ハイブリッド方式は地図描画の効率と分析の完全性を両立する。

## Backend方針

### 既存APIで満たす機能

新しいエンドポイントや集計APIは追加しない。既存APIは次の要件を満たしている。

- manifestは `YEAR` / `DAY`、期間、URL、件数、サイズ、dataset revisionを返す。
- 検索APIは最大366日の期間、Polygon、1ページ最大1,000件、cursor paginationに対応する。
- `YEAR` 1件または `DAY` 1件を1検索単位にすれば、期間上限内で取得できる。
- cursor中にdataset revisionを保持し、途中更新を409で通知する。

### 必要なrevision契約の拡張

PMTilesと検索結果のsnapshotを厳密に一致させるため、既存2エンドポイントを次のように拡張する。

- manifestの各archiveに `query_revision` を追加する。
- `query_revision` は、そのarchiveのperiodと交差するpartition stateを検索APIと同じ `computeHypocenterRevision` で計算する。
- PMTiles metadataにも同じ `query_revision` を格納する。
- `/v2/hypocenters` にoptional query parameter `expected_revision` を追加する。
- 検索対象partitionから計算したrevisionが `expected_revision` と一致しない場合、最初のページでも `409 DATASET_REVISION_CHANGED` を返す。
- 2ページ目以降は既存cursor内のrevision検証も継続する。
- manifestレスポンス全体の `meta.dataset_revision` は、従来どおり公開manifest全体のrevisionとして扱い、archiveの `query_revision` と直接比較しない。

Backendのraw manifest、公開レスポンス、OpenAPI、stub fixture、PMTiles metadata、validator、route/repository testを同じ契約へ更新する。

### 運用確認

アプリ公開前に次を確認する。

- Backend submoduleを震源カタログ実装済みcommitへ更新する。
- DB migrationと震源カタログ同期Workflowが本番適用済みである。
- `/v2/hypocenters` と `/v2/hypocenters/manifest` が本番で有効である。
- APIに `HYPOCENTER_S3_BUCKET` と `HYPOCENTER_PUBLIC_BASE_URL` が設定済みである。
- PMTiles配信先がHTTPS、CORS、HTTP Range Requestに対応する。
- revision付きPMTilesを先に公開し、manifestを最後に切り替える既存publication契約が保たれている。

## Flutterアーキテクチャ

### データモード

`SeismicityDataMode` を追加する。

- `allHypocenters`
- `feltEarthquakes`

可視化・分析UIは既存 `SeismicityEvent` を共通入力として再利用する。全震源APIからの変換では次を対応付ける。

- `hypocenter_id` -> `eventId`
- `origin_time` -> `originTime`
- `magnitude` -> `magnitude`
- `depth_km` -> `depth`
- `latitude` / `longitude` -> 同名座標
- `max_intensity` -> `maxIntensity`

### モデル

アプリ固有の震源アーカイブモデルを `feature/seismicity/data/model/` に追加する。APIパッケージの生成型はrepository境界で変換し、UIへ露出しない。

アーカイブモデルは少なくとも次を保持する。

- partition: `year` または `day`
- period: `from` / `to`
- PMTiles URL
- feature count
- size bytes
- manifest全体のdataset revision
- archive固有のquery revision
- UI表示用の年または日付はperiodから導出する

UI選択の論理IDはpartitionとperiod開始時刻をJSTへ変換した年・日ラベルから決定する。同じ論理archiveのURL、period終了、revisionが更新されても選択を対応付け直せるようにし、URLを選択IDへ含めない。固定の年・日一覧や固定URLは持たない。

### Repository / Data source

責務を次の単位に分ける。

- 既存 `SeismicityRepository`: 有感地震のmanifest、GeoJSON、ローカルキャッシュを担当する。
- `HypocenterManifestRepository`: 生成APIクライアントでmanifestを取得し、アプリモデルへ変換する。
- `HypocenterArchiveProbe`: PMTiles URLへ軽量なRange Requestを送り、206応答、Content-Range、PMTiles headerを検証する。
- `HypocenterAnalysisRepository`: アーカイブ期間、query revision、Polygonから検索条件を作り、全ページを取得して `SeismicityEvent` へ変換する。
- `HypocenterAnalysisLoader`: 複数アーカイブの取得順序、最大2並列、キャンセル、revision整合性を制御する。

現在のMapLibre Flutterラッパーは個別sourceのロード失敗を通知しない。このためPMTiles source追加前のRange検証を必須とし、検証成功したアーカイブだけを地図へ追加する。通常の全ファイルGETやRange未対応時の全ファイルダウンロードは行わない。

### 状態管理

Riverpod notifierで次を保持する。

- manifestの非同期状態
- 現在のデータモード
- 選択アーカイブ集合
- PMTiles検証結果
- 選択矩形
- 分析取得状態と進捗

選択状態は画面ライフサイクル内だけで保持し、Preferencesへ保存しない。新しい矩形、期間、モードが選択されたら進行中の旧分析をキャンセルし、完了しても旧結果を反映しない。

新しいロジックはWidget内のprivate methodへ置かず、単一責務のクラスへ分離してRiverpodでDIする。`ref` と `context` はActionまたはflow以外へ渡さない。

## UI設計

### モード切り替え

画面上部に `全震源` / `有感地震` の切り替えを置く。画面生成時は `全震源` を選択する。

モード切り替え中は各モードの選択状態をメモリ内で保持する。有感地震から全震源へ戻った場合は、同じ画面ライフサイクル中に選んだアーカイブへ戻る。

### 全震源の期間選択

現行の1・3・12か月selectorの代わりに、アーカイブ選択Bottom Sheetを表示する。

- `YEAR` を「年」、`DAY` を「日付」の2セクションに分ける。
- manifestに存在する項目だけを表示する。
- 年・日とも複数選択できる。
- Bottom Sheet内では一時的に全解除できるが、0件では確定できない。
- 初期選択は最新の `DAY` 1件とする。
- `DAY` が存在しない場合は自動で年へフォールバックせず、日付データがないことを表示して年の選択を促す。
- 選択済み項目は画面上で年・日別の件数と短い要約を表示する。

Backendのarchive plannerは年アーカイブと直近3日の日アーカイブを重複させない。Flutterはこの契約に従い、表示名やファイル名から期間を再構築せず、manifestのperiodを唯一の期間情報として使う。

### 有感地震の期間選択

現行の1・3・12か月selector、GeoJSON取得、キャッシュ表示を維持する。

### 地図レイヤー

選択アーカイブごとに独立したMapLibre `VectorSource` を作り、URLを `pmtiles://https://...` 形式へ正規化する。source/layer IDはアーカイブの不変な識別値から生成する。

- zoom 0〜6: source layer `clusters`
- zoom 7〜14: source layer `hypocenters`
- cluster: `count` と `max_magnitude` に応じたサイズ・色
- 個別震源: `magnitude` に応じたサイズ
- 経過時間モード: `origin_time_unix_ms` と描画時刻から色を決定
- マグニチュードモード: `magnitude` から色を決定

選択変更時はMapLibre layer lifecycleを守り、変更されたsource/layerだけを追加・削除する。source URL変更時は対応するsource/layerを安全に再作成する。

## 矩形分析

全震源モードでは、選択アーカイブごとに次の検索を行う。

1. manifestのperiodを `origin_time_gte` / `origin_time_lte` に設定する。
2. 矩形4隅をBackend契約に従うPolygon文字列へ変換する。
3. archiveの `query_revision` を `expected_revision` に、`limit=1000` をlimitに設定して最初のページを取得する。
4. レスポンスの `meta.dataset_revision` がarchiveの `query_revision` と一致することを検証する。
5. `next_token` があれば次リクエストの `cursor` として渡し、なくなるまで同一アーカイブのページを直列取得する。
6. アーカイブ間は最大2件まで並列取得する。
7. 全アーカイブが成功した場合だけ、結合した `SeismicityEvent` を分析UIへ渡す。

アーカイブ期間は重複しないため通常の重複排除は行わない。分析UIは既存のM-T図、回数積算図、日別ヒストグラム、緯度・経度方向の深さ断面図を再利用する。

取得中は対象アーカイブ数、完了アーカイブ数、取得済み件数を表示する。新しい分析条件が指定されたら旧処理をキャンセルする。

## エラー処理と整合性

### Manifest

- HTTPキャッシュに前回レスポンスがあれば、鮮度警告付きで使用する。
- キャッシュもなければ専用エラー表示と再試行操作を出す。
- 空manifestまたは最新DAYなしを固定データで補完しない。

### PMTiles

- Range検証に成功したアーカイブだけ地図へ追加する。
- 一部失敗時は正常なアーカイブを表示しつつ、失敗期間を明示した警告を常時表示する。
- 失敗アーカイブを無言で除外しない。

### 分析API

- いずれかのアーカイブまたはページが失敗したら、途中結果をグラフへ渡さない。
- エラー種別、対象期間、再試行操作を表示し、地図は維持する。
- `409 DATASET_REVISION_CHANGED` では途中結果を破棄し、manifestを更新する。partitionとJST年・日ラベルで選択archiveを新manifestへ対応付け直して、検索全体を1回だけ再実行する。
- 2回目のrevision変更では自動再試行を止め、ユーザー操作による再試行へ切り替える。
- archiveの `query_revision`、検索の `expected_revision`、各検索レスポンスの `meta.dataset_revision` を比較する。不一致時はPMTilesと分析結果を混在させず、manifest更新後に分析をやり直す。
- APIの400、503、通信失敗をそのまま長文表示せず、画面に合う短いメッセージへ変換する。

### ログ

`talker` でrevision、partition、期間、HTTP状態、キャンセル理由を記録する。認証情報や不要なクエリ全文をログへ残さない。`print()` は使わない。

## テスト方針

### Unit test

- API manifestからアプリモデルへの変換
- YEAR/DAY分類、順序、最新DAY初期選択、DAYなし
- 複数年・複数日の選択状態
- PMTiles URL正規化とRange検証
- manifest全体revisionとarchive query revisionの区別
- source/layer ID、zoom境界、cluster/point描画式
- periodと矩形からのAPI検索条件生成
- `expected_revision`、1,000件pagination、`next_token` から `cursor` への引き継ぎ
- 複数アーカイブ最大2並列
- キャンセル、途中失敗、409再実行、revision不一致
- API震源から `SeismicityEvent` への変換

### UI静的検証

新規Widgetテストは作成しない。状態遷移はnotifierのUnit testで検証し、UIは `dart analyze` とコードレビューで次を確認する。

- 既定が全震源かつ最新DAY 1件であること
- モード切り替えと画面内状態復元
- Bottom Sheetの年・日複数選択と0件確定防止
- 空manifest、DAYなし、PMTiles部分失敗の表示
- 分析のloading、進捗、error、retry
- 有感地震の1・3・12か月表示
- textScale拡大を妨げる固定高さをテキスト要素へ追加していないこと

### 契約・統合確認

- Backend OpenAPIから `eqmonitor_api` を再生成し、生成差分を確認する。
- Flutterの生成クライアントがmanifestの `query_revision`、検索の `expected_revision`、cursor、409、503の型を保持することを確認する。
- 本番相当PMTiles URLへRange Requestし、206、Content-Range、CORSを確認する。
- Flutter / Dartコマンドはすべて `mise exec --` 経由で実行する。

## スコープ外

- 新しいBackendエンドポイントや集計APIの追加
- PMTilesの端末永続ダウンロード
- 選択モード・アーカイブのPreferences保存
- 全震源の高度な統計解析、b値、ETAS、活発化領域の自動検出
- 有感地震GeoJSON経路の廃止

## 受け入れ条件

- 地震活動画面を開くと全震源モードで最新DAYが表示される。
- manifestに存在する年・日をそれぞれ複数選択し、PMTilesを重ねて表示できる。
- 有感地震へ切り替えると現行の1・3・12か月表示を使用できる。
- 全震源の矩形分析がPMTilesのロード状況に依存せず、APIの全ページ結果から生成される。
- 部分的なPMTiles表示と不完全な分析結果を、完全な結果として表示しない。
- 既存Backend APIのrevision契約拡張だけで動作し、生成OpenAPIクライアントを経由してアクセスする。
