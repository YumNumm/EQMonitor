# LiveMonitor モード設計

## 目的

HomeSheet や通常の地図操作ボタンを持たず、地震関連情報を常時表示する「LiveMonitor モード」を追加する。

通常時は強震モニタを表示し、EEW、EEW に結合されていない揺れ検知、VXSE51・VXSE52・VXSE53・VXSE61・VXSE62、推計震度の受信に応じて、同じ画面内で表示内容と地図のフォーカスを自動的に変更する。イベントによる画面切り替えにはルーターを使わない。

自動切り替え表示に加え、リアルタイム情報と最新地震情報を同時に表示する画面分割モードを提供する。

## 対象範囲

- スマートフォンとタブレットの縦画面・横画面に対応する。
- HomeSheet に LiveMonitor モードの起動 Card を追加する。
- 自動切り替えモードと画面分割モードを提供する。
- 表示方式、地震情報表示時間、画面点灯維持、縦横別の分割割合を永続化する。
- LiveMonitor モード中は既存 EEW 警報 overlay の視覚表示だけを抑止する。
- 既存の EEW、揺れ検知、地震履歴、Realtime、強震モニタのデータ経路を再利用する。
- EEW と未結合揺れ検知を同時に収めるフォーカス規則は、通常の HomeMap にも適用する。

## 対象外

- TTS 読み上げと効果音再生そのものは実装しない。
- TTS・効果音を含むアプリ全体のイベント演出基盤は再設計しない。
- LiveMonitor モード内のイベント表示にルーターを使用しない。
- 新規 Widget テストは作成しない。

将来の TTS・効果音が表示 UI に依存しないよう、検出済みイベントを購読できる境界は用意する。

## 確定済み UX

### 名称と入口

- 名称は「LiveMonitor モード」とする。
- HomeSheet に専用 Card を追加する。
- Card をタップすると、前回選択した表示方式で専用画面を開く。
- モード内のイベント切り替えは専用画面の状態変更として行う。

### 対応する表示方式

#### 自動切り替え

- 通常時は強震モニタを表示する。
- EEW だけがある場合は、すべての有効な EEW が収まる範囲へ地図を移動する。
- EEW に結合されていない揺れ検知だけがある場合は、すべての未結合揺れ検知が収まる範囲へ地図を移動する。
- EEW と未結合揺れ検知の両方がある場合は、両方の全対象が同時に収まる範囲へ地図を移動する。
- どちらもない場合は、ユーザーが Home 地図設定で保存した既定範囲を表示する。
- VXSE51・VXSE52・VXSE53・VXSE61・VXSE62、または推計震度受信時は、同じ MapLibre 地図を地震情報用レイヤーへ切り替え、対象地震へフォーカスする。
- 地図の下部に、現在の状態に対応する情報 Card を表示する。

#### 画面分割

- 縦画面では上をリアルタイム Pane、下を最新地震 Pane とする。
- 横画面では左をリアルタイム Pane、右を最新地震 Pane とする。
- リアルタイム Pane は強震モニタ、EEW、未結合揺れ検知を表示する。
- 最新地震 Pane は地震専用地図と最新地震 Card を表示する。
- 最新地震は、モードを開く前に発表済みの情報を API から取得し、その後 Realtime で更新する。
- 「最新」は全国一覧を eventId 降順に並べた先頭の地震とする。過去地震への新しい電文追加だけで、より新しい eventId の地震を押しのけない。
- 最新情報が古くても隠さず、発表時刻と経過時間を明示する。

### 分割割合

- Divider のドラッグにより、リアルタイム Pane を 20% から 80% の範囲で連続的に変更できる。
- 残りの領域を最新地震 Pane が使用する。
- ドラッグ中は MapLibre Widget を再生成せず、両 Pane の制約だけを更新する。
- ドラッグ終了時に割合を保存する。
- 縦画面と横画面の割合を別々に保存する。
- 初期値は縦横とも 50% とする。
- Divider は細く表示するが、タッチ対象領域は十分な大きさを確保する。

### コントロールパネル

