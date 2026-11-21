# ホーム画面 Widget（地震履歴）

対象は `app/ios/Widget/Widget.swift`、`Views/EarthquakeWidgetView.swift`、`EarthquakeWidgetCache.swift`、
`DesignSystem.swift` と `app/ios/Shared/` の共有ロジック。Live Activity は [表示と検証](live_activity.md)、
Xcode の所属と Preview は [軽量 Preview](apple_previews.md) を参照する。

## 外観

- 全件を同じ大きさの行で並べ、行の間は細い区切り線で分ける。最新の 1 件だけを大きくしない。
- 色は震度バッジだけに使う。ブランド色のヘッダー帯や、震度色を敷いた行の地は使わない
  （ダークでくすんで見え、震度の色と競合する）。
- ヘッダーは帯なしで、タイトルと取得時刻を補助色で置く。取得時刻に更新を思わせるアイコンは付けない。
  ボタンに見えるが押しても何も起きない。
- M は Live Activity の `SourceMetricsView` と同じ比率にする。ラベルは数値の 0.44 倍、数値は等幅 bold、
  小数点の前後だけを詰める。
- small は震源名に 1 行を使い、2 行目に日時と M を置く。深さは出さない。
  medium / large は震源名、日時と深さ、右端に M を置く。
- ライトだけ、左上から薄い青の光を広くぼかして背景へ重ねる（`EQWidgetBackground`）。ダークには重ねない。
- 震源要素が未発表の地震（震度速報など、`hasHypocenter == false`）は M と深さを出さない。
  アプリの一覧と同じ扱いで、震源があり M だけ不明なときの「M不明」と区別する。
- 訓練・テストの電文は出さない。API へ `statuses=NORMAL` を付けて要求し、表示前にも `isNormal` で落とす。
  App Intent は訓練報を扱うため、絞り込みは `normalOnly: true` を渡した呼び出しだけに効かせる。

## レイアウト

- 表示件数は固定の行高から計算しない。`ViewThatFits(in: .vertical)` に件数の多い順で候補を渡し、
  実寸で収まる最大を選ぶ。`WidgetLayoutPolicy` は候補の上限と取得件数だけを持つ。
- 行リストや `ViewThatFits` を `Spacer` と同じ `VStack` に並べない。高さの提案が等分されて
  収まる件数が減る。残りの領域は `frame(maxHeight: .infinity, alignment: .top)` で渡す。
- `lineLimit(1)` と `minimumScaleFactor` を付けた Text は、高さが足りないと縦にも縮む。
  `fixedSize(horizontal: false, vertical: true)` で高さを固定する。
- 標準の文字サイズでの行の実高は small 30pt、medium 31pt、large 36pt。
  HIG の寸法表で最小の 148pt（iPhone SE）でも small と medium に 3 件入る。余りは small 約 4pt、medium 約 1pt。
  ヘッダーや行の寸法を変えたら、148・155・158pt で件数を確認する。
- 日時は `MM/dd HH:mm`。表示時点と年が違えば small は `yyyy/MM/dd`、medium / large は `yyyy/MM/dd HH:mm`。
- small の震度バッジは 26pt。未入電（「5弱以上」）はバッジが横へ伸び、大きくすると震源名と日時が切れる。
- 文字は 11pt 以上にする（HIG の目安。M のラベルは Live Activity に合わせて例外）。
  Dynamic Type は small が xLarge、medium / large が xxLarge まで。
  上限は macOS の描画に文字倍率（1.12 / 1.24）を掛けた近似から決めた。実機では未確認。

| 文字倍率（近似） | small | medium | large |
|---|---|---|---|
| 1.0（標準） | 3 件 | 3 件 | 6〜7 件 |
| 1.12（xLarge 相当） | 158pt 以上は 3 件、それ未満は 2 件 | 155pt 以上は 3 件、148pt は 2 件 | 6〜7 件 |
| 1.24（xxLarge 相当） | 上限のため適用しない | 2 件 | 6 件 |

## 描画モード

- ホーム画面の色つき・クリア、ロック画面、夜間のスタンバイでは、システムがビューの色を単色へ置き換え、
  アルファだけを残す。背景も外れる。
- 不透明な塗りの上に不透明な文字を置くと同じ色になる。`widgetRenderingMode` がフルカラー以外のときは、
  震度バッジを枠線で描き、`widgetAccentable()` でアクセント側に分ける。

## データ取得

- 取得に成功した結果を App Group コンテナの `Library/Caches/EarthquakeWidget/` へ保存する。
  取得に失敗したら前回分を表示し、ヘッダーに警告アイコンと取得時刻を出す。
  前回分が無いときだけエラー表示にする。
- キャッシュのファイル名は API のホストと取得条件（全国・地域コード）で分ける。
  保存形式を変えるときはファイル名の版を上げる。
- `snapshot` はウィジェットギャラリー（`context.isPreview`）のときだけ見本を返す。
  それ以外で見本を返すと、実在しない地震が実際の情報に見える。
- API のタイムアウトは 10 秒。拡張の実行時間は限られ、URLSession 既定の 60 秒を待つと結果を返せない。
- `relevance` は直近 3 時間に震度 4 以上（地域を指定した表示は震度 2 以上）があるときだけ付ける。
  全国表示は地震が絶えず並ぶため、弱い地震では付けない。

## 確認方法

| 確認する内容 | 方法 |
|---|---|
| 表示件数・文字の切れ（各サイズ、ライト / ダーク） | View のソースを macOS で `ImageRenderer` 描画する。フォントは `app/assets/fonts` を登録する |
| Preview ターゲットでのコンパイル | `EQMonitorPreview` scheme の build |
| WidgetExtension / AppIntentExtension のコンパイル | 拡張ターゲットだけを入れた一時 scheme の build（下記） |
| 共有ロジック | `WidgetModelsTests` |
| 色つき・クリア表示、Dynamic Type、VoiceOver、タップ遷移 | Xcode Preview か実機でのみ確認できる |

- macOS の描画は WidgetKit を通らない。描画モードと Dynamic Type は確認できず、文字倍率を掛けた近似にとどまる。
- 描画した画像から件数を数えるときはダークで行う。ライトは震度バッジの白い数字が地の色と区別できない。
- `WidgetModelsTests` は macOS の deployment target が SDK の版になる。
  macOS がそれより古い環境では `MACOSX_DEPLOYMENT_TARGET=<実行環境の版>` を付けて実行する。
- 拡張ターゲットの build には `app/ios/Flutter/Environment.xcconfig` が要る。Runner scheme の pre-action
  （`scripts/extract_dart_defines.sh`）が生成するファイルで、worktree には無い。
  `SRCROOT=<app/ios の絶対パス> DART_DEFINES= bash app/ios/scripts/extract_dart_defines.sh` で生成できる。
  `IS_PRODUCTION=true` の経路は `DART_DEFINES` に `IS_PRODUCTION=true` の base64 を渡す。
- 共有 scheme の `WidgetExtension` は Runner も build するため Flutter の成果物が要る。
  `BuildActionEntries` に拡張ターゲット 1 つだけを入れた scheme を一時的に作れば、Flutter なしで
  Simulator 向けに build できる（2026-11-22、Xcode 27.2 で WidgetExtension と AppIntentExtension を確認）。
  同じ環境で `-target` 指定の build は `Unable to resolve module dependency: 'HTTPTypes'` で失敗した
  （変更前のコードでも同じ）。
