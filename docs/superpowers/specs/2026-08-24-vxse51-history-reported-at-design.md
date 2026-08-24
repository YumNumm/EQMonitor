# 震度速報の発表時刻を使う地震履歴一覧 設計

- 日付: 2026-08-24
- ステータス: 設計承認済み・仕様書レビュー待ち
- 対象: eqmonitor-backend、生成OpenAPIクライアント、EQMonitor Flutterアプリ

## 背景と目的

地震履歴一覧は `origin_time`、値がなければ `arrival_time` を表示時刻と日付グループの基準にしている。震源要素を持たない震度速報（VXSE51）は `origin_time` がなく、発表時刻と最大震度地域を一覧だけでは正しく表示できない。

Backendには最新電文の `reported_at` に相当する `earthquake.last_reported_at` と震度地域が保存されているが、`EarthquakePartial` には含まれない。本変更ではこれらを一覧APIへ追加し、次の表示と日時順を実現する。

- 1地域: `最大震度3を熊本県熊本で観測`
- 複数地域: `最大震度3を熊本県熊本などで観測`
- subtitle: `yyyy/MM/dd HH:mm頃受信`
- 日付見出しと日時順ソートも同じ発表時刻を使う

通常の震源情報を持つ地震の発生時刻・震源名・深さ表示は維持する。

## 採用方式

Backendが一覧表示に必要な発表時刻と震度地域を返し、一覧用基準時刻でソートする。Flutterも同じ基準時刻をタイル表示と日付グルーピングに使う。

クライアント側だけのページ単位ソートは全体順序を保証できず、タイルごとの詳細API取得はN+1リクエストを生むため採用しない。

## 一覧用基準時刻

`history_time` を次の順で導出する。

1. `origin_time`
2. `origin_time` がなくVXSE51を含む場合は `last_reported_at`
3. `arrival_time`
4. 残る `last_reported_at`
5. すべてなければ時刻不明

BackendのソートとFlutterの表示・グルーピングでこの規則を共有する。event IDのパースや固定時刻によるフォールバックは追加しない。

## Backend API契約

`EarthquakePartial` に次のoptionalフィールドを追加する。

- `last_reported_at`: 最後に反映された対象電文の `reported_at`
- `intensity.regions`: 地域コード、地域名、地域最大震度

最大震度地域は `intensity.max_intensity` と同じ震度の地域とする。代表地域は地域コード昇順の先頭とし、DBやAPIの未規定な配列順へ依存しない。値がない古いデータを推測値で補完しない。

日時ソートに `history_time` を追加し、EQMonitorの「発生時刻」ソートから利用する。時刻不明は昇降順にかかわらず末尾へ置き、同一時刻は `event_id` を第2キーとして同じ昇降順にする。

カーソルはsort key、sort order、カーソル行の `history_time` と `event_id` を保持する。次ページ条件を `(history_time, event_id)` の辞書順と一致させ、同一時刻やページ境界での重複・欠落を防ぐ。地域・都道府県・市区町村・観測点検索の日時順にも同じ規則を適用する。

Backend型、OpenAPI、API stub fixtureを同期し、EQMonitorのDart・Swiftクライアントを既存手順で再生成する。生成ファイルだけを手書きしない。

## Flutterモデルと表示

`EarthquakePartialNormal` に `lastReportedAt` と一覧用地域情報を保持し、API型はモデル変換境界でアプリ固有型へ変換する。基準時刻と代表地域の導出はWidget内のprivate methodへ置かず、テスト可能なモデルextensionまたは専用ロジックへ分離する。

震源名がなくVXSE51を含むタイルのタイトルは次のとおりとする。

- 最大震度地域1件: `最大震度{震度}を{地域名}で観測`
- 最大震度地域2件以上: `最大震度{震度}を{代表地域名}などで観測`
- 地域情報なし: `最大震度{震度}を観測`

地域数は最大震度と一致する地域だけを数える。`lastReportedAt` がある場合はローカル時刻の `yyyy/MM/dd HH:mm頃受信` をsubtitleに表示し、深さ文言を連結しない。通常地震は既存表示を維持する。

## グルーピングとリアルタイム更新

`EarthquakeHistoryDataSource.groupBy` は `history_time` をローカル時刻の `yyyy/MM/dd` へ変換し、時刻がない場合だけ `不明` とする。

REST結果とリアルタイムupsertは同じ日時順を使う。新規挿入は `history_time` とevent IDの複合比較で位置を決め、発表時刻が更新された既存項目も正しい位置へ再配置する。日時以外のソート中は、存在しないリアルタイム項目を無条件挿入しない。

## エラー処理

- 発表時刻がない震度速報は時刻を推測せず、既存の調査中表示へ戻す。
- 最大震度地域がなければ `最大震度{震度}を観測` と表示する。
- API例外はタイルへ展開せず、既存の一覧エラー・再試行表示を使う。

## テスト方針

Backendでは一覧変換、`history_time` の優先順位、日付をまたぐVXSE51、同一時刻、昇降順、null末尾、複合カーソルの重複・欠落、OpenAPIとstub fixtureを検証する。

Flutterでは基準時刻、通常地震の互換性、発表日グループ、最大震度地域1件・複数件・欠損、低い震度地域を除く「など」判定、subtitle、リアルタイム再配置を検証する。時刻・地域選択・並び替えは単体テスト、最終表示は既存Widget Testの拡張で保護する。

## 対象外

- 地震履歴詳細画面の時刻表記変更
- VXSE51以外のタイルデザイン刷新
- 最大震度地域の複数列挙
- event IDの採番規則変更
- 履歴フィルターの新設
