# Headless Device Location Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** OSによるプロセス終了中を含むバックグラウンド位置更新で、端末内解決した `region`・`city`・`tsunamiForecastRegion` の変化をDevice Location APIへ欠落なく送信する。

**Architecture:** ネイティブ層が最新位置を利用者別acknowledge付きで永続化し、通常Flutter Engineまたは専用headless Engineへ通知する。Dartの純粋な同期サービスが地域解決、永続的な重複判定、認証付きAPI送信を共有し、iOSはCore Locationのbackground task、AndroidはWorkManagerで完了まで処理を保持する。

**Tech Stack:** Flutter/Dart、Riverpod 3、Dio、Pigeon、SharedPreferencesAsync、Flutter Secure Storage、Core Location/Swift、Android Fused Location Provider/Kotlin/WorkManager

**Spec:** `docs/superpowers/specs/2026-08-23-headless-device-location-sync-design.md`

## Global Constraints

- 緯度経度は端末内の地域解決にだけ使い、API、Crashlytics、外部ログへ送信しない。
- API送信判定は `region`、`city`、`tsunamiForecastRegion` の3項目を比較する。
- 現在地通知スロットが無効ならDevice Location APIを送信しない。
- 揺れ検知が現在地を利用する場合、Device Locationが無効でも位置監視と通常アプリ反映を維持する。
- pending位置はDevice Locationと通常アプリ反映の利用者別にacknowledgeし、両方の完了まで削除しない。
- Flutter/Dartコマンドはすべて `mise exec --` 経由で実行する。
- 固定値や偽の地域コードへフォールバックせず、解決不能時はpendingを保持する。
- 各production変更は失敗するテストを先に追加し、REDを確認してから実装する。

---

### Task 0: 実装ブランチへ接続

**Files:** 変更なし。

**Interfaces:**
- Consumes: detached HEAD上の設計・実装計画コミット。
- Produces: `codex/headless-device-location-sync` ブランチ。

- [ ] **Step 1: worktree状態を確認する**

Run: `git status --short --branch && git --no-pager log -2 --oneline`

Expected: working treeがcleanで、HEADに設計・計画コミットが存在する。

- [ ] **Step 2: 実装ブランチを作成する**

Codex App管理worktreeでbranch作成が拒否される場合はAppの「Create branch」を使い、
`codex/headless-device-location-sync` を指定する。CLIで許可される場合は次を実行する。

Run: `git switch -c codex/headless-device-location-sync`

Expected: `git branch --show-current` が `codex/headless-device-location-sync` を返す。

- [ ] **Step 3: 必須submoduleとAsset Packを準備する**

Run: `git submodule update --init third_party/flutter_scene`

Run: `mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled`

Expected: `third_party/flutter_scene/packages/flutter_scene` と `app/assets/platform/manifest.json` が存在し、`mise exec -- flutter pub get` が依存解決できる。

---

### Task 1: 共有Device Location同期ドメイン

**Files:**
- Create: `app/lib/feature/location/data/model/device_location_payload.dart`
- Create: `app/lib/feature/location/data/model/pending_device_location.dart`
- Create: `app/lib/feature/location/data/repository/device_location_sync_state_repository.dart`
- Create: `app/lib/feature/location/data/logic/device_location_sync_service.dart`
- Test: `app/test/feature/location/device_location_sync_service_test.dart`

**Interfaces:**
- Consumes: `JmaRegionResolver.resolveEarthquakeRegion()` と `resolveTsunamiForecastRegionCode()` が返す端末内解決結果。
- Produces: `DeviceLocationPayload`、`PendingDeviceLocation`、`DeviceLocationSyncResult`、`DeviceLocationSyncService.syncPending()`。

- [ ] **Step 1: 地域コードの各変化と同値抑止を表す失敗テストを書く**

