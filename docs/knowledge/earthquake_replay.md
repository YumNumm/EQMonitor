# EQRP リプレイ再生

EQRP（`.eqrp`）を読み込み、強震モニタのリアルタイム震度と EQMonitor 形式の EEW をホームの地図へ再生する。

## ファイル形式

- KyoshinEewViewerIngen（KEVi）の `KyoshinReplayFileReader` と同じ構成。`EQRP` の magic、MessagePack のヘッダ、圧縮した `ReplayData[]` が続く。読み込みは `packages/earthquake_replay`。
- 再生に使うのは強震モニタ画像（Union 100、`ImageType.shindo` のみ）と EQMonitor 形式の EEW（Union 1003）。ほかの種類は読み飛ばす。
- 1003 の JSON は EEW API が返す `EewItemWithRelations` をそのまま格納する。`EewItemWithRelations.fromJson` で読めないフレームはログを残して読み飛ばし、再生は止めない。
- KEVi が書き出した EQRP の EEW は気象庁 XML 電文（Union 0）で、1003 を含まない。そのままでは EEW が再生されないため、バックエンドの `tools/eqrp`（`eqrp convert`）で XML から 1003 を追加する。`eqrp inspect` はフレームの種類ごとの件数を出力する。

## 時刻

- EQRP の timestamp は「JST の壁時計を UTC として格納した値」。KEVi は強震モニタ画像の JST の時刻を `DateTimeKind.Unspecified` のまま書き出し、MessagePack-CSharp は Unspecified を変換せずに格納する（`MessagePackPrimitives.TryWrite`）。
- `ReplayTimestampDecoder` が読み込み時に 9 時間戻し、ヘッダと全フレームを実際の時刻（UTC）にする。アプリ側は UTC だけを扱う。EEW の JSON 内の時刻は元から UTC で、変換しない。
- MessagePack-CSharp は小数秒を持つ `DateTime` を timestamp 64 で書く。`msgpack_dart` の `ExtTimeStampDecoder` は秒を 34bit、ナノ秒を論理シフトで取り出す。ナノ秒の最上位 bit が立つと `getUint64` が負数になるため、算術シフトでは誤る。timestamp 96 にも対応している。
- 書き出し（`ReplayTimestampEncoder`）も同じ規約で、実際の時刻（UTC）に 9 時間足して格納する。

## 再生

- `AppClock` を `ReplayTimeMode` にし、EEW の生存判定・P/S 波・到達カウントダウンを再生時刻で動かす。`eewProvider` は非リアルタイム時にライブ受信を切り離し、`KyoshinMonitorNotifier` はライブ取得を止める。
- `ReplayNotifier` は再生位置を時刻で持つ。フレームが途切れても 1 秒ごとに時計を進める（KEVi の `ReplayFileRunner` も毎秒の境界で時刻を進める）。1 回の進行で通過した画像は最後の 1 枚だけ解析する。
- 次の進行時刻は、再生開始時の `Stopwatch` を基準に再生速度から決める。画像解析の時間を待ち時間に足さないため、遅れが積み重ならない。処理が遅れた場合は基準を取り直さず、基準から求めた位置までフレームをまとめて進める。基準を取り直すと時計が後ろへ戻る。
- 進行は 1 倍速で最短 1 秒おきのため、`AppClock.now()` は直前の進行位置に経過時間 × 再生速度を足して補間し、終了時刻で止める（`ReplayClockProgress`）。P/S 波の予想円など毎フレーム描画するものは `now()` を読む。補間しないと 1 秒ごとに跳ぶ。
- 一時停止と速度変更は補間中の位置を基準にする。進行位置へ戻すと、表示中の波面が巻き戻る。
- P/S 波を強震モニタの公開遅延に合わせる設定は、リプレイ中は使わない。再生中の画像は再生位置の時刻のものを表示する。
- シーク・読み込み・終了で世代番号を進め、解析中だった古いフレームを反映しない。シーク時は EEW を先頭から適用し直し、強震モニタは直前の画像 1 枚だけ解析する。画像がない位置では観測点を消す。
- 再生中はアプリ復帰時の強震モニタの作り直しを行わない（一時停止中に観測点が消えるため）。

## 作成

