# Headless Device Location Sync Simplification Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** PR #1762のprocess-terminated Device Location同期を、単一headless executor、Freezed/JsonSerializable Model、Riverpod Generatorへ整理し、既存Local通知を維持したまま不要なlease/generation構造を削除する。

**Architecture:** 通常Flutter Engineはapp effectsとLocalデバッグ通知だけを処理し、Device Location APIはAndroid unique WorkManagerまたはiOS singleton headless lifecycleだけが処理する。native pendingは最新1件とconsumer別ackを維持し、API成功まで削除しない。device token変更時はlast-sent recordを削除し、registration generationとcross-engine leaseは廃止する。

**Tech Stack:** Flutter/Dart, Freezed, JsonSerializable, Riverpod Generator, Pigeon, Kotlin/WorkManager, Swift/CoreLocation/BGTaskScheduler, SharedPreferences, XCTest/JUnit

**Spec:** `docs/superpowers/specs/2026-08-24-simplify-headless-device-location-sync-design.md`

## Global Constraints

- Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。
- production/testを含む今回の変更範囲で手書きRiverpod Provider宣言を追加・維持しない。
- Dartの値ModelはFreezedを使用し、永続化またはJSON境界を持つModelはJsonSerializableも使用する。
- Pigeon生成message classへFreezedを重ねない。
- raw緯度経度をDevice Location API payload、SharedPreferencesのDart state、通常ログへ含めない。
- Device Location APIはheadless executorだけが呼び、通常Engineはapp effectsだけを処理する。
- HTTP 400だけをterminalとし、その他の失敗ではdeviceLocation pendingを保持する。
- 元ブランチ`codex/headless-device-location-sync`とDraft PR #1762はforce-pushや履歴変更を行わない。
- 実機process-terminated/offline E2Eはユーザー指定どおり完了条件に含めない。

---

### Task 1: Dart ModelをFreezedとJsonSerializableへ統一する

**Files:**
- Modify: `app/lib/feature/location/data/model/device_location_payload.dart`
- Modify: `app/lib/feature/location/data/model/pending_device_location.dart`
- Create: `app/lib/feature/location/data/model/device_location_sync_scope.dart`
- Create: `app/lib/feature/location/data/model/device_location_sync_state_record.dart`
- Create: `app/lib/feature/location/data/model/headless_api_identity.dart`
- Modify: `app/lib/feature/location/data/headless/headless_device_location_dependencies.dart`
- Delete: `packages/background_location_tracker/lib/src/location_update_message.dart`
- Modify: `packages/background_location_tracker/lib/background_location_tracker.dart`
- Modify: `packages/background_location_tracker/lib/src/background_location_tracker_impl.dart`
- Test: `app/test/feature/location/device_location_sync_state_repository_test.dart`
- Test: `app/test/feature/location/headless_device_location_dependencies_test.dart`
- Test: `app/test/feature/location/background_location_tracker_test.dart`

**Interfaces:**
- Produces: `DeviceLocationPayload.fromJson`, `DeviceLocationPayload.toJson`, `DeviceLocationSyncScope.fromApiBaseUrl`, `DeviceLocationSyncStateRecord.fromJson`, `HeadlessApiIdentity.fromJson`
- Removes: public legacy `LocationUpdateMessage`, `BackgroundLocationTracker.locationStream`, `BackgroundLocationTracker.consumePendingLocation`

- [ ] **Step 1: Freezed equalityとJSON round-tripの失敗テストを追加する**

```dart
test('DeviceLocationPayload supports value equality and JSON round trip', () {
  const payload = DeviceLocationPayload(
    region: '130',
    city: '13101',
    tsunamiForecastRegion: '100',
  );
  expect(DeviceLocationPayload.fromJson(payload.toJson()), payload);
});

test('state record rejects a different endpoint by value comparison', () {
  const record = DeviceLocationSyncStateRecord(
    scope: DeviceLocationSyncScope(apiEndpoint: 'https://api.example/v2/device/me/location'),
    payload: DeviceLocationPayload(region: '130'),
  );
  expect(record.scope, isNot(const DeviceLocationSyncScope(apiEndpoint: 'https://other.example/v2/device/me/location')));
});
```

