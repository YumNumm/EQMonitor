import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final deviceRegistrationGenerationRepositoryProvider =
    Provider<DeviceRegistrationGenerationRepository>(
      (ref) => DeviceRegistrationGenerationRepository(
        preferences: SharedPreferencesAsync(),
      ),
    );

class DeviceRegistrationGenerationRepository {
  new({
    required SharedPreferencesAsync preferences,
    String Function()? generate,
  }) : _preferences = preferences,
       _generate = generate ?? const Uuid().v4;

  final SharedPreferencesAsync _preferences;
  final String Function() _generate;

  Future<String> readOrCreate() async {
    final stored = await _preferences.getString(
      SharedPreferencesKey.deviceRegistrationGeneration.key,
    );
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }
    return rotate();
  }

  Future<String> rotate() async {
    final generation = _generate();
    await _preferences.setString(
      SharedPreferencesKey.deviceRegistrationGeneration.key,
      generation,
    );
    return generation;
  }
}
