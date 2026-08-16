# 地震履歴の震度区別・ソートページング設計

## 目的

地震履歴で地域を指定したとき、対象地域の観測震度と地震全体の最大震度を明確に区別する。
同時に、ソートと絞り込みを併用した一覧で、ページ境界をまたいでも順序・件数が壊れないようにする。

## 対象

- EQMonitor Flutter アプリの地震履歴一覧、モデル、APIクライアント
- eqmonitor-backend の地震一覧APIと地域別検索API
- 都道府県、震度細分区域、市区町村、観測点の4種類の地域検索

DBスキーマと地震詳細APIは変更しない。

## API契約

地域別検索項目の外側にある `intensity` を `observed_intensity` へ即時リネームする。
これは検索対象の都道府県・地域・市区町村・観測点で観測された震度を表す。
地震全体の最大震度は従来どおり `earthquake.intensity.max_intensity` とする。

旧 `intensity` は併記せず、OpenAPI、APIスタブ、契約fixture、生成Dartクライアントを同時に更新する。
FlutterのDomain型は粒度別の `prefectureIntensity`、`regionIntensity`、`cityIntensity`、
`stationIntensity` を維持する。市区町村レスポンスは `EarthquakePartialCity` へ変換する。

## ソートと絞り込み

通常一覧と4種類の地域検索で、同じソート規則を使用する。
対応キーは `event_id`、`magnitude`、`max_intensity`、`max_lpgm_intensity`、`depth`、
`origin_time` とする。地域検索でも `sortBy` を無視しない。

指定キーを第1キー、`event_id` を一意な第2キーとして、両方を同じ昇順または降順で並べる。
nullableな第1キーは昇順・降順とも `NULLS LAST` とする。
地域検索の震度範囲は対象地域の観測震度へ適用し、ソートキーの最大震度は地震全体の値を使う。

## Cursor契約

`next_token` は現在ページで返さなかった `limit + 1` 件目、つまり次ページ先頭の位置を指す。
次回取得ではその位置を含めるinclusiveなkeyset条件を使う。

Cursorに含めるのはページ位置を再現する最小キーだけとする。

- `event_id` ソート: `event_id`
- その他のソート: ソート値と `event_id`
- ソート値がNULLの場合: NULLを表す値と `event_id`

Cursorには `limit`、フィルター、`sortBy`、`sortOrder` を含めない。
Cursorの値はリクエストの `sortBy` と `sortOrder` に従って解釈する。
Flutterは追加取得でも初回と同じソート・絞り込み条件を送り、返却Cursorだけを追加する。
`limit` はCursor外とし、ページ間で変更可能とする。

不正な形式や、指定ソートキーに必要な位置情報を持たないCursorは400とする。
検索条件を変更した場合、Flutterは新しいDataSourceを作り、Cursorなしで先頭から取得する。

## Flutter表示

地域指定中の一覧行では、日時・深さの下に次の2項目を明記する。

- `最大震度 7`
- `東京都23区 観測震度 5弱`

左端の大きな震度アイコンは地震全体の最大震度を表し、Semanticsにも「最大震度」を設定する。
対象地域側には解決済み地域名と「観測震度」を必ず表示する。
地域指定がない一覧の表示密度は変更しない。

2項目は固定高さを持たない `Wrap` 相当のレイアウトとし、文字拡大時は折り返す。
Light/Darkテーマの既存震度色と前景色解決を再利用する。

## テスト

バックエンドでは、全ソートキーの昇順・降順、同値、NULL、絞り込み併用を検証する。
複数ページを連結した結果に重複、欠落、順序逆転がないことを確認する。
4種類の地域検索について、対象地域震度フィルターと地震全体のソートが両立することを確認する。

Cursorは次ページ先頭を指し、必要なソート値とID以外を含まないことを契約テストする。
FlutterではRefreshとAppendのRepository呼び出しを比較し、Cursor以外の検索条件が等しいことを検証する。
`observed_intensity` の変換、市区町村型、2種類の震度ラベル、文字拡大時のoverflow防止をWidgetテストする。

## 作業分離

Flutter側は現在のEQMonitor Worktreeで作業する。
バックエンド側は `origin/main` を起点に独立したgit Worktreeとブランチを作成する。
両方でテストを先に失敗させ、最小実装で通した後にOpenAPIと生成物を同期する。
