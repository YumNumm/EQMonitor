import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('DeviceIdProvider は保存済み JWT の sub から Device ID を返す', () async {
    final token = JWT({
      'sub': 'device:01976d8e-7d12-7000-8000-1234567890ab',
    }).sign(SecretKey('test-secret'));
    final preferences = _MemorySecurePreferencesDataSource()
      ..values[SecureStorageKey.deviceToken] = token;
    final container = ProviderContainer(
      overrides: [
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => DeviceAuthRepository(preferences),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      await container.read(deviceIdProvider.future),
      '01976d8e-7d12-7000-8000-1234567890ab',
    );
  });

  test('DeviceIdProvider は JWT が保存されていない場合にエラーを返す', () async {
    final container = ProviderContainer(
      overrides: [
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => DeviceAuthRepository(
            _MemorySecurePreferencesDataSource(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(deviceIdProvider.future),
      throwsA(isA<StateError>()),
    );
  });
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    values[key] = value;
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    values.remove(key);
  }

  @override
  Future<void> clear() async => values.clear();

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {}

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {}

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {}
}
