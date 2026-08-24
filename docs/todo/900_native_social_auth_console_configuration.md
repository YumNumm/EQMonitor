# Native Social Authの外部設定

Google / Appleの認証値はtracked設定から安全に確定できないため、リリース前に
Task 9として各Consoleと署名済み実機で次を完了する。

- Google Cloud / Firebaseへdevelop・productionのiOS bundle IDとAndroid package、
  各署名証明書を登録する。
- `GOOGLE_IOS_CLIENT_ID`、`GOOGLE_IOS_REVERSED_CLIENT_ID`、
  `GOOGLE_ANDROID_CLIENT_ID`、`GOOGLE_SERVER_CLIENT_ID`を環境別にCIへ設定する。
- iOS buildでDart defineからInfo.plistへ値を渡す実行済みのbuild phase / xcconfigを
  用意し、生成済みInfo.plistの`GIDClientID`、URL scheme、`GIDServerClientID`を
  archiveごとに検証する。
- Google server client IDをBetter Authの許可audienceと一致させる。
- Apple Service IDへdevelop・productionの固定callback URLを登録し、
  `APPLE_SERVICE_ID`を環境別にCIへ設定する。
- Apple Developer Portalで両bundle IDのSign in with Apple capabilityと
  provisioning profileを更新する。
- iOS / Androidの署名済み実機でGoogle、Apple iOS、Apple Android callbackを
  検証する。
- 上記完了後にだけ環境別CIの`IS_NATIVE_SOCIAL_AUTH_ENABLED`を`true`にする。

値が欠ける場合、Flutter側はNative UIやHTTPを開始せず
`AuthFailureKind.configuration`でfail closedする。