- 移動を伴わない画面タップでコントロールパネルを表示する。地図の pan・pinch・回転と Divider のドラッグでは表示しない。
- パネルは自動では閉じない。
- 明示的な閉じるボタンでパネルを閉じる。背景 barrier のタップでは閉じない。
- パネル表示中は背面の地図操作を受け付けない。
- パネルには次の操作を置く。
  - 自動切り替え・画面分割の変更
  - 地震情報表示時間の入力
  - 画面点灯維持の切り替え
  - パネルを閉じる
  - LiveMonitor モードを終了する
- 端末の戻る操作では終了確認を表示する。
- パネル内の終了操作でも同じ終了確認を表示する。
- 安全上の例外として、新規 EEW eventId を受信した場合は表示中のパネルを即座に閉じ、リアルタイム表示へフォーカスする。

### 永続設定

次の値を保存する。

- 表示方式。初期値は自動切り替え。
- 地震情報表示時間。初期値は 10 秒。
- 画面点灯維持。初期値は有効。
- 縦画面のリアルタイム Pane 比率。初期値は 0.5。
- 横画面のリアルタイム Pane 比率。初期値は 0.5。

地震情報表示時間は整数の直接入力とし、3 秒から 300 秒だけを受理する。空文字、小数、範囲外の値は保存せず、入力欄の近くに説明を表示する。

表示時間の変更は次に受信する VXSE5x・VXSE6x・推計震度から適用し、すでに表示中の地震情報の期限は変更しない。画面点灯維持と表示方式の変更は保存後すぐに反映する。

SharedPreferences のキーは `SharedPreferencesKey` enum に追加し、文字列を機能コードへ直接記述しない。

## アーキテクチャ

### feature 境界

新しい実装は `app/lib/feature/live_monitor/` に配置する。

```text
feature/live_monitor/
├── data/
│   ├── model/
│   ├── notifier/
│   ├── provider/
│   ├── service/
│   └── logic/
└── ui/
    ├── action/
    ├── components/
    └── page/
```

責務を次の単位へ分割する。

- `LiveMonitorCoordinator`: Provider を購読し、現在の自動表示状態を保持する。
- `LiveMonitorTransitionPolicy`: 現在状態、イベント、現在時刻から次の状態と予約動作を決める純粋ロジック。
- `LiveMonitorEventDetector`: 初期値、Realtime、REST 同期から新規・更新・重複を判定する。
- `LiveMonitorScheduler`: 最低表示期限と通常終了期限の callback を予約・取消する。
- `SeismicMapFocusBuilder`: EEW、未結合揺れ検知、既定範囲から共通のリアルタイムカメラ対象を構築し、通常の HomeMap と LiveMonitor の双方から利用する。
- `LiveMonitorEarthquakeMapFocusBuilder`: 地震の震源、有感観測点、Card 領域から LiveMonitor の地震カメラ対象と padding を構築する。
- `LiveMonitorSettingsNotifier`: 永続設定の読み書きを担当する。
- `LiveMonitorWakeLockController`: アプリ lifecycle と設定に応じて画面点灯維持を制御する。
- `LiveMonitorSessionNotifier`: モードが表示中かをアプリ全体へ公開する。

Widget は表示と入力へ限定し、イベント優先度、期限計算、重複排除、カメラ範囲計算を持たない。

### 表示状態

自動切り替えの状態は次の 2 種類とする。

```text
realtime
earthquake(eventId, trigger, earthquake, shownAt, minimumUntil, expiresAt)
```

画面分割モードでは自動表示状態を使って Pane を入れ替えず、リアルタイム Pane と最新地震 Pane を常時更新する。

### データ入力

既存の次の経路を利用する。

- EEW: `eewProvider`、`eewAliveTelegramProvider`、`RealtimeEewUpsertEvent`
- 揺れ検知: accepted snapshot と `shakeDetectionVisibleProvider`
- 地震: `earthquakeHistoryProvider`、`earthquakeHistoryDetailsProvider`、`RealtimeEarthquakeUpsertEvent`、`RealtimeEstimatedIntensityUpsertEvent`
- 接続状態: `eqMonitorWsStatusProvider`
- 地図スタイルと強震モニタ: 既存 Home 地図と同じ Provider・Layer