```dart
test('cityだけが前回成功値と異なる場合に新payloadを送信する', () async {
  final state = InMemoryDeviceLocationSyncStateRepository(
    lastSent: const DeviceLocationPayload(
      region: '301',
      city: '0820100',
      tsunamiForecastRegion: '201',
    ),
  );
  final sent = <DeviceLocationPayload>[];
  final service = DeviceLocationSyncService(
    stateRepository: state,
    resolvePayload: ({required latitude, required longitude}) async =>
        const DeviceLocationPayload(
          region: '301',
          city: '0820200',
          tsunamiForecastRegion: '201',
        ),
    sendPayload: ({required payload}) async => sent.add(payload),
  );

  final result = await service.syncPending(
    location: const PendingDeviceLocation(
      updateId: 'u1', latitude: 36, longitude: 140,
      accuracy: 10, timestampMillis: 1000,
    ),
  );

  expect(result, DeviceLocationSyncResult.sent);
  expect(sent.single.city, '0820200');
  expect(await state.readLastSent(), sent.single);
});
```

同じ形で `region` 単独変化、`tsunamiForecastRegion` 単独変化、3項目同値、地域解決不能、API例外を個別テストにする。期待値は手書きリテラルとし、productionの比較関数で生成しない。

- [ ] **Step 2: テストを実行してREDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/location/device_location_sync_service_test.dart`

Expected: `DeviceLocationSyncService` とモデルが存在しないためコンパイルFAIL。

- [ ] **Step 3: 最小のモデルと同期サービスを実装する**

```dart
class DeviceLocationPayload {
  const DeviceLocationPayload({
    required this.region,
    required this.city,
    required this.tsunamiForecastRegion,
  });
  final String region;
  final String? city;
  final String? tsunamiForecastRegion;
  Map<String, dynamic> toJson() => {
    'region': region,
    if (city case final value?) 'city': value,
    if (tsunamiForecastRegion case final value?)
      'tsunamiForecastRegion': value,
  };
}

enum DeviceLocationSyncResult { sent, unchanged, disabled, noPending }

typedef ResolveDeviceLocationPayload = Future<DeviceLocationPayload?> Function({
  required double latitude,
  required double longitude,
});
typedef SendDeviceLocationPayload = Future<void> Function({
  required DeviceLocationPayload payload,
});
```

`DeviceLocationSyncService.syncPending()` は有効状態を読み、解決不能なら例外を投げ、前回成功値と同値なら `unchanged`、API成功後だけ `writeLastSent()` して `sent` を返す。例外を握りつぶしたりlastSentを先に更新したりしない。

- [ ] **Step 4: 対象テストをGREENにする**

Run: `cd app && mise exec -- flutter test test/feature/location/device_location_sync_service_test.dart`

Expected: 全ケースPASS。

- [ ] **Step 5: formatと解析を実行する**

Run: `mise exec -- dart format app/lib/feature/location/data app/test/feature/location/device_location_sync_service_test.dart`

Run: `cd app && mise exec -- dart analyze lib/feature/location/data/model lib/feature/location/data/logic lib/feature/location/data/repository test/feature/location/device_location_sync_service_test.dart`

Expected: エラーなし。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/location/data/model app/lib/feature/location/data/logic/device_location_sync_service.dart app/lib/feature/location/data/repository/device_location_sync_state_repository.dart app/test/feature/location/device_location_sync_service_test.dart
git commit -m "feat: 位置情報同期判定を共通化"
```

---

### Task 2: 永続的な成功payloadと送信可否

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Modify: `app/lib/feature/location/data/repository/device_location_sync_state_repository.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart`
- Test: `app/test/feature/location/device_location_sync_state_repository_test.dart`
- Test: `app/test/feature/location/background_location_update_notifier_test.dart`

**Interfaces:**
- Consumes: Task 1の `DeviceLocationPayload` と `DeviceLocationSyncStateRepository`。
- Produces: `SharedPreferencesDeviceLocationSyncStateRepository` と永続キー `backgroundLocationLastSentPayload`、`backgroundLocationCurrentSlotEnabled`。

