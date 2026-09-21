# 通知設定・権限・headless位置同期

2026-09-21統合。DartのHTTP分類・3値状態をコード確認した。以下のnative lifecycle契約と
実機手順は既存実装知識を集約したもので、本統合でOS終了後の動作を再検証したものではない。

## 通知・権限の所有

- EEW/地震情報のglobal enabledは常にtrue、有効/無効はslotが所有する。
  現在地slotの最小震度初期値はEEW予報4、地震情報1で、利用者が変更できる。
- Live Activityは「通知しない」以外で有効。custom復元でも古い無効値を引き継がない。
- 警報設定はslot詳細へ統合し、現在地はwarningEnabled、全国はtarget。地域別警報は非対応。
  全国警報はFree/Pro共通で、Pro制限やAPI 402条件を追加しない。
- 警報はbackend側のcritical通知契約。実際の配信状態は別途確認する。
- PermissionStateはOS状態だけを保持し、skipはonboarding中のWidget状態とする。
  NotifierがOS取得・変換・復帰時の再取得を担当し、Modelへ遷移ロジックを入れない。
- Firebase AuthorizationStatusの`deniedPermanently`も明示的に扱い、端末設定からの変更を案内する。
- プリセット初期化の同期callback問題は[UI残件](../todo/800_ui_and_navigation.md)。
  `NotificationPresetSelector`のuseEffect内onChangedは現コードにも存在し、実機再現は未実施。

## 揺れ検知の通知条件

- デバッグ画面の「揺れ検知の通知設定」から現在地・全国・細分化地域を設定する。画面は既存の通常設定ルートでも再利用でき、公開機能フラグは維持する。
- 手動地域はAsset Packの地震情報の都道府県→細分化地域から選ぶ。観測点マスターをAPIから取得しない。地域コードは3桁のAreaForecastLocalEで、EEW地域コードとは別。
- 現在地は共通Device Location APIへ送信する。揺れ検知条件のPUTや、市区町村コードから観測点IDへの変換は行わない。地域未取得の間は現在地通知を行わない。
- `DeviceLocationConsumersRepository` が独立に読み込まれた通常通知と揺れ検知を合成し、OS監視とheadless用の可否を更新する。更新は直列化し、読み込み順によって揺れ検知の現在地が無効にならないようにする。
- 旧地域条件はバックエンドで無効保存し、`requires_reconfiguration` がある間は再設定を案内する。保存失敗時は既存の設定表示を維持する。
- 通知タイトルは条件を満たす設定地域の最高レベル、本文はイベント全体の最大レベルと都道府県。設定地域が同じ最高レベルなら複数列挙する。全国と現在地・地域の併存にも対応する。

## 実行経路と保証境界

Android の通知 channel は [channel 運用](android_notification_channels.md) を参照する。

- nativeが最新位置を永続化し、headless Flutter Engineが地域解決とDevice Location API送信を担う。
  通常Engineはapp effects・Localデバッグ通知を担当し、同じAPIを並行送信しない。
- iOSはsingleton headless lifecycle、AndroidはPendingIntent→Receiver→unique WorkManager。
  生存中Engineへの通知成功だけでは永続実行を保証しない。
- iOSのOS終了後はSignificant Location Changeによるrelaunch。Always権限と
  Background App Refreshが必要。Low Power Modeでは後者が無効になる。
- `.location`起動ではCLLocationManagerを再作成して監視を再開する。
  概ね500m以上の移動が契機だが、配信・再試行時刻はOSが決め、即時同期を保証しない。
- swipe-up/force-stopは通常のOS終了とは別条件。これらの後の起動を合格条件にしない。
- 起動失敗時はFirebase初期化を確認してからCrashlyticsへ記録し、記録失敗でエラー画面を妨げない。
  Android受信位置はDartへ明示的に橋渡しし、listener登録前の最新値も保持する。

## 保存・acknowledge・認証

- 同じupdate IDをdeviceLocationとappEffectsの2 consumerが別々にacknowledgeする。
  両者完了後だけpending全体を削除し、古いIDのackで新しいpendingを変更しない。
- deviceLocationはsent/unchanged/disabled/HTTP 400のterminal処理で完了する。
  uninitialized、認証、network、timeout、地域解決、その他4xx/5xxはretryで保持する。
- headlessはdeviceLocationだけを完了し、appEffectsは通常起動でApp Group・Widget反映後に完了する。
- 現在地のconsumer状態はenabled/disabled/uninitialized。通常通知の現在地slotと、有効な揺れ検知現在地条件のORを永続化する。両方の読み込みが完了するまでは無効化しない。headlessは同じ永続状態を使用する。
- 重複排除recordはAPI endpointと送信済み地域payload。token保存/削除直前に消し、endpoint変更は別scope。
  token/hash/raw座標を記録せず、headless device IDは通常Engineと同じJWT subから復元する。
  token未保存/不正時にUDIDから代替IDを作らず、認証失敗をretryへ残す。
- 位置とconsumer状態は単一recordへ保存し、新形式の永続化成功後だけ旧形式を削除する。
  不完全recordでは緯度経度を含む全項目を削除する。
