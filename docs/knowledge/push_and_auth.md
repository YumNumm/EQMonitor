# APNs とネイティブ認証の契約

2026-09-21 にアプリの実装・設定と照合。配布設定は [delivery_ci.md](delivery_ci.md)、
署名は [native_build_release.md](native_build_release.md) を参照する。

## APNs environment と token

- backendへ同期するAPNs environmentはFlutter flavorではなく署名の `aps-environment` に合わせる。
  現行 `Runner/Runner.entitlements`、`Widget/Widget.entitlements` は production、
  `app/lib/feature/devices/data/provider/apns_environment.dart` も `ApnsEnvironment.production`。
  dev flavorという理由だけでsandboxへ送らない。署名変更時は最終bundleのentitlementも確認する。
- 通知用APNs tokenは初回 `FirebaseMessaging.getAPNSToken()` と、その後のnative callbackを分ける。
  FCMは `getToken()` / `onTokenRefresh` を使い、FCM更新をAPNs再取得の契機にしない。
- iOSの `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` は
  `super.application(...)` を先に呼び、FlutterFireの取込み後に
  `ApnsTokenEventChannel.shared.publish(deviceToken)` を実行する。
- EventChannel名は `net.yumnumm.eqmonitor/apns-token`。空Dataは無視し、
  各byteを2桁の小文字16進数にする。固定値・ランダム値の代替tokenを作らない。
- native handlerは最新tokenを1件保持し、Dartがlistenした時に再送する。
  Dart側は初回値→callbackを結合し、連続する同一tokenを重複送信しない。
  これにより初回取得中に届いたcallbackを取りこぼさない。
- Androidではこのchannelを購読しない。Swift sourceのtarget membershipはRunnerのみとする。
  APNs Push-to-Start tokenは通知用tokenと別の監視経路。
- `firebase_messaging` の権限switchでは `AuthorizationStatus.deniedPermanently` も扱う。
  アプリ内再要求ではなく端末設定で変更する状態として案内する。

## APNs Broadcast の開始と更新

- push-to-startでBroadcast更新を購読させる開始リクエストは次の形を使う:

```http
POST /3/device/{pushToStartToken}
apns-push-type: liveactivity
apns-topic: {bundleId}.push-type.liveactivity
input-push-channel: {apnsChannelId}
```

- `apns-channel-id` はBroadcast update/end・channel管理側の指定で、startの購読指定ではない。
  startだけ成功して更新・終了しない場合は、両者が同じAPNs環境のchannel IDを指すか確認する。
- backendの正本は `backend/docs/apns-live-activity-broadcast.md` と
  `backend/docs/notification-observability.md`。private submoduleのため今回実装は未確認。
  旧記録の「update/endはproduction固定」を現行確認済みの事実として扱わない。

## Google / Apple の nonce

- `GoogleAuthRepository` は `GoogleSignIn.instance.initialize()` の完了後に `authenticate()` する。
  initializeはsingletonに対し一度だけで、初期化後にclient IDの組合せを変えない。
- Googleのnonceはinitialize引数のため、現行経路はプロセス内で一度生成する32-byte nonceを
  SDKとBetter Authへ渡す。対話試行ごとのfresh nonceとは扱わない。
- Appleは試行ごとに32-byte raw nonceを生成する。SDKにはSHA-256 hex、Better Authにはrawを渡す。
- IDや環境の検証はNative UIの起動前に行う。Google IDのprefixは
  ASCII英数字で始まる英数字・`.`・`_`・`-`、suffixは `.apps.googleusercontent.com`。
  Apple Service IDは各segmentがASCII英数字で始まる英数字・`-`で、2segment以上。
  空白・URL・scheme文字列をIDとして受け入れない。

## 環境・Console・署名を合わせる

- `AuthEnvironment.resolve` はflavor、app ID suffix、BuildConfigとTelegramUrlのAPI URLを照合する。
  devは `.dev` / `https://dev.v2.api.eqmonitor.app`、prodは空suffix / `https://v2.api.eqmonitor.app`。
  HTTPSの正確なhostを要求し、port・userinfo・query・fragmentは拒否する。