最新地震の初期表示は、既存地震履歴一覧の最新 eventId を取得し、既存詳細 Provider から full `Earthquake` を得る。LiveMonitor モード専用の重複 API 経路は作らない。

## イベント検出

### EEW

`eventId -> serialNo` を追跡する。

- 初回購読時の有効 EEW は基準値として登録する。
- 未知の eventId は新規 EEW とする。
- 既知の eventId で serialNo が増えた場合は既存 EEW 更新とする。
- 同じまたは古い serialNo は表示トリガーにしない。

初回に有効な EEW が存在する場合、リアルタイム Pane はその EEW を表示・フォーカスするが、新規受信演出としては扱わない。

### 揺れ検知

未結合かつ期限内のイベントだけを対象にし、`eventId -> serialNo` を追跡する。

- 未知の eventId または増加した serialNo を揺れ検知トリガーとする。
- EEW と結合されたイベント、期限切れイベント、古い snapshot は対象外とする。
- snapshot 全体の revision とイベント単位の serialNo の両方で重複を排除する。

### 地震情報と推計震度

full Earthquake の telegram metadata から `(type, reportedAt)` を追跡する。推計震度は Realtime event の `(eventId, estimatedIntensityTile)` を追跡する。Realtime event の `estimatedIntensityTile` は API の `estimatedIntensityKey` に由来する識別値であり、地図へ直接渡せる URL とはみなさない。

- 新しく追加された VXSE51、VXSE52、VXSE53、VXSE61、VXSE62 を表示トリガーとする。
- 新しい `RealtimeEstimatedIntensityUpsertEvent` を表示トリガーとする。
- 同じ metadata を WebSocket と REST の両方で受けても一度だけ処理する。
- 同じ推計震度識別値の再配信は表示トリガーにしない。
- 同一 eventId の新しい VXSE5x・VXSE6x・推計震度は表示内容を更新する。
- 別 eventId の新しい VXSE5x・VXSE6x・推計震度は現在の地震表示を置き換える。
- VXSE61 では更新された震源要素、VXSE62 では長周期地震動階級、推計震度では推計震度レイヤーを初期表示内容とする。
- 推計震度 event が指す full Earthquake がメモリにない場合は、既存詳細取得経路で eventId の詳細を取得してから表示期限を開始する。地図には full `Earthquake.estimatedIntensityTileUrl` だけを使用し、識別値から URL を独自生成しない。不完全な地震 Card を固定値で補完しない。

初回 API 取得で得た最新地震と、その full `Earthquake` が持つ既存の推計震度 URL は画面分割モードへ表示するが、自動切り替えのトリガーにはしない。

## 自動切り替え規則

地震情報の最低表示時間は固定で 3 秒とする。通常表示時間は設定値を使い、初期値は 10 秒とする。

| 現在状態 | 入力 | 動作 |
| --- | --- | --- |
| realtime | 新しい VXSE5x・VXSE6x・推計震度 | earthquake へ切り替え、最低期限と通常期限を開始 |
| earthquake | 同一地震の新しい VXSE5x・VXSE6x・推計震度 | 内容と trigger を置換し、3 秒と設定時間を最初から開始 |
| earthquake | 別地震の新しい VXSE5x・VXSE6x・推計震度 | 対象と trigger を置換し、3 秒と設定時間を最初から開始 |
| earthquake | 新規 EEW eventId | 最低期限中でも即座に realtime へ戻る |
| earthquake | 既存 EEW の serial 更新 | 3 秒経過済みなら即時、未経過なら最低期限到達時に realtime へ戻る |
| earthquake | 未結合揺れ検知 | 3 秒経過済みなら即時、未経過なら最低期限到達時に realtime へ戻る |
| earthquake | 通常期限到達 | realtime へ戻る |
| earthquake | 表示中の地震が削除 | realtime へ戻る |

中断された地震情報は再表示しない。最低期限中に複数の realtime 復帰トリガーを受けた場合、待機するのは「最低期限到達時に最新 realtime 状態へ戻る」という 1 動作だけとする。

Scheduler の task には世代番号を持たせる。新しい地震表示、更新、割り込み、モード変更、画面破棄のたびに世代を進め、古い task が新しい状態を変更できないようにする。

