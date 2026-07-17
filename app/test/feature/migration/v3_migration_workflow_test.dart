import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/workflow/device_migration_workflow.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:workflows/workflows.dart';

const _deviceId = 'test-device-id';
const _oldDeviceId = 'legacy-device-id';

const _fakeDevice = RegisteredDevice(
  id: _deviceId,
  platform: DevicePlatform.ios,
  userId: null,
  locale: DeviceLocale.ja,
  createdAtIso: '2026-01-01T00:00:00Z',
  updatedAtIso: '2026-01-01T00:00:00Z',
);

Result<RegisteredDevice, Exception> _notFound() => Failure(
  DioException(
    requestOptions: RequestOptions(path: '/v2/device/$_deviceId'),
    response: Response(
      requestOptions: RequestOptions(path: '/v2/device/$_deviceId'),
      statusCode: 404,
    ),
    type: DioExceptionType.badResponse,
  ),
);

Result<RegisteredDevice, Exception> _serverError() => Failure(
  DioException(
    requestOptions: RequestOptions(path: '/v2/device/$_deviceId'),
    response: Response(
      requestOptions: RequestOptions(path: '/v2/device/$_deviceId'),
      statusCode: 500,
    ),
    type: DioExceptionType.badResponse,
  ),
);

Result<RegisteredDevice, Exception> _unauthorized() => Failure(
  DioException(
    requestOptions: RequestOptions(path: '/v2/device/me'),
    response: Response(
      requestOptions: RequestOptions(path: '/v2/device/me'),
      statusCode: 401,
    ),
    type: DioExceptionType.badResponse,
  ),
);

Result<RegisteredDevice, Exception> _unauthenticated() => const Failure(
  AuthorizationException(reason: AuthorizationFailureReason.unauthenticated),
);

