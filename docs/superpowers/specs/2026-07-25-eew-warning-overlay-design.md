# アプリ使用中の緊急地震速報警報 overlay 設計

日付: 2026-07-25
状態: ユーザー承認済み

## 目的

アプリを使用中、現在地が緊急地震速報「警報」の対象地域になったことを、
全画面 overlay とバイブレーションで即座に知らせる。10秒後は画面操作を妨げない
上部バナーへ最小化し、警報が無効になった時点で表示を消す。

## スコープ

- アプリが foreground にある時だけ表示するアプリ内 UI
- 現在地に対応する細分区域が警報対象かを判定
- 全画面表示、最小化バナー、再展開、明示的な閉じる操作
- 複数の有効な警報を1画面に集約し、代表イベントを選択
- 最大10秒のパルス状バイブレーション
- 設定で機能全体を有効・無効化（既定は有効）
- 設定画面から実行できる固定データのシミュレーション

以下はスコープ外とする。

- background・アプリ終了中の全画面通知や OS 通知
- 音声・警報音
- 「伏せる、頭を守る」などの安全行動案内
- 複数イベントの並列表示やイベント切替 UI
- 地域を解決できない場合の全国判定・固定地域フォールバック
- 地震リプレイ中の実警報 overlay

## 採用アーキテクチャ

`MaterialApp.router` の `builder` に宣言的な root overlay host を置く。
ページやルートに依存せず、Riverpod の表示状態から全画面またはバナーを描画する。
`OverlayEntry` の手動管理やダイアログ・専用ルートは採用しない。

機能は既存の `feature/eew` 配下へ、責務ごとに分割する。

- candidate provider: EEW、現在地域、realtime 状態から対象イベントを抽出
- display model provider: 代表イベント、集約地域、現在地予想震度、到達情報を整形
- overlay notifier: 表示状態、既知 eventId、タイマー、ユーザー操作、lifecycle を管理
- vibration service: 端末機能を抽象化し、開始・停止を notifier から制御
- simulation notifier: 実データを変更せず固定の訓練表示を要求
- root overlay host: 全画面と最小化バナーの描画だけを担当

`eewProvider` や location provider 自体には overlay 固有状態を混ぜない。

## 入力データと対象判定

実警報は次をすべて満たすイベントだけを候補とする。

1. `isRealtimeModeProvider` が realtime
2. 機能設定が有効
3. `eewProvider` に存在する
4. 生存判定上有効で、取消・期限切れではない
5. `isWarning` が true
6. 現在地から JMA の緊急地震速報用細分区域 `areaForecastLocalEew` を解決できる
7. 解決した区域 code が `event.warning.regions.where((e) => e.hadWarning)` に含まれる

現在地・権限・区域解決が loading/error/不明の場合は表示しない。解決後に対象であれば、
未処理の eventId として通常どおり表示する。対象地域から外れた場合は即座に消し、
同じイベント中に再び対象地域へ入っても再度の全画面表示は行わない。

イベントは、次のいずれかになれば無効と扱う。

- provider から削除
- 取消
- 警報ではなくなる
- 現在地域が警報対象から外れる
- alive 判定の期限切れ

無効化時は overlay とバイブレーションを即座に停止する。

## 複数イベントの集約と優先順位

対象イベントが複数あっても overlay は1つだけ表示する。全候補の警報地域名を重複なく
まとめ、画面の詳細値には代表イベントを使用する。代表イベントは次の辞書順で決める。

1. 現在地への主要動が未到達
2. 到達時刻が不明
3. 主要動が到達済み
4. 同じ到達区分なら現在地の予想震度が大きい
5. 同じ予想震度なら `reportTime` が新しい
6. 最後は `eventId` で安定的に決定

後続報や別イベントの追加・無効化ごとに代表イベントと集約内容を再評価する。
新しい eventId が追加された場合は、現在の表示状態にかかわらず全画面へ展開して
バイブレーションを開始する。既存 eventId の更新は内容だけを更新し、再通知しない。

## 状態遷移

表示状態は `hidden`、`fullscreen`、`minimized` の3状態とする。

- 未処理の対象 eventId を検出: `fullscreen`、10秒タイマーと振動を開始
- 10秒経過: `fullscreen` から `minimized`、振動停止
- 「最小化」または Android back: 即座に `minimized`、振動停止
- 「閉じる」またはバナーの閉じるアイコン: `hidden`、振動停止
- バナー本体をタップ: `fullscreen`。自動最小化せず、再振動もしない
- 全候補が無効: `hidden`、振動停止
- foreground から離脱: 全画面なら `minimized` 相当として保持し、振動停止
- resume: 既知の警報だけならバナー、新しい未処理 eventId があれば全画面と振動

閉じる操作は、その時点で把握している有効イベント群をまとめて処理済みにする。
閉じた直後に次順位の既知イベントを表示することはない。後から追加された新しい eventId
だけが再通知の契機になる。処理済み eventId はメモリ内だけで保持し、アプリ再起動後に
有効な警報が残っていれば再表示してよい。

## 全画面 UI

