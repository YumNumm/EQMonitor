# 揺れ検知グリッド表示（0.25° × セル最大レベル）

## 仕様

ホーム地図の揺れ検知表示は **0.25° グリッドのみ**（矩形モードは廃止）。

1. イベントの `points` を緯度経度で **0.25°** 格子に載せる（南西端 inclusive）
2. 同一セル内の観測点 intensity からレベルを求め、**最大レベル**でそのセルを塗る
3. 観測点が無いセルは描画しない
4. 中心点・四隅マーカーは出さない（塗りつぶしなし・色付き枠線のみ）
5. 微弱（Weaker）の枠線色はカードと同じグレー `#546E7A`
6. レベルが高いセルが上に来る（`line-sort-key` = `level.index`、Feature もレベル昇順）

intensity → level の閾値はバックエンド `getShakeLevelFromIntensity` と同じ。

| intensity | level |
|----------:|-------|
| ≤ -1 | Weaker |
| > -1 かつ ≤ 0.5 | Weak |
| > 0.5 かつ ≤ 2.5 | Medium |
| > 2.5 かつ ≤ 4.5 | Strong |
| > 4.5 | Stronger |

実装: `ShakeDetectionGridCellBuilder`（`app/lib/feature/shake_detection/data/logic/`）

## build_runner 注意

`dart run build_runner build --build-filter=...` は、フィルタ外の既存生成物（`*.g.dart` / `*.freezed.dart`）を大量削除することがある。

- 新規ファイルだけの再生成でも、完了後に `git status` で削除が出ていないか確認する
- 誤削除した場合は `git checkout -- <deleted generated files>` で復元する
- アプリ全体の再生成は `melos run generate` を優先する