- [ ] **Step 2: 対象テストを実行してgenerated API未定義で失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/headless_device_location_dependencies_test.dart
```

Expected: `fromJson`、Freezed generated mixin、または新Modelが未定義でFAILする。

- [ ] **Step 3: Freezed Modelを実装する**

`device_location_payload.dart`は次の形にする。

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_payload.freezed.dart';
part 'device_location_payload.g.dart';

@freezed
abstract class DeviceLocationPayload with _$DeviceLocationPayload {
  const factory DeviceLocationPayload({
    required String region,
    String? city,
    String? tsunamiForecastRegion,
  }) = _DeviceLocationPayload;

  factory DeviceLocationPayload.fromJson(Map<String, dynamic> json) =>
      _$DeviceLocationPayloadFromJson(json);
}
```

`PendingDeviceLocation`、`DeviceLocationSyncScope`、`DeviceLocationSyncStateRecord`、`HeadlessApiIdentity`も同じFreezed + JsonSerializable形式で定義する。`DeviceLocationSyncScope.fromApiBaseUrl`はprivate methodにせずfactory bodyを持つextension `DeviceLocationSyncScopeFactory`へ置く。

- [ ] **Step 4: legacy LocationUpdateMessageを削除する**

`BackgroundLocationTracker`のapp-facing streamは`PendingLocationMessage`だけを公開し、legacy stream、legacy pending cache、`consumePendingLocation`を削除する。既存テストは`pendingLocationStream`とconsumer別`peek/acknowledge`を検証する形へ変更する。

- [ ] **Step 5: build_runnerを実行する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: 5 Modelの`.freezed.dart`と`.g.dart`が生成される。

- [ ] **Step 6: Model関連テストを実行する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/headless_device_location_dependencies_test.dart test/feature/location/background_location_tracker_test.dart
```

Expected: 全テストPASS。

- [ ] **Step 7: Task 1をコミットする**

```bash
git add app/lib/feature/location/data/model app/lib/feature/location/data/headless/headless_device_location_dependencies.dart app/test/feature/location packages/background_location_tracker/lib
git commit -m "refactor: 位置同期ModelをFreezedへ統一"
```

---

### Task 2: Riverpod Generatorへ統一しregistration generationを削除する

**Files:**
- Delete: `app/lib/feature/devices/data/repository/device_registration_generation_repository.dart`
- Modify: `app/lib/feature/devices/data/repository/device_auth_repository.dart`
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Modify: `app/lib/feature/location/data/provider/device_location_sync_scope_provider.dart`
- Modify: `app/lib/feature/location/data/repository/device_location_sync_state_repository.dart`
- Modify: `app/lib/core/provider/telegram_url/provider/telegram_url_provider.dart`
- Delete: `app/test/feature/devices/device_registration_generation_repository_test.dart`
- Modify: `app/test/feature/devices/device_repository_auth_token_test.dart`
- Modify: `app/test/feature/location/device_location_sync_state_repository_test.dart`
- Modify: `app/test/feature/location/background_location_update_notifier_test.dart`
- Create: `app/test/feature/location/background_location_provider_policy_test.dart`

**Interfaces:**
- Produces generated: `deviceLocationSyncStateRepositoryProvider`, `deviceLocationSyncScopeProvider`
- Produces: `DeviceLocationSyncStateRepository.clearLastSent()`
- Removes: `deviceRegistrationGenerationRepositoryProvider`, `deviceRegistrationGeneration` preference key

- [ ] **Step 1: credential変更とProvider policyの失敗テストを追加する**

```dart
test('saving a device token clears last sent Device Location state first', () async {
  final events = <String>[];
  final repository = DeviceAuthRepository(
    preferences,
    onCredentialsWillChange: () async => events.add('clear-location-state'),
  );
  await repository.saveToken(token: 'new-token');
  expect(events, ['clear-location-state']);
});
```

policy testは変更対象Dart fileを読み、次のpatternが0件であることを確認する。

```dart
final forbidden = RegExp(
  r'\b(?:Provider|FutureProvider|StreamProvider|StateProvider|NotifierProvider|AsyncNotifierProvider)(?:<[^;]+>)?\s*\(',
);
```

- [ ] **Step 2: 失敗テストを実行する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/devices/device_repository_auth_token_test.dart test/feature/location/background_location_provider_policy_test.dart
```

