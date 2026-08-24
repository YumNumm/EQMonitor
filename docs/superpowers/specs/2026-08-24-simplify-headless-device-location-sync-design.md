# Headless Device Location Sync Simplification Design

## 目的

Draft PR #1762で実装したprocess-terminated Device Location API同期を、既存のバックグラウンド位置監視とLocalデバッグ通知を維持したまま簡素化する。

元PRのブランチ`codex/headless-device-location-sync`は比較・退避用として変更せず、本設計はそこから分岐した`codex/simplify-headless-device-location-sync`で実装する。

## 現状認識

変更前から、iOS Significant Location Change、Android Fused Location + BroadcastReceiver、headless FlutterEngine起動、native pending保存、通常Engineでの地域更新とLocalデバッグ通知は存在していた。

ただしprocess終了時のDart callbackはready handshakeだけで、Device Location APIを送信していなかった。native pendingは次回通常起動時にconsumeされていたため、既存Local通知は通常Engineが生存したbackground更新の証拠ではあるが、process終了中のAPI送信の証拠ではない。

PR #1762では送信耐久性を追加する過程で、foreground/headless双方からDevice Location APIを送れる構造となり、その競合を抑えるnative lease、registration generation、scope cacheが追加された。これらは複雑性を増やし、最終レビューでもcache invalidation、lease TTL、device lifecycle reconcileの問題が残った。

## 採用する構成

### 責務分離

- 通常Flutter Engineは既存のapp effectsだけを担当する。
  - notification slot更新
  - shake detection更新
  - App Group更新
  - Localデバッグ通知
- Device Location API送信はheadless executorだけが担当する。
  - region、city、tsunami forecast regionを端末内で解決する
  - `PUT /v2/device/me/location`へ地域コードだけを送る
  - raw緯度経度をAPI payloadや通常ログへ含めない
- native側は位置更新を保存してから、app effectsを通常Engineへ通知し、Device Location API用headless workを一つだけscheduleする。

Androidはunique WorkManagerを唯一のDevice Location API executorとする。iOSはsingletonのheadless lifecycleを唯一のDevice Location API executorとし、BGTaskは同じexecutorのretry triggerに限定する。

通常EngineはDevice Location APIを直接送らないため、foreground/headless間のnative leaseとfencingは不要になる。

### Pendingとacknowledge

native pendingは最新1件だけを保持し、consumerを次の2つに分ける。

- `deviceLocation`: headless executorがAPI送信成功、同一payload、または明示的disabledの場合にacknowledgeする
- `appEffects`: 通常Engineが既存のslot、shake、App Group、Local通知処理を完了した場合にacknowledgeする

一方のacknowledgeで他方のpendingを消さない。新しい位置更新が保存された後に古いupdate IDをacknowledgeしても最新pendingを削除しない。

HTTP 400だけをterminalとし、network、timeout、認証、404を含むその他4xx、429、5xxはpendingを保持してretryする。

### Dedupe

last-sent recordはAPI endpointと`DeviceLocationPayload`だけを保存する。device tokenを保存・hash化しない。

device tokenのsave/clear時はlast-sent recordを明示的に削除する。API endpointがrecordと異なる場合はcache missとして送信する。これによりregistration generationとkeep-alive scope cacheを削除する。

### Monitoring lifecycle

notification slotまたはshake detectionがcurrent locationを使う場合だけOS監視を有効にする。

- 通常起動
- slot作成、削除、一括置換
- shake current-location entry作成、削除
- device delete、reprovision

の全経路で共通reconcileを呼ぶ。両consumerの状態を取得でき、どちらも未使用の場合だけstopする。取得不能時は誤停止を避けて現状維持する。

## Model規約

今回追加・変更するDartの値ModelはFreezedを使用する。永続化またはJSON境界を持つModelはJsonSerializableも使用し、手書き`toJson`、手書きMap decodeを禁止する。

対象は少なくとも次を含む。

- `DeviceLocationPayload`
- `PendingDeviceLocation`
- `DeviceLocationSyncScope`
- `DeviceLocationSyncStateRecord`
- `HeadlessApiIdentity`

enumはDart enumのまま使用し、JSON ModelのfieldとしてJsonSerializableに変換させる。

Pigeonのmessage classはPigeon schemaから生成されるplatform channel DTOであり、Freezedを重ねない。

## Riverpod規約

今回追加・変更するproduction/test Dartコードでは、`Provider(...)`、`FutureProvider(...)`、`StreamProvider(...)`、`StateProvider(...)`、`NotifierProvider(...)`、`AsyncNotifierProvider(...)`を直接宣言しない。

すべて`riverpod_annotation`の`@riverpod`または`@Riverpod(keepAlive: true)`とbuild_runner生成物を使用する。test helperも手書きProviderを作らず、生成Providerのoverrideまたは通常classの直接テストを使う。

## 削除対象

- native Device Location sync leaseのPigeon API、store、Dart wrapper、tests
- device registration generation repository、SharedPreferences key、tests
- generationを含むkeep-alive scope cache
- foregroundからDevice Location APIを直接送る経路
- headless依存を手作業で組み立てるfactory/loader classのうち、generated providerで置き換えられるもの
- Pigeonの`PendingLocationMessage`と重複するlegacy `LocationUpdateMessage` API
- 同じ契約を重複して説明するknowledge文書

## 維持対象

- iOS Significant Location Change relaunch
- Android unique WorkManager retry
- save-before-callbackのnative pending
- consumer別acknowledgeとstale update ID保護
- iOS file protectionとbackup exclusion
- Android cloud backup/device transfer exclusion
- raw座標をAPIへ送らないprivacy境界
- 既存Localデバッグ通知の設定と表示内容
- 実機E2E未実施という保証境界

## 検証

- Freezed/JsonSerializable/Riverpod生成物をbuild_runnerで生成し、再生成差分がcleanであること
- 変更範囲に手書きProvider宣言がないことをstatic grep testで確認すること
- foreground更新ではapp effectsとLocal通知が動き、Device Location API senderを直接呼ばないこと
- headless executorだけがDevice Location APIを送ること
- process終了相当のpendingからregion/cityを解決して送信し、成功時だけdeviceLocationをacknowledgeすること
- retry/terminal、consumer別ack、stale update ID、backup exclusionを既存native/unit testで確認すること
- Android unit testとdebug APK build、iOS XCTestとSimulator build、対象Dart analyze/testを実行すること
- 実機process-terminated/offline E2Eはユーザー指定どおりPR作成・release判定のblockerにしないこと

## 非目標

- 位置情報取得方式や約1km単位の更新条件の変更
- backend API contractの変更
- Localデバッグ通知のUI変更
- raw緯度経度のbackend送信や永続履歴化
- 元PRブランチのforce-pushまたは履歴改変
