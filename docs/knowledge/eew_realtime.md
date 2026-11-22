# EEW・リアルタイム更新の契約

2026-09-21に既存知識を統合。コード確認箇所を末尾に示す。過去のテスト件数や
一時的なビルド失敗は現在の検証結果として扱わず、実機確認は別途実施する。

## 発表値と表示

- 深さとJMA発表の予想最大震度は独立。発表値があれば深さに関係なく表示する。
- 未発表でも震度枠を残し、Flutterは`JmaIntensity.unknown`の`-`を表示する。
  取消時は震度ではなく取消記号を出す。iOSの外観は[Live Activity](live_activity.md)を参照。
- 深発注意文は「取消でない・低精度検知でない・最大震度未発表・**depth > 150km**」
  の全条件で表示する。150kmちょうどでは出さない。旧記録の「150km以上」は採用しない。
- 距離減衰によるアプリ側推定を`depth >= 150`で停止する条件とは区別する。
- PLUM、レベル法、IPF 1点検知はM・深さを表示しない。レベル法は
  `accuracy.epicenter == 1 && originTime == null`、IPF 1点は発生時刻あり・非PLUM。
- PLUMの時刻は地震検知。M・深さ欠落を補わず、EEWの数値深さは`N km`で表す。
- 最終報は`最終 第N報`。到達後はFlutterもLive Activityも`揺れ到達まで`＋`0秒`を維持する。
  Live Activityはシステムタイマーの制約で文言を切り替えられず、Flutterはそれに合わせている。
- 表示終了は発生時刻からの経過秒数（250/360/400秒）で判定する。最新報が最終報なら、
  加えて最終報の発表から30秒超の経過も必要とし、遅れて届いた最終報を即座に消さない。
  取消報は発表から180秒超で終了し、この条件の対象外。

## 警報見出しと振動

- 通知pushの完成文字列を空白や語尾で分割しない。アプリの構造化EEWから見出しを作る。
- 震源名は`hypocenter?.detailedName ?? hypocenter?.name`、地域は現在報の`warning.zones`。
  地域を半角スペースで結び、`で強い揺れ`は末尾に1回だけ付ける。
- PLUM・レベル法・震源不明では推定できない震源名を主見出しにしない。
  overlayの情報不足時の文言は`強い揺れに警戒`。数値・地域を捏造しない。
- 現在警報は`isWarning && !isCanceled`と現在報の警報配列で判断する。
  `hadWarning`は前回報の警報状態であり、初回警報や追加区域の抽出条件に使わない。
- 区域コードは`warning.prefectures`の90xxと`warning.regions`の3桁を区別する。
  描画側の区域対応は地図ドキュメントに従う。
- backendの警報専用push、通常EEW push、Live Activityは別の文面生成経路。
  過去のSQL順序・欠損時文面・早期returnの調査結果を現行配信仕様と断定しない。
- 振動失敗はログに記録して警報UIを継続する。対応端末は700ms×10回＋間隔300ms×9回
  （計9700ms）の有限pattern、非対応端末は700ms×1回。iOSのusage descriptionは不要。
- 実機では閉じる・最小化・10秒経過・background移行で停止を確認する。
  Androidの`VIBRATE`宣言を重複追加しない。

## EEWのREST・WebSocket整合

- `Eew`はRESTをlistenし、正常完了時だけ整合処理へ渡す。受信済み値がある間は
  Loading/Errorで表示状態を置き換えず、通信状態は`eewRestProvider`が保持する。
- 初回未取得はLoading/Errorを伝える。RESTの古い前回値で新しいRealtime報を巻き戻さない。
- 再取得契機はresumed、Realtime ready、未接続中の10秒周期、API依存変更。
  復帰とreadyが続いても、実機の発火回数をログなしで断定しない。
- 正常な空結果は既存の整合規則に従い、失効判定はtickerで継続する。
  非リアルタイムモードではライブ値を破棄する。
- テストはCompleterでRESTを未完了に保ち、その間の表示値を検証する。
  最終serialだけではちらつき回帰を検出できない。デフォルトinvalidateとasReloadを区別する。
