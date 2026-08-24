import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'provisioning returns required when flag is true but token is missing',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final authRepo = _MemoryDeviceAuthRepository();

      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => authRepo,
          ),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(deviceProvisioningProvider.future);
      expect(status, DeviceProvisioningStatus.required);

      final repo = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      expect(await repo.isProvisioned(), isFalse);
    },
  );

  test(
    'provisioning returns notRequired when flag is true and token exists',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final authRepo = _MemoryDeviceAuthRepository()
        ..savedToken = JWT({
          'sub': 'device:01976d8e-7d12-7000-8000-1234567890ab',
          'exp': 0,
        }).sign(SecretKey('test-secret'));

      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => authRepo,
          ),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(deviceProvisioningProvider.future);
      expect(status, DeviceProvisioningStatus.notRequired);
    },
  );

  test(
    'provisioning clears malformed JWT and returns required',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final authRepo = _MemoryDeviceAuthRepository()..savedToken = 'not-a-jwt';

      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith((ref) async => authRepo),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(deviceProvisioningProvider.future);
      expect(status, DeviceProvisioningStatus.required);
      expect(authRepo.savedToken, isNull);

      final repo = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      expect(await repo.isProvisioned(), isFalse);
    },
  );

  test(
    'provisioning clears JWT without device subject and returns required',
    () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceProvisioned.key: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final authRepo = _MemoryDeviceAuthRepository()
        ..savedToken = JWT({
          'sub': 'user:01976d8e-7d12-7000-8000-1234567890ab',
        }).sign(SecretKey('test-secret'));

      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith((ref) async => authRepo),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(deviceProvisioningProvider.future);
      expect(status, DeviceProvisioningStatus.required);
      expect(authRepo.savedToken, isNull);

      final repo = await container.read(
        deviceProvisioningRepositoryProvider.future,
      );
      expect(await repo.isProvisioned(), isFalse);
    },
  );

  test('不正JWTを削除した後はキャッシュ済みDevice IDも破棄する', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
    });
    final prefs = await SharedPreferences.getInstance();
    final authRepo = _MemoryDeviceAuthRepository()
      ..savedToken = JWT({
        'sub': 'device:device-a',
      }).sign(SecretKey('test-secret'));
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith((ref) async => authRepo),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(deviceIdProvider.future), 'device-a');
    authRepo.savedToken = 'not-a-jwt';

    expect(
      await container.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.required,
    );
    await expectLater(
      container.read(deviceIdProvider.future),
      throwsA(isA<StateError>()),
    );
  });

  test(
    'provisioning returns required when flag is false',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final authRepo = _MemoryDeviceAuthRepository();

      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => authRepo,
          ),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(deviceProvisioningProvider.future);
      expect(status, DeviceProvisioningStatus.required);
    },
  );
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
