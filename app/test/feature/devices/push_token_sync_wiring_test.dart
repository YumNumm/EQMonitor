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

  test('same token is upserted once in each fresh app session', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final first = _createHarness(prefs: prefs);
    await first.start();
    first.tokens.add(const NotificationToken(fcmToken: 'same-token'));
    await first.waitFor((snapshot) => snapshot.fcm is SyncedTokenState);
    await first.dispose();

    final second = _createHarness(prefs: prefs);
    await second.start();
    second.tokens.add(const NotificationToken(fcmToken: 'same-token'));
    await second.waitFor((snapshot) => snapshot.fcm is SyncedTokenState);
    await second.dispose();

    expect(first.repository.calls, [
      (kind: PushTokenKind.fcm, token: 'same-token'),
    ]);
    expect(second.repository.calls, [
      (kind: PushTokenKind.fcm, token: 'same-token'),
    ]);
  });

  test('duplicate token is upserted once within one app session', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final harness = _createHarness(prefs: prefs);
    addTearDown(harness.dispose);
    await harness.start();

    const token = NotificationToken(fcmToken: 'same-token');
    harness.tokens.add(token);
    await harness.waitFor((snapshot) => snapshot.fcm is SyncedTokenState);
    harness.tokens.add(token);
    await harness.acks.stream.firstWhere((count) => count == 2);

    expect(harness.repository.calls, [
      (kind: PushTokenKind.fcm, token: 'same-token'),
    ]);
  });

  test('retryable FCM failure does not block either APNs worker', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final repository = _RecordingDeviceRepository(failFcmRetryably: true);
    final harness = _createHarness(
      prefs: prefs,
      repository: repository,
      capabilities: const PushTokenPlatformCapabilities(
        supportsFcm: true,
        supportsApns: true,
        supportsPushToStart: true,
      ),
    );
    addTearDown(harness.dispose);
    await harness.start();

    harness.tokens.add(
      const NotificationToken(
        fcmToken: 'fcm-token',
        apnsToken: 'apns-token',
        apnsPushToStartToken: 'push-to-start-token',
      ),
    );
    final snapshot = await harness.waitFor(
      (value) =>
          value.apnsNotification is SyncedTokenState &&
          value.apnsPushToStart is SyncedTokenState &&
          value.fcm is WaitingTokenState,
    );

    expect(snapshot.fcm, isA<WaitingTokenState>());
    expect(
      repository.calls,
      containsAll(<({PushTokenKind kind, String token})>[
        (kind: PushTokenKind.apnsNotification, token: 'apns-token'),
        (kind: PushTokenKind.apnsPushToStart, token: 'push-to-start-token'),
      ]),
    );
  });

  test(
    'unsupported kinds are notApplicable and make no repository call',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final harness = _createHarness(
        prefs: prefs,
        capabilities: const PushTokenPlatformCapabilities(supportsFcm: true),
      );
      addTearDown(harness.dispose);
      await harness.start();

      harness.tokens.add(
        const NotificationToken(
          fcmToken: 'fcm-token',
          apnsToken: 'apns-token',
          apnsPushToStartToken: 'push-to-start-token',
        ),
      );
      final snapshot = await harness.waitFor(
        (value) => value.fcm is SyncedTokenState,
      );

      expect(snapshot.apnsNotification, isA<NotApplicableTokenState>());
      expect(snapshot.apnsPushToStart, isA<NotApplicableTokenState>());
      expect(harness.repository.calls, [
        (kind: PushTokenKind.fcm, token: 'fcm-token'),
      ]);
    },
  );
}

_WiringHarness _createHarness({
  required SharedPreferences prefs,
  _RecordingDeviceRepository? repository,
  PushTokenPlatformCapabilities capabilities =
      const PushTokenPlatformCapabilities(supportsFcm: true),
}) {
  final tokens = StreamController<NotificationToken>();
  final acks = StreamController<int>.broadcast();
  final resolvedRepository = repository ?? _RecordingDeviceRepository();
  var emitted = 0;
  final container = ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
      deviceAuthRepositoryProvider.overrideWith(
        (ref) async => _MemoryDeviceAuthRepository(),
      ),
      notificationTokenStreamProvider.overrideWith((ref) async* {
        await for (final token in tokens.stream) {
          yield token;
          emitted++;
          acks.add(emitted);
        }
      }),
      pushTokenPlatformCapabilitiesProvider.overrideWithValue(capabilities),
      deviceRepositoryProvider.overrideWith((ref) async => resolvedRepository),
      telemetryRecorderProvider.overrideWithValue(_NoopTelemetryRecorder()),
      telemetryUploaderProvider.overrideWithValue(_NoopTelemetryUploader()),
    ],
  );
  return _WiringHarness(
    container: container,
    tokens: tokens,
    acks: acks,
    repository: resolvedRepository,
  );
}

final class _WiringHarness {
  _WiringHarness({
    required this.container,
    required this.tokens,
    required this.acks,
    required this.repository,
  });

  final ProviderContainer container;
  final StreamController<NotificationToken> tokens;
  final StreamController<int> acks;
  final _RecordingDeviceRepository repository;

  Future<void> start() => container.read(pushTokenSyncWiringProvider.future);

  Future<PushTokenSyncSnapshot> waitFor(
    bool Function(PushTokenSyncSnapshot snapshot) predicate,
  ) async {
    final completer = Completer<PushTokenSyncSnapshot>();
    final subscription = container.listen(pushTokenSyncProvider, (_, next) {
      final snapshot = next.value;
      if (snapshot != null && predicate(snapshot) && !completer.isCompleted) {
        completer.complete(snapshot);
      }
    }, fireImmediately: true);
    final snapshot = await completer.future.timeout(const Duration(seconds: 5));
    subscription.close();
    return snapshot;
  }

  Future<void> dispose() async {
    container.dispose();
    await tokens.close();
    await acks.close();
  }
}

final class _RecordingDeviceRepository extends DeviceRepository {
  _RecordingDeviceRepository({this.failFcmRetryably = false})
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
      );

  final bool failFcmRetryably;
  final calls = <({PushTokenKind kind, String token})>[];

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    calls.add((kind: kind, token: token));
    if (kind == PushTokenKind.fcm && failFcmRetryably) {
      return const Failure(NetworkUnreachableException());
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

final class _NoopTelemetryRecorder extends Fake implements TelemetryRecorder {
  @override
  Future<void> record(TelemetryEvent event) async {}
}

final class _NoopTelemetryUploader extends Fake implements TelemetryUploader {
  @override
  Future<UploadResult> flush() async =>
      const UploadResult(sentCount: 0, failedCount: 0);
}