- 実機残件は[EEW・推計震度](../todo/800_eew_and_estimated_intensity.md)。
  resumed/ready/REST開始・終了、loading/hasValue、eventId/serialを同じ時系列で確認する。

## WebSocket の再接続とチケット取得

- 再接続の待ち時間は1、2、4、8、16、32、60秒と増やし、以後は60秒を維持する。
  失敗回数から整数のべき乗を計算しない。Dart VM の `pow(2, 63)` は負数、
  `pow(2, 64)` 以降は0になり、待ち時間なしの再送を引き起こす。
- 接続成功・アプリ復帰・ネットワーク変更で待ち時間を初期化する。
- `/v2/realtime/ticket` は `x-eqmonitor-device-id` が必須。
  保存トークンの欠落・読み取り失敗・解析失敗時は interceptor でローカルエラーにし、
  HTTP リクエストを送らない。再接続時にトークンを読み直して復旧を試みる。
  端末 ID が任意の API は引き続き利用できる。
- 端末固有のトークン欠落原因と実機での長時間失敗・復帰の確認は、
  [リアルタイム監視の残課題](../todo/160_realtime_monitor_followups.md)で追跡する。

## WebSocket heartbeat の互換性

- 接続URLには `heartbeat=fixed-v1` を付与し、接続直後と15秒ごとに
  `{"type":"ping","pingId":"heartbeat"}` を送る。ticketと配信先はAPIの応答を使う。
- 応答は `{"type":"pong","pingId":"heartbeat"}`。Durable Objectsの自動応答は
  文字列全体で照合するため、JSONのキー順序と空白も固定する。
- heartbeatは接続層で動き、デバッグ画面の表示に依存しない。
  受信が30秒途絶えた場合の再接続、切断・provider破棄時のtimer停止を維持する。
- 既存Nodeサーバーは追加queryを無視し、同じpingIdを返せる。
  アプリからサーバー起因の `{"type":"ping"}` へのpong応答も維持する。
- 旧アプリは通常画面でclient pingを送らない。新サーバーではqueryのない接続を
  legacy扱いし、従来のserver pingを送る必要がある。旧アプリも接続できるが、
  legacy接続が残るDOでは定期的に処理が起動する。
- デバッグ画面のRTT計測は従来の連番pingIdを使い、固定heartbeatのpongは無視する。
  RTT計測中はDOで通常のmessage処理が起動する。

## 再生と派生画面

- 履歴シミュレーションの報切替、P/S波、カードは共通の再生経過時間を参照する。
  pause時に確定、resume時に実時計基準だけ更新し、最終報では位置を固定する。
- 次報タイマーは共通再生位置から残り時間を求める。Widgetで独自に`DateTime.now()`を引かない。
- 報間隔は先頭報からの実際の発表時刻差を使い、最小・最大間隔を設けない。
  同時刻の報は報番号順に扱う。カードとP/S波は`playbackTimeAt`を参照し、
  最終報の発表時刻で固定する。完了後の再生操作は先頭から開始する。
- 再生状態は詳細画面ごとのProviderScopeに保持し、地震切替・画面破棄時に破棄する。
  一覧へ戻るときの選択報は、再生順のindexではなく報番号で対応させる。
- 巻き戻し・地震切替・取消時は以前の推定震度を持ち越さない。
  到達前の端数秒は切り上げ、現在時刻未取得を到達済みとして扱わない。
- 取消報は震源や予報が残っていても、P/S波・予想震度の塗りつぶし・到達表示を消す。
- 停止中の走時表ロード完了でも波面を再計算する。走時表の時刻に一致した場合は
  対応する距離を返し、補間のゼロ除算を避ける。
- 過去のリプレイ注入で時刻をシフトする方式では、report/origin/arrivalだけでなく
  `forecastIntensity.regions[].arrivalTime.value`にも同じoffsetが必要だった。
  現在の共通clock方式へ旧debug実装のパスや欠損値補完を無条件に持ち込まない。
- 電文一覧のeventId別画面はfamily NotifierがRealtimeを購読し、種別とeventId一致時だけinvalidateする。
  一覧と詳細キャッシュは別所有者なので、それぞれに更新を接続する。
