# Notification Settings Reliability Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make foreground and background notification settings updates visibly reliable and compatible with the backend OpenAPI schema.

**Architecture:** Fix the EEW request/response mapping first, then add user-visible Mutation error handling to foreground settings pages, then make background location-driven settings updates observable and retryable. Keep changes scoped to notification settings and background location update flows; device authentication is handled separately in `docs/superpowers/plans/2026-06-05-device-auth-token-sync.md`.

**Tech Stack:** Flutter, Dart, Riverpod Mutation, Retrofit generated API client, Freezed models, BackgroundLocationTracker, Hono OpenAPI.

---

## Finding Summary

Foreground notification settings updates have three correctness issues:

- EEW PATCH sends `notification_tiers: []` when `criticalThreshold == null`, but OpenAPI requires `minItems: 1` for non-null arrays.
- EEW response field `one_point_enabled` is ignored by the app model, so the app cannot preserve/display the backend value.
- General/EEW/Earthquake settings save failures can become `MutationError` without SnackBar feedback.

Background notification settings updates are implemented through `backgroundLocationServiceProvider`, not through FCM background messages. The service updates EEW, Earthquake, and Shake Detection current-location settings, but several outer catches swallow failures without logging, and transient API failures are not retried.

## File Structure

- Modify: `app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart`  
  Add `onePointEnabled`.
- Modify generated: `app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.freezed.dart`  
  Produced by build_runner.
- Modify: `app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart`  
  Map `onePointEnabled` and return nullable EEW tiers for threshold removal.
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart`  
  Preserve `onePointEnabled` across PATCH calls.
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`  
  Show save errors.
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`  
  Show save errors and include `onePointEnabled` in fallback state.
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart`  
  Show save errors.
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart`  
  Show level update errors and inline the level label switch.
- Modify: `app/lib/feature/location/data/background_location_service.dart`  
  Log swallowed exceptions and retry background API updates.
- Test: `app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart`
- Test: `app/test/feature/location/background_location_service_error_test.dart`

### Task 1: Align EEW Settings With OpenAPI

**Files:**

- Modify: `app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`
- Test: `app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart`

- [ ] **Step 1: Write failing repository tests**

Create `app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart`.

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('patchEewSettings sends null tiers when threshold is cleared', () async {
    final adapter = _DeviceSettingsAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceNotificationSettingsRepository(api.ApiClient(dio));

    final result = await repository.patchEewSettings(
      deviceId: 'unused',
      enabled: true,
      criticalThreshold: null,
      startLiveActivity: true,
      onePointEnabled: false,
    );

    expect(result, isA<Success>());
    expect(adapter.patchEewBody['notification_tiers'], isNull);
    expect(adapter.patchEewBody['one_point_enabled'], isFalse);
  });

  test('getEewSettings maps onePointEnabled from response', () async {
    final adapter = _DeviceSettingsAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceNotificationSettingsRepository(api.ApiClient(dio));

    final result = await repository.getEewSettings('unused');

    final settings = switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    expect(settings.onePointEnabled, isFalse);
  });
}

final class _DeviceSettingsAdapter implements HttpClientAdapter {
  Map<String, Object?> patchEewBody = {};

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path == '/v2/device/me/settings/eew' &&
        options.method == 'PATCH') {
      patchEewBody = Map<String, Object?>.from(options.data as Map);
      return _json({
        'enabled': patchEewBody['enabled'] ?? true,
        'notification_tiers': [
          {
            'min_jma_intensity': '4',
            'sound': 'default',
            'interruption_level': 'critical',
          },
        ],
        'start_live_activity': patchEewBody['start_live_activity'] ?? true,
        'one_point_enabled': patchEewBody['one_point_enabled'] ?? false,
      });
    }
    if (options.path == '/v2/device/me/settings/eew' &&
        options.method == 'GET') {
      return _json({
        'enabled': true,
        'notification_tiers': [
          {
            'min_jma_intensity': '4',
            'sound': 'default',
            'interruption_level': 'critical',
          },
        ],
        'start_live_activity': true,
        'one_point_enabled': false,
      });
    }
    if (options.path == '/v2/device/me/settings/eew/regions') {
      return _json(<Map<String, Object?>>[]);
    }
    return ResponseBody.fromString('', 404);
  }

  ResponseBody _json(Object body) => ResponseBody.fromString(
    jsonEncode(body),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart
```

Expected: FAIL because `onePointEnabled` does not exist on `EewNotificationSettings` and `patchEewSettings` has no `onePointEnabled` parameter.