- [ ] **Step 1: isolate再生成後も同値抑止できる失敗テストを書く**

```dart
test('再生成したRepositoryが最後の送信成功payloadを復元する', () async {
  final preferences = SharedPreferencesAsync();
  final first = SharedPreferencesDeviceLocationSyncStateRepository(preferences);
  await first.writeLastSent(
    const DeviceLocationPayload(
      region: '301', city: '0820100', tsunamiForecastRegion: '201',
    ),
  );

  final recreated = SharedPreferencesDeviceLocationSyncStateRepository(
    SharedPreferencesAsync(),
  );

  expect((await recreated.readLastSent())?.toJson(), {
    'region': '301',
    'city': '0820100',
    'tsunamiForecastRegion': '201',
  });
});
```

現在地スロットのGET/作成/削除/一括置換後に `isDeviceLocationSyncEnabled` が正しく保存されるテストも追加する。

- [ ] **Step 2: テストを実行してREDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/background_location_update_notifier_test.dart`

Expected: SharedPreferences実装とキーが無いためFAIL。

- [ ] **Step 3: キャッシュを持たないSharedPreferencesAsync実装を追加する**

```dart
enum SharedPreferencesKey {
  backgroundLocationLastSentPayload('background_location_last_sent_payload'),
  backgroundLocationCurrentSlotEnabled(
    'background_location_current_slot_enabled',
  ),
}
```

payloadはJSON objectとして保存し、読出し時に `region is String` を必須、他2項目は `String?` として検証する。不正JSONは送信済み扱いにせず `null` を返す。

- [ ] **Step 4: 通知スロット成功結果とローカル送信可否を同期する**

`NotificationSlotsNotifier.build()` のGET成功後、`putCurrentLocation()`、`replaceSlots()`、`deleteCurrentLocation()` のAPI成功後に現在地スロット有無を保存する。API失敗時にはローカル値を先行変更しない。

- [ ] **Step 5: 対象テストをGREENにする**

Run: `cd app && mise exec -- flutter test test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/background_location_update_notifier_test.dart`

Expected: 全ケースPASS。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart app/lib/feature/location/data/repository/device_location_sync_state_repository.dart app/lib/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart app/test/feature/location
git commit -m "feat: 現在地同期状態を永続化"
```

---

### Task 3: 利用者別acknowledge付きネイティブpending契約

**Files:**
- Modify: `packages/background_location_tracker/pigeons/background_location.dart`
- Modify: `packages/background_location_tracker/lib/src/background_location_tracker_impl.dart`
- Modify: `packages/background_location_tracker/lib/src/background_location.g.dart` (generated)
- Create: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/PendingLocationStore.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationPlugin.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationApi.g.swift` (generated)
- Create: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/PendingLocationStore.kt`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationPlugin.kt`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationApi.g.kt` (generated)
- Modify: `packages/background_location_tracker/android/build.gradle.kts`
- Create: `packages/background_location_tracker/android/src/test/kotlin/net/yumnumm/background_location_tracker/PendingLocationStoreTest.kt`
- Create: `app/ios/WidgetModelsTests/BackgroundLocationPendingLocationStoreTests.swift`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`
- Test: `app/test/feature/location/background_location_tracker_test.dart`

**Interfaces:**
- Consumes: OS位置更新の緯度・経度・精度・測位時刻。
- Produces: `PendingLocationMessage`、`PendingLocationConsumer`、`HeadlessTaskResult`、`peekPendingLocation()`、`acknowledgePendingLocation()`、`completeHeadlessTask()`。

- [ ] **Step 1: 新しいPigeon契約を使う失敗テストを書く**

```dart
test('古いupdateIdのacknowledgeでは新しいpendingを削除しない', () async {
  final first = await BackgroundLocationTracker.peekPendingLocation(
    consumer: PendingLocationConsumer.deviceLocation,
  );
  final acknowledged = await BackgroundLocationTracker.acknowledgePendingLocation(
    updateId: 'older-id',
    consumer: PendingLocationConsumer.deviceLocation,
  );

  expect(first?.updateId, 'new-id');
  expect(acknowledged, isFalse);
});
```

Device Locationだけacknowledgeした後も `appEffects` ではpeek可能、両方acknowledge後はnull、という契約もmock message handlerで検証する。
同じシナリオをSwiftの隔離した `UserDefaults` suiteとKotlinのtest Contextでも記述し、実際の永続storeがID不一致時に新しい位置を保持することを検証する。

- [ ] **Step 2: テストを実行してREDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/location/background_location_tracker_test.dart`

