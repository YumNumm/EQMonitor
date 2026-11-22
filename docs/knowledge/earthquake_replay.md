# EQRP リプレイ再生

EQRP（`.eqrp`）を読み込み、強震モニタのリアルタイム震度と EQMonitor 形式の EEW をホームの地図へ再生する。

## ファイル形式

- KyoshinEewViewerIngen（KEVi）の `KyoshinReplayFileReader` と同じ構成。`EQRP` の magic、MessagePack のヘッダ、圧縮した `ReplayData[]` が続く。読み込みは `packages/earthquake_replay`。
- 再生に使うのは強震モニタ画像（Union 100、`ImageType.shindo` のみ）と EQMonitor 形式の EEW（Union 1003）。ほかの種類は読み飛ばす。
- 1003 の JSON は EEW API が返す `EewItemWithRelations` をそのまま格納する。`EewItemWithRelations.fromJson` で読めないフレームはログを残して読み飛ばし、再生は止めない。

## 時刻

- EQRP の timestamp は「JST の壁時計を UTC として格納した値」。KEVi は強震モニタ画像の JST の時刻を `DateTimeKind.Unspecified` のまま書き出し、MessagePack-CSharp は Unspecified を変換せずに格納する（`MessagePackPrimitives.TryWrite`）。
- `ReplayTimestampDecoder` が読み込み時に 9 時間戻し、ヘッダと全フレームを実際の時刻（UTC）にする。アプリ側は UTC だけを扱う。EEW の JSON 内の時刻は元から UTC で、変換しない。
- MessagePack-CSharp は小数秒を持つ `DateTime` を timestamp 64 で書く。`msgpack_dart` の `ExtTimeStampDecoder` は秒を 34bit、ナノ秒を論理シフトで取り出す。ナノ秒の最上位 bit が立つと `getUint64` が負数になるため、算術シフトでは誤る。timestamp 96 にも対応している。
- EQRP を書き出す機能を作る場合も、同じ規約で JST の壁時計を UTC として格納する。

## 再生

- `AppClock` を `ReplayTimeMode` にし、EEW の生存判定・P/S 波・到達カウントダウンを再生時刻で動かす。`eewProvider` は非リアルタイム時にライブ受信を切り離し、`KyoshinMonitorNotifier` はライブ取得を止める。
- `ReplayNotifier` は再生位置を時刻で持つ。フレームが途切れても 1 秒ごとに時計を進める（KEVi の `ReplayFileRunner` も毎秒の境界で時刻を進める）。1 回の進行で通過した画像は最後の 1 枚だけ解析する。
- 次の進行時刻は、再生開始時の `Stopwatch` を基準に再生速度から決める。画像解析の時間を待ち時間に足さないため、遅れが積み重ならない。処理が遅れた場合は基準を取り直さず、基準から求めた位置までフレームをまとめて進める。基準を取り直すと時計が後ろへ戻る。
- 進行は 1 倍速で最短 1 秒おきのため、`AppClock.now()` は直前の進行位置に経過時間 × 再生速度を足して補間し、終了時刻で止める（`ReplayClockProgress`）。P/S 波の予想円など毎フレーム描画するものは `now()` を読む。補間しないと 1 秒ごとに跳ぶ。
- 一時停止と速度変更は補間中の位置を基準にする。進行位置へ戻すと、表示中の波面が巻き戻る。
- P/S 波を強震モニタの公開遅延に合わせる設定は、リプレイ中は使わない。再生中の画像は再生位置の時刻のものを表示する。
- シーク・読み込み・終了で世代番号を進め、解析中だった古いフレームを反映しない。シーク時は EEW を先頭から適用し直し、強震モニタは直前の画像 1 枚だけ解析する。画像がない位置では観測点を消す。
- 再生中はアプリ復帰時の強震モニタの作り直しを行わない（一時停止中に観測点が消えるため）。端末内の揺れ検知には再生画像を渡さない。

## 表示と導線

- 再生中はホームの「リアルタイム 接続」を「過去の地震を再生中」（`ReplayStatusCard`）に替え、タップでコントロールシートを開く。強震モニタの設定が無効でも、再生中は強震モニタの列と観測点レイヤーを表示する。
- 読み込みは `/replay/open?source=<URI>`（`ReplayOpenPage`）に集約する。現在はデバッグメニューの「過去の地震を再生」と OS の「ファイルで開く」から入る。
- OS から渡された `file://`・`content://` は `NotificationDeepLink.fromAppLinkUri` だけが `/replay/open` へ変換する。通知の link からは開けない。
- iOS は UTI `net.yumnumm.eqmonitor.eqrp` を export する。`LSSupportsOpeningDocumentsInPlace` は `false` で、OS が `Documents/Inbox` へ複製したファイルを読み、読み込み後に削除する。
- Android は VIEW の `content://` をパスの `.eqrp` で受け付け、`ReplayFileMethodChannel` で Activity の `ContentResolver` から読む。パスに拡張子を含まない provider（ダウンロードの `msf:` など）からは一致しない。
