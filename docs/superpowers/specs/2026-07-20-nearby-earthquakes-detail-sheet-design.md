# 地震履歴詳細シート 近傍地震一覧 設計

作成日: 2026-07-20

## 目的

地震履歴詳細シートに、表示中の地震と震源位置・深さが近い地震を一覧表示する。利用者は過去の周辺地震を詳細シートから確認でき、必要に応じて探索範囲や並び順を変更し、既存の地震履歴一覧で全件を閲覧できる。

## 調査結果と採用方針

過去に次の2方式が実装されていた。

1. `GET /v2/earthquake/{eventId}/similar` の独自スコアを A〜E の類似度として表示する方式
2. 既存の `GET /v2/earthquake` に緯度・経度・深さの範囲を指定し、近傍地震を表示する方式

専用 `similar` エンドポイントは現行 API クライアントに存在しない。一方、現行の `EarthquakeHistoryRepository.fetchEarthquakeList` は緯度・経度・深さ・並び順をすべて受け取れる。このため、追加のバックエンド変更が不要で、既存検索条件と結果の意味が一致する2を採用する。

## 表示仕様

- 詳細シートの電文一覧ボタンより前に「この震源の近傍で発生した地震」カードを表示する。
- 初期探索範囲は震源座標から緯度 `±0.5°`、経度 `±0.5°`、震源の深さ `±50km` とする。
- 震源座標が不明な場合はカードを表示しない。
- 深さが「不明」の場合は深さ条件を付けず、探索パラメータシートにも深さ設定を表示しない。
- 「ごく浅い」は `0km`、「700km以上」は `700km` を検索中心として扱う。これは過去実装と既存 API の深さ範囲表現に合わせる。
- 表示中の地震自身は `eventId` で結果から除外する。
- カード内には最大5件を表示する。
- 初期並び順は「最大震度・降順」とする。
- 並び替え項目は「発生時刻」「マグニチュード」「最大震度」「震源の深さ」。選択中の項目を再度押すと昇順・降順を切り替える。
- 地震行は既存の `EarthquakeHistoryListTile` を再利用し、タップすると対象地震の詳細へ遷移する。
- 「すべて表示」を押すと、現在の探索範囲と並び順を `EarthquakeHistoryParameter.all` に渡して既存の地震履歴一覧へ遷移する。
- 設定ボタンから既存の探索パラメータシートを開き、緯度・経度・深さの範囲を変更できる。

## 状態別表示

- 読み込み中: カード内に小さい `CircularProgressIndicator.adaptive` を表示する。
- 取得失敗: 詳細画面全体は維持し、カード内に短いエラー文と再試行ボタンを表示する。例外文字列は直接表示しない。
- 0件: カード内に「該当する地震がありません」と表示する。
- 1件以上: 最大5件と「すべて表示」を表示する。

## アーキテクチャ

### Data / Provider

`NearbyEarthquakeQuery` を追加し、検索の入力を1つの不変オブジェクトにまとめる。

- 除外対象 `eventId`
- 中心の緯度・経度
- 中心の深さ（不明時は `null`）
- `NearbyEarthquakeParameter`
- `EarthquakeSortBy`
- `SortOrder`

`nearbyEarthquakesProvider(query)` は `EarthquakeHistoryRepository.fetchEarthquakeList` を呼び、探索範囲を API 条件へ変換する。カードで5件を確実に得られるよう API には6件を要求し、自身を除外した後に先頭5件を返す。これにより、自身が取得結果に含まれた場合でも表示枠が4件に減ることを避ける。

緯度は `[-90, 90]`、経度は `[-180, 180]`、深さ下限は `0` に丸め、API の入力範囲を超えないようにする。深さ上限は現行 API 契約の最大値 `2000` に丸める。

### UI

`NearbyEarthquakeCard` を `HookConsumerWidget` として追加する。並び順と探索パラメータのみを hooks で保持し、検索条件の組み立てや取得処理は Provider に委譲する。

カード内部は責務別の private Widget に分割する。

- ヘッダーと設定ボタン
- 現在の探索範囲の要約
- 並び替え行
- 非同期状態表示
- `ListView.separated` による最大5件の一覧

既存の `NearbyEarthquakeParameterSheet` は今回触れる範囲で `StatefulWidget` から `HookWidget` へ変更し、既存挙動を維持しながら現行規約へ合わせる。

### 遷移

- 各行: `EarthquakeHistoryDetailsRoute(eventId: ...).push(context)`
- 全件: `EarthquakeHistoryRoute($extra: EarthquakeHistoryParameter.all(...)).push(context)`

新しいルートは追加しない。

## データフロー

1. 詳細 API から取得した `Earthquake` の震源座標と深さをカードへ渡す。
2. カードが画面内の探索パラメータと並び順から `NearbyEarthquakeQuery` を生成する。
3. Provider が query を緯度・経度・深さの上下限へ変換する。
4. Repository が既存の地震一覧 API を呼び出す。
5. Provider が表示中の `eventId` を除外し、最大5件を返す。
6. カードが既存の地震履歴タイルとして表示する。

## テスト方針

- Provider テスト
  - 初期値から緯度・経度 `±0.5°`、深さ `±50km` が Repository に渡る。
  - 緯度・経度・深さが API 入力範囲に丸められる。
  - 深さ不明時は深さ条件を渡さない。
  - 表示中の `eventId` を除外する。
  - 自身を除外した後も最大5件を返す。
- Widget テスト
  - 座標不明時はカードを表示しない。
  - loading、error、empty、data の各状態を表示できる。
  - data 状態は最大5件を表示する。
  - 並び替え操作と再試行操作が Provider の条件に反映される。
  - 一覧行タップと「すべて表示」の遷移条件を確認する。
  - 探索パラメータシートが初期値を表示し、変更値を返す。

## 影響範囲

- `app/lib/feature/earthquake_history/data/model/`
- `app/lib/feature/earthquake_history/data/provider/`
- `app/lib/feature/earthquake_history/ui/components/`
- `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`
- 対応する `app/test/feature/earthquake_history/` 配下のテスト
- Riverpod / Freezed の生成物

バックエンド、API スキーマ、新規ルート、Preferences は変更しない。