Expected: 手書きProvider検出またはlast-sent clear未実装でFAIL。

- [ ] **Step 3: repositoryとscopeをgenerated providerへ変換する**

```dart
@Riverpod(keepAlive: true)
DeviceLocationSyncStateRepository deviceLocationSyncStateRepository(Ref ref) =>
    SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

@Riverpod(keepAlive: true)
Future<DeviceLocationSyncScope> deviceLocationSyncScope(Ref ref) async {
  final baseUrl = (await ref.watch(telegramUrlProvider.future)).restApiUrl;
  return DeviceLocationSyncScopeFactory.fromApiBaseUrl(baseUrl);
}
```

`DeviceAuthRepository`のcredential変更callbackは`clearLastSent`を呼ぶ。Telegram URL変更時はrecordにendpointを持つため明示削除を必須とせず、scope不一致をcache missとして扱う。

- [ ] **Step 4: registration generationを削除する**

repository file、preference key、関連test、headless loaderのgeneration読込を削除する。last-sent JSONは`DeviceLocationSyncStateRecord.fromJson`でdecodeし、旧generation形式はcache missとして安全に無視する。

- [ ] **Step 5: test helperの手書きFutureProviderを削除する**

`background_location_update_notifier_test.dart`ではprivate `FutureProvider`群を作らず、`BackgroundLocationSyncCoordinator`を直接呼ぶか、生成済み`backgroundLocationServiceProvider`のdependencyをoverrideして検証する。

- [ ] **Step 6: build_runnerと対象テストを実行する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/devices/device_repository_auth_token_test.dart test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/background_location_update_notifier_test.dart test/feature/location/background_location_provider_policy_test.dart
```

Expected: 全テストPASSし、policy testが手書きProvider 0件を報告する。

- [ ] **Step 7: Task 2をコミットする**

```bash
git add app/lib/core/data/preferences app/lib/core/provider/telegram_url app/lib/feature/devices app/lib/feature/location app/test/feature/devices app/test/feature/location
git commit -m "refactor: 位置同期Providerをgeneratorへ統一"
```

---

### Task 3: Device Location APIを単一headless executorへ限定する

**Files:**
- Modify: `app/lib/feature/location/data/background_location_service.dart`
- Modify: `app/lib/feature/location/data/headless/headless_device_location_dependencies.dart`
- Modify: `app/lib/feature/location/data/headless/headless_device_location_runner.dart`
- Modify: `app/lib/feature/location/data/logic/device_location_sync_service.dart`
- Delete: `app/lib/feature/location/data/logic/background_location_sync_lease.dart`
- Modify: `app/test/feature/location/background_location_update_notifier_test.dart`
- Modify: `app/test/feature/location/device_location_sync_service_test.dart`
- Modify: `app/test/feature/location/headless_device_location_runner_test.dart`
- Modify: `app/test/feature/location/headless_device_location_dependencies_test.dart`

**Interfaces:**
- Normal Engine consumes/acks only `PendingLocationConsumer.appEffects`
- Headless runner consumes/acks only `PendingLocationConsumer.deviceLocation`
- `DeviceLocationSyncService.sync` no longer accepts or acquires a lease

- [ ] **Step 1: executor ownershipの失敗テストを追加する**

```dart
test('foreground coordinator never sends Device Location API', () async {
  await coordinator.applyPendingLocation(container);
  expect(deviceLocationSendCount, 0);
  expect(appEffectsAcknowledged, isTrue);
});

