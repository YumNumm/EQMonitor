# リプレイ再生

EQRP（`.eqrp`）または強震モニタが公開している過去画像を、EQMonitor 形式の EEW と合わせてホームの地図へ再生する。
供給元は `ReplaySource` で表し、再生の進行・シーク・表示は共通の `ReplayNotifier` が担う。

## ファイル形式

- KyoshinEewViewerIngen（KEVi）の `KyoshinReplayFileReader` と同じ構成。`EQRP` の magic、MessagePack のヘッダ、圧縮した `ReplayData[]` が続く。読み込みは `packages/earthquake_replay`。
- 再生に使うのは強震モニタ画像（Union 100、`ImageType.shindo` のみ）と EEW（EQMonitor 形式の Union 1003、気象庁 XML 電文の Union 0 のうち緊急地震速報）。ほかの種類は読み飛ばす。
- `ReplayDataType` に無い Union（バックエンドの地震アーカイブが書く 1004 の地震情報・1005 の K-NET/KiK-net 波形など）は、読み込み時に捨てる。対応前のアプリは未知の Union で読み込みに失敗する。
- 1003 の JSON は EEW API が返す `EewItemWithRelations` をそのまま格納する。`EewItemWithRelations.fromJson` で読めないフレームはログを残して読み飛ばし、再生は止めない。
- Union 0 は題名（`Control/Title`）が緊急地震速報（警報）・（予報）・（地震動予報）のものだけを `packages/jma_eew_xml` で読み、`JmaEewXmlConverter` でアプリ用の `EewTelegramItem` にする。読めない電文はログを残して読み飛ばす。
- 再生開始時に `ReplayEewReportResolver` が EEW のフレームを一度だけ変換し、再生中・シーク時はフレームの位置で引いて `Eew.upsert` へ渡す。
- 同じ地震に複数の形式があるときは、1003 > 地震動予報（VXSE45）> 予報（VXSE44）> 警報（VXSE43）の順で 1 つの形式だけを使う。警報電文は予報電文と情報番号の系列が別で、混ぜると報の前後関係が崩れる。

## 時刻

- EQRP の timestamp は「JST の壁時計を UTC として格納した値」。KEVi は強震モニタ画像の JST の時刻を `DateTimeKind.Unspecified` のまま書き出し、MessagePack-CSharp は Unspecified を変換せずに格納する（`MessagePackPrimitives.TryWrite`）。
- `ReplayTimestampDecoder` が読み込み時に 9 時間戻し、ヘッダと全フレームを実際の時刻（UTC）にする。アプリ側は UTC だけを扱う。EEW の JSON 内の時刻は元から UTC で、変換しない。
- MessagePack-CSharp は小数秒を持つ `DateTime` を timestamp 64 で書く。`msgpack_dart` の `ExtTimeStampDecoder` は秒を 34bit、ナノ秒を論理シフトで取り出す。ナノ秒の最上位 bit が立つと `getUint64` が負数になるため、算術シフトでは誤る。timestamp 96 にも対応している。
- 書き出し（`ReplayTimestampEncoder`）も同じ規約で、実際の時刻（UTC）に 9 時間足して格納する。

## 強震モニタの過去画像

- 地震履歴の詳細画面の「強震モニタで再生」から始める。発生時刻が現在から3時間以内の地震にだけ表示する。
  範囲の判定は `ReplayKyoshinArchiveWindowResolver` が行い、再生位置ではなく実時刻（`AppClock.realtimeNow`）を使う。
- 過去画像は1時間ごとに、その時点の3時間前までがまとめて削除される。2026-11-23 の実測では、kmoni は 05:46 JST に 02:44 台まで、
  lmoni は 06:15 JST に 03:14 台までが消えた。保持幅は削除の直後に3時間、直前に4時間になる。1日分の計測で、別の日も同じ規則かは未確認。
- 再生中に削除が走っても画像が残るよう、導線を出す範囲は3時間から区間の長さを引いた時点までとする。
  0.5 倍速では再生し終えるまでに画像が区間の長さだけ古くなるため。秒単位の発生時刻では、発生からおよそ2時間56分までになる。
  一時停止が長いと再生中に削除されることがあるため、開始時にも先頭の1枚を取得し、404 なら再生を始めずに期間外と伝える。
- 再生区間は発生時刻の10秒前から3分後まで。終端が現在時刻に近い場合は、公開済みの時刻までに切り詰める。
- 発生時刻が分単位の地震は、実際の発生がその1分間のどこかにあるため、終端を1分延ばし、目印を「頃」と表示する。
  時・日・月単位や欠測の場合は導線を出さない。
