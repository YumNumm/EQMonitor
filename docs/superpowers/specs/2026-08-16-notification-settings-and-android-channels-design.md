# 通知設定と Android 通知チャネル再設計

日付: 2026-08-16

## 目的

通知設定の現在地・指定地域・全国画面を、利用者が実際に受ける通知条件と一致させる。
緊急地震速報（警報）は、現在地が警報対象になった通知と全国設定だけで受ける通知を
backend で区別する。Android は通知種別ごとの Notification Channel を正とし、iOS
だけがアプリ内の音・割り込みレベル設定を使用する。

## 確定要件

- 緊急地震速報（警報）の現在地通知は `passive` / `active` / `time_sensitive` /
  `critical` から選択でき、既定値は `critical` とする。
- 全国通知は `passive` / `active` / `time_sensitive` から選択でき、`critical` を
  API・DB・配信処理のすべてで拒否する。
- 同じ警報で現在地と全国の両方に一致した場合は、現在地設定を優先する。
- Android では Apple の割り込みレベルを配信表示へ流用しない。現在地警報と全国警報は
  別 Channel に配信する。
- Android では予想震度別設定、通知音・割り込みレベル設定、全国警報の配信レベル設定を
  表示しない。通知の音・バイブレーション・重要度は OS の Channel 設定を正とする。
- iOS では予想震度別設定と通知音・割り込みレベル設定を表示する。
- 警報通知が有効で、現在地通知のレベルが `critical` であり、重大な通知に対応した
  端末で権限が未許可の場合、警報設定の有効スイッチ直下に説明 Card と
  「重大な通知を許可」ボタンを表示する。
- Webhook の任意 Channel ID 契約は変更しない。
- アプリと backend をまたぐ Channel ID の契約テストは追加しない。各リポジトリ内の
  振り分けテストと Channel 定義テストは追加する。
- 旧アプリとの段階的切り替えは行わず、アプリと backend を新 Channel へ一括変更する。

## 緊急地震速報（警報）の設定モデル

`device_eew_warning_config` は次の設定を保持する。

| 設定 | 許可値 | 既定値 |
|---|---|---|
| `target` | `current_location_only`, `current_location_and_nationwide` | `current_location_only` |
| `current_location_interruption_level` | `passive`, `active`, `time_sensitive`, `critical` | `critical` |
| `nationwide_interruption_level` | `passive`, `active`, `time_sensitive`; 現在地のみの場合は `NULL` | 全国有効化時は `active` |

API の request / response と Flutter のモデルにも現在地レベルを追加する。DB の CHECK
制約は、現在地レベルを常に必須とし、全国レベルでは `critical` を許可しない。

backend のマッチ結果は `current_location` / `nationwide` の一致元を保持する。重複時は
SQL の行順に依存せず `current_location` を選ぶ。APNs は一致元に応じて対応する設定値を
`aps.interruption-level` に設定する。FCM は一致元に応じて現在地用または全国用 Channel
を選ぶが、Apple の interruption level は Channel 選択や表示 priority に使用しない。

通知済み状態には一致元も保存する。全国通知済みのイベントで、続報により現在地が新たに
警報対象となった場合は現在地通知へ昇格させ、通常の新規現在地警報として配信する。

## 通知設定 UI

### 緊急地震速報（警報）

- 有効スイッチ
- 条件を満たす場合の重大な通知権限 Card
- 現在地通知の配信レベル（iOS のみ）
- 通知対象: 現在地のみ / 現在地 + 全国
- 全国通知の配信レベル（iOS かつ全国有効時のみ）
- Android では配信レベルの代わりに、Android の通知設定を開く導線を表示する

### 緊急地震速報（予報）のしきい値

表示名を「最小震度」から「通知する予想震度のしきい値」へ変更する。

| スロット | 選択肢 |
|---|---|
| 現在地・指定地域 | すべて、震度4、震度5弱、震度5強、震度6弱、震度6強、震度7 |
| 全国 | すべて、震度1、震度2、震度3、震度4、震度5弱、震度5強、震度6弱、震度6強、震度7 |

「すべて」は API 値 `0` に対応する。`5-` / `5+` / `6-` / `6+` は UI では
「5弱」/「5強」/「6弱」/「6強」と表示する。既存の現在地・指定地域設定で
`0`〜`3` のしきい値は `0` へ正規化し、表示と実際の配信条件を一致させる。

しきい値行の subtitle は次の形式とする。

- 現在地: `現在地でこの震度以上が予想された場合に通知します`
- 都道府県: `東京都でこの震度以上が予想された場合に通知します`
- 市区町村: `東京都新宿区でこの震度以上が予想された場合に通知します`
- 全国: `全国でこの震度以上が予想された場合に通知します`

市区町村名の前へ余分な空白を入れない。スロット一覧のしきい値表示にも同じ震度表記を
使用する。

### その他

カスタム設定画面の次の文章を削除する。

> ダウングレード時も設定は保持され、Freeの上限を超える項目は配信時に無効扱いになります。

## Android Notification Channel

Android の `minSdk` は 29 のため、すべての対応端末で Channel の importance・sound・
vibration が通知表示を決める。FCM の `android.priority` は配送優先度として別に扱う。
緊急性のある実通知は配送を `high` とし、表示上の緊急度は次の Channel 定義へ委ねる。

### Channel Group

