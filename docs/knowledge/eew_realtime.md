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
- 最終報は`最終 第N報`。Flutterは到達後を`主要動`＋`到達済み`とする。
  Live Activityはシステムタイマーの制約により`主要動到達まで`＋`00:00`を維持する。

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

## 再生と派生画面

- 履歴シミュレーションの報切替、P/S波、カードは共通の再生経過時間を参照する。
  pause時に確定、resume時に実時計基準だけ更新し、最終報では位置を固定する。
- 次報タイマーは共通再生位置から残り時間を求める。Widgetで独自に`DateTime.now()`を引かない。
- 過去のリプレイ注入で時刻をシフトする方式では、report/origin/arrivalだけでなく
  `forecastIntensity.regions[].arrivalTime.value`にも同じoffsetが必要だった。
  現在の共通clock方式へ旧debug実装のパスや欠損値補完を無条件に持ち込まない。
- eventId別画面はfamily NotifierがRealtimeを購読し、種別とeventId一致時だけinvalidateする。
  一覧と詳細キャッシュは別所有者なので、それぞれに更新を接続する。
- 非同期テストはイベント送出→`container.pump()`→`container.read(provider.future)`で
  完了を待つ。不一致イベントでは取得回数が増えないことも確認する。

## 揺れ検知snapshot

- REST `/v2/shake-detection/active`とWebSocketはactive全件の完全snapshot。
  採用した一覧で置換し、空配列は全削除。初回revision 0は採用し、以後は厳密な増加だけ採用する。
- ready後にREST同期するが、取得中もWebSocketを受理し、両方を同じrevision reducerへ渡す。
  REST完了順で上書きせず、WebSocket受理だけではREST同期世代を失効させない。
- repeated ready、disconnect、time-shift、disposeでは同期世代を更新し、遅延結果を無効化する。
- expiryはサーバーの`expiresAt`、EEW相関は`correlatedEew.eventId`を使う。
  固定TTL・アプリ独自相関・未知levelを弱い値へ置換する処理を入れない。
- time-shift自動復帰のbaselineは採用済みcanonical snapshot。通常復帰では保持する。
  disconnectでは破棄し、reconnectのconnected時に保持中snapshotから明示的に再確立する。
- 既知IDの更新・削除・同一接続での再出現は新規イベントとして自動復帰させない。
- `IS_SHAKE_DETECTION_ENABLED` は既定 true。無効時は canonical snapshot で REST/WS 購読と適用を止め、debug overlay 経由の表示や設定 route も無効にする。配布別の指定は [配布と CI](delivery_ci.md) を参照する。
- provider test は `BuildConfigFixture` で `buildConfigProvider` を override し、dart-define 未指定の flavor 例外を避ける。

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