- 画像は再生位置の1秒ごとに1枚取得し、再生中はメモリに保持する。一括の先読みはしない。速度は 0.5x・1x・2x。
- 取得するのは利用者の表示設定に関係なく地表の震度画像。取得元（lmoni / kmoni）は保存済みの設定に従う。
- 404 の時刻は観測点を消す。ライブ用の遅延補正（`KyoshinMonitorOffsetAdjustment`）へは反映しない。
  404 かつ2時間より古い時刻であれば削除済みとみなし、通知して再生を終了する。
  取得と削除済みの判定は `ReplayKyoshinArchiveFrameLoader` が行い、`ReplayNotifier` は結果に応じた状態の更新だけを担う。
- EEW は Pro のときだけ `getV2EewEventId` で取得し、EQRP の 1003 と同じ JSON のフレームにして発表時刻で適用する。
  取得に失敗した場合は強震モニタだけを再生する。

## 再生

- タイムシフト再生（現在時刻からのずらし）は廃止した。時刻のモードはリアルタイムとリプレイの2つ。
- `AppClock` を `ReplayTimeMode` にし、EEW の生存判定・P/S 波・到達カウントダウンを再生時刻で動かす。`eewProvider` は非リアルタイム時にライブ受信を切り離し、`KyoshinMonitorNotifier` はライブ取得を止める。
- `ReplayState.passedFrameCount` は再生位置までに通過したフレームの数。過去画像の再生では EEW だけがフレームになり、
  区間の先頭に通過済みのフレームが無いため、「最後に通過した位置」では表せない。
- `ReplayNotifier` は再生位置を時刻で持つ。フレームが途切れても 1 秒ごとに時計を進める（KEVi の `ReplayFileRunner` も毎秒の境界で時刻を進める）。1 回の進行で通過した画像は最後の 1 枚だけ解析する。
- 次の進行時刻は、再生開始時の `Stopwatch` を基準に再生速度から決める。画像解析の時間を待ち時間に足さないため、遅れが積み重ならない。処理が遅れた場合は基準を取り直さず、基準から求めた位置までフレームをまとめて進める。基準を取り直すと時計が後ろへ戻る。
- 進行は 1 倍速で最短 1 秒おきのため、`AppClock.now()` は直前の進行位置に経過時間 × 再生速度を足して補間し、終了時刻で止める（`ReplayClockProgress`）。P/S 波の予想円など毎フレーム描画するものは `now()` を読む。補間しないと 1 秒ごとに跳ぶ。
- 一時停止と速度変更は補間中の位置を基準にする。進行位置へ戻すと、表示中の波面が巻き戻る。
- P/S 波を強震モニタの公開遅延に合わせる設定は、リプレイ中は使わない。再生中の画像は再生位置の時刻のものを表示する。
- シーク・読み込み・終了で世代番号を進め、解析中だった古いフレームを反映しない。シーク時は EEW を先頭から適用し直し、強震モニタは直前の画像 1 枚だけ解析する。画像がない位置では観測点を消す。
- 再生中はアプリ復帰時の強震モニタの作り直しを行わない（一時停止中に観測点が消えるため）。

## 緊急地震速報の発表時

- 再生中にライブの EEW を受信したら、再生を終了してリアルタイムへ戻し、その旨を通知する。
  `eewProvider` は再生中にライブ受信を切り離しているため、`ReplayNotifier` が `realtimeEventsProvider` を別に監視する。
- WebSocket が接続していない間は、10秒ごとに REST の最新 EEW を確認する。
- 発表中かどうかは `EewAliveChecker` に実時刻を渡して判定する。取消報や訓練報も、ライブで表示される間は対象。
- 発表中の EEW がある間は、再生を開始できない。読み込みや取得を待つ間に発表された場合に備え、再生へ切り替える直前にも確認する。

## 作成