- Google設定は `GOOGLE_IOS_CLIENT_ID`、`GOOGLE_IOS_REVERSED_CLIENT_ID`、
  `GOOGLE_ANDROID_CLIENT_ID`、`GOOGLE_SERVER_CLIENT_ID` を同じ環境のConsole登録へ揃える。
- iOSのdart-defineは自動ではInfo.plistのbuild settingにならない。
  Runner schemeのBuild PreAction → `app/ios/scripts/extract_dart_defines.sh` →
  `Flutter/Environment.xcconfig` → Debug/Release xcconfig、という既存経路を使う。
  Environment.xcconfigは生成物でありcheckoutにないこと自体は異常ではない。
- 現行Info.plistの `GIDClientID` / callback schemeは固定値、`GIDServerClientID` は未記載。
  未検証の `$(...)` へ置換せず、環境別の展開経路をarchiveの生成済みInfo.plistで確認する。
- Androidはclient ID / server client IDを明示的にpluginへ渡す。
  `google-services.json` の存在だけではAndroid OAuth client・署名の登録確認にはならない。
- Apple Android callbackは以下の環境固定URLと、Manifestの `signinwithapple://callback` を使う:
  - `https://dev.v2.api.eqmonitor.app/api/auth/apple/android/callback`
  - `https://v2.api.eqmonitor.app/api/auth/apple/android/callback`
- Console、Info.plist、provisioning profile、Android署名登録を署名済み実機で確認するまで
  `IS_NATIVE_SOCIAL_AUTH_ENABLED=false`（既定値）を維持する。登録値を推測して有効化しない。

## 同時実行と session commit

- Google/Apple共通の `NativeAuthAttemptCoordinator` が同時試行を一件に制限する。
  二件目はNative UI・HTTPの前に `AuthFailureKind.busy`。Better Auth応答・保存・session受理まで保持する。
- HTTP 200だけを成功としない。有効な `set-auth-token` がちょうど一件、Secure Storage保存、
  一時Cookie snapshotのcommit、認証済みsessionの受理が必要。
- header欠落・複数・不正値なら既存token/Cookieを維持する。
  保存開始後の失敗は旧tokenを復元、旧tokenがなければ新規tokenを削除する。
  generationが変わった新sessionを古い処理のrollbackで上書きしない。
- 正本は `app/lib/feature/auth/data/repository/better_auth_api_client.dart` と
  `native_social_auth_repository.dart`。rollbackでUser JWT memoryを巻き込んで消去しない。

## デバイス Admin とユーザー権限

- `DeviceRepository.getDeviceRole()` はデバイスJWTで `GET /v2/device/me` の `role` を取得する。
  未登録・通信失敗・未知値はUI側で非Adminとして扱い、取得不能をAdminへ補完しない。
- デバイスの `ADMIN` / `USER` は開発者UIのゲート。Better Authの `user.role` による
  backend管理者認可とは別で、デバイスroleを管理APIの認可根拠にしない。
- 利用可能性と保存済み設定を分け、権限を失ったら設定がONでも表示しない。
  `isHomeEewEstimationDebugAvailableProvider` / `isHomeEewEstimationVisibleProvider` が実装例。
  操作不可のtoggleには「取得中」「非Admin」「デバッグ無効」など理由を表示する。
- 旧記録の「アプリにログイン/sessionがない」は現在の `feature/auth` 実装と矛盾するため廃止。
- `ADMIN_DEVICE_IDS` はbackendの許可リストとして扱う。端末IDは平文valuesへ書かず、
  既存一覧を保持してSecret/SealedSecretを更新する。環境ごとの注入設定と復号を確認する。
  旧 `deploy/k8s/...` はこのcheckoutに存在せず、現行運用先と設定はbackend側で再確認が必要。

## 未確認の運用項目

- APNs callback後の新token同期が1回、同値再通知が0回になることを署名済み実機で確認する。
- Googleの環境別plist展開、Android OAuth署名、Apple callbackのConsole登録・実機認証は未確認。
- backendのBroadcast環境ルーティングとAdmin許可リスト配置は、private submodule側で照合する。
