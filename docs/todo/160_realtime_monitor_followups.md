# 揺れ検知・強震モニタの残課題

数値は元の優先度。

## 800: チケット取得失敗後の実機復旧確認

- iOS / Android で端末トークン未登録・読み取り失敗・不正なトークンを確認する。
  チケット要求が送信されず、端末 ID が任意の API は利用できることを確認する。
- 64回以上の接続失敗でも再試行間隔が60秒を維持し、トークン復旧後の再試行、
  background復帰、ネットワーク切替で接続できることを確認する。
- 401を継続した端末でトークンが取得できない理由は、サーバー側ログでは判別できない。
  トークン値を記録せず、端末側で未保存・ストレージ読み取り失敗・解析失敗を切り分ける。
- 修正版配布後に本番の `/v2/realtime/ticket` の401件数と再送間隔を確認する。
  旧バージョンからの大量再送はアプリの修正だけでは即時に止まらない。

## 700: background 復帰時の接続維持と未接続中の REST 取得

対象: `app/lib/core/realtime/`、`app/lib/feature/eew/data/eew.dart`、`app/lib/feature/earthquake_history/data/notifier/`。
仕様は [EEW・リアルタイム更新の契約](../knowledge/eew_realtime.md) を参照する。

- 実機未検証: iOS / Android で数秒〜30秒未満の background から復帰したとき、再接続せず同じ接続で受信を続けること。
- 実機未検証: 30秒以上の background から復帰したとき、即座に再接続し、接続完了まで EEW が1秒周期で取得されること。
- 実機未検証: 機内モードやサーバー停止で未接続のとき、前面では EEW が1秒、地震履歴が10秒周期で取得され、background では止まること。
- 未検証: `/v2/eew/latest` と `/v2/earthquake` が `ETag` を返し、`If-None-Match` に304で応答すること。
  返さない場合は毎回全文を取得する。1秒周期の通信量とサーバー負荷を本番で確認する。
- 未接続中は Dio のログが毎秒出力される。ネットワークはあるが API に届かない場合は、失敗のログも毎秒残る。
  ログの量が問題になる場合は、該当リクエストの出力を抑える。
- チケット取得が401のまま接続できない端末は、前面表示中ずっと EEW を1秒周期で取得する。
  WebSocket の障害時は前面の全端末が同時に REST へ切り替わるため、本番の負荷を確認する。

## 160: 揺れ検知の公開テスト再有効化

- 実機未検証: 揺れ検知が無効な配布ビルドで、Admin ロールかつデバッグモード有効の端末から通知地域・最小レベルを保存できること。再起動時の条件維持、Android の前面・背面通知、権限取得失敗からの再試行、非 Admin・デバッグ無効時の変更抑止も確認する。
- 対象: `.github/workflows/deploy-app.yaml`、`app/lib/core/model/environment.dart`、`app/lib/feature/shake_detection/`。
- iOS external / Android external の `IS_SHAKE_DETECTION_ENABLED=false` を解除し、ホームgrid/card、`/settings/notification/shake` を確認する。
- このflagはclient表示/購読だけを止める。無効ビルドで既登録のserver pushも止める必要があるなら、server抑止または登録設定削除の仕様を決めて配信テストを追加する。
- 完了条件: 配布trackごとの表示/pushの挙動が仕様と一致する。削除済みの揺れ検知履歴が必要なら、RESTを持つ履歴として別途設計する。

## 155: 端末内の揺れ検知

対象: `packages/shake_detection_engine`、`packages/shake_eew_correlator`、`app/lib/feature/shake_detection/`。

- 端末内検知は既定で無効。デバッグ画面の「揺れ検知エンジン」から有効にする。Beta 機能として一般開放するときは、
  一般向けの設定に有効化の導線を置き、同じ注意事項の同意フロー（`ShakeDetectionEnableFlow.ensureAgreed`）を通す。
- 実機未検証: production ビルドで Admin がデバッグ画面から有効にできること、注意事項の同意後に検知が始まること、
  マップレイヤー設定の「表示する揺れの強さ」「揺れ検知時に自動ズーム」が地図・カード・カメラに反映されること。
- 実機未検証: 起動直後・background 復帰直後に揺れている状態で 1 フレーム目から表示されること、平常時の起動で誤検知が出ないこと。
  kmoni の実画像では、平常時 60 回のコールドスタートで確定イベント 0 件、M3.4 の地震の途中 4 時点で 1 フレーム目から検知できた。
