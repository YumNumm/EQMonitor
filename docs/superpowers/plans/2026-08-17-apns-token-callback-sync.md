# APNs Token Callback Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** APNs通知トークンの初回値を`getAPNSToken()`で取得し、以後の変更をiOS APNs登録Callbackからサーバへ同期する。

**Architecture:** `AppDelegate`のAPNs登録Callbackを専用`FlutterEventChannel`へ転送し、最新Callbackを購読時に再生する。Dartは初回取得値とCallbackストリームを順に結合し、既存の`PushTokenSyncWorker`へ渡す。

**Tech Stack:** Flutter/Dart、Riverpod 3、Firebase Messaging、Swift、FlutterEventChannel、flutter_test

## Global Constraints

- Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。
- FCMとLive Activity Push to Startの取得経路は変更しない。
- APNs初回取得は`FirebaseMessaging.getAPNSToken()`を維持する。
- APNs更新でFirebase Messagingの`onTokenRefresh`を使用しない。
- `dynamic`、`Object`、null assertion演算子を新規コードで使用しない。
- iOS Callbackでは`super.application(...)`を先に呼び、FlutterFire反映後にDartへ通知する。
- API、バックエンド、Preferencesキーは変更しない。

---

### Task 1: Dart APNs Callbackデータソースとトークンストリーム

**Files:**
- Create: `app/lib/feature/devices/data/data_source/apns_token_callback_data_source.dart`
- Create: `app/test/feature/devices/apns_token_callback_data_source_test.dart`
- Create: `app/test/feature/devices/notification_token_stream_test.dart`
- Modify: `app/lib/feature/devices/data/provider/notification_token_stream.dart:36-69`
- Generate: `app/lib/feature/devices/data/data_source/apns_token_callback_data_source.g.dart`
- Generate: `app/lib/feature/devices/data/provider/notification_token_stream.g.dart`

**Interfaces:**
- Produces: `ApnsTokenCallbackDataSource.tokenUpdates: Stream<String>`
- Produces: `apnsTokenCallbackDataSourceProvider`
- Produces: `apnsNotificationTokenStreamProvider: StreamProvider<String>`
- Consumes: EventChannel `net.yumnumm.eqmonitor/apns-token`
- Test helper: `createHarness({String? initialApnsToken, Stream<String>? callbackTokens})` returns a record containing `ProviderContainer`, fake messaging, and its FCM refresh controller

- [ ] **Step 1: Write failing stream behavior tests**

Add fakes for `FirebaseMessaging` and `ApnsTokenCallbackDataSource`, then test these exact behaviors:

```dart
test('APNs emits getAPNSToken result before callback updates', () async {
  final callbacks = StreamController<String>();
  final harness = createHarness(
    initialApnsToken: 'initial-token',
    callbackTokens: callbacks.stream,
  );
  final emitted = <String>[];
  final subscription = harness.container.listen(
    apnsNotificationTokenStreamProvider,
    (_, next) {
      if (next case AsyncData(:final value)) {
        emitted.add(value);
      }
    },
    fireImmediately: true,
  );
  await pumpEventQueue();
  expect(emitted, ['initial-token']);
  callbacks.add('callback-token');
  await pumpEventQueue();
  expect(emitted, ['initial-token', 'callback-token']);
  subscription.close();
});

test('FCM refresh does not re-read APNs token', () async {
  final harness = createHarness(initialApnsToken: 'initial-token');
  await harness.firstApnsToken;
  harness.fcmRefreshes.add('new-fcm-token');
  await pumpEventQueue();
  expect(harness.messaging.apnsTokenReadCount, 1);
});
```

Also test `null` initial value followed by Callback, duplicate initial/Callback suppression, and Android not reading the APNs data source. In `apns_token_callback_data_source_test.dart`, use `TestDefaultBinaryMessenger` and `StandardMethodCodec` to send one valid String envelope and one non-String envelope; assert that the former emits and the latter produces `FormatException`.

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
cd app
mise exec -- flutter test test/feature/devices/apns_token_callback_data_source_test.dart test/feature/devices/notification_token_stream_test.dart
```

Expected: compilation failure because the public APNs stream and Callback data source do not exist.

- [ ] **Step 3: Add the typed EventChannel data source**

Define an interface and production implementation so tests can inject a callback stream:

```dart
abstract interface class ApnsTokenCallbackDataSource {
  Stream<String> get tokenUpdates;
}