- [ ] **Step 3: Add `onePointEnabled` to EEW app model**

Update `app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart`.

```dart
@freezed
abstract class EewNotificationSettings with _$EewNotificationSettings {
  const factory EewNotificationSettings({
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required bool startLiveActivity,
    required bool onePointEnabled,
    required List<NotificationRegion> regions,
  }) = _EewNotificationSettings;
}
```

- [ ] **Step 4: Map and preserve `onePointEnabled` in repository**

Update `DeviceNotificationSettingsRepository.patchEewSettings`.

```dart
Future<Result<EewNotificationSettings, Exception>> patchEewSettings({
  required String deviceId,
  required bool enabled,
  required JmaIntensity? criticalThreshold,
  required bool startLiveActivity,
  required bool onePointEnabled,
}) => Result.capture(() async {
  final response = await _api.device.patchV2DeviceMeSettingsEew(
    body: api.EewSettingsRequest(
      enabled: enabled,
      notificationTiers: _toEewApiTiers(criticalThreshold),
      startLiveActivity: startLiveActivity,
      onePointEnabled: onePointEnabled,
    ),
  );
  final regionsResult = await _api.device.getV2DeviceMeSettingsEewRegions();
  return _eewFromResponse(
    response.data,
    regionsResult.data.map((r) => r.toNotificationRegion).toList(),
  );
});
```

Update `_eewFromResponse`.

```dart
EewNotificationSettings _eewFromResponse(
  api.EewSettingsResponse resp,
  List<NotificationRegion> regions,
) => EewNotificationSettings(
  enabled: resp.enabled,
  criticalThreshold: _extractCriticalThresholdFromTiers3(
    resp.notificationTiers,
  ),
  startLiveActivity: resp.startLiveActivity,
  onePointEnabled: resp.onePointEnabled,
  regions: regions,
);
```

Update `_toEewApiTiers`.

```dart
List<api.NotificationTiers4>? _toEewApiTiers(JmaIntensity? threshold) {
  if (threshold == null) {
    return null;
  }
  final apiIntensity = threshold.toApiMinJmaIntensity;
  if (apiIntensity == null) {
    return null;
  }
  return [
    api.NotificationTiers4(
      minJmaIntensity: apiIntensity,
      sound: 'default',
      interruptionLevel: api.InterruptionLevel.critical,
    ),
  ];
}
```

- [ ] **Step 5: Preserve `onePointEnabled` in EEW notifier**

Update all `repo.patchEewSettings(...)` calls in `app/lib/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart`.

```dart
final result = await repo.patchEewSettings(
  deviceId: deviceId,
  enabled: enabled,
  criticalThreshold: current.criticalThreshold,
  startLiveActivity: current.startLiveActivity,
  onePointEnabled: current.onePointEnabled,
);
```

For `setCriticalThreshold`, pass:

```dart
onePointEnabled: current.onePointEnabled,
```

For `setStartLiveActivity`, pass:

```dart
onePointEnabled: current.onePointEnabled,
```

- [ ] **Step 6: Update EEW UI fallback state**

Update `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`.

```dart
final settings = settingsAsync.value ??
    const EewNotificationSettings(
      enabled: true,
      criticalThreshold: null,
      startLiveActivity: true,
      onePointEnabled: true,
      regions: [],
    );
```

- [ ] **Step 7: Run code generation**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `eew_notification_settings.freezed.dart` is updated and build_runner exits 0.

- [ ] **Step 8: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart
```

Expected: PASS.

- [ ] **Step 9: Commit**

```bash
git add app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.freezed.dart app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart app/lib/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart
git commit -m "fix: EEW通知設定のAPI変換を修正"
```

### Task 2: Show Foreground Save Errors

**Files:**

- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart`

- [ ] **Step 1: Write widget regression tests**

Create `app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart`.

```dart
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

void main() {
  testWidgets('general settings save error shows SnackBar', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: NotificationSettingsPage())));

    final context = tester.element(find.byType(NotificationSettingsPage));
    GeneralNotificationSettingsNotifier.saveMutation
        .run(ProviderScope.containerOf(context), (_) async {
      throw Exception('save failed');
    });
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('EEW save error shows SnackBar', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: EewSettingsPage())));

    final context = tester.element(find.byType(EewSettingsPage));
    EewSettingsNotifier.saveSettingsMutation
        .run(ProviderScope.containerOf(context), (_) async {
      throw Exception('eew failed');
    });
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('earthquake save error shows SnackBar', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: EarthquakeSettingsPage())));

    final context = tester.element(find.byType(EarthquakeSettingsPage));
    EarthquakeNotificationSettingsNotifier.saveSettingsMutation
        .run(ProviderScope.containerOf(context), (_) async {
      throw Exception('earthquake failed');
    });
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('shake detection level update error shows SnackBar', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: ShakeDetectionSettingsPage())));

    final context = tester.element(find.byType(ShakeDetectionSettingsPage));
    ShakeDetectionSettingsNotifier.updateLevelMutation
        .run(ProviderScope.containerOf(context), (_) async {
      throw Exception('shake failed');
    });
    await tester.pump();

    expect(find.textContaining('震度レベルの更新に失敗しました'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart
```

