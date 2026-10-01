import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/devices/data/repository/legacy_device_id_repository.dart';

final class const SecureStorageInitializer({
  required final PreferencesDataSource<SharedPreferencesKey> sharedPreferences,
  required final PreferencesDataSource<SecureStorageKey> securePreferences,
}) {
  Future<void> initialize() async {
    final initialized = await sharedPreferences.getBool(
      key: SharedPreferencesKey.secureStorageInitialized,
    );
    final migrated = await sharedPreferences.getBool(
      key: SharedPreferencesKey.deviceLegacyMigrationVerified,
    );
    if (migrated == true && initialized != null) {
      await securePreferences.remove(key: SecureStorageKey.legacyApiToken);
      return;
    }
    await LegacyDeviceIdRepository(
      sharedPreferences: sharedPreferences,
      securePreferences: securePreferences,
    ).recover();
    if (initialized != null) {
      return;
    }
    final legacyToken = await securePreferences.getString(
      key: SecureStorageKey.legacyApiToken,
    );
    // v2 は marker を持たない。破損 token も証拠を失わないよう保持する。
    if (legacyToken == null) {
      await securePreferences.clear();
    }
    await sharedPreferences.setBool(
      key: SharedPreferencesKey.secureStorageInitialized,
      value: true,
    );
  }
}