Run: `cd app/ios && xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'`

Run: `cd app/android && mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest`

Expected: 新しいPigeon型、native store、acknowledge APIが存在しないためFAIL。

- [ ] **Step 3: Pigeon schemaを定義して生成する**

```dart
enum PendingLocationConsumer { deviceLocation, appEffects }
enum HeadlessTaskResult { success, retry, terminalFailure }

class PendingLocationMessage {
  final String updateId;
  final double latitude;
  final double longitude;
  final double accuracy;
  final int timestampMillis;
}

@HostApi()
abstract class BackgroundLocationHostApi {
  void initialize(int callbackHandle);
  void startMonitoring();
  void stopMonitoring();
  PendingLocationMessage? peekPendingLocation(PendingLocationConsumer consumer);
  bool acknowledgePendingLocation(
    String updateId,
    PendingLocationConsumer consumer,
  );
  String? getActiveHeadlessTaskId();
  void completeHeadlessTask(String updateId, HeadlessTaskResult result);
}

@FlutterApi()
abstract class BackgroundLocationFlutterApi {
  void onLocationUpdate(PendingLocationMessage location);
}
```

Run: `cd packages/background_location_tracker && mise exec -- dart run pigeon --input pigeons/background_location.dart`

- [ ] **Step 4: Swift/Kotlinの永続storeを実装する**

両実装とも保存キーを一か所の定数に集約する。新規位置保存時にUUID update IDと2利用者の未完了状態を保存し、`peek(consumer:)` はその利用者が未完了の場合だけ返す。`acknowledge(updateId:consumer:)` はID一致時だけ該当利用者を完了し、両方完了時だけ全位置キーを削除する。

- [ ] **Step 5: live callbackより先に必ずpendingを保存する**

iOS `SignificantLocationMonitor` とAndroid `LocationUpdateReceiver` の両方で、Flutter Engineの有無にかかわらずstoreへ保存し、その `PendingLocationMessage` をlive Flutter APIまたはheadless runnerへ渡す。保存失敗時は未保存の位置をAPI処理済みに見せない。

- [ ] **Step 6: Dart契約テストと生成差分を検証する**

Run: `cd app && mise exec -- flutter test test/feature/location/background_location_tracker_test.dart`

Run: `cd app/ios && xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'`

Run: `cd app/android && mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest`

Run: `mise exec -- dart format packages/background_location_tracker/lib packages/background_location_tracker/pigeons app/test/feature/location/background_location_tracker_test.dart`

Expected: テストPASS、生成ファイル以外のformat差分なし。

- [ ] **Step 7: コミットする**

```bash
git add packages/background_location_tracker app/ios/Runner.xcodeproj/project.pbxproj app/ios/WidgetModelsTests/BackgroundLocationPendingLocationStoreTests.swift app/test/feature/location/background_location_tracker_test.dart
git commit -m "feat: 未処理位置を利用者別に保持"
```

---

### Task 4: 通常Flutter Engineを共有同期サービスへ移行

