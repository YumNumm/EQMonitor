# Live Activity の動く表示（時刻の文字と専用フォント）

EEW の Live Activity で、0.5秒おきの点滅と0.1秒単位のカウントダウンを出す方法です。
何をどこに出すかは [Live Activity](live_activity.md) を参照してください。

## 原理

- Live Activity は自前のタイマーや繰り返しアニメーションを動かせない。View は ContentState の更新まで再評価されない。
- 更新なしで変わるのは、システムが描き直す時刻の文字だけ。
- その文字を専用フォントで描けば、数字ごとの字形で見た目を作れる。フォントの置き換え規則（`calt`）もシステムが描く文字に効く。

## 使える時刻の文字

| 文字 | 変わる間隔 | 対応 |
| --- | --- | --- |
| `Text(date, style: .timer)`、`Text(timerInterval:)` | 1秒 | iOS 16.1〜 |
| `Text(.currentDate, format: .stopwatch(startingAt:maxPrecision: .milliseconds(100)))` | 0.1秒 | iOS 18〜 |
| `Text(.currentDate, format: .timer(countingDownIn:maxPrecision: .milliseconds(100)))` | 0.1秒。0で止まる | iOS 18〜 |

- `maxPrecision` に250ms・500msを渡しても小数は出ず、1秒ごとになる。
- 0.1秒単位のタイマーは必ず `0:08.5` の形。`maxFieldCount` を1や2にすると小数が消える。
- 独自の `FormatStyle` は使えない。Live Activity 全体が骨組み表示になる。
- `.durationOffset(to:)` は負の符号が付き、到達後は増え続ける。

## 点滅（`BlinkBlock`）

- 0〜4が塗りつぶし、5〜9が空のフォント（`EQBlinkHalf.ttf`、1文字=1em）でストップウォッチ文字を描く。
- 文字サイズを枠の幅の1.1倍にして右詰めで置き、末尾の0.1秒の桁だけを `clipped()` で切り抜く。0.5秒点灯・0.5秒消灯になる。
- 開始時刻は到達予想時刻から整数秒ずらす。塗りの出はじめがカウントダウンの秒の切り替わりにそろう。
- iOS 17は `style: .timer` と `EQBlink.ttf`（偶数が塗り）で、秒の1桁目を切り抜く。1秒おき。
- 偶数・奇数のフォントを0.1秒の桁に使わない。5Hzになり、光過敏性発作の目安（1秒に3回まで）を超える。
- 視差効果を減らす設定と常時表示（輝度低下）では塗りっぱなしにする。

## カウントダウン（`ArrivalCountdownText`）

- `EQCountdown.ttf` の置き換え規則で、システムが描く `0:08.5` を `8.5秒` に見せる。
  - 分が0のとき、`0:` と秒の十の位の0を幅0の空の字形にし、末尾に小さい `秒` を足す。
  - 小数点（`.` と `,`）とその後ろの数字を0.62倍の字形にする。
  - `0:00.0` は `0秒` にする。0に達したとき、更新を待たずに切り替わる。
  - 1分以上は `1:15.3` のまま。
- 描いた時点で到達済みなら、固定の文字列 `0:00.0` を同じフォントで出す（`0秒` になる）。
- タイマー文字は横いっぱいに広がるため、同じフォントの非表示 placeholder で幅を確保し、`overlay` で重ねる。
- placeholder も置き換えを受ける。描いた時点の残りが1分未満なら `0:11.1`、1分以上なら `1:11.1` を使う。
- iOS 17、常時表示、幅が狭い Dynamic Island は従来の `M:SS`。

## フォント

- `EQCountdown.ttf`: `uv run utils/live_activity_fonts/build_countdown_font.py` で作る。Google Sans Code の太字と
  Noto Sans JP Bold の `秒` が元（どちらも OFL）。書体名を変え、両方の著作権表示を残す。
- `EQBlink.ttf`・`EQBlinkHalf.ttf`: `fontforge` で作る。数字・コロン・ピリオド・カンマの送り幅を1000、
  塗りつぶす数字を x 0〜1000・y -1000〜2000 の矩形にする。
- フォントは Widget のバンドルに入れ、`AppFonts` で実行時に登録する。Preview 側の `membershipExceptions` にも足す。
- 拡張の一時領域へ書き出して登録したフォントは、タイマー文字に効かない（描画する側のプロセスが読めない）。
- 置き換え結果は `hb-shape EQCountdown.ttf "0:08.5"` で確認できる。

## 落とし穴

- 漢字を文字として渡さない。フォントに字形があっても、描画時にシステムの日本語フォントへ差し替えられ、
  幅が足りず `…` になる。`秒` は文字に割り当てず、置き換え規則からだけ出す。
- タイマー文字に `fixedSize()` を付けると描かれない。`frame(width:alignment:)` で幅を渡す。
- 切り抜く1文字は枠より1割広くする。同じ幅だと隣の桁の塗りが端に細く見える。
- 整数部と小数部を別の文字から組み立てない。秒単位は切り上げ（残り12.4秒で `0:13`）、0.1秒単位は `12.4` で食い違う。
- `秒` を別の `Text` で並べない。左寄せの場所で数字との間が空く。
- 小数点は地域設定でカンマになる。フォントは両方に対応させる。

## 確認方法

- Preview の Canvas では確認できない。Simulator の実表示を `simctl io recordVideo` で録画し、フレームで見る。
- Dynamic Island のない機種では、`AlertConfiguration` 付きの更新で Lock Screen 用の表示がバナーに出る。
- インストール直後の最初の起動では Live Activity が出ないことがある。もう一度起動する。

## 未確認

- 実機の Lock Screen、Apple Watch、CarPlay。
- iOS 18〜26 での動作（確認は iOS 27 Simulator のみ）。
- 0.1秒ごとの描き直しによる電池への影響。
- 地域設定が日本語・英語以外で、数字や区切りが変わる場合。
