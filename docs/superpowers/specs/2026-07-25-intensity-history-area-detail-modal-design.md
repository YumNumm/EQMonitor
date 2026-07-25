# 震度履歴 地域詳細モーダル設計

## 背景

地域別最大震度マップのフローティングパネルで、都道府県フォーカス中にパネルをタップすると `UnimplementedError` が発生している。
また、市区町村詳細モーダルにも地震一覧の未実装表示が残っている。

## 目的

- 都道府県詳細モーダルを実装し、未実装例外をなくす。
- 市区町村詳細モーダルの未実装表示を実データ一覧に置き換える。
- 都道府県と市区町村のモーダル UI を過度に分けず、実装と見た目を必要十分に共通化する。
- 生命に関わる情報として、固定値やランダム値での代替表示は行わない。

## 方針

既存の `EarthquakeHistoryNotifier` を可能な限り再利用する。
地域詳細モーダル側では、都道府県と市区町村を `EarthquakeHistoryParameter.prefecture` / `EarthquakeHistoryParameter.city` に変換し、`earthquakeHistoryProvider(parameter)` の結果を表示する。

`EarthquakeHistoryDataSource` は通常の地震履歴ページ向けの paging UI と密結合しやすいため、モーダルでは直接利用しない。
初期表示と「さらに読み込む」操作は `EarthquakeHistoryNotifier.fetchNextData()` に寄せる。

## UI 設計

モーダルは `DraggableScrollableSheet` のまま維持する。
上部はドラッグハンドル、サマリ、一覧見出しの順に配置する。

サマリには以下を表示する。

- 地域名または親地域名
- 最高震度アイコン
- 最高震度を観測した地震件数
- 代表地震の発生時刻、震源名、マグニチュード

震源名がない場合は空文字を表示せず、「震源不明」など明示的な代替文言を出す。
ただし、地震データそのものを補完したように見える固定値は使わない。

一覧には既存の `EarthquakeHistoryListTile` を簡素な密度で使用する。
検索対象地域の震度チップが正しく出るよう、`searchParameter` にはモーダルで使っている地域パラメータを渡す。
各行をタップした場合は既存の地震詳細ルートへ遷移する。

## 共通化

公開関数は呼び出し側の読みやすさを優先して分ける。

- `showPrefectureDetailModal(...)`
- `showCityDetailModal(...)`

内部では共通の private Widget に集約する。
共通 Widget は以下を受け取る。

- 地域種別
- 地域コード
- 表示名
- 親地域名
- `HighestIntensityEntry?` サマリ
- `EarthquakeHistoryParameter`

都道府県専用・市区町村専用の分岐は、公開関数でのパラメータ組み立てとサマリ表示のラベル差分に限定する。

## データフロー

1. `RegionFloatingPanel` が現在の `IntensityHistoryState` と highest provider の結果からサマリを取得する。
2. 都道府県タップ時は `showPrefectureDetailModal` を呼ぶ。
3. 市区町村タップ時は既存の `showCityDetailModal` を呼ぶ。
4. モーダルは地域種別に応じた `EarthquakeHistoryParameter` を作る。
5. `earthquakeHistoryProvider(parameter)` を watch し、初期読み込み・エラー・空・一覧を描画する。
6. `nextToken` がある場合のみ「さらに読み込む」ボタンを表示し、押下で `fetchNextData()` を呼ぶ。

## エラー・空表示

- 初期読み込み中は `CircularProgressIndicator.adaptive` と短い文言を表示する。
- エラー時は既存の `ErrorCard` を使い、リロード操作で provider を invalidate する。
- 空の場合は「この地域で観測された地震はありません」と表示する。
- append 中の例外は `AsyncValue` の既存状態に合わせて、一覧を消さずにエラー表示または再試行導線を出す。

## テスト

Widget テストを追加・更新する。

- 都道府県フォーカス中に `RegionFloatingPanel` をタップしても例外が出ず、都道府県名のモーダルが表示される。
- 市区町村モーダルで未実装 placeholder が表示されない。
- `EarthquakeHistoryNotifier` の provider override を使い、地震一覧が表示される。
- サマリがない場合でも地域名が表示され、レイアウトが成立する。

既存の広範な Flutter analyze が重い場合は、編集ファイルに対する `mise exec -- flutter analyze --no-pub` と対象 Widget テストを優先する。

## スコープ外

- 地域詳細モーダル内のフィルタ UI。
- 都道府県内市区町村のランキング表示。
- API の新規追加。
- 地震一覧ページ本体の UX 変更。
