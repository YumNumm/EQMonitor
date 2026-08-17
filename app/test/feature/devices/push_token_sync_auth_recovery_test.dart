import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
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
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemetry_store/telemetry_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'unauthenticated upsert deprovisions and does not retry forever',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final tokens = StreamController<NotificationToken>();
      final repository = _UnauthenticatedDeviceRepository();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => _MemoryDeviceAuthRepository(),
          ),
          notificationTokenStreamProvider.overrideWith((ref) => tokens.stream),
          pushTokenPlatformCapabilitiesProvider.overrideWithValue(
            const PushTokenPlatformCapabilities(supportsFcm: true),
          ),
          deviceRepositoryProvider.overrideWith((ref) async => repository),
          telemetryRecorderProvider.overrideWithValue(_NoopTelemetryRecorder()),
          telemetryUploaderProvider.overrideWithValue(_NoopTelemetryUploader()),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(tokens.close);

      await container.read(pushTokenSyncWiringProvider.future);
      final failed = Completer<FailedTokenState>();
      final subscription = container.listen(pushTokenSyncProvider, (_, next) {
        final fcm = next.value?.fcm;
        if (fcm is FailedTokenState && !failed.isCompleted) {
          failed.complete(fcm);
        }
      });
      addTearDown(subscription.close);
      tokens.add(const NotificationToken(fcmToken: 'fcm-token'));

      final failure = await failed.future.timeout(const Duration(seconds: 5));
      final provisioningRepository = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );

      expect(await provisioningRepository.isProvisioned(), isFalse);
      expect(failure.error, isA<AuthorizationException>());
      expect(failure.error.userMessage, '認証が必要です');
      expect(repository.calls, 1);
    },
  );
}

final class _UnauthenticatedDeviceRepository extends DeviceRepository {
  new()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
      );

  var calls = 0;

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    calls++;
    return const Failure(
      AuthorizationException(
        reason: AuthorizationFailureReason.unauthenticated,
      ),
    );
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  new() : super(_MemorySecurePreferencesDataSource());

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

final class _NoopTelemetryRecorder extends Fake implements TelemetryRecorder {
  @override
  Future<void> record(TelemetryEvent event) async {}
}

final class _NoopTelemetryUploader extends Fake implements TelemetryUploader {
  @override
  Future<UploadResult> flush() async =>
      const UploadResult(sentCount: 0, failedCount: 0);
}
