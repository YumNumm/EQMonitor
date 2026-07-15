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
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('syncs automatically when notification token becomes pending', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final tokenController = StreamController<NotificationToken>();
    final authRepository = _MemoryDeviceAuthRepository();
    final deviceRepository = _RecordingDeviceRepository();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        deviceIdProvider.overrideWith((ref) async => 'device-id'),
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(tokenController.close);

    await container.read(pushTokenSyncWiringProvider.future);
    tokenController.add(const NotificationToken(fcmToken: 'fcm-token'));

    await deviceRepository.synced.future.timeout(const Duration(seconds: 5));

    expect(deviceRepository.tokens, [
      const NotificationToken(fcmToken: 'fcm-token'),
    ]);
  });

  test('unsupported platform wiring upserts only FCM', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final authRepository = _MemoryDeviceAuthRepository();
    final deviceRepository = _UpsertRecordingDeviceRepository();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        deviceIdProvider.overrideWith((ref) async => 'device-id'),
        notificationTokenStreamProvider.overrideWith(
          (ref) => Stream.value(
            const NotificationToken(
              fcmToken: 'fcm-token',
              apnsToken: 'apns-token',
              apnsPushToStartToken: 'push-to-start-token',
            ),
          ),
        ),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(),
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository),
      ],
    );
    addTearDown(container.dispose);
    final syncCompleted = Completer<void>();
    final mutationSubscription = container.listen(
      PushTokenSyncNotifier.syncMutation,
      (_, next) {
        if (next is MutationSuccess && !syncCompleted.isCompleted) {
          syncCompleted.complete();
        }
      },
    );
    addTearDown(mutationSubscription.close);

    await container.read(pushTokenSyncWiringProvider.future);
    await syncCompleted.future.timeout(const Duration(seconds: 5));

    final snapshot = container.read(pushTokenSyncProvider).value;
    expect(snapshot?.apnsNotification, isA<NotApplicableTokenState>());
    expect(snapshot?.apnsPushToStart, isA<NotApplicableTokenState>());
    expect(deviceRepository.upsertedKinds, [PushTokenKind.fcm]);
  });
}

final class _RecordingDeviceRepository extends DeviceRepository {
  _RecordingDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  final synced = Completer<void>();
  final tokens = <NotificationToken>[];

  @override
  Future<Result<void, Exception>> syncPushTokens({
    required String deviceId,
    required NotificationToken token,
  }) async {
    tokens.add(token);
    if (!synced.isCompleted) {
      synced.complete();
    }
    return const Success(null);
  }
}

final class _UpsertRecordingDeviceRepository extends DeviceRepository {
  _UpsertRecordingDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  final upsertedKinds = <PushTokenKind>[];

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    upsertedKinds.add(kind);
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