| ID | 表示名 |
|---|---|
| `eew` | 緊急地震速報 |
| `earthquake` | 地震情報 |
| `tsunami` | 津波情報 |
| `safety_information` | 防災・関連情報 |
| `service` | サービス通知 |

### Channel

| ID | Group | 用途 | 初期 importance |
|---|---|---|---|
| `eew_warning_current_location` | `eew` | 現在地が対象の緊急地震速報（警報） | high |
| `eew_warning_nationwide` | `eew` | 全国設定だけで受ける緊急地震速報（警報） | default |
| `eew_forecast` | `eew` | 緊急地震速報（予報） | high |
| `eew_low_accuracy_v2` | `eew` | 1点検知・レベル法の低精度EEW | default |
| `earthquake_vxse51` | `earthquake` | 震度速報 | high |
| `earthquake_vxse52` | `earthquake` | 震源情報 | default |
| `earthquake_vxse53` | `earthquake` | 震源・震度情報 | high |
| `earthquake_vxse61` | `earthquake` | 震源要素更新 | default |
| `earthquake_vxse62` | `earthquake` | 長周期地震動情報 | high |
| `earthquake_estimated_intensity` | `earthquake` | 推計震度情報 | low |
| `tsunami_major_warning` | `tsunami` | 大津波警報 | high |
| `tsunami_warning` | `tsunami` | 津波警報・第1波到達 | high |
| `tsunami_advisory` | `tsunami` | 津波注意報 | high |
| `tsunami_update` | `tsunami` | 更新・切替・解除・取消 | default |
| `tsunami_passive` | `tsunami` | 津波予報・沖合観測 | low |
| `earthquake_notice` | `safety_information` | VZSE40 | low |
| `nankai_information` | `safety_information` | 南海トラフ臨時・解説情報 | high |
| `aftershock_advisory` | `safety_information` | 北海道・三陸沖後発地震注意情報 | high |
| `shake_detection` | `safety_information` | 揺れ検知 | high |
| `training_information` | `safety_information` | 訓練・試験情報 | low |
| `service_test` | `service` | 通常テスト通知 | default |
| `service_test_critical` | `service` | 重大テスト通知 | high |
| `service_fallback` | `service` | Channel 未指定通知の fallback | default |
| `bgl_debug` | `service` | アプリ内バックグラウンド位置デバッグ | low |

`high` Channel は音・バイブレーションあり、`default` は標準音あり、`low` は無音を
初期値とする。いずれもアプリから DND bypass を有効化せず、ユーザーの OS 設定を優先する。
確認できていない専用音へ固定フォールバックせず、初期音は Android の標準音を使用する。

既存の backend 未使用 Channel 定義はソースから削除する。旧 Channel は新しい一意な ID
へ置き換え、アプリ起動時に既知の旧 ID を削除してから新 Channel を作成する。Manifest の
`com.google.firebase.messaging.default_notification_channel_id` は `service_fallback` を指す。

Webhook が未知の Channel ID を指定する既存契約は維持する。その Channel が端末に
存在しない場合の FCM fallback 動作を変更しない。

## backend の Channel 選択

Channel 選択は `platform/fcm.ts` の catch-all ではなく、通知イベントの意味を失う前に
明示する。

- EEW: 予報、低精度、現在地警報、全国警報を分ける。
- 地震: `telegramType` により VXSE51/52/53/61/62、VZSE40、NANKAI、VYSE60 を分ける。
- 津波: kind と trigger により大津波警報、警報/第1波、注意報、更新、passive を分ける。
- 揺れ検知、推計震度、テスト通知は専用 Channel を指定する。
- 訓練・試験状態のイベントは `training_information` を指定する。
- Webhook は既存の任意指定または未指定を維持する。

FCM 配送 priority と Channel ID は別々に解決する。Apple の interruption level や
per-message sound から Android の importance を推測しない。

## エラー処理

- 権限取得失敗は例外本文を画面へ直接出さず、既存の権限ダイアログと案内を使用する。
- 通知設定 API 更新失敗は既存のエラーダイアログを使用し、ローカル表示だけを先行更新しない。
- 未知の震度値を「すべて」に黙って置換しない。既知のレガシー値だけを決定的に移行し、
  未知値は読み込みエラーとして扱う。

## テスト

### Flutter

- スロット種別ごとのしきい値選択肢と日本語表記
- 現在地・都道府県・市区町村・全国 subtitle
- iOS でだけ音・割り込み・震度別設定を表示すること
- 重大な通知 Card の表示条件と許可ボタン
- ダウングレード説明文が表示されないこと
- 全 Channel ID の重複がなく、参照 Group が定義済みであること
- 旧 Channel 削除と新 Channel 作成の初期化順

### backend

- EEW 警報の現在地/全国マッチ、重複時の現在地優先、全国から現在地への昇格
- 現在地と全国の interruption level 許可値
- 地震電文種別、津波 kind/trigger、EEW 種別、揺れ検知、推計震度、テスト通知の Channel 選択
- FCM 配送 priority が Channel importance と独立していること
- API と DB が全国の `critical` を拒否し、`time_sensitive` を受理すること

横断的な app/backend 契約テストと Webhook の任意 Channel 検証は追加しない。

## 対象外

- Android の予想震度別 Channel
- Android のアプリ内音・割り込みレベル編集
- Webhook API の Channel enum 化
- 旧アプリ向け Channel version gate と段階移行
- FCM/APNs を唯一の生命安全通知経路として保証すること