test('headless runner is the only Device Location API sender', () async {
  final result = await runner.run(taskId: 'task-1');
  expect(result, HeadlessTaskResult.success);
  expect(deviceLocationSendCount, 1);
  expect(deviceLocationAcknowledged, isTrue);
});
```

- [ ] **Step 2: executor ownershipテストを実行してforeground sender呼出しで失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/location/background_location_update_notifier_test.dart test/feature/location/headless_device_location_runner_test.dart
```

Expected: foreground経路のsend countが1となりFAIL。

- [ ] **Step 3: foreground coordinatorをapp effects専用にする**

`backgroundLocationService`は`PendingLocationConsumer.appEffects`のstream/peekだけを処理する。`syncDeviceLocation`、scope/state repositoryのforeground依存、Device Location API結果によるackを削除する。既存のslot、shake、App Group、Localデバッグ通知処理とappEffects ackは残す。

- [ ] **Step 4: DeviceLocationSyncServiceからleaseを削除する**

serviceはavailability、resolve、dedupe、PUT、last-sent writeだけを順に行う。lease interface、exception、manager field、`isCurrent`確認を削除する。最新update ID保護はnative storeのstale acknowledge契約へ一本化する。

- [ ] **Step 5: headless dependencyをgenerated provider中心に整理する**

callbackは`ProviderContainer`を一つ作り、生成されたheadless runner providerをreadして完了後disposeする。単純なdependency loader/factory classは`@Riverpod(keepAlive: true)` functionへ変換し、テストはprovider overrideを使う。JSON値ModelはTask 1のFreezed型を使う。