Expected: FAIL because the new listeners are missing. If provider initialization errors happen before mutation assertions, replace page pumping with focused section widgets or add provider overrides for each page's notifier.

- [ ] **Step 3: Add general settings error listener**

Update `_GeneralSettingsSection.build` in `notification_settings_page.dart`.

```dart
ref.listen(GeneralNotificationSettingsNotifier.saveMutation, (_, next) {
  if (next is MutationError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('設定の保存に失敗しました: ${next.error}'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
});
```

- [ ] **Step 4: Add EEW settings error listeners**

Update `_EnabledSection.build`, `_ThresholdSection.build`, and `_LiveActivitySection.build` in `eew_settings_page.dart`.

For `_EnabledSection` and `_ThresholdSection`:

```dart
ref.listen(EewSettingsNotifier.saveSettingsMutation, (_, next) {
  if (next is MutationError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('設定の保存に失敗しました: ${next.error}'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
});
```

For `_LiveActivitySection`:

```dart
ref.listen(EewSettingsNotifier.saveLiveActivityMutation, (_, next) {
  if (next is MutationError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Live Activity設定の保存に失敗しました: ${next.error}'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
});
```

- [ ] **Step 5: Add earthquake settings error listeners**

Update `_EnabledSection.build`, `_ThresholdSection.build`, and `_EstimatedIntensitySection.build` in `earthquake_settings_page.dart`.

```dart
ref.listen(EarthquakeNotificationSettingsNotifier.saveSettingsMutation, (_, next) {
  if (next is MutationError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('設定の保存に失敗しました: ${next.error}'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
});
```

- [ ] **Step 6: Add shake detection update error listener and remove widget method**

Update `_Body.build` in `shake_detection_settings_page.dart`.

```dart
ref.listen(ShakeDetectionSettingsNotifier.updateLevelMutation, (_, next) {
  if (next is MutationError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('震度レベルの更新に失敗しました: ${next.error}'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
});
```

Replace `_levelLabel(level)` in `_ShakeEntryCard` with an inline switch expression:

```dart
child: Text(switch (level) {
  api.ShakeDetectionLevel.weaker => '最小（Weaker）',
  api.ShakeDetectionLevel.weak => '小（Weak）',
  api.ShakeDetectionLevel.medium => '中（Medium）',
  api.ShakeDetectionLevel.strong => '大（Strong）',
  api.ShakeDetectionLevel.stronger => '最大（Stronger）',
}),
```

Delete the `_levelLabel` method from `_ShakeEntryCard`.

- [ ] **Step 7: Run targeted widget tests**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart
git commit -m "fix: 通知設定保存失敗をUIに表示"
```

### Task 3: Make Background Settings Updates Observable

**Files:**

- Modify: `app/lib/feature/location/data/background_location_service.dart`
- Test: `app/test/feature/location/background_location_service_error_test.dart`

- [ ] **Step 1: Write failing retry tests**

Create `app/test/feature/location/background_location_service_error_test.dart`.

```dart
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BackgroundLocationUpdateRetry retries transient failures', () async {
    const retry = BackgroundLocationUpdateRetry();
    var attempts = 0;

    final result = await retry.run(() async {
      attempts += 1;
      if (attempts < 3) {
        throw Exception('transient');
      }
      return 'ok';
    });

    expect(result, 'ok');
    expect(attempts, 3);
  });

  test('BackgroundLocationUpdateRetry rethrows final failure', () async {
    const retry = BackgroundLocationUpdateRetry();
    var attempts = 0;

    await expectLater(
      retry.run(() async {
        attempts += 1;
        throw Exception('persistent');
      }),
      throwsException,
    );
    expect(attempts, 3);
  });
}
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
mise exec -- flutter test app/test/feature/location/background_location_service_error_test.dart
```

Expected: FAIL because `BackgroundLocationUpdateRetry` does not exist.

- [ ] **Step 3: Add `talker` logging to swallowed catches**

Update `app/lib/feature/location/data/background_location_service.dart`.

```dart
import 'package:eqmonitor/core/provider/log/talker.dart';
```

Change `_ensureMonitoring`.

```dart
} on Object catch (e, st) {
  talker.error('[BackgroundLocation] ensureMonitoring failed', e, st);
}
```

Change `_applyPendingLocation`.

```dart
} on Object catch (e, st) {
  talker.error('[BackgroundLocation] applyPendingLocation failed', e, st);
}
```

Change the outer catch in `_applyLocation`.

```dart
} on Object catch (e, st) {
  talker.error('[BackgroundLocation] applyLocation failed', e, st);
}
```

Change `_fireDebugNotifications`.

```dart
} on Object catch (e, st) {
  talker.error('[BackgroundLocation] fireDebugNotifications failed', e, st);
}
```

- [ ] **Step 4: Add retry helper for background API updates**

Add this class in the same file near the bottom.

```dart
final class BackgroundLocationUpdateRetry {
  const BackgroundLocationUpdateRetry();

