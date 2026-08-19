import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceAuthRepository> deviceAuthRepository(Ref ref) async =>
    DeviceAuthRepository(
      await ref.watch(securePreferencesDataSourceProvider.future),
    );

class DeviceAuthRepository {
  const new(this._preferences);

  final PreferencesDataSource<SecureStorageKey> _preferences;

  Future<String?> readToken() =>
      _preferences.getString(key: SecureStorageKey.deviceToken);

  Future<void> saveToken({required String token}) =>
      _preferences.setString(key: SecureStorageKey.deviceToken, value: token);

  Future<void> clearToken() =>
      _preferences.remove(key: SecureStorageKey.deviceToken);
}
