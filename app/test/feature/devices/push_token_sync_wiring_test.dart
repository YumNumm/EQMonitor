import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_force_resync_result.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:eqmonitor/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart';
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

  test(
    'startup provisions an already-required device and accepts initial token',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = _StartupDeviceRepository();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => _MemoryDeviceAuthRepository(),
          ),
          deviceIdProvider.overrideWith((ref) async => 'device-id'),
          notificationTokenStreamProvider.overrideWith(
            (ref) => Stream.value(
              const NotificationToken(fcmToken: 'initial-token'),
            ),
          ),
          pushTokenPlatformCapabilitiesProvider.overrideWithValue(
            const PushTokenPlatformCapabilities(supportsFcm: true),
          ),
          deviceRepositoryProvider.overrideWith((ref) async => repository),
          telemetryRecorderProvider.overrideWithValue(_NoopTelemetryRecorder()),
          telemetryUploaderProvider.overrideWithValue(_NoopTelemetryUploader()),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(repository.close);

      final startupSubscription = container.listen(
        pushTokenSyncStartupProvider,
        (_, _) {},
      );
      addTearDown(startupSubscription.close);
      final initialCall = repository.callEvents.stream.firstWhere(
        (value) => value.token == 'initial-token',
      );
      await container.read(pushTokenSyncStartupProvider.future);
      final call = await initialCall.timeout(const Duration(seconds: 5));

      expect(call.kind, PushTokenKind.fcm);
      final provisioningRepository = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      expect(await provisioningRepository.isProvisioned(), isTrue);
    },
  );

  test(
    'manual recovery after startup failure activates token wiring',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final tokens = StreamController<NotificationToken>.broadcast();
      final repository = _RecordingDeviceRepository();
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
          deviceProvisioningProvider.overrideWith(
            _FailingThenRecoverableProvisioningNotifier.new,
          ),
          deviceRepositoryProvider.overrideWith((ref) async => repository),
          telemetryRecorderProvider.overrideWithValue(_NoopTelemetryRecorder()),
          telemetryUploaderProvider.overrideWithValue(_NoopTelemetryUploader()),
        ],
      );
      addTearDown(tokens.close);
      addTearDown(repository.close);
      addTearDown(container.dispose);

      final startupSubscription = container.listen(
        pushTokenSyncStartupProvider,
        (_, _) {},
      );
      addTearDown(startupSubscription.close);
      await expectLater(
        container.read(pushTokenSyncStartupProvider.future),
        throwsA(isA<StateError>()),
      );
      final wiringRecomputed = Completer<void>();
      var completedBuilds = 0;
      final wiringSubscription = container.listen(pushTokenSyncWiringProvider, (
        _,
        next,
      ) {
        if (next is AsyncData<void>) {
          completedBuilds++;
          if (completedBuilds == 2) {
            wiringRecomputed.complete();
          }
        }
      }, fireImmediately: true);
      addTearDown(wiringSubscription.close);
      final recoveredCall = repository.callEvents.stream.firstWhere(
        (call) => call.token == 'recovered-token',
      );
      final provisioningNotifier =
          container.read(deviceProvisioningProvider.notifier)
              as _FailingThenRecoverableProvisioningNotifier;
      provisioningNotifier.recover();
      await wiringRecomputed.future.timeout(const Duration(seconds: 5));
      tokens.add(const NotificationToken(fcmToken: 'recovered-token'));

      await recoveredCall.timeout(const Duration(seconds: 5));
    },
  );

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

  test('rebuilding wiring keeps notifier-owned workers alive', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final harness = _createHarness(prefs: prefs);
    addTearDown(harness.dispose);
    await harness.start();

    harness.tokens.add(const NotificationToken(fcmToken: 'first-token'));
    await harness.waitFor((snapshot) => snapshot.fcm is SyncedTokenState);

    harness.container.invalidate(pushTokenSyncWiringProvider);
    await harness.start();
    final secondCall = harness.repository.callEvents.stream.firstWhere(
      (call) => call.token == 'second-token',
    );
    harness.tokens.add(const NotificationToken(fcmToken: 'second-token'));

    await secondCall.timeout(const Duration(seconds: 5));
    expect(
      harness.repository.calls.where((call) => call.token == 'second-token'),
      hasLength(1),
    );
  });

  test('forceResync re-upserts the current stream token', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final harness = _createHarness(prefs: prefs);
    addTearDown(harness.dispose);
    await harness.start();

    harness.tokens.add(const NotificationToken(fcmToken: 'same-token'));
    await harness.waitFor((snapshot) => snapshot.fcm is SyncedTokenState);
    final resyncCall = harness.repository.callEvents.stream.firstWhere(
      (call) =>
          call.kind == PushTokenKind.fcm &&
          call.token == 'same-token' &&
          harness.repository.calls.length == 2,
    );

    final result = await harness.container
        .read(pushTokenSyncProvider.notifier)
        .forceResync(kind: PushTokenKind.fcm);

    await resyncCall.timeout(const Duration(seconds: 5));
    expect(result, PushTokenForceResyncResult.started);
    expect(harness.repository.calls, [
      (kind: PushTokenKind.fcm, token: 'same-token'),
      (kind: PushTokenKind.fcm, token: 'same-token'),
    ]);
  });

  test('forceResync returns tokenAbsent when no token is available', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final harness = _createHarness(prefs: prefs);
    addTearDown(harness.dispose);
    await harness.start();

    final result = await harness.container
        .read(pushTokenSyncProvider.notifier)
        .forceResync(kind: PushTokenKind.fcm);

    expect(result, PushTokenForceResyncResult.tokenAbsent);
    expect(harness.repository.calls, isEmpty);
  });

  test(
    'forceResync returns notApplicable for unsupported token kind',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final harness = _createHarness(prefs: prefs);
      addTearDown(harness.dispose);
      await harness.start();

      final result = await harness.container
          .read(pushTokenSyncProvider.notifier)
          .forceResync(kind: PushTokenKind.apnsNotification);

      expect(result, PushTokenForceResyncResult.notApplicable);
      expect(harness.repository.calls, isEmpty);
    },
  );

  test(
    'in-flight auth failure after disposal uses resolved dependencies',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final tokens = StreamController<NotificationToken>();
      final repository = _PendingFailureDeviceRepository();
      final provisioningRepository = _RecordingProvisioningRepository(
        prefs: prefs,
      );
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
          deviceProvisioningRepositoryProvider.overrideWith(
            (ref) async => provisioningRepository,
          ),
          telemetryRecorderProvider.overrideWithValue(_NoopTelemetryRecorder()),
          telemetryUploaderProvider.overrideWithValue(_NoopTelemetryUploader()),
        ],
      );

      await container.read(pushTokenSyncWiringProvider.future);
      tokens.add(const NotificationToken(fcmToken: 'pending-token'));
      await repository.started.future.timeout(const Duration(seconds: 5));
      container.dispose();
      repository.completeUnauthenticated();

      await provisioningRepository.cleared.future.timeout(
        const Duration(seconds: 5),
      );
      await tokens.close();
      expect(await provisioningRepository.isProvisioned(), isFalse);
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
    await repository.close();
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
  final callEvents =
      StreamController<({PushTokenKind kind, String token})>.broadcast();

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    calls.add((kind: kind, token: token));
    callEvents.add((kind: kind, token: token));
    if (kind == PushTokenKind.fcm && failFcmRetryably) {
      return const Failure(NetworkUnreachableException());
    }
    return const Success(null);
  }

  Future<void> close() => callEvents.close();
}