- 未検証: 取得元が lmoni のときに 30・90・180 秒前の画像を取得できること。取得できない場合は固定値の平常値になり、
  計測震度 1.2 未満の揺れは 1 フレーム目では検知できない。
- 未検証: EEW との結合を実際の EEW 発表中に確認する。EEW を表示している間は結合を維持し、表示が終わった後も
  揺れが続いていれば揺れ検知として表示される。
- 未検証: 履歴の作り直しは起動・復帰のたびに 10 枚の画像を追加で取得する。実機での通信量と、取得中の表示の変化を確認する。
- 平常値に使う過去フレームの時刻（30・90・180 秒前）はデバッグ画面から変更できない。調整が必要になった時点で設定へ加える。
- 実機未検証: 揺れ検知カードの新しい見た目（EEW カードと同じ構成、都道府県と地域の表示）と、
  地図のデバッグ表示（マップレイヤー設定の「デバッグ」）の配置・可読性。
- 表示種別が震度以外・地下のときは検知しない。検知用に地上の震度画像を別途取得するかを決める。
- レベル境界は公開版の値（4.5 / 2.5 / 0.5 / -1）。サーバーが送る通知のレベルと食い違う場合の扱いを決める。
- 揺れ検知のサーバー配信（`shake_detection` の WebSocket 配信、`/v2/shake-detection/active`）は backend とアプリの Dart 側から撤去済み。
  Swift の EQMonitorAPI（`app/ios/Packages/EQMonitorAPI`）は再生成しておらず、`openapi.json` と生成済みの型に揺れ検知の配信用の定義が残る。
  macOS で `Scripts` の手順に沿って再生成する。
- 実機未検証: 異常値として除外中の観測点が地図に描かれないこと、直近 10 フレームに実測があり最新フレームが欠測の観測点が
  灰色の枠線だけで描かれること（枠表示の設定が「表示しない」でも描く）。iOS / Android の両方で `circle-opacity` と
  `circle-stroke-width` の式が例外にならないことも確認する。

## 150: EQRP リプレイ再生の実機確認と公開

対象: `app/lib/feature/earthquake_replay/`、`packages/earthquake_replay/`、`app/ios/Runner/Info.plist`、`app/android/app/src/main/AndroidManifest.xml`。

- 実機未検証: iOS で Files・AirDrop・メール添付から `.eqrp` を開けること（起動中・コールドスタートの両方）。`Documents/Inbox` の複製が読み込み後に削除されること。
- 実機未検証: Android のファイルアプリから開けること。パスに拡張子を含まない provider（ダウンロードの `msf:` など）は intent-filter に一致しない。必要なら共有（`ACTION_SEND`）からの受け取りを検討する。
- 実機未検証: 再生中の観測点・EEW の波面と到達カウントダウン・コントロールシートの操作、終了後にライブ表示へ戻ること。
- 実機未検証: 端末内の揺れ検知を有効にして再生し、検知の表示・EEW との結合・地図の自動フォーカスが再生時刻に沿って動くこと。シークと終了で検知が残らないこと。
- EQRP の導線はデバッグメニューと OS の「ファイルで開く」のみ。EQRP の作成はデバッグメニューにだけある。設定画面の導線は、Pro 限定の EQRP 作成機能と合わせて公開する。作成時の時刻の規約は [リプレイ再生](../knowledge/earthquake_replay.md) に従う。
- 実機未検証: 「保存済みのリプレイ」で、ファイルの追加、フォルダの移動、名前とフォルダの変更、複数選択での削除、再生ができること。日本語や空白を含む名前でも再生でき、エクスポートが admin デバイスだけに出ること（iPad の共有シートの位置を含む）。
- 実機未検証: 端末の容量表示（`packages/native_plugin`）。iOS は同じ `NSURL` の呼び出しを macOS で実行して確認済み。Android の JNIgen による `StatFs` 呼び出しは、R8 を有効にした release ビルドを含めて未実行。
- 実機未検証: デバッグメニューの「リプレイファイルを作成」で、名前とフォルダを指定した作成と中止ができること。EEW を含む期間で 1003 が格納され再生されること（EEW API の取得は未確認。フレームの時刻に発表時刻を使う点は、バックエンドの `tools/eqrp` と揃っているか未確認）。
- KyoshinEewViewerIngen（YumNumm fork）の `EqMonitorEventMessage` は 1003 の JSON を camelCase の EventMessage として読み、アプリの契約（EEW API の `EewItemWithRelations`）と異なる。KEVi と同じファイルを共有する場合は形式を揃える。
- 完了条件: 上記の実機確認が済み、公開範囲（Pro 限定か）と設定画面の導線が決まっている。