- [ ] **Step 6: Device Location同期テストを実行する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/location/background_location_update_notifier_test.dart test/feature/location/device_location_sync_service_test.dart test/feature/location/headless_device_location_runner_test.dart test/feature/location/headless_device_location_dependencies_test.dart
```

Expected: foreground send 0、headless send 1、成功/unchanged/disabledのみack、retry failureはpending保持。

- [ ] **Step 7: Task 3をコミットする**

```bash
git add app/lib/feature/location app/test/feature/location
git commit -m "refactor: 位置API送信をheadlessへ限定"
```

---

### Task 4: native leaseを削除し単一executor schedulingへ整理する

**Files:**
- Modify: `packages/background_location_tracker/pigeons/background_location.dart`
- Modify generated: `packages/background_location_tracker/lib/src/background_location.g.dart`
- Modify generated: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationApi.g.kt`
- Modify generated: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationApi.g.swift`
- Delete: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/DeviceLocationSyncLeaseStore.kt`
- Delete: `packages/background_location_tracker/android/src/test/kotlin/net/yumnumm/background_location_tracker/DeviceLocationSyncLeaseStoreTest.kt`
- Delete: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/DeviceLocationSyncLeaseStore.swift`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/LocationUpdateReceiver.kt`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/PendingLocationWorker.kt`
- Modify: `packages/background_location_tracker/android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationPlugin.kt`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationPlugin.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/LocationHeadlessRunner.swift`
- Modify: `packages/background_location_tracker/ios/background_location_tracker/Sources/background_location_tracker/HeadlessExecutionLifecycle.swift`
- Modify: `app/ios/WidgetModelsTests/BackgroundLocationPendingLocationStoreTests.swift`
- Modify: `packages/background_location_tracker/android/src/test/kotlin/net/yumnumm/background_location_tracker/PendingLocationWorkerTest.kt`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`

**Interfaces:**
- Pigeon host API retains monitoring, pending peek/ack, active task and completion methods
- Removes: `DeviceLocationSyncLeaseMessage` and acquire/isCurrent/release methods
- Android location event always schedules unique Device Location work after save
- iOS location event always submits the singleton Device Location headless lifecycle after save

- [ ] **Step 1: native single-executorの失敗テストを追加する**

Android testは同じpendingに対する複数enqueueがunique work一件へ収束し、foreground dispatch有無でscheduleが省略されないことを確認する。iOS testはlive Flutter callbackとは独立してheadless lifecycle submitが一回だけ行われることを確認する。

- [ ] **Step 2: native testを実行して現在のdispatch/lease契約との差で失敗することを確認する**

Run:

```bash
cd app/android
mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest --console=plain
cd ../ios
mise exec -- xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=macOS' -quiet
```

Expected: lease APIまたはschedule回数の期待差でFAIL。

- [ ] **Step 3: Pigeon schemaからlease APIを削除して再生成する**

Run:

```bash
cd packages/background_location_tracker
mise exec -- dart run pigeon --input pigeons/background_location.dart
```

workspace analyzer競合が発生する場合は`docs/knowledge/20260823_pigeon_analyzer_isolation.md`のPigeon 26.3.4分離手順を使用する。

- [ ] **Step 4: Androidをunique WorkManager単一executorへ整理する**

receiverはsave-before-callbackを維持し、appEffects用live dispatch後もDevice Location用unique workをscheduleする。Workerだけがheadless Device Location callbackを起動する。Worker完了時はtask ID一致を確認し、retry/terminal契約を維持する。

- [ ] **Step 5: iOSをsingleton headless executorへ整理する**

pluginのmonitor callbackはpending保存、appEffects live dispatch、headless lifecycle submitの順に行う。BGTaskは同じrunnerを再開するtriggerに限定する。lease store参照、Xcode project file entry、lease testを削除する。

- [ ] **Step 6: native testを再実行する**

Run:

```bash
cd app/android
mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest --console=plain
cd ../ios
mise exec -- xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=macOS' -quiet
```

Expected: Android/iOS全native test PASS。

- [ ] **Step 7: Task 4をコミットする**

```bash
git add packages/background_location_tracker app/ios/Runner.xcodeproj app/ios/WidgetModelsTests
git commit -m "refactor: native位置同期を単一executorへ整理"
```

---

### Task 5: device lifecycle後のmonitoring reconcileを完成させる

**Files:**
- Modify: `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart`
- Modify: `app/lib/feature/location/data/background_location_monitoring_lifecycle.dart`
- Modify: `app/lib/feature/location/data/background_location_service.dart`
- Modify: `app/test/feature/devices/device_repository_auth_token_test.dart`
- Modify: `app/test/feature/location/background_location_service_error_test.dart`
- Modify: `app/test/feature/location/background_location_update_notifier_test.dart`

**Interfaces:**
- Device delete success stops monitoring after clearing consumer state
- Reprovision invalidates/refetches slots and shake settings, then invokes common reconcile

- [ ] **Step 1: in-process delete/reprovisionの失敗テストを追加する**

```dart
test('device delete stops monitoring when the replacement has no consumers', () async {
  await notifier.deleteDeviceAndClearLocal();
  expect(stopMonitoringCalls, 1);
});

test('reprovision refetches both consumer states before reconcile', () async {
  await notifier.reprovision();
  expect(refetchedProviders, containsAll(['notificationSlots', 'shakeDetectionSettings']));
  expect(stopMonitoringCalls, 1);
});
```

- [ ] **Step 2: lifecycle testを実行してstop未呼出しで失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/location/background_location_service_error_test.dart test/feature/location/background_location_update_notifier_test.dart test/feature/devices/device_repository_auth_token_test.dart
```

Expected: delete/reprovision経路のstopまたはrefetch期待でFAIL。

- [ ] **Step 3: device lifecycleから共通reconcileを呼ぶ**

delete成功時はconsumerなしを確定させて明示stopする。provision成功時は`notificationSlotsProvider`と`shakeDetectionSettingsProvider`をinvalidateし、両futureを取得して`BackgroundLocationMonitoringLifecycle.reconcile`へ渡す。取得失敗時は既存policyどおり誤stopしない。

