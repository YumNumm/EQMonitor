# LiveMonitor 地震 Card の遅延構築

`LiveMonitorEarthquakeCard` は `ListView.separated` を使用しているが、渡す
`children` 自体は `build` 内で先に全件構築している。地域震度の件数が多い地震で、
画面外の行まで eager に Widget を生成する。

大文字表示時の内部スクロールと compact / split の共通表示を維持したまま、
ヘッダー・地域グループを index から構築する presenter model へ分け、
画面外行を遅延構築する。実機で通常・大文字・縦横分割の Card 高さとスクロールを
確認してから置き換える。