自動切り替えから画面分割へ変更する場合は、地震表示の task と待機中の realtime 復帰を取り消す。画面分割から自動切り替えへ変更する場合は realtime 状態から開始し、その時点で有効な EEW と未結合揺れ検知へフォーカスする。分割表示中の地震情報を自動切り替えへ引き継がない。

## 地図と Pane

### 共通 MapLibre host

MapLibre 本体、style、操作 Queue、controller lifecycle を扱う共通 host を用意し、その上へ用途別 Layer 群を配置する。

- `LiveMonitorRealtimeLayers`: 強震モニタ、EEW 予測地域、P/S 波、EEW 震源、未結合揺れ検知。
- `LiveMonitorEarthquakeLayers`: 地震震源、震度、観測点、推計震度など、対象地震に存在する情報。

自動切り替えでは MapLibre host を 1 枚維持し、Layer 群とカメラ対象を切り替える。画面分割では独立した host、controller、操作 Queue を 2 組持つ。

表示方式変更、style 変更、画面破棄、端末回転の順序が入れ替わっても、古い controller の dispose が新しい controller を消さないよう、controller identity を検証して解除する。

### カメラ

通常の HomeMap と LiveMonitor のリアルタイム表示では、同じ純粋ロジックを使い、次の対象をすべて含む bounds を作る。

- 有効な EEW の有効な震源座標
- EEW に結合されていない有効な揺れ検知範囲

EEW だけ、未結合揺れ検知だけ、両方のいずれも同じ計算入口を使う。対象がない場合は保存済みの Home 地図範囲を使う。対象座標が一部欠けている場合、その対象だけを bounds 計算から除外し、固定座標で補完しない。通常の HomeMap と LiveMonitor は camera controller や画面状態を共有せず、フォーカス対象を算出する純粋ロジックだけを共有する。

地震表示では、震源と震度 1 以上のすべての有感観測点を bounds に含める。震度 0、震度不明、座標不明の観測点は除外する。震源または有感観測点の一方しかない場合は存在する対象から bounds を作り、どちらもない場合は保存済みの Home 地図範囲を使う。

自動フォーカスによる最大 zoom は 8 とする。これは EEW、未結合揺れ検知、地震情報、既定範囲への自動移動だけに適用し、ユーザーの pan・pinch 等の手動操作には適用しない。手動操作の最大 zoom は既存の Home 地図設定を維持する。単一点や近接点だけでも、自動フォーカスによって zoom 8 を超えない。

地震表示では、SafeArea 内の左上に置く発表時刻 Card と画面下部の震源情報 Card の実測領域を fitBounds の padding に反映し、震源と有感観測点が Card の裏へ隠れないようにする。リアルタイム表示でも、Card が地図を隠す領域を測定して padding に反映する。

コントロールパネルが隠れている間は、既存 Home 地図設定に従って pan、zoom、回転などの地図 gesture を利用できる。

### SafeArea

MapLibre とその gesture 対象領域は画面端まで広げ、ノッチ、ステータスバー、ホームインジケータを含む SafeArea 外にも地図を描画する。SafeArea を画面全体や MapLibre host へ適用しない。

発表時刻 Card、震源情報 Card、リアルタイム Card、接続状態、コントロールパネル、終了操作など、読取・操作が必要な UI overlay だけを SafeArea 内へ配置する。画面分割時も各 Pane の地図は Pane 全体へ描画し、overlay のみ安全領域を考慮する。

## 情報 Card

### リアルタイム Card

- EEW Card を先に表示し、新しく更新されたものを上へ置く。
- 続けて未結合揺れ検知 Card を新しい順に表示する。
- すべての Card を縦に積む。
- Card 領域は表示中 Pane の 50% を上限とし、超えた場合だけ内部をスクロール可能にする。
- EEW と揺れ検知の全対象を地図 bounds に含める。

### 地震情報 Card

画面下部には、既存の `EarthquakeHypocenterInformationCard` を変更せず、そのまま再利用する。LiveMonitor 専用の大きな地震 Card は表示しない。地域ごとの震度、現在地震度、長周期地震動階級、推計震度の補助概要をこの Card へ追加しない。震度・長周期地震動・推計震度そのものは、対象データがある場合に地図レイヤーで表現する。