- [ ] **Step 4: lifecycle testを再実行する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/location/background_location_service_error_test.dart test/feature/location/background_location_update_notifier_test.dart test/feature/devices/device_repository_auth_token_test.dart
```

Expected: 全テストPASS。

- [ ] **Step 5: Task 5をコミットする**

```bash
git add app/lib/feature/devices app/lib/feature/location app/test/feature/devices app/test/feature/location
git commit -m "fix: device再登録後の位置監視を整合"
```

---

### Task 6: 重複文書を整理して全体検証する

**Files:**
- Modify: `docs/knowledge/20260823_headless_device_location_sync.md`
- Delete or merge: `docs/knowledge/20260824_device_location_sync_concurrency_privacy.md`
- Delete or merge: `docs/knowledge/20260824_pending_location_atomic_persistence.md`
- Modify: `docs/knowledge/20260824_android_headless_location_workmanager.md`
- Modify: `docs/knowledge/20260824_ios_significant_location_headless_execution.md`
- Modify: `docs/superpowers/specs/2026-08-24-simplify-headless-device-location-sync-design.md`

**Interfaces:**
- Produces one authoritative operational guide plus platform-specific command notes

- [ ] **Step 1: 文書を実装済み構成へ更新する**

cross-engine leaseとregistration generationの説明を削除し、単一headless executor、consumer別pending、Freezed Model、generated Provider、実機E2E境界を記録する。重複文書は内容をauthoritative guideへ移して削除する。

- [ ] **Step 2: generated artifactsを再生成してcleanを確認する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
cd ../packages/background_location_tracker
mise exec -- dart run pigeon --input pigeons/background_location.dart
cd ../..
git status --short
```

Expected: 意図したgenerated file以外の追加差分なし。

- [ ] **Step 3: Dart analyzeと関連Flutter testを実行する**

Run:

```bash
cd app
mise exec -- dart analyze lib/feature/location lib/feature/devices test/feature/location test/feature/devices
mise exec -- flutter test test/feature/devices/device_repository_auth_token_test.dart test/feature/location/background_location_backup_policy_test.dart test/feature/location/background_location_service_error_test.dart test/feature/location/background_location_tracker_test.dart test/feature/location/background_location_update_notifier_test.dart test/feature/location/device_location_sync_service_test.dart test/feature/location/device_location_sync_state_repository_test.dart test/feature/location/headless_device_location_dependencies_test.dart test/feature/location/headless_device_location_runner_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
```

Expected: analyze 0 diagnostics、関連test全PASS。

- [ ] **Step 4: Android test/buildを実行する**

Run:

```bash
cd app/android
mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest :app:assembleDebug --console=plain
```

Expected: `BUILD SUCCESSFUL`。

- [ ] **Step 5: iOS test/buildを実行する**

Run:

```bash
cd app/ios
mise exec -- xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=macOS' -quiet
mise exec -- flutter build ios --simulator --debug --no-codesign
```

Expected: XCTest exit 0、`Built build/ios/iphonesimulator/Runner.app`。

- [ ] **Step 6: 差分縮小と規約を確認する**

Run:

```bash
git diff --check codex/headless-device-location-sync..HEAD
git diff --stat 41a983d85ddad792effb84a8bb923b9395f6a026..HEAD
rg -n "\b(Provider|FutureProvider|StreamProvider|StateProvider|NotifierProvider|AsyncNotifierProvider)(<[^;]+>)?\s*\(" app/lib/feature/location app/lib/feature/devices app/test/feature/location app/test/feature/devices
rg -n "DeviceLocationSyncLease|registrationGeneration|deviceRegistrationGeneration" app packages/background_location_tracker
```

Expected: diff check成功、手書きProvider 0件、lease/generation参照0件、PR #1762よりproduction構造と総差分が縮小している。

- [ ] **Step 7: Task 6をコミットする**

```bash
git add docs app packages/background_location_tracker mise.toml mise.lock
git commit -m "docs: 簡素化後の位置同期手順を整理"
```

- [ ] **Step 8: branch状態を確認する**

Run:

```bash
git status --short
git log --oneline codex/headless-device-location-sync..HEAD
```

Expected: worktree clean、新ブランチに簡素化コミットだけが積まれている。
