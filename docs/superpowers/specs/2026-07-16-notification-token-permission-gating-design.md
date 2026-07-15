# Notification Token Permission Gating Design

## 目的

オンボーディングの初回デバイス登録時に通知権限を暗黙に要求しない。OS の通知権限で通知配信が可能な場合だけ FCM、APNs 通知、APNs push-to-start token を取得し、既存の push token 同期経路へ渡す。

Token 取得可否と、オンボーディングやホーム画面で「通知を完全に許可済み」と表示する判定は分離する。iOS の provisional authorization は静かな通知を配信できるため Token 取得対象に含めるが、既存 UI では完全な許可済みとして扱わない。

## 現状と原因

`notificationTokenStreamProvider` は購読開始時に `FirebaseMessaging.requestPermission(provisional: true)` を呼び、その後に FCM、APNs 通知、push-to-start token の取得を開始する。

デバイスプロビジョニング完了後は `pushTokenSyncWiringProvider` と `PushTokenSyncNotifier` がこの Stream を購読する。そのため、オンボーディングの最初のデバイス登録が完了した直後に、権限画面へ進む前でも provisional authorization の要求と Token 取得が始まる。

## 権限ポリシー

| `AuthorizationStatus` | Token 取得 | サーバ同期 | UI の完全許可表示 |
| --- | --- | --- | --- |
| `authorized` | 行う | 行う | 許可済み |
| `provisional` | 行う | 行う | 未許可のまま |
| `notDetermined` | 行わない | 行わない | 未許可 |
| `denied` | 行わない | 行わない | 未許可 |

Android 13 以上では Firebase Messaging の `denied` が未選択と拒否を区別しない場合があるが、どちらも Token を取得しないため本設計の分岐には影響しない。Android 13 未満は、OS 設定で通知が無効化されていなければ Firebase Messaging が返す `authorized` に従う。

## 設計

### 通知権限モデル

`OsNotificationPermission` に Token 取得可否を表す getter を追加する。値は `authorized` または `provisional` のときだけ `true` とする。

既存の `isOsNotificationGranted` は `authorized` のみを `true` とする現在の意味を維持する。これにより、provisional authorization の利用者へ完全な通知許可を促す既存 UI と、Token 取得可否を混同しない。

### 権限状態の共有と更新

`osNotificationPermissionProvider` を Token 取得可否の正本として利用する。Provider は Firebase Messaging の `getNotificationSettings()` だけを呼び、権限要求は行わない。

次のタイミングで Provider を再評価する。

- アプリが foreground へ復帰したとき
- オンボーディング内の通知権限要求が完了したとき
- ホーム画面の通知権限バナーから権限要求が完了したとき

既存の `isNotificationPermissionGrantedProvider` は、この共有 Provider の値から完全許可判定を派生する。Firebase Messaging へ同じ権限状態を別経路で問い合わせる実装は残さない。

### Token Stream のゲート

`notificationTokenStreamProvider` は最初に `osNotificationPermissionProvider` を評価する。

- Token 取得可能なら、プラットフォームに応じて FCM、APNs 通知、push-to-start の各 Stream を購読する。
- Token 取得不可能なら、各 Token provider を購読せず、空の `NotificationToken` を返して終了する。

`FirebaseMessaging.requestPermission(provisional: true)` は Token Stream から削除する。権限要求の責務はオンボーディング権限フローと通知権限バナーに限定する。

ゲートは子 Stream を生成する前に置く。これにより `FirebaseMessaging.getToken()`、`FirebaseMessaging.getAPNSToken()`、ActivityKit の push-to-start token 初期取得・更新監視を、未許可時に一度も呼ばないことを保証する。

### 権限変更後の同期

権限状態 Provider が `notDetermined` または `denied` から `authorized` または `provisional` へ変わると、`notificationTokenStreamProvider` を再構築する。再構築後に初めて Token を取得し、既存の `PushTokenSyncNotifier` が pending token としてサーバへ同期する。

権限が配信不可へ変わった場合は、新規 Token 取得と更新 Stream の購読を停止する。本変更では、過去にサーバへ送信済みの Token を権限変更時に削除する API は追加しない。サーバ側削除は既存の無効 Token 処理および別途設計済みの lifecycle cleanup の責務とする。

## エラー処理

権限状態の取得に失敗した場合は Token 取得可能と推測せず、Token API を呼ばない。Provider の `AsyncError` を維持し、既存のリトライ・デバッグ表示経路から観測できるようにする。

固定値へのフォールバックや、権限状態が不明なまま Token を取得する処理は追加しない。

## テスト

TDD で、production code の変更前に失敗するテストを追加する。

### 権限モデル

- `authorized` は Token 取得可能
- `provisional` は Token 取得可能
- `notDetermined` は Token 取得不可
- `denied` は Token 取得不可
- `provisional` は既存どおり UI の完全許可判定では未許可

### Token Stream

Firebase Messaging と push-to-start token source を記録可能な fake に差し替え、次を検証する。

- `notDetermined` と `denied` では `requestPermission()` を呼ばない
- `notDetermined` と `denied` では `getToken()` を呼ばない
- Apple platform の `notDetermined` と `denied` では `getAPNSToken()` を呼ばない
- Apple platform の `notDetermined` と `denied` では push-to-start token の初期取得・監視を呼ばない
- `authorized` と `provisional` では対象 platform の Token を取得する
- Token Stream 自体は、どの権限状態でも権限要求を行わない

### 同期配線

- 未許可時は Token API とサーバ同期 API の双方が 0 回
- provisional authorization では取得した Token が既存同期 API へ渡る
- 権限付与後の Provider 再評価で Token 取得・同期が開始される
- 既存のオンボーディング welcome step のデバイス登録 gate とエラー表示が壊れない

## 対象ファイル

主な変更対象は次のとおりとする。実装計画では既存テスト helper の再利用可否を確認して確定する。

- `app/lib/core/provider/notification/os_notification_permission.dart`
- `app/lib/core/provider/notification/os_notification_permission_provider.dart`
- `app/lib/feature/permission/data/notification_permission_provider.dart`
- `app/lib/feature/permission/data/notifier/permission_notifier.dart`
- `app/lib/feature/permission/ui/component/notification_permission_banner.dart`
- `app/lib/feature/devices/data/provider/notification_token_stream.dart`
- 上記に対応する unit test と provider test

## 対象外

- オンボーディング画面の順序や文言変更
- デバイス登録 API の request schema 変更
- サーバ上の Token 即時削除 API の追加
- push token lifecycle 全体の retry、30日 cleanup、per-activity update token 廃止
- provisional authorization を UI 上の完全許可として扱う変更

## 完了条件

- オンボーディング初回デバイス登録では通知権限を要求しない
- `notDetermined` と `denied` では FCM/APNs/push-to-start Token API を一度も呼ばない
- `authorized` と `provisional` では Token を取得し、既存同期経路でサーバへ送信する
- 権限変更後、アプリ再起動を待たずに Token 取得可否を再評価する
- 追加した権限分岐テスト、Token Stream test、同期配線 test、オンボーディング回帰 test が通る
- `mise exec -- flutter analyze` が通る