**Files:**
- Modify: `app/lib/feature/location/data/background_location_service.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart`
- Test: `app/test/feature/location/background_location_update_notifier_test.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

**Interfaces:**
- Consumes: Task 1の同期サービス、Task 2の永続state、Task 3のpending API。
- Produces: live位置と起動時pendingの双方を同じ `DeviceLocationSyncService` へ渡す通常アプリ経路。

- [ ] **Step 1: foreground処理のacknowledge順序を表す失敗テストを書く**

`appEffects` は揺れ検知・App Group処理後にacknowledgeされ、Device LocationはAPI成功または同値確認後にだけacknowledgeされることを、記録型fake repositoryのイベント順で検証する。API例外時は `deviceLocation` acknowledgeが無いことも別テストにする。

- [ ] **Step 2: テストを実行してREDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/location/background_location_update_notifier_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

Expected: 現行coordinatorがpending IDと利用者別acknowledgeを扱わないためFAIL。

- [ ] **Step 3: Repositoryのセッション内重複キャッシュを除去する**

`NotificationSlotRepository._lastDeviceLocationPayload` と `jsonEncode` 比較を削除し、`putDeviceLocation()` はAPI送信だけを担う `Future<void>` に戻す。重複判定は永続stateを使うTask 1のサービスへ一本化する。

- [ ] **Step 4: BackgroundLocationSyncCoordinatorを共有サービスへ接続する**

live streamの `PendingLocationMessage` と起動時 `peekPendingLocation()` を同じ処理へ渡す。Device Location結果が `sent` / `unchanged` / `disabled` の場合に該当consumerをacknowledgeし、例外時は残す。揺れ検知・App Group・Widget反映後に `appEffects` をacknowledgeする。

- [ ] **Step 5: 対象テストをGREENにする**

Run: `cd app && mise exec -- flutter test test/feature/location/background_location_update_notifier_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart test/feature/location/device_location_sync_service_test.dart`

Expected: 全ケースPASS。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/location/data/background_location_service.dart app/lib/feature/settings/features/notification_settings/data app/test/feature/location/background_location_update_notifier_test.dart app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
git commit -m "refactor: 位置更新の送信経路を統合"
```

---

### Task 5: 最小headless Dart bootstrap

**Files:**
- Create: `app/lib/feature/location/data/headless/headless_device_location_runner.dart`
- Create: `app/lib/feature/location/data/headless/headless_device_location_dependencies.dart`
- Create: `app/lib/feature/location/data/headless/headless_location_callback.dart`
- Modify: `app/lib/main.dart`
- Modify: `packages/background_location_tracker/lib/src/background_location_tracker_impl.dart`
- Delete: `packages/background_location_tracker/lib/src/callback_dispatcher.dart`
- Test: `app/test/feature/location/headless_device_location_runner_test.dart`
- Test: `app/test/feature/location/headless_device_location_dependencies_test.dart`

**Interfaces:**
- Consumes: Task 1〜4の共有同期処理とPigeon API。
- Produces: `@pragma('vm:entry-point') void backgroundLocationCallbackDispatcher()` と `HeadlessDeviceLocationRunner.run({required String taskUpdateId})`。

- [ ] **Step 1: headless結果とpending保持を表す失敗テストを書く**

```dart
test('API失敗時はretryを返しdeviceLocationをacknowledgeしない', () async {
  final pending = pendingLocation(updateId: 'u1');
  final bridge = RecordingBackgroundLocationBridge(pending: pending);
  final runner = HeadlessDeviceLocationRunner(
    bridge: bridge,
    createSyncService: () async => throwingSyncService,
  );

  final result = await runner.run(taskUpdateId: 'u1');

  expect(result, HeadlessTaskResult.retry);
  expect(bridge.acknowledgedConsumers, isEmpty);
  expect(bridge.completedUpdateId, 'u1');
});
```

成功、同値、無効、pendingなし、地域解決失敗、401/403、4xx不正payloadも結果分類を個別に検証する。pendingなしの場合でもnativeから取得したactive task IDへ成功完了を返し、workerを待機させないことを確認する。

