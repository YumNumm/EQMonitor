import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/workflow/device_migration_workflow.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:workflows/workflows.dart';

const _deviceId = 'new-device';
const _oldDeviceId = 'old-device';
const _fakeDevice = RegisteredDevice(
  id: _deviceId,
  platform: DevicePlatform.ios,
  userId: null,
  locale: DeviceLocale.ja,
  createdAtIso: '2026-01-01T00:00:00Z',
  updatedAtIso: '2026-01-01T00:00:00Z',
);

void main() {
  const workflow = DeviceMigrationWorkflow();

  FakeDeviceRepository repository(Result<void, Exception> Function() migrate) =>
      FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: migrate,
      );

  test('成功後の再起動では同じ移行を再送しない', () async {
    final persistence = InMemoryWorkflowPersistence();
    final repo = repository(() => const Success(null));
    for (var i = 0; i < 2; i++) {
      await workflow.run(
        runner: WorkflowRunner(persistence: persistence),
        repository: repo,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      );
    }
    expect(repo.migrateCalls, 1);
    expect(
      await workflow.isComplete(
        persistence: persistence,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      ),
      isTrue,
    );
  });

  test('失敗後は新しい runner でも移行を再試行できる', () async {
    final persistence = InMemoryWorkflowPersistence();
    var shouldFail = true;
    final repo = repository(
      () => shouldFail
          ? Failure(Exception('network failure'))
          : const Success(null),
    );
    await expectLater(
      workflow.run(
        runner: WorkflowRunner(persistence: persistence),
        repository: repo,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      ),
      throwsA(isA<Exception>()),
    );
    expect(
      await workflow.isComplete(
        persistence: persistence,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      ),
      isFalse,
    );
    shouldFail = false;
    await workflow.run(
      runner: WorkflowRunner(persistence: persistence),
      repository: repo,
      oldDeviceId: _oldDeviceId,
      deviceId: _deviceId,
    );
    expect(repo.migrateCalls, 2);
  });

  test('移行元・移行先が変わると以前の成功を再利用しない', () async {
    final persistence = InMemoryWorkflowPersistence();
    final repo = repository(() => const Success(null));
    for (final pair in [
      (old: _oldDeviceId, destination: _deviceId),
      (old: _oldDeviceId, destination: 'another-device'),
      (old: 'another-source', destination: _deviceId),
    ]) {
      await workflow.run(
        runner: WorkflowRunner(persistence: persistence),
        repository: repo,
        oldDeviceId: pair.old,
        deviceId: pair.destination,
      );
    }
    expect(repo.migrateCalls, 3);
  });

  test('v1で保存された成功を新 workflow の成功と扱わない', () async {
    final persistence = InMemoryWorkflowPersistence();
    await persistence.saveStepResult(
      'v3-device-migration-v1',
      'migrateLegacySettings',
      null,
    );
    await persistence.saveStepResult(
      'v3-device-migration-v1',
      'markLocalComplete',
      true,
    );
    final repo = repository(() => const Success(null));
    await workflow.run(
      runner: WorkflowRunner(persistence: persistence),
      repository: repo,
      oldDeviceId: _oldDeviceId,
      deviceId: _deviceId,
    );
    expect(repo.migrateCalls, 1);
  });

  test('成功step保存後の完了保存失敗は再起動後も移行を再送しない', () async {
    final persistence = _FailCompletePersistence();
    final repo = repository(() => const Success(null));
    await expectLater(
      workflow.run(
        runner: WorkflowRunner(persistence: persistence),
        repository: repo,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      ),
      throwsStateError,
    );
    await workflow.run(
      runner: WorkflowRunner(persistence: persistence),
      repository: repo,
      oldDeviceId: _oldDeviceId,
      deviceId: _deviceId,
    );
    expect(repo.migrateCalls, 1);
    expect(
      await workflow.isComplete(
        persistence: persistence,
        oldDeviceId: _oldDeviceId,
        deviceId: _deviceId,
      ),
      isTrue,
    );
  });
}

final class _FailCompletePersistence implements WorkflowPersistence {
  final delegate = InMemoryWorkflowPersistence();
  var failOnce = true;

  @override
  Future<String?> getRaw(String instanceId, String stepName) =>
      delegate.getRaw(instanceId, stepName);

  @override
  Future<void> saveRaw(String instanceId, String stepName, String raw) async {
    if (stepName == 'markLocalComplete' && failOnce) {
      failOnce = false;
      throw StateError('mock disk failure');
    }
    await delegate.saveRaw(instanceId, stepName, raw);
  }

  @override
  Future<void> clearInstance(String instanceId) =>
      delegate.clearInstance(instanceId);
}

class FakeDeviceRepository extends DeviceRepository {
  new({
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
  Future<Result<RegisteredDevice, Exception>> getDevice() async {
    getCalls++;
    return _getResult();
  }

  @override
  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) async {
    putCalls++;
    return _putResult();
  }

  @override
  Future<Result<void, Exception>> migrateFromLegacy({
    required String oldDeviceId,
  }) async {
    migrateCalls++;
    return _migrateResult();
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  new() : super(_MemorySecurePreferencesDataSource());

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
