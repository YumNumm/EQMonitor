# APNsトークンCallback同期 設計

## 目的

APNs通知トークンの更新検知をFirebase Messagingの`onTokenRefresh`から分離し、
iOSのAPNs登録Callbackを起点としてサーバへ同期する。

初回トークンは従来どおり`FirebaseMessaging.getAPNSToken()`で取得する。
初回取得後の変更だけをAPNs登録Callbackから受け取る。

## 対象範囲

- iOSのAPNs通知トークン
- `AppDelegate`からDartへのCallback通知
- `notificationTokenStreamProvider`への統合
- APNsトークン同期の回帰テスト

FCMトークンとLive Activity Push to Startトークンの取得経路は変更しない。
バックエンドAPIとデータベーススキーマも変更しない。

## アーキテクチャ

### iOS

`AppDelegate`で次のCallbackをoverrideする。

```swift
application(_:didRegisterForRemoteNotificationsWithDeviceToken:)
```

Callbackで受け取った`Data`を小文字の16進文字列へ変換し、専用の
`FlutterEventChannel`へ送る。EventChannelの登録とストリームハンドラは
専用クラスへ分離し、`AppDelegate`にはCallback転送だけを置く。専用クラスは
最新のCallbackトークンを1件保持し、Dartの購読開始時に再生する。

Callback内では最初に`super.application(...)`を呼び、FlutterFireを含む
既存プラグインへAPNsトークンを反映してからEventChannelへ通知する。
これによりCallbackを受けたDart側がFCMトークン取得を再開した時点で、
FlutterFireが最新のAPNsトークンを保持していることを保証する。

### Dart

APNs更新EventChannelを型付きの`Stream<String>`として公開するproviderを追加する。
プラットフォームチャネルからString以外の値を受け取った場合は破棄せず、
ストリームエラーとして扱う。

`_apnsTokenStream`は次の順序で動作する。

1. `FirebaseMessaging.getAPNSToken()`で初回値を取得してemitする
2. APNs Callbackストリームの購読を開始する
3. 以後はCallbackストリームの値をemitする

初回取得中または取得と購読の間に発生したCallbackは、ネイティブ側が保持した
最新値を購読開始時に再生するため取りこぼさない。同じ値が重複した場合は
ストリームで抑止し、既存の`PushTokenSyncWorker`でも二重に防御する。

FCMの`_firebaseMessagingTokenStream`は、iOSでは引き続き最初のAPNsトークンを
待ってから`getToken()`を呼ぶ。ただしFCMの`onTokenRefresh`はAPNs providerを
invalidateしない。

## データフロー

```text
アプリ起動
  -> getAPNSToken()
  -> APNs Callbackストリーム購読開始（最新Callbackを再生）
  -> notificationTokenStreamProvider
  -> PushTokenSyncWorker(APNs)
  -> PATCH /v2/device/me/apns/NOTIFICATION

APNs登録Callback
  -> AppDelegate
  -> FlutterEventChannel
  -> notificationTokenStreamProvider
  -> PushTokenSyncWorker(APNs)
  -> PATCH /v2/device/me/apns/NOTIFICATION
```

## エラー処理

- 初回`getAPNSToken()`が`null`の場合はCallbackを待つ
- Callbackストリームの不正な型は明示的なエラーにする
- API送信失敗は既存`PushTokenSyncWorker`の再試行方針を使用する
- APNs登録失敗Callbackの新規通知は今回の対象外とし、既存挙動を維持する

## テスト

- 初回APNsトークンが`getAPNSToken()`からemitされる
- APNs Callbackの更新値が集約ストリームを通って同期される
- FCM `onTokenRefresh`だけではAPNsトークンを再取得しない
- 初回取得中または購読開始前に届いた最新APNs Callbackを取りこぼさない
- 同じAPNsトークンの重複Callbackを同期しない
- AndroidではAPNs EventChannelを購読しない
- 既存のFCM、Push to Start、同期ワーカーのテストが通る

## 完了条件

- APNs更新経路からFCM `onTokenRefresh`依存がなくなる
- 初回取得は`getAPNSToken()`のまま維持される
- APNs Callbackの新しいトークンが既存APIへ送信される
- FlutterFireのAPNs/FCM連携を壊さない
- 関連テストと静的解析が成功する