- EEW詳細は初回API取得前からライブ状態を購読し、取得前の現在値・API応答・取得中の更新を統合する。
  対象eventIdと報番号で照合し、同一報は発表時刻が新しい値、同時刻なら後から統合した値を採用する。
  初期のライブ値よりAPI応答を優先し、取得中の更新を最後に適用する。取得後の同一報番号の訂正・取消も置き換える。
- ライブ状態のLoading・ErrorはEEW詳細のAPI結果を置き換えない。購読エラーはログへ渡し、初回API取得の完了を妨げない。
- EEW詳細地図は`fiveUnknown`（震度5弱以上）も震度別レイヤーの対象とし、震度5弱の色を使う。
- 非同期テストはイベント送出→`container.pump()`→`container.read(provider.future)`で
  完了を待つ。不一致イベントでは取得回数が増えないことも確認する。

## 揺れ検知（端末内検知）

- 揺れ検知はサーバーから配信しない。強震モニタの画像から端末内で計算し、サーバーは通知だけを送る。
  REST `/v2/shake-detection/active` と WebSocket の `shake_detection` は backend から撤去済みで、アプリの API クライアントにも型が無い。
- 検知は `packages/shake_detection_engine`、EEW との結合は `packages/shake_eew_correlator` が担う。
  前者は公開版 KyoshinEewViewer for ingen の `ShakeDetectionEngine`、後者は backend の `packages/event-correlator` の移植で、
  閾値や判定順を変える場合は移植元との差を README に残す。
- エンジンは解析用 Isolate の中で状態を持つ。観測点インデックスは `kyoshinImageObservationPointsProvider` の並びを指し、
  Isolate に渡す観測点と必ず同じ並びにする。
- 検知は地上の震度画像でのみ行う。強震モニタが無効、表示種別が震度以外、地下の場合は検知しない。
  リプレイ再生中は端末内の検知結果を公開しない。
- 端末内検知の有効・無効、履歴の作り直し、検知・結合のパラメータは `ShakeDetectionSettings` に保存し、
  デバッグ画面の「揺れ検知エンジン」で変更する。既定は無効で、production を含むすべてのビルドで有効にできる。
  表示側の判定は `isDeviceShakeDetectionEnabledProvider` を使い、ビルド時の `isShakeDetectionEnabled` を見ない。
  `isShakeDetectionEnabled` はサーバーが送る揺れ検知通知の設定画面と通知チャンネルだけを制御する。
- 有効にするときは、揺れ検知通知と同じ注意事項（`ShakeDetectionNoticeDialog`）への同意を求める。
  同意は通知と共通で、どちらかで同意済みなら再度は求めない。
- 表示する最小レベルと自動ズームは `HomeShakeDetectionSettings`（マップレイヤー設定）に持つ。
  最小レベル未満と期限切れのイベントは `shakeDetectionActiveProvider` で除外し、地図・カード・自動ズームのすべてに反映する。
  自動ズームの対象は `shakeDetectionFocusTargetsProvider` で、EEW の自動ズーム設定とは独立している。
- 最小レベルの選択肢には、検知エンジンの閾値（`ShakeEventLevel.fromIntensity`）に対応する震度の目安を二行目に出す
  （弱い: 震度1程度〜、揺れ: 震度3程度〜、強い: 震度4程度〜、非常に強い: 震度6弱程度〜）。
  一行では選択中の表示が省略されるため改行で分ける。微弱な揺れは下限が無いため目安を出さない。
  通知の最小レベルでは微弱な揺れを「非推奨」と表示し、選んだときに確認ダイアログを出す。
  誤検知の可能性が高く通知の回数も多いためで、地図・カードの表示レベルには適用しない。
- EEW と結合したイベントは、地図とカード（`shakeDetectionVisibleProvider`）からは外すが、自動ズームの対象には残す。
  EEW は震源 1 点しか持たないため、結合した揺れ検知の範囲を合わせて、震源と揺れている範囲の両方を収める。
  ホームボタンによる EEW への再フォーカスは、従来どおり EEW だけを対象にする。
  パラメータの初期値はパッケージ側の値を正とし、アプリには初期値との差分だけを保存する。
  設定を変えると検知結果を破棄し、次のフレームで平常値の取得からやり直す。
