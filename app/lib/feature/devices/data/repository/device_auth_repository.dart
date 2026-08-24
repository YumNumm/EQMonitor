import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_registration_generation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceAuthRepository> deviceAuthRepository(Ref ref) async =>
    DeviceAuthRepository(
      await ref.watch(securePreferencesDataSourceProvider.future),
      onCredentialsWillChange: ref
          .watch(deviceRegistrationGenerationRepositoryProvider)
          .rotate,
    );

class DeviceAuthRepository {
  const new(this._preferences, {this.onCredentialsWillChange});

  final PreferencesDataSource<SecureStorageKey> _preferences;
  final Future<void> Function()? onCredentialsWillChange;

  Future<String?> readToken() =>
      _preferences.getString(key: SecureStorageKey.deviceToken);

  Future<void> saveToken({required String token}) async {
    await onCredentialsWillChange?.call();
    await _preferences.setString(
      key: SecureStorageKey.deviceToken,
      value: token,
    );
  }

  Future<void> clearToken() async {
    await onCredentialsWillChange?.call();
    await _preferences.remove(key: SecureStorageKey.deviceToken);
  }
}