  Future<T> run<T>(Future<T> Function() action) async {
    Object? lastError;
    StackTrace? lastStackTrace;
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        return await action();
      } on Object catch (e, st) {
        lastError = e;
        lastStackTrace = st;
        if (attempt < 2) {
          await Future<void>.delayed(Duration(milliseconds: 250 * (attempt + 1)));
        }
      }
    }
    Error.throwWithStackTrace(lastError ?? StateError('retry failed'), lastStackTrace ?? StackTrace.current);
  }
}
```

Inside `_applyLocation`, create:

```dart
const retry = BackgroundLocationUpdateRetry();
```

Wrap each API update:

```dart
didUpdateEew = await retry.run(
  () => ref
      .read(eewSettingsProvider.notifier)
      .updateCurrentLocationRegion(regionCode: code, regionName: name),
);
```

Use the same pattern for Earthquake and Shake Detection.

- [ ] **Step 5: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/location/background_location_service_error_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/location/data/background_location_service.dart app/test/feature/location/background_location_service_error_test.dart
git commit -m "fix: バックグラウンド通知設定更新の失敗を記録"
```

### Task 4: Verify Notification Settings Flow

**Files:**

- Modify only if tests or analyzer reveal failures.

- [ ] **Step 1: Run notification settings tests**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart app/test/feature/location/background_location_service_error_test.dart
```

Expected: PASS.

- [ ] **Step 2: Run code generation check**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: no unresolved generated code errors.

- [ ] **Step 3: Run analyzer**

Run:

```bash
mise exec -- melos run analyze
```

Expected: PASS with no new warnings.

- [ ] **Step 4: Manual acceptance checklist**

Verify these flows in a local build or with adapter-backed tests:

```text
EEW threshold cleared:
  PATCH /v2/device/me/settings/eew sends notification_tiers: null

EEW settings response:
  one_point_enabled is mapped into EewNotificationSettings.onePointEnabled

General settings save failure:
  Snackbar appears

EEW enabled / threshold / Live Activity save failure:
  Snackbar appears

Earthquake enabled / threshold / estimated intensity save failure:
  Snackbar appears

Shake Detection level update failure:
  Snackbar appears

Background location update API failure:
  talker.error records the failure
  each API update retries up to 3 attempts
```

- [ ] **Step 5: Commit verification-only fixes if needed**

If verification reveals small fixes in this plan's files:

```bash
git add app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart app/lib/feature/settings/features/notification_settings/data/model/eew_notification_settings.freezed.dart app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart app/lib/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart app/lib/feature/location/data/background_location_service.dart app/test/feature/settings/features/notification_settings/device_notification_settings_repository_test.dart app/test/feature/settings/features/notification_settings/notification_settings_mutation_error_test.dart app/test/feature/location/background_location_service_error_test.dart
git commit -m "test: 通知設定更新フローの検証を補強"
```

If no files changed, do not create a commit.

## Self-Review

- Spec coverage: Covers foreground general/EEW/earthquake/shake settings save feedback, EEW OpenAPI request compatibility, `one_point_enabled` response preservation, and background location-driven settings update observability.
- Completeness scan: No unfinished wording remains.
- Type consistency: `onePointEnabled` is added to the app model, repository mapping, notifier PATCH calls, and UI fallback state.
- Backend compatibility: Keeps `/v2/device/me/settings/*` endpoints unchanged and aligns the EEW request body with the generated `EewSettingsRequest` model and OpenAPI constraints.
