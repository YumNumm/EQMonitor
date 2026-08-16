# 地震履歴一覧の表示設定 設計

## 目的

地震履歴設定の「最大震度ごとの背景塗りつぶし」を一覧表示へ正しく反映する。
また、日付区切りを発生時刻ソート時だけ表示するか、常に非表示にするかを利用者が選べるようにする。

## 現状と原因

- `EarthquakeHistoryListConfig.isFillBackground` は設定画面から保存できる。
- `EarthquakeHistoryListTile` も `showBackgroundColor` で塗りつぶしを制御できる。
- しかし地震履歴一覧は設定 Provider を購読せず、`showBackgroundColor` を渡していないため、既定値 `true` が常に使われている。
- 日付区切りは現在、ソート種別にかかわらず sticky header として常に表示される。

## 設定モデル

`EarthquakeHistoryListConfig` に `showDateSeparator` を追加する。既定値は `true` とする。

- `true`: `EarthquakeSortBy.eventId`（画面上の「発生時刻」）でソートしている時だけ日付区切りを表示する。昇順・降順の両方を対象とする。
- `false`: ソート種別にかかわらず日付区切りを表示しない。

保存済み JSON にキーがない場合は Freezed の既定値によって `true` に復元し、既存利用者の表示を維持する。

## UI とデータフロー

地震履歴設定画面には「発生時刻ソート時の日付区切り」のスイッチを追加する。スイッチ変更時は既存の `EarthquakeHistoryConfigNotifier.save` を通じて設定全体を保存する。

地震履歴一覧は `earthquakeHistoryConfigProvider` から一覧設定だけを購読する。

- `isFillBackground` を `EarthquakeHistoryListTile.showBackgroundColor` へ渡す。
- 日付区切りの表示可否は、一覧設定と現在の `EarthquakeHistoryParameter.sortBy` から純粋関数で決定する。
- 非表示時は `headerBuilder` が `SizedBox.shrink()` を返し、`stickyHeader` も無効にする。

日付によるデータのグループ化は維持する。ページングデータソースやAPIリクエストには変更を加えない。

## エラー処理

設定の読み込み・保存エラー処理は既存の Provider に委ねる。新しい固定値フォールバックや例外の握り潰しは追加しない。

## テスト

- `EarthquakeHistoryListConfig` の既定値が `showDateSeparator == true` であること。
- 新しいキーがない既存 JSON から `true` へ復元できること。
- `showDateSeparator` の `false` を JSON ラウンドトリップできること。
- 発生時刻ソートの昇順・降順では、設定が有効なら日付区切りを表示すること。
- 発生時刻以外のソートと、設定が無効な場合は日付区切りを表示しないこと。
- 地震履歴一覧が `isFillBackground` を各 ListTile に渡すこと。
- 設定画面のスイッチ操作で `showDateSeparator` が保存されること。

## 対象外

- 日付区切りを常に表示するモード。
- EEW履歴など、地震履歴以外の一覧の日付区切り設定。
- ページングパッケージやAPIの変更。
