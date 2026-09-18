# Native Social Auth設定の境界

## Google Sign-In 7.2.0

`GoogleSignIn.instance.initialize()`はsingletonごとに一度だけ呼び、完了を待ってから
`authenticate()`する。nonceは`initialize()`引数なので、現行public APIでは
対話試行ごとのfresh nonceを設定できない。EQMonitorはアプリプロセス内で一度生成した
32-byte nonceを初期化とBetter Authの両方へ渡し、fresh-per-attemptとは扱わない。

iOSの`--dart-define`は自動ではInfo.plistのbuild settingにならない。現行projectは
`Runner.xcscheme`のBuild PreActionから`extract_dart_defines.sh`を実行し、生成される
`Environment.xcconfig`を`Debug.xcconfig` / `Release.xcconfig`からincludeする経路を
持つ。生成物がcheckoutに存在しないこと自体は異常ではない。Task 6では未展開の
`$(...)`へ置換せず、既存の`GIDClientID`とURL schemeを保持した。Task 9でこの既存経路が
CI / archiveでも動作することを確認してから、次を同じ環境のConsole値へ揃える。

```text
GOOGLE_IOS_CLIENT_ID
GOOGLE_IOS_REVERSED_CLIENT_ID
GOOGLE_SERVER_CLIENT_ID
```

`GIDClientID`、callback URL scheme、`GIDServerClientID`へ値が展開されることを
archiveの生成済みInfo.plistで確認する。未定義build settingをInfo.plistへ書かない。

Androidは`GOOGLE_ANDROID_CLIENT_ID`と`GOOGLE_SERVER_CLIENT_ID`を明示的に
pluginへ渡す。`google-services.json`にAndroid OAuth clientがない状態は認証完了の
証拠にならないため、Console登録と署名済み実機検証を必須とする。

## Sign in with Apple 8.1.0

Appleは試行ごとに32-byte raw nonceを生成する。SHA-256 hexをNative SDKへ渡し、
raw nonceをBetter Authへ渡す。Androidは次の環境固定callbackだけを使う。

```text
https://dev.v2.api.eqmonitor.app/api/auth/apple/android/callback
https://v2.api.eqmonitor.app/api/auth/apple/android/callback
```

Android Manifestのcallback scheme/pathはpackage公式契約の
`signinwithapple://callback`から変更しない。Service IDやGoogle client IDが空、
URL・flavor・app IDが不一致の場合はNative UIを開く前にfail closedする。
Google OAuth client IDのprefixはASCII英数字を先頭とする英数字・`.`・`_`・`-`、
Apple Service IDの各segmentはASCII英数字を先頭とする英数字・`-`だけを許す。
空白、`/`、`:`、scheme文字列はNative UI前に拒否する。

Console、Info.plist、provisioning profile、Android署名登録の一致を実機確認するまで
`IS_NATIVE_SOCIAL_AUTH_ENABLED=false`を維持する。tracked設定に存在しない値を
推測して有効化してはならない。

## 同時実行とsession commit

Google / AppleをまたぐNative sign-inはrepository単位で一件だけ実行し、二件目は
`AuthFailureKind.busy`でNative UIとHTTPの前に拒否する。gateはBetter Auth応答と
local session commitが完了するまで保持する。

social sign-inのHTTP 200だけを成功条件にしない。有効な`set-auth-token`がちょうど
一件あり、Secure Storage保存と一時Cookie snapshotのcommitが両方成功した場合だけ
成功とする。欠落・複数・不正headerでは既存session token / Cookieを維持し、保存開始後の
失敗では旧tokenを復元するか新規tokenを削除する。User JWT memoryはこのcleanupで触らない。
