import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    'sync clears provisioned flag when push token sync is unauthenticated',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final deviceRepository = _UnauthenticatedDeviceRepository();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceIdProvider.overrideWith((ref) async => 'device-id'),
          notificationTokenStreamProvider.overrideWith(
            (ref) =>
                Stream.value(const NotificationToken(fcmToken: 'fcm-token')),
          ),
          deviceRepositoryProvider.overrideWith(
            (ref) async => deviceRepository,
          ),
        ],
      );
      addTearDown(container.dispose);
      final pendingSnapshot = Completer<void>();
      final subscription = container.listen(pushTokenSyncProvider, (_, next) {
        if ((next.value?.hasPending ?? false) && !pendingSnapshot.isCompleted) {
          pendingSnapshot.complete();
        }
      });
      addTearDown(subscription.close);

      await pendingSnapshot.future.timeout(const Duration(seconds: 5));

      await expectLater(
        container.read(pushTokenSyncProvider.notifier).sync(),
        throwsA(
          isA<AuthorizationException>().having(
            (exception) => exception.reason,
            'reason',
            AuthorizationFailureReason.unauthenticated,
          ),
        ),
      );

      final repo = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      final state = container.read(pushTokenSyncProvider).value;
      final fcm = state?.fcm;
      expect(await repo.isProvisioned(), isFalse);
      expect(fcm, isA<FailedTokenState>());
      if (fcm is! FailedTokenState) {
        fail('fcm token state should be FailedTokenState');
      }
      expect(
        fcm.error,
        isA<AuthorizationException>().having(
          (exception) => exception.reason,
          'reason',
          AuthorizationFailureReason.unauthenticated,
        ),
      );
      expect(deviceRepository._syncPushTokensCalls, 1);
    },
  );

  test('sync retries failed token state after reprovisioning', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final deviceRepository = _RecoveringDeviceRepository();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceIdProvider.overrideWith((ref) async => 'device-id'),
        notificationTokenStreamProvider.overrideWith(
          (ref) => Stream.value(const NotificationToken(fcmToken: 'fcm-token')),
        ),
        deviceRepositoryProvider.overrideWith(
          (ref) async => deviceRepository,
        ),
      ],
    );
    addTearDown(container.dispose);
    final pendingSnapshot = Completer<void>();
    final subscription = container.listen(pushTokenSyncProvider, (_, next) {
      if ((next.value?.hasPending ?? false) && !pendingSnapshot.isCompleted) {
        pendingSnapshot.complete();
      }
    });
    addTearDown(subscription.close);

    await pendingSnapshot.future.timeout(const Duration(seconds: 5));
    await expectLater(
      container.read(pushTokenSyncProvider.notifier).sync(),
      throwsA(isA<AuthorizationException>()),
    );
    final repo = await container.read(
      deviceProvisioningRepositoryProvider.future,
    );
    await repo.markProvisioned();

    await container.read(pushTokenSyncProvider.notifier).sync();

    final state = container.read(pushTokenSyncProvider).value;
    expect(state?.fcm, isA<SyncedTokenState>());
    expect(deviceRepository._syncPushTokensCalls, 2);
  });
}

final class _UnauthenticatedDeviceRepository extends DeviceRepository {
  _UnauthenticatedDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  var _syncPushTokensCalls = 0;

  @override
  Future<Result<void, Exception>> syncPushTokens({
    required String deviceId,
    required NotificationToken token,
  }) async {
    _syncPushTokensCalls++;
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

  var _syncPushTokensCalls = 0;

  @override
  Future<Result<void, Exception>> syncPushTokens({
    required String deviceId,
    required NotificationToken token,
  }) async {
    _syncPushTokensCalls++;
    if (_syncPushTokensCalls == 1) {
      return const Failure(
        AuthorizationException(
          reason: AuthorizationFailureReason.unauthenticated,
        ),
      );
    }
    return const Success(null);
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  @override
  Future<void> saveToken({
    required String token,
  }) async {}

  @override
  Future<String?> readToken() async => null;

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