- [ ] **Step 2: テストを実行してREDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/location/headless_device_location_runner_test.dart test/feature/location/headless_device_location_dependencies_test.dart`

Expected: headless runnerが存在しないためFAIL。

- [ ] **Step 3: callbackをアプリ側entrypointへ移す**

```dart
@pragma('vm:entry-point')
void backgroundLocationCallbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(const HeadlessDeviceLocationDependencies().run());
}
```

`BackgroundLocationTracker.initialize()` はコールバック関数を必須引数で受けてhandleを保存する。`main.dart` は `backgroundLocationCallbackDispatcher` を渡す。
dependenciesは最初に `getActiveHeadlessTaskId()` を読み、nullなら安全に終了する。IDがある場合はpendingの有無にかかわらず、最終的にそのIDへ完了結果を返す。

- [ ] **Step 4: 必要依存だけを構築するloaderを実装する**

`HeadlessDeviceLocationDependencies` は以下を順に初期化する。

1. `SharedPreferencesAsync` を使うTask 2のstate repository。
2. 既存と同じiOS keychain group/accessibilityを使う `SecurePreferencesDataSource` からdevice tokenを読む。
3. `rootBundle` の `Assets.jmaMap` と、Asset Packの `earthquakeStations` JSONだけを `ParameterJsonParser.parseEarthquake()` で読む。
4. `JmaRegionResolver` を構築する。
5. `BuildConfig.fromEnvironment()` と保存済みTelegram URLからREST URLを決める。
6. `PackageInfo`、`DeviceInfoPlugin`、`FlutterUdid`から通常APIと同じUser-Agent、version、platform、device ID、Bearer tokenヘッダーを持つDioを構築する。
7. `ApiClient` と `NotificationSlotRepository` を経由してTask 1のサービスを実行する。

Device Location endpointではAppCheckを要求しないため、Firebase、AppCheck、デバイス再登録は初期化しない。

- [ ] **Step 5: headless完了を必ずnativeへ返す**

runnerは成功・同値・無効・pendingなしを `success`、ネットワーク/timeout/5xx/地域解決不能・401/403を `retry`、再試行不能な不正4xxを `terminalFailure` として `completeHeadlessTask(updateId,result)` へ渡す。terminal failureは診断結果を保存してDevice Location consumerをacknowledgeし、通常アプリ反映consumerは残す。ログにはupdate IDと結果だけを記録し、緯度経度を含めない。

- [ ] **Step 6: 対象テストをGREENにする**

Run: `cd app && mise exec -- flutter test test/feature/location/headless_device_location_runner_test.dart test/feature/location/headless_device_location_dependencies_test.dart`

Expected: 全ケースPASS。

- [ ] **Step 7: コード生成と解析を実行する**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- dart analyze lib/feature/location/data/headless test/feature/location/headless_device_location_runner_test.dart test/feature/location/headless_device_location_dependencies_test.dart`

Expected: エラーなし。

- [ ] **Step 8: コミットする**

```bash
git add app/lib/feature/location/data/headless app/lib/main.dart app/test/feature/location/headless_device_location_runner_test.dart app/test/feature/location/headless_device_location_dependencies_test.dart packages/background_location_tracker/lib
git commit -m "feat: 終了中の位置同期Workerを追加"
```

---

### Task 6: iOS再起動とbackground taskの完了管理

**Files:**
- Modify: `app/ios/Runner/AppDelegate.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/LocationHeadlessRunner.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationPlugin.swift`
- Create: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/HeadlessTaskState.swift`
- Create: `app/ios/WidgetModelsTests/BackgroundLocationHeadlessTaskStateTests.swift`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`

**Interfaces:**
- Consumes: Task 3のpending store/完了APIとTask 5のDart callback。
- Produces: iOS background taskの開始・成功終了・期限切れ終了、およびEngine解放。

- [ ] **Step 1: runner状態機械の失敗テストを書く**

Flutterに依存しない `HeadlessTaskState` をplugin sourceへ切り出し、成功時にbackground taskを1回終了する、期限切れ時にpendingを残す、古いupdate IDを無視する、同時起動を1 Engineへまとめる各ケースを既存 `WidgetModelsTests` targetのXCTestで記述する。pluginのstate sourceを同targetのCompile Sourcesへ追加する。