- EEW がなく揺れ検知だけの間も、地図のフォーカスは EEW と同じ扱いにする。フォーカス中はホームボタンを無効にし、
  地図を操作すると解除する。解除後は同じ検知イベントの更新では再開せず、新しい検知イベントで再開する。
  解除後のホームボタンは全国表示ではなく検知範囲へ再フォーカスする。EEW 発表中に解除した場合は、
  揺れ検知の追加では再開しない。自動ズームが無効なら揺れ検知はフォーカスの対象にならず、ホームボタンは全国表示へ戻す。
- 上昇量は直近 10 フレームの最新値と最古の有効値の差で、履歴が無い 1 フレーム目は必ず 0 になる。
  起動直後・復帰直後・5 秒以上の時刻の飛び・worker の再起動では、30・90・180 秒前の画像の中央値を平常値として
  最古の標本に投入し、1 フレーム目から検知する。過去フレームをすべて取得できない場合は固定値 1.0 で代用する。
- レベルは震度階級の境界で分ける（`ShakeEventLevel.fromIntensity`）。Weaker: 0.5 未満（震度0以下）、Weak: 0.5 以上（震度1〜2）、
  Medium: 2.5 以上（震度3）、Strong: 3.5 以上（震度4〜5強）、Stronger: 5.5 以上（震度6弱以上）。
  配信側の検知サービス（private `ShakeDetectionServer` の `KyoshinEvent.GetLevel`）とバックエンドの通知判定
  （`getShakeLevelFromIntensity`）と同じ境界で、名称も通知文言に合わせて Medium を「揺れ」とする。
  レベルは確定条件・有効時間・統合距離にも使う。Weaker は 5 点以上、Weak は 4 点以上の観測点で確定し、Medium 以上は即時に確定する。
  このため、観測点が 1 点だけの離島の単独検知は Medium（震度3相当）以上でのみ確定する。
  配信側にある疎な観測網向けの確定緩和は、端末内のエンジンには無い。
- 平常値との差は数十秒から数分の緩やかな雑音の変動も拾う。平常値が窓に残る 9 フレームの間は Medium 以上だけを確定する。
  平常値を最小値にすると雑音で下に偏り誤検知が増えるため、中央値を使う。
- 1 フレーム目を出した後、直前 10 秒の画像を裏で取得し、平常値の投入からその 10 フレームと
  コールドスタート以降のフレームを流し直す（設定で無効にできる）。平常値が窓から外れた状態になるため、
  弱い揺れも通常の条件で確定でき、連続して動いていた場合に近い結果になる。
  作り直す前後で観測点が重なるイベントには同じ ID を引き継ぐ。`createdAt` は早まることがある。
- EEW との結合の時間条件は、観測点ごとの検知時刻（`ShakeEventPointSnapshot.detectedAt`）で判定する。観測点は
  イベントの終了まで増え続けるため、イベントの発生時刻で判定すると後から加わった観測点が P 波到達前として
  対象から外れ、結合が成立しなくなる。震源・発生時刻の誤差を見込み、P 波到達の 5 秒前から認める。
- 震度条件は、観測震度が予測震度を 1.5 を超えて上回らないことだけを確認する。検知するのは初期微動であることが
  多く、主要動の予測震度を 2〜3 下回る（2026-11-17 三陸沖 M4.7 の実画像で確認）。差の絶対値で判定すると
  一致する観測点がほとんど無くなる。
- 結合は、震度を観測できた観測点の全体に対して、時間条件と震度条件の両方を満たす観測点が 0.3 以上の場合に
  成立する。時間条件を満たす観測点だけを分母にすると、震度条件が片側である分、波面がイベントの一部に
  重なっただけの別の EEW も成立する。
- 平常値との差で検知したイベントは検知時刻が揺れ始めより後になる。EEW との結合では時間条件の上限
  （S 波到達 + 30 秒）を適用せず、下限だけを確認する。
