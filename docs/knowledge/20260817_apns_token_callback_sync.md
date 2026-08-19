# APNs token は初回取得と更新通知を分離する

## 原則

APNs notification token は、FCM token の更新を契機に再取得しない。

- アプリ起動時の初回値: `FirebaseMessaging.getAPNSToken()`
- 起動後の更新値: iOS の
  `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` callback
- Dart への通知: `net.yumnumm.eqmonitor/apns-token` EventChannel

FCM token は従来どおり `getToken()` と `onTokenRefresh` で管理し、APNs token
の更新経路とは分離する。APNs Push-to-Start token の監視経路も変更しない。

## iOS callback の順序

`AppDelegate` では FlutterFire がAPNs tokenを取り込めるよう、最初に
`super.application(...)` を呼び、その後でEventChannelへpublishする。

```swift
super.application(
  application,
  didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
)
ApnsTokenEventChannel.shared.publish(deviceToken)
```

空の `Data` は通知しない。token文字列は各byteを2桁の小文字16進数へ変換する。
固定値やランダム値へのフォールバックは入れない。

## callback の取りこぼし防止

初回の `getAPNSToken()` 完了前にnative callbackが届く場合がある。
EventChannel handlerは最新callback tokenを1件だけ保持し、Dartがlistenした時点で
再送する。Dart側は「初回値 → callback」の順に結合し、連続する同一tokenを
重複送信しない。

AndroidではAPNs EventChannelを購読しない。channel sourceのtarget membershipは
Runnerだけに設定し、Widget・Live Activityなどのextension targetへ追加しない。

## 検証

Dartの回帰テストと解析はFlutterコマンドを `mise exec --` 経由で実行する。
iOS native変更はLinux上の構造確認だけで完了扱いにせず、macOSで次を実行する。

```bash
cd app
mise exec -- flutter build ios --debug --no-codesign
```

可能であれば実機で、callback後にAPNs notification tokenの同期APIが新しいtokenに
対して1回だけ呼ばれ、同じtokenの再通知では呼ばれないことも確認する。