- デバッグメニュー先頭のリプレイのカードにある「リプレイファイルを作成」（`ReplayCreationPage`）で、直近の強震モニタ画像と EEW から EQRP を作る。書き出しは `packages/earthquake_replay` の `ReplayDataWriter`。
- 圧縮は gzip、timestamp は常に timestamp 64 で書く。フレームは時刻順に並べる。読み込み側が再生位置を二分探索で求め、揺れ検知が同時刻の画像を完全一致で探すため、画像フレームの時刻は秒ちょうどの観測時刻にする。
- 選択できる範囲は `ReplayCreationRangeResolver` が決め、3 時間前から 30 秒前まで、長さは最長 30 分。過去画像の保持幅は「強震モニタの過去画像」の実測のとおりで、3 時間以内でも古い側が削除済みのことがある。範囲は実時刻（`AppClock.realtimeNow`）で求める。
- 含められる画像は震度・最大加速度・最大速度（地表）。P/S 波と予想震度の画像は、EEW がない時刻に 302 を返すことまでしか確認できておらず、対象にしていない。EQRP の `ImageType` に無い変位・応答・長周期も含められない。
- 画像は 1 秒ごとに 4 並列で取得する。404 のフレームは飛ばし、ほかの失敗は 3 回まで試して作成を中止する。GIF は gzip でほとんど縮まず、震度だけで 1 秒あたり約 5 KB になる。
- 揺れ検知の平常値に使うため、既定で開始の 180 秒前から取得する。ヘッダの開始時刻は選んだ開始時刻のままにし、再生側（`ReplaySource.startTime`）はヘッダの開始時刻より前のフレームを再生範囲に含めない。
- EEW は `GET /v2/eew` を発生日（前後 1 日）で絞って候補のイベントを集め、`GET /v2/eew/{eventId}` の全報から発表時刻が期間内のものを 1003 として格納する。フレームの時刻は発表時刻（`reportTime`）。訓練・試験も含める。
- 作成画面へは、地震履歴の詳細（各地の震度の下）と緊急地震速報の履歴（地図の右上）からも入れる。発生時刻の1分前を開始時刻に、震源名と発生時刻を名前に入れた状態で開く。ボタンはデバッグモードが有効で、発生時刻が作成できる範囲（3時間前から30秒前）にある場合だけ出す（`replayCreationEntryAvailableProvider`）。
- 緊急地震速報の履歴の「シミュレーション再生」は、同じ地図の右上のボタンにまとめている。
- 作成画面で名前とフォルダを指定できる。空欄の場合、名前は `eqmonitor_<開始時刻>_<秒数>s.eqrp`、フォルダは開始時刻（JST）の `年/月`（例: `2026/11`）にする。

## 地震アーカイブからの取得

- デバッグメニューのリプレイのカードにある「地震アーカイブから取得」（`EarthquakeArchiveListPage`）で、バックエンドが毎時作る地震ごとの EQRP を一覧・取得する。仕様はバックエンドの `docs/earthquake-archive.md`。
- デバイスの役割が Admin（`DebugAccessLevel.full`）の端末だけに入口を出し、ルートも `DebugMenuRouteGuard` で admin 専用にしている。
- API（`/v2/admin/earthquake-archives`）は、`ADMIN_DEVICE_IDS` の端末のトークンでも通る。ほかの admin API と違い、アカウントへのログインは要らない。`DeviceAuthTokenInterceptor` がこのパスの GET にデバイスのトークンを付ける。
- 一覧と詳細は生成済みの `AdminApiClient`、ファイルは `/file` を同じ Dio でバイト列として取る。保存先は外から開けないため、API が中継する。
- 取得したファイルは EQRP として読めた場合だけ、ヘッダの開始時刻の `年/月` に保存する（`ReplayLibraryRepository.saveDownloaded`）。「保存して再生」はそのまま `/replay/open` へ進む。
- 一覧と詳細には、フレームの種類ごとの件数・容量・時刻の範囲を出す。1004（地震情報）と 1005（K-NET/KiK-net 波形）は再生では読み飛ばす。

## 保存と管理