void main() {
  late InMemoryWorkflowPersistence persistence;
  late WorkflowRunner runner;

  setUp(() {
    persistence = InMemoryWorkflowPersistence();
    runner = WorkflowRunner(persistence: persistence);
  });

  Future<void> run(FakeDeviceRepository repo) => runV3MigrationWorkflow(
    runner: runner,
    repository: repo,
    deviceId: _deviceId,
    oldDeviceId: _oldDeviceId,
  );

  // ── happy path: device absent ───────────────────────────────────────────

  group('デバイス未登録のフルハッピーパス', () {
    test('GET→PUT→POSTの順に呼ばれ、完了フラグが立つ', () async {
      final repo = FakeDeviceRepository(
        getResult: _notFound,
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      );

      await run(repo);

      expect(repo.getCalls, 1);
      expect(repo.putCalls, 1);
      expect(repo.migrateCalls, 1);
      expect(await isV3MigrationComplete(persistence), isTrue);
    });

    test('2回目の実行でAPIが一切呼ばれない (全ステップキャッシュ済み)', () async {
      final repo = FakeDeviceRepository(
        getResult: _notFound,
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      );

      await run(repo);

      final getCalls = repo.getCalls;
      final putCalls = repo.putCalls;
      final migrateCalls = repo.migrateCalls;

      // 同一 runner / persistence で再実行
      await run(repo);

      expect(repo.getCalls, getCalls, reason: 'getDevice が再実行されてはいけない');
      expect(repo.putCalls, putCalls, reason: 'registerDevice が再実行されてはいけない');
      expect(repo.migrateCalls, migrateCalls, reason: 'migrate が再実行されてはいけない');
    });
  });

  // ── happy path: device already registered ──────────────────────────────

  test('GETが200のとき PUT をスキップして POST migrate を呼ぶ', () async {
    final repo = FakeDeviceRepository(
      getResult: () => const Success(_fakeDevice),
      putResult: () => throw StateError('PUT should not be called'),
      migrateResult: () => const Success(null),
    );

    await run(repo);

    expect(repo.getCalls, 1);
    expect(repo.putCalls, 0);
    expect(repo.migrateCalls, 1);
  });

  test('GETが401のとき未登録扱いで PUT と migrate を呼ぶ', () async {
    final repo = FakeDeviceRepository(
      getResult: _unauthorized,
      putResult: () => const Success(_fakeDevice),
      migrateResult: () => const Success(null),
    );

    await run(repo);

    expect(repo.getCalls, 1);
    expect(repo.putCalls, 1);
    expect(repo.migrateCalls, 1);
    expect(await isV3MigrationComplete(persistence), isTrue);
  });

  test('GETがunauthenticatedのとき未登録扱いで PUT と migrate を呼ぶ', () async {
    final repo = FakeDeviceRepository(
      getResult: _unauthenticated,
      putResult: () => const Success(_fakeDevice),
      migrateResult: () => const Success(null),
    );

    await run(repo);

    expect(repo.getCalls, 1);
    expect(repo.putCalls, 1);
    expect(repo.migrateCalls, 1);
    expect(await isV3MigrationComplete(persistence), isTrue);
  });

  // ── resume: registerDevice failure ─────────────────────────────────────

  test('PUT失敗後の再実行: ensureDeviceAbsent はスキップされ PUT が再試行される', () async {
    var putShouldFail = true;
    final repo = FakeDeviceRepository(
      getResult: _notFound,
      putResult: () {
        if (putShouldFail) {
          return Failure(Exception('PUT network error'));
        }
        return const Success(_fakeDevice);
      },
      migrateResult: () => const Success(null),
    );

    // 1回目: GET成功 (キャッシュ), PUT失敗
    await expectLater(run(repo), throwsA(isA<Exception>()));
    expect(repo.getCalls, 1, reason: 'GET は1回だけ呼ばれるはず');
    expect(repo.putCalls, 1, reason: 'PUT は1回試行されるはず');
    expect(repo.migrateCalls, 0, reason: 'migrate はまだ呼ばれないはず');

    // 2回目: PUT を成功させる
    putShouldFail = false;
    await run(repo);

    expect(repo.getCalls, 1, reason: 'GET は2回目でキャッシュ済みなので再実行されない');
    expect(repo.putCalls, 2, reason: 'PUT は2回目で再試行される');
    expect(repo.migrateCalls, 1, reason: 'migrate は2回目で呼ばれる');
    expect(await isV3MigrationComplete(persistence), isTrue);
  });

  // ── resume: migrateLegacySettings failure ──────────────────────────────

  test(
    'migrate失敗後の再実行: ensureDeviceAbsent・registerDevice はスキップされ migrate が再試行される',
    () async {
      var migrateShouldFail = true;
      final repo = FakeDeviceRepository(
        getResult: _notFound,
        putResult: () => const Success(_fakeDevice),
        migrateResult: () {
          if (migrateShouldFail) {
            return Failure(Exception('migrate network error'));
          }
          return const Success(null);
        },
      );

      // 1回目: GET・PUT成功, migrate失敗
      await expectLater(run(repo), throwsA(isA<Exception>()));
      expect(repo.getCalls, 1);
      expect(repo.putCalls, 1);
      expect(repo.migrateCalls, 1);

      // 2回目: migrate を成功させる
      migrateShouldFail = false;
      await run(repo);

      expect(repo.getCalls, 1, reason: 'ensureDeviceAbsent はキャッシュ済み');
      expect(repo.putCalls, 1, reason: 'registerDevice はキャッシュ済み');
      expect(repo.migrateCalls, 2, reason: 'migrate は再試行される');
      expect(await isV3MigrationComplete(persistence), isTrue);
    },
  );

  // ── getDevice unexpected error ──────────────────────────────────────────

  test('GET が 500 を返したとき例外が伝播し完了フラグは立たない', () async {
    final repo = FakeDeviceRepository(
      getResult: _serverError,
      putResult: () => throw StateError('should not reach'),
      migrateResult: () => throw StateError('should not reach'),
    );

    await expectLater(run(repo), throwsA(isA<Exception>()));
    expect(await isV3MigrationComplete(persistence), isFalse);
  });
}

// ── fake ───────────────────────────────────────────────────────────────────

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
