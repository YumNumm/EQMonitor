import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/devices/data/logic/legacy_device_id_decoder.dart';

final class const LegacyDeviceIdRepository({
  required final PreferencesDataSource<SharedPreferencesKey> sharedPreferences,
  required final PreferencesDataSource<SecureStorageKey> securePreferences,
  final LegacyDeviceIdDecoder decoder = const LegacyDeviceIdDecoder(),
}) {
  Future<String?> recover() async {
    final token = await securePreferences.getString(
      key: SecureStorageKey.legacyApiToken,
    );
    final decodedId = decoder.decode(token);
    final savedId = await sharedPreferences.getString(
      key: SharedPreferencesKey.legacyDeviceId,
    );
    if (decodedId != null) {
      if (savedId != null && savedId != decodedId) {
        throw StateError('Conflicting legacy migration sources');
      }
      await sharedPreferences.setString(
        key: SharedPreferencesKey.legacyDeviceId,
        value: decodedId,
      );
      return decodedId;
    }
    return savedId != null && decoder.isValid(savedId) ? savedId : null;
  }
}