- 保存先はアプリの `Documents/replay/`。iOS は `UIFileSharingEnabled` を設定していないため Files アプリからは見えない。`Documents/Inbox` は読み込み後に削除する対象のため使わない。
- 一覧・再生・追加・名前とフォルダの変更・削除は「保存済みのリプレイ」（`ReplayLibraryPage`）で行う。フォルダごとに表示し、ファイルをタップすると再生する。
- `年/月` は既定の保存先にすぎない。フォルダは自由に作成・名前の変更・移動・削除ができ、空のフォルダも残す。`年/月` 導入前にルート直下へ保存したファイルは、そのまま最上位に表示する。
- フォルダの名前の変更と移動は同じ操作で、ルートからのパスを書き換える。移動先に同名のフォルダがある場合と、自分自身の中への移動は失敗にする。フォルダの削除は中のファイルごと消す。
- 名前とフォルダの規則は `ReplayFilePathResolver` に集める。`/`・`\`・`:`・制御文字・先頭の `.` を拒否し、拡張子は `.eqrp` に揃える。保存と追加は同名があれば `_2` を付け、名前の変更は同名があれば失敗にする。
- ファイルの追加は権限を問わず使える。選んだファイルを EQRP として読み込めた場合だけ複製する。追加先は表示中のフォルダで、最上位を表示中の場合はヘッダの開始時刻の `年/月`。`file_picker` が一時領域へ作った複製は取り込み後に消す。
- 外部への共有（`share_plus`）は `DebugAccessLevel.full`（admin デバイス）だけに出す。
- 複数選択は長押しか「選択」で始め、表示中のフォルダにあるファイルとフォルダをまとめて移動・削除できる。
- 画面の先頭にリプレイファイルの合計と端末の空き・使用中・全体の容量を出す。端末の容量は `packages/native_plugin` の `DeviceStorageReader` で取得する。
- iOS の空きは `volumeAvailableCapacityForImportantUsage`（削除できるキャッシュを空きに含む値）で、設定アプリの表示に近い。容量の API は Required Reason API のため、`PrivacyInfo.xcprivacy` に `NSPrivacyAccessedAPICategoryDiskSpace`（理由 `85F4.1`: 利用者への表示）を宣言している。
- `ReplayFileDataSource.readFile` が読み込み後に削除するのは `Documents/Inbox` 直下のファイルだけ。フォルダ名は利用者が決められるため、パスに `Inbox` を含むだけでは削除しない。

## OS の API の直接呼び出し（`packages/native_plugin`）

- MethodChannel を使わず、FFIgen（Objective-C）と JNIgen（Java）のバインディングで Dart から直接呼ぶ。生成手順はパッケージの README にある。
- 公開する型は Freezed。OS で値の意味が異なる `DeviceStorage` は sealed class（`android` / `ios`）にしている。
- iOS は `package:objective_c` の `NSURL` を使い、FFIgen では `NSURLVolume*Key` の定数だけを生成する。`@Native` のシンボルはプロセス内の Foundation から解決されるため、build hook は要らない。
- Android は `android.jar` から `android.os.StatFs` を ASM で読んで生成する。Android SDK のスタブはソースからの生成（doclet）に向かない。
- JNI の Java 例外は `JThrowable` として届く。`JniException` という型は無い。

## 揺れ検知

- 端末内の揺れ検知が有効な場合、再生画像を解析用 Isolate の検知エンジンへ渡す。検知結果は再生時刻で有効期限を判定し、再生中の EEW と結合する。
- 平常値（30・90・180 秒前）と履歴の作り直し（直前の数秒）には、ライブ取得の代わりにファイル内の同時刻の画像を使う。過去画像の再生では同じ時刻の画像を取得して使う。ファイルの先頭付近で過去の画像が無い場合は、ライブと同じく固定値を平常値にする。
- 読み込み・シーク・終了で検知結果を破棄する。シーク後は最初の画像で平常値の投入からやり直すため、巻き戻しても以前の検知は残らない。
- 再生は画像を 1 枚ずつ進めるため、再生速度を上げても検知エンジンへ渡るフレームは間引かれない。
- ライブの取得中にリプレイを始めた場合、その取得結果は表示にも検知にも反映しない。

## 表示と導線

- 再生中はホームの「リアルタイム 接続」を「過去の地震を再生中」（`ReplayStatusCard`）に替える。タップするとその場で広がり、
  スライダー・再生操作・速度・終了を操作できる。もう一度タップするか地図を操作すると畳む。
- スライダーのトラックには地震の発生時刻の目印を描く（`ReplayOriginTrackShape`）。EQRP では最初に発生時刻を持つ EEW から取り、
  無ければ目印を出さない。「発生」のボタンでその時刻へ移動する。強震モニタの設定が無効でも、再生中は強震モニタの列と観測点レイヤーを表示する。
- EQRP の読み込みは `/replay/open?source=<URI>`（`ReplayOpenPage`）に集約する。現在はデバッグメニューの「保存済みから再生・ファイルを追加」（保存済みのリプレイ）と OS の「ファイルで開く」から入る。
- OS から渡された `file://`・`content://` は `NotificationDeepLink.fromAppLinkUri` だけが `/replay/open` へ変換する。通知の link からは開けない。
- iOS は UTI `net.yumnumm.eqmonitor.eqrp` を export する。`LSSupportsOpeningDocumentsInPlace` は `false` で、OS が `Documents/Inbox` へ複製したファイルを読み、読み込み後に削除する。
- Android は VIEW の `content://` をパスの `.eqrp` で受け付け、`ReplayFileMethodChannel` で Activity の `ContentResolver` から読む。パスに拡張子を含まない provider（ダウンロードの `msf:` など）からは一致しない。