最新の発表時刻は震源情報 Card から分離し、SafeArea 内の地図左上に小さな Card として表示する。文言は `yyyy/MM/dd HH:mm 発表 (5時間07分前)` の形式とし、分は 2 桁、時間は 24 時間を超えても日数へ丸めず累積時間で表す。相対時刻は表示中に 1 分ごとに更新する。発表時刻を取得できない場合は、推測値や固定値で補完せず、発表時刻 Card 自体を表示しない。

自動切り替えと画面分割の最新地震 Pane は同じ Card 構成を使う。詳細一覧、地域震度一覧、近傍地震、広告、データソース切り替えは表示しない。

## Realtime 再同期と lifecycle

イベント検出を WebSocket メッセージだけに依存させない。REST 同期後の正規化済み state も比較し、WebSocket と REST のどちらから到着しても同じ検出入口へ渡す。

- 初回 state は基準値として登録し、過去情報を自動表示しない。
- WebSocket 再接続後は REST で欠落を補完し、基準値との差分だけを処理する。
- バックグラウンド中に発生した新規 EEW は、復帰時に新規 EEW として扱う。
- バックグラウンド中に追加された VXSE5x・VXSE6x・推計震度は、復帰時に地震表示へ切り替える。
- バックグラウンド中に変化した揺れ検知は、最新 snapshot との差分として扱う。
- 復帰時は現在時刻と期限を再評価し、バックグラウンド中に失効した表示を復活させない。

## EEW 警報 overlay と画面点灯

`LiveMonitorSessionNotifier` は LiveMonitor モードの mount・dispose に合わせて active 状態を公開する。

既存 EEW 警報は候補選択、表示状態、振動処理を継続する。`EewWarningOverlayHost` の描画だけが session active を参照し、LiveMonitor モード中は fullscreen と banner を描画しない。これにより振動と将来の TTS・効果音を視覚表示から分離する。

画面点灯維持は専用 service を通して制御する。

- 設定が有効かつアプリが foreground の間だけ有効化する。
- background 移行時、モード終了時、Widget dispose 時に解除する。
- foreground 復帰時に設定を再評価する。
- platform 呼び出し失敗時は現在表示を継続し、talker へ記録する。

## エラー表示

- WebSocket が接続中・再接続中の場合、画面上端に小さな状態表示を出す。
- 接続回復後は状態表示を自動的に消す。
- 例外文字列をそのまま画面へ表示しない。
- 地震情報の更新に失敗し、キャッシュがある場合は以前の情報を維持して更新失敗を表示する。
- キャッシュがない場合は地震 Pane に再試行可能な空状態を表示する。
- 一方の MapLibre host が初期化に失敗しても、他方の Pane は表示を継続する。
- Map style 再読込中は直前の表示を可能な範囲で保持する。
- 詳細なエラーは talker へ記録する。

## パフォーマンスとアクセシビリティ

- 自動切り替えでは MapLibre host を 1 枚だけ保持する。
- 分割モードでは 2 枚の host を安定した key で保持し、Divider ドラッグで再生成しない。
- 非表示になった host の controller、timer、subscription を確実に破棄する。
- Card に固定高さを指定せず、拡大文字では内部スクロールへ移行する。
- 地図は SafeArea 外まで描画し、重要情報と操作 UI だけを SafeArea および display feature の安全領域へ収める。
- Divider とコントロールパネルの操作対象は、見た目より広いタッチ領域を持つ。
- Light・Dark の双方でテーマ token を使用する。

## テスト方針

新規 Widget テストは作成しない。状態遷移、検出、設定、カメラ計算、platform service を UI から分離し、単体テストで保証する。

### Coordinator と policy

- 初期状態が realtime である。
- VXSE51・52・53・61・62 と推計震度で earthquake へ遷移する。
- 同一地震と別地震の更新で内容と期限を置き換える。
- 最低 3 秒中の既存 EEW 更新と揺れ検知を最低期限まで待機する。
- 新規 EEW eventId が最低期限を無視して即時割り込みする。
- 中断した地震情報を再表示しない。
- 設定した 3 秒から 300 秒で realtime へ戻る。
- 古い Scheduler task が新しい state を変更しない。
- 表示中地震の削除で realtime へ戻る。
- 表示方式変更で task を取り消し、自動切り替えへ戻った場合は realtime から開始する。
- 表示時間の変更が表示中 state の期限を変えず、次の地震表示から適用される。