- [ ] **Step 2: XCTestを実行してREDを確認する**

Run: `cd app/ios && xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'`

Expected: 完了管理用の状態型が存在しないためFAIL。

- [ ] **Step 3: AppDelegateの初期化順を修正する**

`super.application(...didFinishLaunchingWithOptions:)` の戻り値を先に取得し、`didInitializeImplicitFlutterEngine` で `pluginRegistrantCallback` が設定された後に `.location` launch optionを処理する。これによりheadless Engine起動前に全プラグイン登録コールバックを保証する。

- [ ] **Step 4: background taskとEngine lifecycleを実装する**

位置保存後に `UIApplication.shared.beginBackgroundTask` を開始し、callback handleからEngineを起動する。Dartの `completeHeadlessTask` でupdate IDを照合してEngineをdestroyしtaskを終了する。expiration handlerも同じcleanupを一度だけ実行するがpending consumerをacknowledgeしない。

- [ ] **Step 5: XCTestとiOS buildをGREENにする**

Run: `cd app/ios && xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'`

Run: `cd app && mise exec -- flutter build ios --simulator --debug --no-codesign`

Expected: XCTest PASS、Simulator build成功。

- [ ] **Step 6: コミットする**

```bash
git add app/ios/Runner/AppDelegate.swift app/ios/Runner.xcodeproj/project.pbxproj app/ios/WidgetModelsTests/BackgroundLocationHeadlessTaskStateTests.swift packages/background_location_tracker/ios
git commit -m "feat: iOS終了中の位置同期を完了管理"
```

---

### Task 7: Android WorkManagerによるheadless完了管理

**Files:**
- Modify: `packages/background_location_tracker/android/build.gradle.kts`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/LocationUpdateReceiver.kt`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationPlugin.kt`
- Replace: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/LocationHeadlessRunner.kt`
- Create: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/PendingLocationWorker.kt`
- Create: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/HeadlessTaskCompletionRegistry.kt`
- Create: `packages/background_location_tracker/android/src/test/kotlin/net/yumnumm/background_location_tracker/HeadlessTaskCompletionRegistryTest.kt`

**Interfaces:**
- Consumes: Task 3のpending/完了APIとTask 5のDart callback。
- Produces: unique work `eqmonitor-device-location-sync` とWorkManagerのsuccess/retry/failure結果。

- [ ] **Step 1: completion registryの失敗テストを書く**

正しいupdate IDだけ待機中workerを完了する、古いIDを無視する、timeoutでretryとなる、二重completeを無視する各ケースをKotlin unit testにする。

- [ ] **Step 2: Android unit testを実行してREDを確認する**

Run: `cd app/android && mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest`

Expected: registryとworkerが存在しないためFAIL。

- [ ] **Step 3: WorkManager依存とunique work enqueueを追加する**

`androidx.work:work-runtime-ktx` をpluginへ追加する。Receiverは位置を保存後、network connected制約と指数backoffを持つOneTimeWorkRequestを `ExistingWorkPolicy.REPLACE` で `eqmonitor-device-location-sync` としてenqueueし、直接Flutter Engineを生成しない。

- [ ] **Step 4: Workerでheadless Engineを保持する**

Workerはcallback handleを読み、`FlutterEngine` をフィールドで保持し、`GeneratedPluginRegistrant.registerWith(engine)` を明示してDart callbackを実行する。`completeHeadlessTask` の結果をregistryで待ち、success/retry/terminalFailureをWorkManager結果へ変換してからEngineをdestroyする。timeout・worker停止・例外でもEngineを解放し、pendingは削除しない。

- [ ] **Step 5: Android testとdebug buildをGREENにする**

Run: `cd app/android && mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest`

Run: `cd app && mise exec -- flutter build apk --debug`

Expected: unit test PASS、debug APK build成功。

- [ ] **Step 6: コミットする**

```bash
git add packages/background_location_tracker/android
git commit -m "feat: Android終了中の位置同期を永続実行"
```

---

### Task 8: 回帰確認・実機検証・運用知見

**Files:**
- Create: `docs/knowledge/20260823_headless_device_location_sync.md`
- Modify only if verification finds a scoped defect: files from Tasks 1〜7 with a new failing regression test first.

**Interfaces:**
- Consumes: Tasks 1〜7の完成したcross-platform実装。
- Produces: 再現可能な検証手順と、位置情報を含まない診断方法。

- [ ] **Step 1: 関連Dartテストをまとめて実行する**

Run: `cd app && mise exec -- flutter test test/feature/location/background_location_tracker_test.dart test/feature/location/device_location_sync_service_test.dart test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/background_location_update_notifier_test.dart test/feature/location/background_location_service_error_test.dart test/feature/location/headless_device_location_runner_test.dart test/feature/location/headless_device_location_dependencies_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

