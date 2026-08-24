# 終了中のDevice Location同期を検証する

## 適用範囲と保証境界

この同期は、nativeが受けた最新位置をconsumer別acknowledge付きで保存し、通常Flutter Engineまたは
headless Flutter Engineから地域を解決してDevice Location APIへ送る。位置イベントとbackground
taskの実行時刻はOSが決めるため、アプリ終了直後の即時同期は保証しない。

- foreground: 通常EngineがDevice Location同期とapp effectsを処理する。
- background: 生存中Engineへ通知しつつ、iOSはbackground task、AndroidはWorkManagerで処理を保持する。
- process terminated: iOSはSignificant Location ChangeによるOS relaunch、AndroidはPendingIntentからの
  BroadcastReceiverとWorkManagerで新しいprocessを起動する。
- iOSのapp switcherからのswipe-up、Androidの`force-stop`は通常のOS終了とは別扱いである。
  これらの後のbackground起動を合格条件にしない。

Simulatorと自動テストは状態機械を検証できるが、iOSのSignificant Location Change relaunch、権限、
Background App Refresh、Android端末固有のbackground制限は実機で別途確認する。

## 同期とacknowledgeの不変条件

最新位置には同じupdate IDを使う2 consumerがある。

| consumer | 完了条件 | 完了しない条件 |
| --- | --- | --- |
| `deviceLocation` | `sent`、`unchanged`、`disabled`、HTTP 400のterminal処理 | `uninitialized`、認証・network・timeout・地域解決・retry対象HTTP |
| `appEffects` | 揺れ検知、App Group、Widget反映が完了 | 通常アプリ側の処理が未完了または失敗 |

- 片方だけacknowledgeしても、もう片方から同じpendingを取得できる。
- 両consumer完了後だけpending全体を削除する。
- 古いupdate IDのacknowledgeで新しいpendingを変更しない。
- headless経路は`deviceLocation`だけを扱い、`appEffects`は次の通常起動まで残す。
- notification slot状態は`enabled` / `disabled` / `uninitialized`の3値である。
  `uninitialized`は無効とみなさず、headlessではretry、通常起動ではslotを取得して確定する。
- API結果はHTTP 400だけをterminalなpayload validation failureとする。404、その他の不明な4xx、
  401/403、network、timeout、5xxはretryし、pendingを残す。

## privacy境界

診断、report、Issue、共有ログへ緯度経度、認証token、端末名、個人情報を出さない。

共有してよい情報:

- update ID、headless結果名、HTTP status code
- WorkManagerのunique work名、state、attempt、schedule時刻
- API requestの地域・市区町村・津波予報区コード
- XCTest / Gradle / Flutter commandの成否とtest件数

共有してはいけない情報:

- pending store、Core Location、Fused Location Providerのraw値
- Authorization header、secure storage、SharedPreferences全体のdump
- 広範囲な端末logや`dumpsys location`の未編集出力

本実装の通常診断logはupdate IDと結果だけで、各native stageをすべて記録しない。`stored`、
`headless-started`、`deviceLocation-ack`を実機で詳しく追う場合は、該当関数へdebug breakpointを置き、
変数表示を共有しない。API側は地域コードだけを確認する。

## 共通準備と自動検証

fresh worktreeではsubmoduleとAsset Packを準備する。Flutter / Dart / Gradleは`mise exec --`経由で
実行する。

```bash
git submodule update --init --recursive
mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled

cd app
mise exec -- flutter test \
  test/feature/location/background_location_tracker_test.dart \
  test/feature/location/device_location_sync_service_test.dart \
  test/feature/location/device_location_sync_state_repository_test.dart \
  test/feature/location/background_location_update_notifier_test.dart \
  test/feature/location/background_location_service_error_test.dart \
  test/feature/location/headless_device_location_runner_test.dart \
  test/feature/location/headless_device_location_dependencies_test.dart \
  test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
mise exec -- flutter analyze --no-pub
```

full analyzeが既存診断で失敗した場合は、対象pathを別に解析し、診断元が比較BASEから未変更かも
確認する。既存診断を今回差分の成功に読み替えない。

```bash
cd app
mise exec -- dart analyze \
  lib/feature/location \
  ../packages/background_location_tracker
git --no-pager diff <TASK_BASE> -- <DIAGNOSTIC_FILE>
```

Pigeon schema変更時はgenerator versionを固定し、Dart / Swift / Kotlinを再生成する。生成後にDartを
workspaceのformatterへ通し、3生成物に未コミット差分がないことを確認する。

## iOS検証

### 前提

- 位置権限をAlwaysにし、現在地のnotification slotを有効にする。
- SettingsでBackground App Refreshを端末全体とアプリの両方で有効にする。
- Low Power Mode中はBackground App Refreshが無効になるため、検証時は解除する。
- Significant Location Changeは概ね500m以上の移動を契機とし、通知頻度もOS管理である。
- `.location` relaunchではmanagerを作り直して監視を再開する。実装は位置を
  AfterFirstUnlock対応のatomic storageへ保存してからbackground task / Engineを開始する。
- `BGTaskScheduler` handlerは`didFinishLaunchingWithOptions`終了前にidentifierごとに1回登録する。

