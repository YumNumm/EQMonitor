# iOS Significant Location Changeのheadless実行制約

## 再起動の前提

`startMonitoringSignificantLocationChanges()`は、OSによるprocess終了後に大きな位置変化が
届くとappをbackground relaunchし、launch optionsへ`.location`を付ける。relaunch時は
`CLLocationManager`を作り直し、同APIを再度開始しないとpending eventを受け取れない。

- Significant Location Changeには`authorizedAlways`が必要。
- Background App Refreshを端末全体またはapp単位で無効にすると、位置イベントによる
  relaunchは行われない。Low Power ModeではBackground App Refreshが自動的に無効になる。
- app switcherからのswipe-upはOSによる通常終了とは異なる。Appleはforce-quit flagが
  background launchを一般に抑止し、一部例外は非公開かつOSで変わり得るとしている。
  Significant Location Changeの例外が観測されるOSでも、swipe-up後の即時relaunchを
  製品要件や自動テストの保証条件にしない。
- 配信時刻と再試行時刻はOSが決める。位置イベントが来ない状態での即時同期は保証しない。

参考:

- [startMonitoringSignificantLocationChanges](https://developer.apple.com/documentation/corelocation/cllocationmanager/startmonitoringsignificantlocationchanges%28%29)
- [Location and Maps Programming Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html)
- [backgroundRefreshStatus](https://developer.apple.com/documentation/uikit/uiapplication/backgroundrefreshstatus)
- [iOS Background Execution Limits](https://developer.apple.com/forums/thread/685525)

## 保存・Engine・完了順序

headless Engine用のplugin registrantは、Storyboard / UISceneによるimplicit UI Engineの
初期化callbackに依存させない。`application(_:didFinishLaunchingWithOptions:)`の先頭で
同期設定し、その後にBGTask handler登録と`.location`監視復元を行う。background-only
launchではUI sceneが生成されない場合があるため、`didInitializeImplicitFlutterEngine`は
UI Engine自身へのplugin登録だけを担う。

位置はEngine起動やcallback handle確認より先に、AfterFirstUnlockで読めるatomic storageへ保存する。
callback handle未保存、plugin registrant未準備、Engine起動失敗、network失敗ではDevice Location
consumerをacknowledgeせず、pendingを後続実行へ残す。

1. pending位置を保存する。
2. `UIApplication.beginBackgroundTask`で短い処理時間を要求する。
3. callback handleからheadless `FlutterEngine`を1個だけ起動し、pluginを登録する。
4. Dartの`completeHeadlessTask(updateId, result)`でactive update IDを照合する。
5. 一致した完了だけEngineをdestroyし、background taskを1回終了する。
6. `retry`またはexpirationではpendingをacknowledgeせず、OS retry taskを再登録する。

expirationとDart完了が競合しても先着だけがcleanupする。処理中に新しい位置が保存された場合は
同じEngineへ重複launchせず、active cleanup後に最新update IDだけを再実行する。
`beginBackgroundTask`が`.invalid`を返した場合はbackground実行時間を確保できていないため、
Engineを起動しない。active stateを`retry`で1回だけfinalizeし、pendingを保持してretry requestを
登録する。

## BGTaskScheduler

短い再送用の`BGAppRefreshTask`には`fetch`、長めの再処理用の`BGProcessingTask`には
`processing` background modeが必要で、両identifierを
`BGTaskSchedulerPermittedIdentifiers`へ登録する。launch handlerは
`application(_:didFinishLaunchingWithOptions:)`が終わる前に各identifierにつき1回だけ登録する。
同じidentifierのrequestを再submitすると未実行requestを置き換える。

App RefreshとProcessingのsubmitは独立した`do/catch`で行う。一方が失敗しても他方をsubmitし、
少なくとも一方が成功したかを結果として保持する。失敗診断にはtask identifierとOS error code
だけを記録し、位置やcallback payloadを含めない。両方が失敗してもpendingを削除せず、次回app
launchまたはforeground移行時にpendingがあれば再submitする。Background App Refresh無効時などは
submit自体が失敗し得るため、「retry登録済み」と無条件に扱わない。

各taskは最初にexpiration handlerを設定し、終了時に`setTaskCompleted(success:)`を1回だけ呼ぶ。
expirationではEngineを破棄してfailure完了とし、pendingを残して次回retryへ渡す。

参考:

- [Using background tasks to update your app](https://developer.apple.com/documentation/uikit/using-background-tasks-to-update-your-app)
- [BGTask expirationHandler](https://developer.apple.com/documentation/backgroundtasks/bgtask/expirationhandler)
- [Starting and Terminating Tasks During Development](https://developer.apple.com/documentation/backgroundtasks/starting-and-terminating-tasks-during-development)

## 検証

Simulatorでは状態機械とbuildを検証できるが、Significant Location Changeによる終了中relaunch、
Always権限、Background App Refresh、BGTaskの実スケジューリングは実機でのみ確認する。

```shell
cd app/ios
xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_ID>'

cd app
mise exec -- flutter build ios --simulator --debug --no-codesign
```

実機debug中にtaskを明示起動・期限切れさせる場合だけ、Apple記載のLLDB debug commandを使う。
private selectorをapp codeへ含めてはならない。

```text
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateExpirationForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
```

実機ではupdate IDだけを端末診断とbackend requestへ対応付け、緯度経度をlogへ出さない。
offlineで`retry`になった後、network復帰時に同じpending update IDが成功することも確認する。
