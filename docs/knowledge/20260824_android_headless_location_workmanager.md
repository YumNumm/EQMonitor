# Android headless位置同期のWorkManager制約

## 実装上の不変条件

- `LocationUpdateReceiver` は位置をアプリ専用ストレージへ保存してから、unique work
  `eqmonitor-device-location-sync` を `ExistingWorkPolicy.REPLACE` で登録する。
- work request は `NetworkType.CONNECTED` と30秒からの指数backoffを使う。workerはrequestの
  inputではなく、実行開始時に最新pendingを読む。新しい位置は古い実行を置き換える。
- Receiverの寿命内ではFlutter Engineを起動しない。生存中Engineへの通知に成功しても、
  永続実行を保証するためworkは登録する。
- pendingのacknowledgeはDartのconsumerだけが行う。native workerは成功、terminal、retry、
  timeoutのどの場合もpendingを削除しない。

## Flutter Engineと完了通知

- cold processではcallback handle読出し後、FlutterLoader初期化、auto-registration無効のEngine生成、
  messengerとregistrationのbind、callback information lookup、
  `GeneratedPluginRegistrant.registerWith(engine)`、Dart callback開始の順にする。lookupはEngine生成前に
  行うとFlutter JNI/cacheが未初期化の可能性がある。
- このbootstrapとEngine destroyはmain dispatcherで行う。完了待ちはinterrupt可能なIO dispatcherへ
  分離する。
- callback handleが未保存、0、不正、Engine起動失敗、timeout、worker cancellationはretryとし、
  callback lookupやplugin/Dart開始の`LinkageError`もretryへ分類する。Engineが生成済みなら失敗箇所に
  かかわらず必ず1回だけdestroyする。
- plugin attach前にEngineのbinary messengerとcompletion registrationを紐付ける。これにより
  通常Engineはactive IDを持たず、該当headless EngineだけがTask 5の
  `completeHeadlessTask(updateId, result)` を完了できる。
- completionはregistrationの同一性とupdate IDの両方を検証する。二重完了、timeout後の遅延完了、
  `REPLACE` 前の古いEngineからの完了は無視する。新registrationの`begin()`時に旧Engine mappingを
  削除し、pluginはattach時のIDをcacheせず、ID取得・完了のたびにactive mappingを再確認する。
- Dartの`success`と`terminalFailure`はWorkManagerの`Result.success()`、`retry`、timeout、
  Engine例外は`Result.retry()`へ変換する。terminalをfailureへ変換すると無限再試行になる。

## Android versionとForeground Service

- 現在のworker timeoutは60秒で、通常の`CoroutineWorker`として実行する。long-running workerへ
  変更せず、foreground service、通知、expedited workは要求しない。
- 10分以上へ延長してlong-running workerに変える場合、Android 14（API 34）以降では適切な
  foreground service type（この用途では`dataSync`）と対応permissionが必要になる。API 33以前でも
  base foreground service permissionと通知が必要になる。
- Android 16ではlong-running workerもJobScheduler quotaを消費するため、実行時間を延長する際は
  quotaとforeground service代替を再評価する。

公式資料:

- https://developer.android.com/develop/background-work/background-tasks/persistent/how-to/manage-work
- https://developer.android.com/develop/background-work/background-tasks/persistent/how-to/long-running
- https://developer.android.com/about/versions/14/changes/fgs-types-required
- https://developer.android.com/about/versions/16/changes/job-runtime-quota

## 検証コマンド

このworktreeには`app/android/gradlew`がない。mise管理のGradle 9.3.1実体を使う。

```bash
cd app/android
mise exec -- /Users/ryotaro.onoue/.local/share/mise/installs/gradle/9.3.1/gradle-9.3.1/bin/gradle \
  :background_location_tracker:testDebugUnitTest --rerun-tasks --console=plain

mise exec -- /Users/ryotaro.onoue/.local/share/mise/installs/gradle/9.3.1/gradle-9.3.1/bin/gradle \
  :background_location_tracker:lintDebug --rerun-tasks --console=plain

cd ..
mise exec -- flutter build apk --debug
```

現状のmodule lintはBASEから未変更の`AndroidManifest.xml`にある`CoarseFineLocation`で失敗する。
今回差分の判定では、全文reportを確認し、ManifestがBASEから無変更であることを併記する。

`flutter clean`後はAsset Pack stagingに加え、SwiftPM plugin copy先の親を復元してからbuildする。

```bash
mkdir -p app/build/ios/SourcePackages app/build/macos/SourcePackages
mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled
cd app && mise exec -- flutter build apk --debug
```

実機ではAndroid StudioのWorkManager Inspectorまたは次のdiagnosticで実行状態を確認する。出力を
共有する場合はBearer tokenと緯度経度を含めない。

```bash
adb shell dumpsys jobscheduler net.yumnumm.eqmonitor
```