final class _PendingFailureDeviceRepository extends DeviceRepository {
  _PendingFailureDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
      );

  final started = Completer<void>();
  final _result = Completer<Result<void, Exception>>();

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) {
    if (!started.isCompleted) {
      started.complete();
    }
    return _result.future;
  }

  void completeUnauthenticated() {
    _result.complete(
      const Failure(
        AuthorizationException(
          reason: AuthorizationFailureReason.unauthenticated,
        ),
      ),
    );
  }
}

final class _StartupDeviceRepository extends DeviceRepository {
  _StartupDeviceRepository()
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
      );

  final callEvents =
      StreamController<({PushTokenKind kind, String token})>.broadcast();

  @override
  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required String deviceId,
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) async => Success(
    RegisteredDevice(
      id: deviceId,
      platform: devicePlatform,
      userId: null,
      locale: deviceLocale,
      createdAtIso: '2026-07-15T00:00:00Z',
      updatedAtIso: '2026-07-15T00:00:00Z',
    ),
  );

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    callEvents.add((kind: kind, token: token));
    return const Success(null);
  }

  Future<void> close() => callEvents.close();
}

final class _RecordingProvisioningRepository
    extends DeviceProvisioningRepository {
  _RecordingProvisioningRepository({required SharedPreferences prefs})
    : super(
        dataSource: SharedPreferencesDataSource(sharedPreferences: prefs),
        persistence: SharedPreferencesWorkflowPersistence(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
      );

  final cleared = Completer<void>();

  @override
  Future<void> clearProvisioned() async {
    await super.clearProvisioned();
    if (!cleared.isCompleted) {
      cleared.complete();
    }
  }
}

final class _FailingThenRecoverableProvisioningNotifier
    extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;

  @override
  Future<void> provision() async {
    throw StateError('automatic provisioning failed');
  }

  void recover() {
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
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
