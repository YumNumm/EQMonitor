import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _deviceId = 'test-device-id';
const _legacyId = 'legacy-supabase-id';

const _fakeDevice = RegisteredDevice(
  id: _deviceId,
  platform: DevicePlatform.ios,
  userId: null,
  locale: DeviceLocale.ja,
  createdAtIso: '2026-01-01T00:00:00Z',
  updatedAtIso: '2026-01-01T00:00:00Z',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    talker_lib.talker = Talker();
  });

  Future<(ProviderContainer, FakeDeviceRepository, SharedPreferences)>
  buildContainer({
    required Map<String, Object> initialPrefs,
    required FakeDeviceRepository deviceRepo,
  }) async {
    SharedPreferences.setMockInitialValues(initialPrefs);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => _MemoryDeviceAuthRepository()..savedToken = 'jwt',
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepo),
        deviceIdProvider.overrideWith((ref) => _deviceId),
        // _NoopPushTokenSync overrides build() to avoid Firebase init,
        // and sync() to be a no-op. provision() swallows sync errors anyway.
        pushTokenSyncProvider.overrideWith(() => _NoopPushTokenSync()),
      ],
    );
    addTearDown(container.dispose);
    return (container, deviceRepo, prefs);
  }

  test('legacy ID があればワークフロー実行後に移行済みフラグとprovisionedが立つ', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {SharedPreferencesKey.legacyDeviceId.key: _legacyId},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      ),
    );

    await container.read(deviceProvisioningProvider.notifier).provision();

    expect(deviceRepo.migrateCalls, 1);
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isTrue,
    );
    expect(prefs.getBool(SharedPreferencesKey.deviceProvisioned.key), isTrue);
  });

  test('legacy ID が無ければ registerDevice のみで migrate は呼ばれない', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      ),
    );

    await container.read(deviceProvisioningProvider.notifier).provision();

    expect(deviceRepo.migrateCalls, 0);
    expect(deviceRepo.putCalls, 1);
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isNot(isTrue),
    );
    expect(prefs.getBool(SharedPreferencesKey.deviceProvisioned.key), isTrue);
  });

  test('migrate が非再試行エラー(400)なら例外が伝播しフラグは立たない', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {SharedPreferencesKey.legacyDeviceId.key: _legacyId},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: _badRequest,
      ),
    );

    await expectLater(
      container.read(deviceProvisioningProvider.notifier).provision(),
      throwsA(isA<InvalidRequestException>()),
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isNot(isTrue),
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceProvisioned.key),
      isNot(isTrue),
    );
  });
}

// 400 BadRequest を表す非再試行エラー。
// 400 は mapDioToProvisioningException で InvalidRequestException に変換される。
// RetryController は isRetryable=false で即座に rethrow するため遅延なし。
Result<void, Exception> _badRequest() {
  final options = RequestOptions(path: '/v2/device/me/migrate');
  return Failure(
    DioException(
      requestOptions: options,
      response: Response(requestOptions: options, statusCode: 400),
      type: DioExceptionType.badResponse,
    ),
  );
}

// provision() の末尾で呼ばれる pushTokenSync をスタブ化する。
// build() を override して Firebase 初期化を回避する。
// sync() は no-op（provision() は sync 失敗を catch(_) で握り潰すため問題なし）。
final class _NoopPushTokenSync extends PushTokenSyncNotifier {
  @override
  Future<PushTokenSyncSnapshot> build() async => const PushTokenSyncSnapshot(
    fcm: NotApplicableTokenState(),
    apnsNotification: NotApplicableTokenState(),
    apnsPushToStart: NotApplicableTokenState(),
  );

  @override
  Future<void> sync() async {}
}

// ---- 以下、v3_migration_workflow_test.dart の Fake/Memory 実装をコピー ----
// private class なので import 不可のためここに再定義する。

class FakeDeviceRepository extends DeviceRepository {
  FakeDeviceRepository({
    required Result<RegisteredDevice, Exception> Function() getResult,
    required Result<RegisteredDevice, Exception> Function() putResult,
    required Result<void, Exception> Function() migrateResult,
  }) : _getResult = getResult,
       _putResult = putResult,
       _migrateResult = migrateResult,
       super(
         api: api.ApiClient(Dio()),
         authRepository: _MemoryDeviceAuthRepository(),
         apnsEnvironment: api.ApnsEnvironment.development,
         isApplePlatform: true,
       );

  final Result<RegisteredDevice, Exception> Function() _getResult;
  final Result<RegisteredDevice, Exception> Function() _putResult;
  final Result<void, Exception> Function() _migrateResult;

  // ignore: type_annotate_public_apis
  var getCalls = 0;
  // ignore: type_annotate_public_apis
  var putCalls = 0;
  // ignore: type_annotate_public_apis
  var migrateCalls = 0;

  @override
  Future<Result<RegisteredDevice, Exception>> getDevice(String deviceId) async {
    getCalls++;
    return _getResult();
  }

  @override
  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required String deviceId,
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) async {
    putCalls++;
    return _putResult();
  }

  @override
  Future<Result<void, Exception>> migrateFromLegacy({
    required String deviceId,
    required String oldDeviceId,
  }) async {
    migrateCalls++;
    return _migrateResult();
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  String? savedToken;

  @override
  Future<void> saveToken({required String token}) async {
    savedToken = token;
  }

  @override
  Future<String?> readToken() async => savedToken;

  @override
  Future<void> clearToken() async {
    savedToken = null;
  }
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