- デバッグメニュー先頭のリプレイのカードにある「リプレイファイルを作成」（`ReplayCreationPage`）で、直近の強震モニタ画像と EEW から EQRP を作る。書き出しは `packages/earthquake_replay` の `ReplayDataWriter`。
- 圧縮は gzip、timestamp は常に timestamp 64 で書く。フレームは時刻順に並べる。読み込み側が再生位置を二分探索で求め、揺れ検知が同時刻の画像を完全一致で探すため、画像フレームの時刻は秒ちょうどの観測時刻にする。
- 強震モニタ・長周期地震動モニタは、約 3 時間 40 分前までの画像を配信する（2026-11-23 実測。それより前は 404）。選択できる範囲は `ReplayCreationRangeResolver` が決め、3 時間前から 30 秒前まで、長さは最長 30 分。リプレイ中の `AppClock` は再生時刻を返すため、範囲は実時刻（端末時計 + NTP offset）で求める。
- 含められる画像は震度・最大加速度・最大速度（地表）。P/S 波と予想震度の画像は、EEW がない時刻に 302 を返すことまでしか確認できておらず、対象にしていない。EQRP の `ImageType` に無い変位・応答・長周期も含められない。
- 画像は 1 秒ごとに 4 並列で取得する。404 のフレームは飛ばし、ほかの失敗は 3 回まで試して作成を中止する。GIF は gzip でほとんど縮まず、震度だけで 1 秒あたり約 5 KB になる。
- 揺れ検知の平常値に使うため、既定で開始の 180 秒前から取得する。ヘッダの開始時刻は選んだ開始時刻のままにし、再生側（`ReplayState.startTime`）はヘッダの開始時刻より前のフレームを再生範囲に含めない。
- EEW は `GET /v2/eew` を発生日（前後 1 日）で絞って候補のイベントを集め、`GET /v2/eew/{eventId}` の全報から発表時刻が期間内のものを 1003 として格納する。フレームの時刻は発表時刻（`reportTime`）。訓練・試験も含める。
- 保存先はアプリの `Documents/replay/`。iOS は `UIFileSharingEnabled` を設定していないため Files アプリからは見えない。`Documents/Inbox` は読み込み後に削除する対象のため使わない。
- 外部への共有（`share_plus`）は `DebugAccessLevel.full`（admin デバイス）だけに出す。

## 揺れ検知

- 端末内の揺れ検知が有効な場合、再生画像を解析用 Isolate の検知エンジンへ渡す。検知結果は再生時刻で有効期限を判定し、再生中の EEW と結合する。
- 平常値（30・90・180 秒前）と履歴の作り直し（直前の数秒）には、ライブ取得の代わりにファイル内の同時刻の画像を使う。ファイルの先頭付近で過去の画像が無い場合は、ライブと同じく固定値を平常値にする。
- 読み込み・シーク・終了で検知結果を破棄する。シーク後は最初の画像で平常値の投入からやり直すため、巻き戻しても以前の検知は残らない。
- 再生は画像を 1 枚ずつ進めるため、再生速度を上げても検知エンジンへ渡るフレームは間引かれない。
- ライブの取得中にリプレイを始めた場合、その取得結果は表示にも検知にも反映しない。

## 表示と導線

- 再生中はホームの「リアルタイム 接続」を「過去の地震を再生中」（`ReplayStatusCard`）に替え、タップでコントロールシートを開く。強震モニタの設定が無効でも、再生中は強震モニタの列と観測点レイヤーを表示する。
- 読み込みは `/replay/open?source=<URI>`（`ReplayOpenPage`）に集約する。現在はデバッグメニューの「ファイルを読み込んで再生」、作成画面の保存済みファイル、OS の「ファイルで開く」から入る。
- OS から渡された `file://`・`content://` は `NotificationDeepLink.fromAppLinkUri` だけが `/replay/open` へ変換する。通知の link からは開けない。
- iOS は UTI `net.yumnumm.eqmonitor.eqrp` を export する。`LSSupportsOpeningDocumentsInPlace` は `false` で、OS が `Documents/Inbox` へ複製したファイルを読み、読み込み後に削除する。
- Android は VIEW の `content://` をパスの `.eqrp` で受け付け、`ReplayFileMethodChannel` で Activity の `ContentResolver` から読む。パスに拡張子を含まない provider（ダウンロードの `msf:` など）からは一致しない。