- EEW との結合は、表示中の EEW（`eewAliveTelegramProvider`）のうち発生時刻・震源・マグニチュードが揃い、
  取消されていないものを対象にする。backend は最終報で結合を外すが、アプリは最終報の後も EEW を表示している間は
  結合を維持し、EEW の表示が終わった後も揺れが続いていれば揺れ検知として表示する。
- 観測点はイベントの終了まで外さない。上昇が止まった観測点も残り、観測点数と範囲は終了まで減らない。
  すべての観測点の検知期限が過ぎた時点でイベントを終了し、観測点をまとめて解放する。移植元は観測点を個別に外す。
- 観測点の震度は、最新値とは別にイベント中の最大値（`peakIntensity`）を持つ。地図のセルのレベル、カードの地域、
  EEW との結合判定は最大値を使う。収まった観測点が最新値で判定を崩さないようにするためである。
- カードの範囲は、イベントの最大レベルで揺れた観測点の都道府県と地域を出す（KyoshinEewViewer と同じ考え方）。
  要約の規則としきい値は `ShakeDetectionRegionResolver` の定数にまとめている。
  - 要約は `shakeDetectionEventRegionsProvider` で同期的に計算する。イベントは毎フレーム更新されるため、
    イベントを引数にした非同期 provider にすると、更新のたびに読み込み中を挟んでカードの範囲の行が 1 フレーム消える。
    観測点と地域名の対応は `shakeDetectionRegionCatalogProvider` が一度だけ読み込んで保持する。
  - 検知した都道府県が 3 以下: 都道府県ごとに地域の内訳を出す。観測点のある地域の 75% 以上で検知していれば「全域」、
    それ未満は地域名を 3 つまで並べ、残りは「ほか N 地域」とする。
  - 4 以上: 内訳を出さず、地方（EEW の地方予報区の区分）ごとにまとめる。地方内の都道府県の 2/3 以上かつ 2 県以上で
    検知していれば地方名、満たさなければ都道府県名を並べる。
- 強震モニタ観測点の `region_code` は地震情報の細分区域（3 桁）で、名前は震度観測点のパラメータ（`EarthquakeParameter`）から引く。
  JMA コード表の `area_forecast_local_eew` は EEW の府県予報区（4 桁）で別のコード体系のため、引き当てに使えない。
- 表示の期限はエンジンの `expiresAt`（観測点ごとの期限の最大値）を使う。固定 TTL を入れない。
- `IS_SHAKE_DETECTION_ENABLED` は既定 true で、production を含むすべてのビルドで揺れ検知通知を利用できる。
  プランによる制限はなく、無料プランでも設定できる。アプリは `/start` の `plan_constraints.shake_detection` を参照しない。
  backend の設定 API と配信もプランを参照しない。
- `IS_SHAKE_DETECTION_ENABLED=false` のビルドでは、揺れ検知通知の一般向け設定 route と、デバッグの「揺れ検知 Card」「揺れ検知を挿入」を無効にする。
  このビルドでも、デバッグを有効にした Admin 端末は揺れ検知通知を利用できる。
  デバッグ用通知設定 route はデバッグメニューへのアクセス権で開ける。配布別の指定は [配布と CI](delivery_ci.md) を参照する。
- provider test は `BuildConfigFixture` で `buildConfigProvider` を override し、dart-define 未指定の flavor 例外を避ける。

## 地図のデバッグ表示

- デバッグメニューを利用できる場合に限り、マップレイヤー設定の「デバッグ」で、地図に重ねる機能ごとの情報を切り替える。
  設定は `HomeDebugOverlaySettings`、表示は `HomeDebugHud`、各行の組み立ては `HomeDebugHudFormatter` が担う。
- 揺れ検知の表示は未確定のイベントも含め、対象の EEW ごとの結合判定の内訳（一致数・対象数・S 波到達からの時間・震度差）を出す。
  表示している間だけ `shakeDetectionDebugReportProvider` が計算する。
- 機能を追加するときは、`HomeDebugOverlaySettings` に項目、`HomeDebugHudFormatter` に行の組み立て、
  マップレイヤー設定にスイッチを足す。

## EEWカードの外観

