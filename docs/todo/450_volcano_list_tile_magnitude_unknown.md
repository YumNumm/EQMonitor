# 火山噴火の ListTile 末尾に「M不明」が表示される

## 現状

震源カード（`EarthquakeSummaryHeader`）は地震種別に応じた表現へ変更済み。

- 火山噴火: マグニチュード不明時は「M不明」ではなく「火山の噴火」を表示
- 遠地地震: 判明している要素（M / 深さ）だけを表示

一方 `EarthquakeHistoryListTile` の `trailing` は種別を考慮しておらず、
火山噴火でも `MagnitudeText` が「M不明」を描画する。
地震履歴一覧・近傍地震カードの両方で、噴火なのにマグニチュードを
探しているような表示になっている。

## 対応候補

- 火山噴火では `trailing` を出さない
- もしくは種別に応じた短いラベル（例: 「噴火」）を出す

`trailing` は幅が限られるため、文言を決めてから実装する。
`app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart`
の `trailing` と、`app/test/feature/earthquake_history/ui/components/` 配下の
テスト追加が必要。
