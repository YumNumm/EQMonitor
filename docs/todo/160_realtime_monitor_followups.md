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

## 160: 揺れ検知の公開テスト再有効化

- 実機未検証: 揺れ検知が無効な配布ビルドで、Admin ロールかつデバッグモード有効の端末から通知地域・最小レベルを保存できること。再起動時の条件維持、Android の前面・背面通知、権限取得失敗からの再試行、非 Admin・デバッグ無効時の変更抑止も確認する。
- 対象: `.github/workflows/deploy-app.yaml`、`app/lib/core/model/environment.dart`、`app/lib/feature/shake_detection/`。
- iOS external / Android external の `IS_SHAKE_DETECTION_ENABLED=false` を解除し、ホームgrid/card、timeshift自動復帰、`/settings/notification/shake` を確認する。
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
- リプレイ再生では検知しない。再生画像を同じエンジンへ流すかを決める。
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
- 導線はデバッグメニューと OS の「ファイルで開く」のみ。設定画面の導線は、Pro 限定の EQRP 作成機能と合わせて公開する。作成時の時刻の規約は [リプレイ再生](../knowledge/earthquake_replay.md) に従う。
- KyoshinEewViewerIngen（YumNumm fork）の `EqMonitorEventMessage` は 1003 の JSON を camelCase の EventMessage として読み、アプリの契約（EEW API の `EewItemWithRelations`）と異なる。KEVi と同じファイルを共有する場合は形式を揃える。
- 完了条件: 上記の実機確認が済み、公開範囲（Pro 限定か）と設定画面の導線が決まっている。

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