## 150: 強震モニタ過去画像の再生の実機確認

対象: `app/lib/feature/earthquake_replay/`、`app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`。

- 実機未検証: 発生から3時間以内の地震の詳細画面に「強震モニタで再生」が表示され、ホームで観測点・EEW・発生時刻の目印が再生時刻に沿って動くこと。分割表示の詳細ペインからも開始できること。
- 実機未検証: 再生中カードの展開・折りたたみの動き、狭い画面での操作パネルの幅、アニメーションを減らす設定での即時切り替え、読み上げ。
- 実機未検証: 再生中に EEW が発表されたとき、リアルタイムへ戻って通知が出ること。WebSocket 切断中の10秒ごとの確認も含む。
- 未検証: 本番 API が返す `originTimePrecision`。気象庁の電文の発生時刻は分単位のため、分単位では区間を1分延ばしている。秒単位で返る場合は延長が不要になる。
- 未検証: 過去画像の削除が別の日も同じ規則（毎時、その時点の3時間前まで）で走ること。2026-11-23 の1日分だけ計測した。3時間を下回る日があれば、導線を出す範囲（`ReplayKyoshinArchiveWindowResolver.retention`）を短くする。
- 未検証: 中身の小さい画像（約2.6KB、通常は約6KB）が 200 で返った時刻の解析結果。
- 公開範囲は「強震モニタの再生は全利用者、EEW の重ね合わせは Pro」の既定案で実装した。Pro 限定にする場合は導線側で制御する。
- 再生終了後は元の詳細画面へ戻らず、ホームに留まる。

## 150: WebSocket固定heartbeatの実機確認

- サーバ選択で `https://cf.v2.api.eqmonitor.app` を手入力し、保存直後のREST・WebSocket再接続、再起動後のURL復元、既定サーバへの復帰をiOS/Android実機で確認する。カスタムURLでは既存の環境チェックによりGoogle・Apple・Passkey認証は利用できないため、Workersへの全面切替には認証の対応と検証が別途必要。
- iOS/Android実機で、デバッグ画面を開かずにNodeとDurable Objectsそれぞれの接続を維持できることを確認する。
- background復帰・ネットワーク切替後の再接続と、デバッグ画面のRTT表示を確認する。
- 新サーバーを旧アプリへ公開する前に、queryのないlegacy接続でserver pingが継続し、30秒の無受信監視で切断されないことを確認する。

## 080: 強震モニタ data 層

対象: `app/lib/feature/kyoshin_monitor/data/`。

- 高: Android実機で、保存済みの取得元が `kmoni` の状態から更新し、時刻・観測点の表示を確認する。
  `network_security_config.xml` で `www.kmoni.bosai.go.jp` のHTTP通信を許可しているが、
  Cronetでの取得と報告端末での復旧は未検証。`lmoni` への切替と再起動後の表示も確認する。
- 高: `KyoshinMonitorNotifier._fetchAndAnalyzeImage` を注入可能な専用クラスへ分離し、毎秒 `AsyncLoading` に戻す点滅を解消する。補正量の正本をSettings/Adjustmentで二重化せず、永続化をRepositoryへ集約する。
- 高: 時刻同期エンジン（初回即時→連続測定→画像取得による二分探索の較正）を実機で確認する。起動から収束までの時間、較正後の404頻度、kmoni/長周期の切替、background復帰、端末時計＋30秒と小数秒のNTP offsetを見る。`timer_stream` の秒境界はappClock基準へ修正済みだが、発行時刻の契約テストは未作成。
- 中: `KyoshinMonitorTimerNotifier` のTimer/StreamControllerと `unawaited` バースト、`delayAdjustType` の4値/2挙動を整理する。`lastUpdatedAt` をappClockへ揃え、未使用色mapファイル3件の参照を確認して削除する。
- 中: lmoniを既定にした状態で長周期階級・周期別画像の実機表示を確認する。最低震度フィルターに影響されないこと、地表固定、種類切替後の更新を確認する。EEW発表中のP/S波画像は未検証。
- 低: 遅延設定UIをhomeから `kyoshin_monitor/ui` へ移す。Mutation/flowは副作用・画面遷移の実際の必要に合わせて導入する。
- 完了条件: 画像取得/解析、遅延判定、時計補正、破棄時のtimer終了をテストでき、毎秒表示を消さずに更新できる。