Expected: 全テストPASS。

- [ ] **Step 2: 静的解析とnative testを実行する**

Run: `cd app && mise exec -- flutter analyze --no-pub`

Run: `cd app/ios && xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,OS=latest,name=iPhone 16 Pro'`

Run: `cd app/android && mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest`

Expected: 対象コード由来のエラーなし。既知の `flutter_hooks_lint_plugin` Analysis Serverクラッシュが再発した場合は、target-code failureと分けて記録する。

- [ ] **Step 3: iOS実機でプロセス終了経路を検証する**

Always位置情報権限とBackground App Refreshを有効にし、現在地通知スロットを設定する。実機ビルドを終了後、Xcodeのlocation simulationまたは実移動で異なるcityへ移動し、update ID単位で `stored → headless-started → api-success → deviceLocation-ack` を確認する。API request bodyは地域コードだけを確認し、緯度経度をログへ出さない。

- [ ] **Step 4: Android実機でプロセス終了経路を検証する**

background location権限を許可し、アプリプロセス終了後にemulator locationを異なるcityへ変更する。`adb shell dumpsys jobscheduler` と位置情報を含まないアプリログでunique work実行を確認し、backend側のDevice Location更新と照合する。

- [ ] **Step 5: 失敗回復を両OSで確認する**

オフライン状態で地域を変化させ、pendingが残ることを確認する。オンライン復帰後の次回workerまたは通常起動で送信され、成功後にDevice Location consumerだけがacknowledgeされることを確認する。通常起動後に揺れ検知/App Group反映が完了し、全consumer完了後にpendingが削除されることも確認する。

- [ ] **Step 6: 運用知見を記録する**

`docs/knowledge/20260823_headless_device_location_sync.md` に、iOSのAlways権限・Background App Refresh・background task、AndroidのWorkManager、Asset Pack staging、位置情報を出さない診断ログ、実機検証コマンドを500行以内で記載する。

- [ ] **Step 7: 最終差分と生成物を確認する**

Run: `git --no-pager diff --check origin/develop...HEAD`

Run: `git status --short`

Expected: whitespace errorなし、意図しない変更なし、生成ファイルの未コミット差分なし。

- [ ] **Step 8: 知見と最終修正をコミットする**

```bash
git add docs/knowledge/20260823_headless_device_location_sync.md
git commit -m "docs: 終了中の位置同期手順を記録"
```

- [ ] **Step 9: push前に全コミットを確認する**

Run: `git --no-pager log --oneline origin/develop..HEAD`

Expected: 設計、共有同期、永続state、pending契約、通常経路、headless Dart、iOS、Android、知見が目的別コミットに分かれている。

- [ ] **Step 10: ブランチをpushする**

Run: `git push -u origin codex/headless-device-location-sync`

Expected: YumNumm/EQMonitorの同名remote branchへ全コミットがpushされる。PRはユーザーから明示依頼があった場合だけ `--repo YumNumm/EQMonitor --base develop` を指定して作成する。