### buildと状態機械

```bash
cd app/ios
xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'

cd ..
mise exec -- flutter build ios --simulator --debug --no-codesign
```

`OS=latest`に指定機種がなければ、`xcrun simctl list devices available`で利用可能なruntimeを確認し、
同じ機種の明示OSへfallbackする。fallbackした事実はreportへ残す。

Apple記載のBGTask debug selectorは、実機debugでtask handlerを検証する場合だけLLDBから実行する。
private selectorをアプリコードへ入れない。

```text
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateExpirationForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
```

### process terminated E2E

1. 非本番検証用の端末・アカウントで、権限、slot、networkを確認する。
2. foregroundとbackgroundで地域が変わる移動を行い、同じupdate IDについてAPIの地域コード更新と
   `deviceLocation`完了を確認する。
3. swipe-upせず、OSによるsuspend / terminationを待つ。実移動でSignificant Location Changeを起こす。
4. `stored → headless-started → api-success → deviceLocation-ack`の順序をbreakpointと安全な結果log、
   backendの地域コードで照合する。
5. 次回通常起動で`appEffects`が完了し、両consumer完了後にpendingがなくなることを確認する。

Xcodeのlocation simulationは機能確認には使えるが、debugger接続と人工イベントだけでは、OSによる
process終了後の実運用relaunchを証明しない。実機移動の結果を別に残す。

## Android検証

### WorkManager契約とbuild

Receiverは位置を保存してからunique work `eqmonitor-device-location-sync`を
`ExistingWorkPolicy.REPLACE`で登録する。workはnetwork接続制約と指数backoffを持ち、実行時に最新pendingを
読む。native workerはpendingをacknowledgeしない。

```bash
cd app/android
mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest
mise exec -- ./gradlew :background_location_tracker:lintDebug \
  --rerun-tasks --console=plain

cd ..
mise exec -- flutter build apk --debug
```

lintが既存Manifestで失敗する場合はreport全文と比較BASEからの差分を確認し、今回差分と分離する。

### process terminated E2E

1. 非本番検証用の端末またはemulatorでbackground location権限とslotを有効にする。
2. appをbackgroundへ移し、次のcommandで通常のprocess deathを近似する。
   `force-stop`はjobとreceiverを止める別条件なので使わない。
3. emulatorのroute / location controlで地域を変える。入力したraw位置をreportや共有logへ転記しない。
4. unique work実行とAPIの地域コード更新を照合する。
5. 通常起動後に`appEffects`も完了し、pendingが消えることを確認する。

```bash
adb devices -l
adb shell am kill net.yumnumm.eqmonitor
adb shell am broadcast \
  -a androidx.work.diagnostics.REQUEST_DIAGNOSTICS \
  -p net.yumnumm.eqmonitor
adb shell dumpsys jobscheduler net.yumnumm.eqmonitor
adb logcat -d | rg 'WM-DiagnosticsWrkr|PendingLocationWorker|HeadlessDeviceLocationRunner'
```

出力を共有する前にraw位置、token、端末識別情報がないことを確認する。Background Task Inspectorも
WorkManager stateの確認に使える。

## offline回復E2E

iOS / Androidの各process terminated E2Eに続けて確認する。

1. networkを切り、別地域の位置イベントを発生させる。
2. headless結果が`retry`で、`deviceLocation` pendingが残ることをupdate ID単位で確認する。
3. networkを戻し、次のworker / BGTask / 通常起動で同じpendingが送信されることを確認する。
4. API成功後は`deviceLocation`だけが完了し、通常起動前の`appEffects` pendingが残ることを確認する。
5. 通常起動でapp effects完了後、両consumer分のpendingが削除されることを確認する。
6. HTTP 400はterminal診断を保存して`deviceLocation`を完了し、それ以外の4xxや一時失敗はretryする。

## 公式資料

- [Apple: startMonitoringSignificantLocationChanges](https://developer.apple.com/documentation/corelocation/cllocationmanager/startmonitoringsignificantlocationchanges%28%29)
- [Apple: Handling location updates in the background](https://developer.apple.com/documentation/corelocation/handling-location-updates-in-the-background)
- [Apple: BGTaskScheduler register](https://developer.apple.com/documentation/backgroundtasks/bgtaskscheduler/register%28fortaskwithidentifier%3Ausing%3Alaunchhandler%3A%29)
- [Apple: BGTask expirationHandler](https://developer.apple.com/documentation/backgroundtasks/bgtask/expirationhandler)
- [Apple: Starting and Terminating Tasks During Development](https://developer.apple.com/documentation/backgroundtasks/starting-and-terminating-tasks-during-development)
- [Android: Define work requests](https://developer.android.com/develop/background-work/background-tasks/persistent/getting-started/define-work)
- [Android: Unique work](https://developer.android.com/develop/background-work/background-tasks/persistent/how-to/manage-work)
- [Android: WorkManager diagnostics](https://developer.android.com/develop/background-work/background-tasks/testing/persistent/debug)
- [Android: adb activity manager commands](https://developer.android.com/tools/adb#am)
- [Android: BroadcastReceiver process lifecycle](https://developer.android.com/develop/background-work/background-tasks/broadcasts)
