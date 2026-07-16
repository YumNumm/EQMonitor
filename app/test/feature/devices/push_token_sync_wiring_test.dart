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
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    talker = Talker();
  });

  test('syncs FCM token automatically when notification token arrives',
      () async {
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
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(tokenController.close);

    await container.read(pushTokenSyncWiringProvider.future);
    tokenController.add(const NotificationToken(fcmToken: 'fcm-token'));

    await deviceRepository.synced.future.timeout(const Duration(seconds: 5));

    expect(deviceRepository.upsertCalls, [
      (kind: PushTokenKind.fcm, token: 'fcm-token'),
    ]);
  });

  test('same token emitted twice in same container results in one upsert',
      () async {
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
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(tokenController.close);

    await container.read(pushTokenSyncWiringProvider.future);
    tokenController.add(const NotificationToken(fcmToken: 'fcm-token'));

    await deviceRepository.synced.future.timeout(const Duration(seconds: 5));

    // Emit same token again
    tokenController.add(const NotificationToken(fcmToken: 'fcm-token'));
    // Give time for any spurious upsert
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(deviceRepository.upsertCalls.length, 1);
  });

  test('two independent containers each perform their own upsert', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });

    final authRepository = _MemoryDeviceAuthRepository();

    // Container 1
    final prefs1 = await SharedPreferences.getInstance();
    final tokenController1 = StreamController<NotificationToken>();
    final deviceRepository1 = _RecordingDeviceRepository();
    final container1 = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs1),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController1.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository1),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container1.dispose);
    addTearDown(tokenController1.close);

    // Container 2
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs2 = await SharedPreferences.getInstance();
    final tokenController2 = StreamController<NotificationToken>();
    final deviceRepository2 = _RecordingDeviceRepository();
    final container2 = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs2),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController2.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository2),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsFcm: true),
        ),
      ],
    );
    addTearDown(container2.dispose);
    addTearDown(tokenController2.close);

    await container1.read(pushTokenSyncWiringProvider.future);
    await container2.read(pushTokenSyncWiringProvider.future);

    tokenController1.add(const NotificationToken(fcmToken: 'same-token'));
    tokenController2.add(const NotificationToken(fcmToken: 'same-token'));

    await deviceRepository1.synced.future.timeout(const Duration(seconds: 5));
    await deviceRepository2.synced.future.timeout(const Duration(seconds: 5));

    // Both containers should independently sync (no cross-session hash skip)
    expect(deviceRepository1.upsertCalls.length, 1);
    expect(deviceRepository2.upsertCalls.length, 1);
  });

  test('FCM failure does not block APNs sync', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final tokenController = StreamController<NotificationToken>();
    final authRepository = _MemoryDeviceAuthRepository();
    final deviceRepository = _FailFcmDeviceRepository();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => authRepository,
        ),
        notificationTokenStreamProvider.overrideWith(
          (ref) => tokenController.stream,
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepository),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(
            supportsFcm: true,
            supportsApns: true,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(tokenController.close);

    await container.read(pushTokenSyncWiringProvider.future);

    // Listen for APNs reaching synced state in the snapshot
    final apnsSyncedInSnapshot = Completer<void>();
    final subscription = container.listen(pushTokenSyncProvider, (_, next) {
      final snapshot = next.value;
      if (snapshot != null &&
          snapshot.apnsNotification is SyncedTokenState &&
          !apnsSyncedInSnapshot.isCompleted) {
        apnsSyncedInSnapshot.complete();
      }
    });
    addTearDown(subscription.close);

    tokenController.add(
      const NotificationToken(
        fcmToken: 'fcm-token',
        apnsToken: 'apns-token',
      ),
    );

    // Wait for APNs to reach synced state in the snapshot
    await apnsSyncedInSnapshot.future.timeout(const Duration(seconds: 5));

    final snapshot = container.read(pushTokenSyncProvider).value;
    expect(snapshot, isNotNull);
    expect(snapshot!.apnsNotification, isA<SyncedTokenState>());
    expect(snapshot.fcm, isA<FailedTokenState>());
  });
}

// ── Helpers ─────────────────────────────────────────────────────────────────

typedef _UpsertCall = ({PushTokenKind kind, String token});

final class _RecordingDeviceRepository extends DeviceRepository {
  _RecordingDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  final synced = Completer<void>();
  final upsertCalls = <_UpsertCall>[];

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    upsertCalls.add((kind: kind, token: token));
    if (!synced.isCompleted) {
      synced.complete();
    }
    return const Success(null);
  }
}

final class _FailFcmDeviceRepository extends DeviceRepository {
  _FailFcmDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: true,
      );

  final apnsSynced = Completer<void>();

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    if (kind == PushTokenKind.fcm) {
      return const Failure(
        InvalidRequestException(statusCode: 400),
      );
    }
    if (!apnsSynced.isCompleted) {
      apnsSynced.complete();
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
