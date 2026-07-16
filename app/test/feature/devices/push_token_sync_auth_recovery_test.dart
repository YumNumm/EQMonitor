import 'dart:async';

import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    talker = Talker();
  });

  test('auth failure is treated as recoverable deprovisioning signal', () {
    const exception = AuthorizationException(
      reason: AuthorizationFailureReason.unauthenticated,
    );

    expect(exception.isRetryable, isFalse);
    expect(exception.userMessage, '認証が必要です');
  });

  test('handleAuthenticationFailure clears provisioned flag', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(pushTokenSyncProvider.notifier)
        .handleAuthenticationFailure();

    final repo = await container.read(
      deviceProvisioningRepositoryProvider.future,
    );
    expect(await repo.isProvisioned(), isFalse);
  });

  test(
    'unauthenticated upsert clears provisioned and worker enters failed state',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final deviceRepository = _UnauthenticatedDeviceRepository();
      final authRepository = _MemoryDeviceAuthRepository();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => authRepository,
          ),
          notificationTokenStreamProvider.overrideWith(
            (ref) =>
                Stream.value(const NotificationToken(fcmToken: 'fcm-token')),
          ),
          deviceRepositoryProvider.overrideWith(
            (ref) async => deviceRepository,
          ),
          pushTokenPlatformCapabilitiesProvider.overrideWithValue(
            const PushTokenPlatformCapabilities(supportsFcm: true),
          ),
        ],
      );
      addTearDown(container.dispose);

      // Trigger the notifier build
      await container.read(pushTokenSyncProvider.future);

      // Feed a token to the notifier directly (simulating wiring)
      container.read(pushTokenSyncProvider.notifier).accept(
        const NotificationToken(fcmToken: 'fcm-token'),
      );

      // Wait for the worker to process
      await deviceRepository.called.future.timeout(
        const Duration(seconds: 5),
      );
      // Give a bit of time for state propagation
      await Future<void>.delayed(const Duration(milliseconds: 100));

      final repo = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      final state = container.read(pushTokenSyncProvider).value;
      expect(await repo.isProvisioned(), isFalse);
      expect(state?.fcm, isA<FailedTokenState>());
      final fcm = state!.fcm as FailedTokenState;
      expect(
        fcm.error,
        isA<AuthorizationException>().having(
          (e) => e.reason,
          'reason',
          AuthorizationFailureReason.unauthenticated,
        ),
      );
      // Worker should not retry (unauthenticated is non-retryable)
      expect(deviceRepository.upsertCallCount, 1);
    },
  );

  test('worker retries after reprovisioning and retryFailed', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final deviceRepository = _RecoveringDeviceRepository();
    final authRepository = _MemoryDeviceAuthRepository();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        notificationTokenStreamProvider.overrideWith(
          (ref) =>
              Stream.value(const NotificationToken(fcmToken: 'fcm-token')),
        ),
        deviceRepositoryProvider.overrideWith(
          (ref) async => deviceRepository,
        ),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container.dispose);

    // Trigger the notifier build
    await container.read(pushTokenSyncProvider.future);

    // Feed a token — first call will fail with unauthenticated
    container.read(pushTokenSyncProvider.notifier).accept(
      const NotificationToken(fcmToken: 'fcm-token'),
    );

    await deviceRepository.firstCallDone.future.timeout(
      const Duration(seconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 100));

    // Simulate reprovisioning
    final repo = await container.read(
      deviceProvisioningRepositoryProvider.future,
    );
    await repo.markProvisioned();

    // Retry failed workers
    container.read(pushTokenSyncProvider.notifier).retryFailed();

    await deviceRepository.secondCallDone.future.timeout(
      const Duration(seconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final state = container.read(pushTokenSyncProvider).value;
    expect(state?.fcm, isA<SyncedTokenState>());
    expect(deviceRepository.upsertCallCount, 2);
  });
}

// ── Helpers ─────────────────────────────────────────────────────────────────

final class _UnauthenticatedDeviceRepository extends DeviceRepository {
  _UnauthenticatedDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  var upsertCallCount = 0;
  final called = Completer<void>();

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    upsertCallCount++;
    if (!called.isCompleted) {
      called.complete();
    }
    return const Failure(
      AuthorizationException(
        reason: AuthorizationFailureReason.unauthenticated,
      ),
    );
  }
}

final class _RecoveringDeviceRepository extends DeviceRepository {
  _RecoveringDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  var upsertCallCount = 0;
  final firstCallDone = Completer<void>();
  final secondCallDone = Completer<void>();

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    upsertCallCount++;
    if (upsertCallCount == 1) {
      if (!firstCallDone.isCompleted) {
        firstCallDone.complete();
      }
      return const Failure(
        AuthorizationException(
          reason: AuthorizationFailureReason.unauthenticated,
        ),
      );
    }
    if (!secondCallDone.isCompleted) {
      secondCallDone.complete();
    }
    return const Success(null);
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  @override
  Future<void> saveToken({required String token}) async {}

  @override
  Future<String?> readToken() async => 'auth-token';

  @override
  Future<void> clearToken() async {}
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    values[key] = value;
  }

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<int?> getInt({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : int.tryParse(value);
  }

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : double.tryParse(value);
  }

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : bool.tryParse(value);
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    values.remove(key);
  }

  @override
  Future<void> clear() async {
    values.clear();
  }
}
