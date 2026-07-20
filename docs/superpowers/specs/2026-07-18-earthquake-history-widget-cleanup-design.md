# Earthquake History Widget Cleanup Design

## Goal

iOS ホーム画面の地震履歴 Widget から地図 Widget を廃止し、通常の地震履歴 Widget のヘッダーを整理する。見た目の基準は EEW Live Activity の情報優先レイアウトだが、行構造の作り替えは行わず最小変更とする。

## Decisions

- アプローチ: 最小変更（行レイアウトは現状維持）
- ヘッダー: ストライプなし。タイトル＋更新時刻の帯をブランド色（`Color.eqBrand`）にする
- 更新ボタン: 全サイズから削除。`RefreshWidgetIntent` も削除する
- 左上アイコン: small / medium / large すべて削除
- マグニチュード: medium/large は約 15→12、small は約 12→10 に縮小
- small 震度バッジ: 約 32→26 に縮小し、「6強」等の見切れを防ぐ
- 対象: iOS Widget のみ（Android は対象外）

## Scope

### Do

- `MapEarthquakeWidget` / `MapEarthquakeWidgetView`（`MapSnapshotView` 含む）を削除
- `WidgetBundle` から地図 Widget 登録を外す
- Xcode プロジェクト参照があれば合わせて外す
- `EarthquakeWidgetView` のヘッダー刷新（ブランド色帯・アイコンなし・更新ボタンなし・区切り線なし）
- M フォントと small 震度バッジサイズの調整
- 呼び出し元がなくなる `RefreshWidgetIntent` を削除
- Preview を新ヘッダーが見える状態に保つ

### Do not

- 各地震行を EEW 風のラベル＋値レイアウトへ作り替えない
- タイムライン取得・地域解決・deep link・表示件数ポリシーは変更しない
- Android Widget は触らない

## UI detail

### Header（全サイズ共通）

- 背景: `Color.eqBrand`（ライト `#2F6FE4` / ダーク `#4D8DFF`）
- 左寄せ: タイトル（medium/large は `title`、small は `compactTitle`）と「更新 HH:mm」
- 文字色: タイトルは白、更新時刻は白の約 70%
- アイコン・更新ボタン・ストライプ・ヘッダー下の細い区切り線は置かない

### Earthquake rows（構造維持）

- 左: 震度バッジ / 中央: 震源＋時刻・深さ / 右: M
- 行背景の淡い震度色は現状どおり
- medium/large: M フォント約 12
- small: M フォント約 10、震度バッジ size 約 26

## Notes on refresh button

Widget の `Button(intent:)` から返した `dialog` はホーム画面では表示されない（Shortcuts / Siri 向け）。`reloadAllTimelines()` もシステム予算の制約を受ける。今回は更新ボタン自体を全サイズから外す。

## Testing

- small / medium / large Preview でヘッダー色・アイコンなし・更新ボタンなし・M 縮小を確認
- small で「6強」などが見切れないこと
- Widget extension のビルドが通ること
- WidgetModelsTests は地図非依存なら変更不要。依存があれば追随する

## Out of follow-up

行を EEW Live Activity 風（ラベル＋値、正方形震度バッジ）に寄せる作り替えは、必要になったら別タスクとする。