final class EventChannelApnsTokenCallbackDataSource
    implements ApnsTokenCallbackDataSource {
  const EventChannelApnsTokenCallbackDataSource(this._channel);
  final EventChannel _channel;

  @override
  Stream<String> get tokenUpdates async* {
    await for (final value in _channel.receiveBroadcastStream()) {
      if (value case final String token when token.isNotEmpty) {
        yield token;
      } else {
        throw const FormatException('Invalid APNs token callback payload');
      }
    }
  }
}
```

The generated provider returns this implementation with the fixed channel name.

- [ ] **Step 4: Replace FCM-triggered APNs invalidation**

Rename `_apnsTokenStream` to public `apnsNotificationTokenStream`. It must call `getAPNSToken()` once, then iterate `tokenUpdates`, retaining `lastToken` so an identical replay is skipped. Remove the loop that invalidates itself from `messaging.onTokenRefresh` and update both existing references to the public provider.

- [ ] **Step 5: Generate code and verify GREEN**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/devices/apns_token_callback_data_source_test.dart test/feature/devices/notification_token_stream_test.dart test/feature/devices/push_token_platform_capabilities_test.dart
```

Expected: all selected tests pass, including proof that FCM refresh does not re-read APNs.

- [ ] **Step 6: Commit Dart stream change**

```bash
git add app/lib/feature/devices/data/data_source/apns_token_callback_data_source.dart app/lib/feature/devices/data/data_source/apns_token_callback_data_source.g.dart app/lib/feature/devices/data/provider/notification_token_stream.dart app/lib/feature/devices/data/provider/notification_token_stream.g.dart app/test/feature/devices/apns_token_callback_data_source_test.dart app/test/feature/devices/notification_token_stream_test.dart
git commit -m "fix: APNsトークン更新をCallbackストリームへ分離"
```

### Task 2: iOS APNs Callback EventChannel

**Files:**
- Create: `app/ios/Runner/ApnsTokenEventChannel.swift`
- Modify: `app/ios/Runner/AppDelegate.swift:25-63`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`

**Interfaces:**
- Consumes: `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)`
- Produces: EventChannel `net.yumnumm.eqmonitor/apns-token`
- Produces: lowercase hexadecimal APNs token strings

- [ ] **Step 1: Add the EventChannel publisher**

Implement `ApnsTokenEventChannel: NSObject, FlutterStreamHandler` with `static let shared`, `latestToken`, and `eventSink`. `publish(_ deviceToken: Data)` converts bytes using `String(format: "%02x", byte)`, stores the token, and emits it when listening. `onListen` stores the sink and immediately replays `latestToken`; `onCancel` clears the sink.

- [ ] **Step 2: Register and forward the native Callback**

Register the singleton with the implicit engine registrar. Add the AppDelegate override in this exact order:

```swift
override func application(
  _ application: UIApplication,
  didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
) {
  super.application(
    application,
    didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
  )
  ApnsTokenEventChannel.shared.publish(deviceToken)
}
```

- [ ] **Step 3: Add the Swift file to the Runner target**

Add one `PBXFileReference`, one `PBXBuildFile`, the Runner group entry, and the Runner Sources phase entry. Do not add it to extensions.

- [ ] **Step 4: Format and compile-check**

The current Linux environment has no Swift or Xcode toolchain, so record native compile verification as unavailable here. Before merge, run `cd app && mise exec -- flutter build ios --debug --no-codesign` on macOS. Expected: build succeeds and no duplicate UIApplicationDelegate selector exists.

- [ ] **Step 5: Commit native bridge**

```bash
git add app/ios/Runner/AppDelegate.swift app/ios/Runner/ApnsTokenEventChannel.swift app/ios/Runner.xcodeproj/project.pbxproj
git commit -m "feat: APNs登録CallbackをFlutterへ通知"
```

### Task 3: End-to-end regression verification

**Files:**
- Modify only if verification exposes a defect in the Task 1 or Task 2 files.

**Interfaces:**
- Consumes: `NotificationToken.apnsToken`
- Consumes: `DeviceRepository.upsertPushToken(kind: .apnsNotification, token: ...)`
- Produces: verified PATCH `/v2/device/me/apns/NOTIFICATION`

- [ ] **Step 1: Run focused tests**

```bash
cd app
mise exec -- flutter test test/feature/devices/apns_token_callback_data_source_test.dart test/feature/devices/notification_token_stream_test.dart test/feature/devices/push_token_platform_capabilities_test.dart test/feature/devices/push_token_sync_wiring_test.dart test/feature/devices/push_token_sync_worker_test.dart test/feature/devices/device_repository_apns_kind_test.dart test/feature/devices/device_repository_fcm_token_test.dart
```

Expected: all tests pass with zero failures.

- [ ] **Step 2: Run static analysis and formatting checks**

```bash
cd app
mise exec -- dart format --output=none --set-exit-if-changed lib/feature/devices/data test/feature/devices/apns_token_callback_data_source_test.dart test/feature/devices/notification_token_stream_test.dart
mise exec -- flutter analyze lib/feature/devices/data test/feature/devices/apns_token_callback_data_source_test.dart test/feature/devices/notification_token_stream_test.dart
```

Expected: both commands exit 0.

- [ ] **Step 3: Inspect the final diff**

Run `git --no-pager diff HEAD~2 --check` and `git --no-pager diff HEAD~2 --stat`. Confirm no FCM behavior, Push to Start behavior, backend API, generated unrelated files, or pre-existing workspace changes entered the commits.