参考画像の「強い警告色、短い見出し、重要値を大きく見せる」構成だけを取り入れ、
EQMonitor の Material 3 テーマに合わせる。

- 最上部に赤・黒系の警告ストライプを約10 logical pxで表示
- ストライプ背景は SafeArea 外の status bar 領域まで広げる
- 本文と操作ボタンは SafeArea 内に配置
- `緊急地震速報（警報） 第N報` を表示
- 次の2行を最も強く強調する
  - `○○で地震`
  - `△△ □□ ◇◇で強い揺れ`
- 警報地域は半角スペース区切りで一続きにし、末尾の「で強い揺れ」は1回だけ付ける
- 現在地の予想震度を大きく表示
- 主要動は「あと約N秒」または「到達と推定」と表示。不明時は断定しない
- 現在地域、震源、M、深さを補助情報として表示
- 複数時は「N件の警報から代表表示」と示す
- 下部に「最小化」「閉じる」を固定配置

長い地域名や text scale 拡大時は本文だけをスクロール可能にし、操作ボタンは常に画面内へ
残す。テキストを含む領域に固定高を設けない。Light/Dark とアクセシビリティに対応する。

見出しは backend の Live Activity と同じ構造を採用し、完成済み文字列の分割ではなく、
短縮震源名と警報地域の構造化データから組み立てる。アプリ側では短縮震源名を
`hypocenter?.detailedName ?? hypocenter?.name`、見出し地域を
`warning.zones.where((e) => e.hadWarning)` から得る。backend の `isLevel` 相当はアプリモデルに
直接存在しないため、`accuracy?.epicenter == 1 && originTime == null` から明示的に導出する。
PLUM 法・レベル法または震源不明時は不正確な震源を強調せず、地域側の
「○○で強い揺れ」を主見出しにする。地域も得られない場合だけ、overlay 独自の安全な
fallback として「強い揺れに警戒」を使用する。

## 最小化バナー

画面最上部へ固定し、現在のページ上に重ねる。警報ラベル、短い見出し、現在地予想震度、
到達状況を簡潔に示す。バナー全体のタップで全画面へ再展開し、末尾の閉じるアイコンで
表示を終了する。全画面と同じ警告色を使うが、通常操作を大きく覆わない高さにする。

## バイブレーション

対応端末では `700ms 振動 + 300ms 停止` を最大10秒間繰り返す。
閉じる、最小化、無効化、background 遷移のいずれでも直ちに cancel する。
再展開では開始しない。端末非対応、OS 設定による無効、API エラー時も画面表示は継続し、
例外はユーザー向け本文へ出さず talker に記録する。

実装時は vibration package の capability API を service 内に閉じ込め、Android 権限設定と
iOS の haptics 制約を各プラットフォームで確認する。

## 設定とシミュレーション

通常の設定画面に「アプリ使用中の緊急地震速報警報」toggle を追加する。既定は有効。
無効化すると全画面、バナー、バイブレーションをまとめて停止する。保存キーは
`SharedPreferencesKey` enum に追加し、文字列を利用箇所へ直書きしない。

同じ設定画面から、toggle が無効でもシミュレーションを実行できる。シミュレーションは
`eewProvider` と location provider を変更せず、次の固定訓練データを専用 notifier へ渡す。

- `訓練／シミュレーション`
- `テスト震源で地震`
- `テスト地域で強い揺れ`
- `予想震度6弱`
- `あと約10秒`

シミュレーション中に実警報が対象になった場合は、実警報を優先して置き換える。
シミュレーション終了後に自動で訓練画面へ戻さない。

## 検証方針

ユーザー要望により Widget test は追加しない。ロジックを Widget から分離し、次を unit /
provider / notifier test で検証する。

- 対象区域、警報状態、realtime 状態による候補抽出
- 到達区分、予想震度、時刻、eventId による代表選択
- 同一 eventId の再通知抑止と、後続報による表示内容更新
- 複数イベントを閉じた後に次順位を表示しないこと
- 新しい eventId による全画面再展開
- fake clock による10秒後の最小化と、再展開後は自動最小化しないこと
- fake vibration service による開始・各停止条件・再展開時非開始
- location 離脱・再進入、lifecycle、無効化の状態遷移
- 設定の既定値・永続化・無効化
- シミュレーションが provider を汚染せず、実警報に優先されること

実機またはシミュレーション UI で、SafeArea、長い地域名、text scale、Light/Dark、
Android back、実際の振動開始・停止を手動確認する。

## 主な既存接続点

- `app/lib/app.dart`: root overlay host
- `app/lib/feature/eew/data/eew.dart`: EEW 一覧
- `app/lib/feature/eew/data/eew_alive_telegram.dart`: 生存判定
- `app/lib/feature/location/data/location.dart`: 現在地
- `app/lib/feature/location/data/nearest_jma_feature.dart`: EEW 用区域
- `app/lib/core/component/decoration/warning_stripe_decoration.dart`: 警告ストライプ
- `app/lib/core/data/preferences/shared/shared_preferences_key.dart`: 設定キー