### Event detector

- 初回値を表示トリガーにしない。
- EEW eventId と serialNo の新規・更新・重複を区別する。
- 揺れ検知 snapshot revision と event serialNo を比較する。
- VXSE5x・VXSE6x metadata の新規追加を検出する。
- 推計震度の eventId と識別値の新規組み合わせを検出する。
- 推計震度レイヤーには詳細 API から得た full `Earthquake.estimatedIntensityTileUrl` を使用する。
- full Earthquake が未取得の推計震度 event では詳細取得後に表示期限を開始する。
- WebSocket と REST の同一情報を一度だけ処理する。
- 再接続と foreground 復帰の差分を検出する。

### 設定、カメラ、service

- 表示時間が整数かつ 3 秒から 300 秒の場合だけ保存される。
- 縦横の分割割合が別々に保存される。
- 分割割合を 0.2 から 0.8 の範囲外へ変更できない。
- Home 範囲、複数 EEW、複数の未結合揺れ検知、両方を結合した bounds を構築でき、HomeMap と LiveMonitor で同じ対象になる。
- 地震の震源と震度 1 以上の全観測点を bounds に含め、震度 0・不明の観測点を除外できる。
- 自動フォーカスは zoom 8 を超えず、手動 gesture の最大 zoom は既存設定を維持する。
- 上部の発表時刻 Card と下部の震源情報 Card の領域が camera padding に反映される。
- 画面点灯維持が foreground、background、終了、失敗時に正しく動作する。
- session active 中だけ EEW overlay の描画が抑止される。
- 新規 EEW eventId で表示中のコントロールパネルを閉じる判断が行われる。

### 手動確認

- スマートフォンとタブレット。
- 縦画面と横画面。
- Light と Dark。
- 文字サイズ拡大。
- 2 枚の MapLibre 表示中の Divider 連続操作。
- Divider 操作後の縦横別比率復元。
- 端末回転、表示方式変更、background 復帰。
- コントロールパネル、明示的な閉じる操作、終了確認。
- 地図 gesture と Divider ドラッグではパネルが開かず、新規 EEW ではパネルが閉じる。
- 複数 EEW と揺れ検知 Card のスクロール。
- 通常の HomeMap と LiveMonitor で、EEW のみ、未結合揺れ検知のみ、両方、どちらもなしの各フォーカスが一致する。
- 地震表示で震源と全有感観測点が上部・下部 Card に隠れず、過剰に拡大されない。
- MapLibre が SafeArea 外まで描画され、Card と操作 UI は SafeArea 内に収まる。
- 接続切断、地震情報取得失敗、キャッシュ表示。
- iOS と Android の画面点灯維持。
- Map の消失、レイヤー ID 重複、controller leak がないこと。

## 完了条件

- イベントによるルート遷移なしで、確定した優先度と時間規則どおり表示が切り替わる。
- 自動切り替えと画面分割をコントロールパネルから変更でき、再起動後も復元される。
- 分割割合を 20% から 80% の範囲で変更でき、縦横別に復元される。
- 分割モードでリアルタイム地図と最新地震地図が同時に動作する。
- HomeMap と LiveMonitor の双方で、EEW と未結合揺れ検知が同時にある場合に両方へフォーカスする。
- 対象がないリアルタイム表示では保存済みの Home 地図範囲を使い、自動フォーカスは zoom 8 を超えない。
- 地震地図が震源と全有感観測点を含み、既存の震源情報 Card と独立した発表時刻 Card を表示する。
- 地図は SafeArea 外まで描画し、情報・操作 overlay は SafeArea 内に表示する。
- LiveMonitor モード中は EEW overlay が視覚表示されず、振動処理は維持される。
- foreground 中の画面点灯維持を設定で変更できる。
- 新規単体テストと既存の EEW・揺れ検知・地震履歴・地図関連テストが成功する。
- 対象 analyze と `git diff --check` が成功する。
- 実機・Simulator の手動確認項目を満たす。