- Android commit失敗時は直前recordへ戻し、blt_prefs.xmlをcloud backup/device transferから除外する。
- iOSはbinary plistのatomic replaceとfile/親directoryの同期を行い、replace/rollback後にも
  backup除外とcompleteFileProtectionUntilFirstUserAuthenticationを設定する。

## iOS Engineとretry

- headless registrantをdidFinishLaunchingWithOptions先頭で同期登録する。UI scene初期化に依存しない。
  位置をAfterFirstUnlock対応storageへ保存してからcallback確認・Engine起動を行う。
- beginBackgroundTaskで時間を確保し、invalidならEngineを起動せずpendingを保持してretry登録する。
- 完了はactive update IDを照合し、expirationとの先着だけがEngine破棄・task終了を1回行う。
  処理中新位置は重複launchせず、cleanup後に最新IDだけ再実行する。
- BGAppRefreshTaskはfetch、BGProcessingTaskはprocessing modeとpermitted identifiersが必要。
  launch handlerはdidFinishLaunchingWithOptions終了前にidentifierごとに1回登録する。
- 両taskのsubmitは独立したdo/catch。一方失敗でも他方を試し、両方失敗でもpendingを消さない。
  identifier/OS error codeだけを診断し、無条件に「retry登録済み」と扱わない。
- UIScene環境の復帰はUIApplication.didBecomeActiveNotificationを一度購読し、pending時に再submit。
  observerを多重登録せず破棄時に解除する。各taskはexpirationを先に設定し完了を1回だけ通知する。

## Android Engineとretry

- Receiverは保存後にunique work `eqmonitor-device-location-sync`をREPLACEで登録する。
  CONNECTED制約、30秒開始の指数backoffを使い、workerは実行時の最新pendingを読む。
- Receiver内でEngineを起動しない。native workerは成功/terminal/retry/timeoutのいずれもackしない。
- cold起動はcallback handle→FlutterLoader→auto-registration無効Engine→messenger/registration bind
  →callback lookup→GeneratedPluginRegistrant→Dartの順。lookupをEngine生成前に行わない。
- bootstrap/destroyはmain dispatcher、interrupt可能な完了待ちはIO dispatcher。
  handle不正・LinkageError・起動失敗・timeout/cancelはretryとし、生成したEngineは必ず1回destroyする。
- 完了はregistration同一性とupdate IDで照合し、二重/遅延/REPLACE前Engineの完了を無視する。
  plugin attach前にbindし、active mappingを都度確認する。通常Engineには完了権限を与えない。
- Dart success/terminalFailureはResult.success、retry等はResult.retry。terminalを失敗へ変換しない。
- 現契約は60秒timeoutの通常CoroutineWorker。long-running化する際はAndroid 14以降の
  foreground service type/permission、通知、Android 16のJobScheduler quotaを再評価する。

## 検証と診断

コード確認: `app/lib/feature/location/data/headless/headless_device_location_runner.dart`、
`app/lib/feature/location/data/repository/device_location_sync_state_repository.dart`。
Flutter の自動検証は `app/` から:

```sh
mise exec -- flutter test test/feature/location \
  test/feature/settings/features/notification_settings --dart-define=CI=true
mise exec -- dart analyze lib/feature/location
```

native の検証は `app/android/` から（fresh checkout の未生成 gradlew へ依存しない）:

```sh
mise exec -- gradle :background_location_tracker:testDebugUnitTest --console=plain
mise exec -- gradle :background_location_tracker:lintDebug --console=plain
```

- iOSはWidgetModelsTestsとSimulator buildで状態機械を確認し、実機でAlways/Background App Refresh、
  OS終了後の移動→API更新、offline→retry→回復、通常起動後のappEffects完了を確認する。
- BGTaskの手動起動/expirationは実機debugのLLDBからAppleのdebug selectorを使う。
  private selectorをアプリコードへ組み込まない。Simulator位置入力だけでrelaunch成功としない。
- Androidは`adb shell am kill net.yumnumm.eqmonitor`後に位置を変え、WorkManager Inspectorまたは
  `androidx.work.diagnostics.REQUEST_DIAGNOSTICS`、jobschedulerでunique workとAPI更新を照合する。
- offlineで同じupdate IDが残り、回復後はdeviceLocationのみ完了、通常起動後にpending全体が消えることを確認する。
- 共有する診断はupdate ID、結果、HTTP status、work state/attempt、地域コードのみ。
  raw座標・token・端末名・storage全dump・未編集dumpsys locationを共有しない。
- native各stageが常時ログされるとは限らない。詳細はbreakpointで追い、変数の個人情報を転記しない。
- 旧記録のlint/ビルド失敗は当時のbaseline。現在の結果は全文reportと対象差分で判断する。

実機debugのLLDBでのApp Refresh handler確認例（OSによる自然起動の証明ではない）:

```text
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateExpirationForTaskWithIdentifier:@"net.yumnumm.eqmonitor.background-location-refresh"]
```

公式資料: [Apple background location](https://developer.apple.com/documentation/corelocation/handling-location-updates-in-the-background)、
[Apple background execution limits](https://developer.apple.com/forums/thread/685525)、
[Android unique work](https://developer.android.com/develop/background-work/background-tasks/persistent/how-to/manage-work)。
