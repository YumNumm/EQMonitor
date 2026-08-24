import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'better_auth_session_repository.g.dart';

@Riverpod(keepAlive: true)
Future<BetterAuthSessionRepository> betterAuthSessionRepository(Ref ref) async {
  final preferences = await ref.watch(
    securePreferencesDataSourceProvider.future,
  );
  return BetterAuthSessionRepository(preferences: preferences);
}

final class BetterAuthSessionRepository {
  const new({
    required PreferencesDataSource<SecureStorageKey> preferences,
  }) : _preferences = preferences;

  final PreferencesDataSource<SecureStorageKey> _preferences;

  Future<String?> readSessionToken() => _preferences.getString(
    key: SecureStorageKey.betterAuthSessionToken,
  );

  Future<void> saveSessionToken({required String token}) =>
      _preferences.setString(
        key: SecureStorageKey.betterAuthSessionToken,
        value: token,
      );

  Future<void> clearSession() => _preferences.remove(
    key: SecureStorageKey.betterAuthSessionToken,
  );
}