対象は `app/lib/feature/home/ui/component/eew/` の `eew_card.dart` と `eew_card_*.dart`（ヘッダー、震源情報、現在地欄、カウントダウン、文字スタイル、配色）。
ホーム、EEW履歴の発表中欄、EEW詳細、デバッグ画面で共用する。

- 配置・文字サイズ・余白・色は Live Activity の Lock Screen（`EewLockScreenView`）の値をそのまま使う。
  幅371ptで並べて描くと、文字の位置は1pt以内、全体の高さは2pt以内で重なる。値を変えるときは両方を変える。
- 現在地欄も Live Activity と同じ出し分けにする。予想震度と到達予想がそろえば地名を省き、`現在地`／`揺れ到達まで` と
  0.1秒単位のカウントダウン（60秒以上は `1:15.3`、到達後は `0秒`）を出す。到達予想が無ければ `現在地` と地名を出す。
  現在地がPLUM法（報全体がPLUM法の場合を含む）なら `すぐに到達` を出す。
- カウントダウンは最長の桁で幅を確保して右寄せにする。小数は0.62倍、`秒` は0.56倍で、`EQCountdown.ttf` と同じ比率。
  時刻の配信は1秒おきなので、その間は経過時間を足して0.1秒の桁を進める。リプレイは再生位置がフレームごとに届くため、
  倍速を掛けた経過時間を足し（一時停止中は足さない）、次のフレームを追い越さないよう1秒までにとどめる。
  シミュレーション再生（EEW詳細）は `clockOverride` に再生時刻を返す関数を渡し、描画のたびに読む。時刻の値を渡すと1秒おきにしか進まない。
- Google Sans Flex は `opsz` を文字サイズに合わせて指定する（`EewCardFlexTextStyle`）。iOS は自動で効くが Flutter は既定値の18のままになり、
  小さい文字の字形と字間が Live Activity とずれる。
- 等幅フォントの小数点は1文字分の幅を取る。Mとカウントダウンは小数点の前後だけ字間を詰める。
- 日本語は Live Activity がシステムのヒラギノ、カードが同梱の Noto Sans JP（Medium・Bold のみ）。太さと字形は一致しない。
- Live Activity と違う点: 現在地の予想震度は値があれば出す（Live Activity は予報なら震度4以上のみ）。
  取消は種別 `(取消)` と本文。長周期地震動階級、透かし、推計震度のフォールバックはカードだけが持つ。
  文字は Text Scale に追従し、見出しは収まらなければ2行になる。
- 地色はダークが黒、ライトが `surfaceContainer`。現在地が警報対象のときは外観に依らず暗い赤と白文字にし、
  `強い揺れに警戒!` の背景を0.5秒おきに点滅させる。アニメーションを減らす設定では塗りっぱなしにする。
- 現在地が警報対象かどうかは、非取消・警報・JMAが発表した現在地の `isWarning` で決める。
  推計震度は警報対象かどうかを持たないため、強調に使わない。
- 過去のEEWを再生する `EewDetailsByEventIdPage` は `emphasizesLocalWarning: false` で強調を切る。現在地への警報と誤解させない。
- `Card` は形の変化を200msかけて補間するため、枠線の色は切り替え直後だけ前の色が残る。
  一時 golden で撮るときは300ms進めてから撮る。
- 見比べ方は [Live Activity](live_activity.md) の「ローカルデバッグとPreview」にある Lock Screen の画像化と、
  [テスト](testing.md) の一時 golden を同じ状態・同じ幅で並べる。

## 確認箇所と検証

コード確認済み: `app/lib/feature/eew/data/eew.dart`の表示保持、
`app/lib/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice.dart`と
`app/ios/Shared/EewDisplay.swift`の厳密な150km境界。その他は維持する契約として集約した。

```sh
# app/から
mise exec -- flutter test test/feature/eew/data test/feature/home/ui/home_eew_card_test.dart --dart-define=CI=true
mise exec -- flutter test test/feature/telegram_list test/feature/shake_detection --dart-define=CI=true
mise exec -- dart analyze lib/feature/eew/data lib/feature/telegram_list
```

シミュレーションは`clock`と`fake_async`で停止・再開・終了を確認する。
APIテストは`packages/eqmonitor_api`から`mise exec -- dart test`を実行する。
