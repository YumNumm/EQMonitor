import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_data_source.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferencesDataSource> sharedPreferencesDataSource(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SharedPreferencesDataSource(sharedPreferences: prefs);
}

class SharedPreferencesDataSource
    implements PreferencesDataSource<SharedPreferencesKey> {
  new({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> setString({
    required SharedPreferencesKey key,
    required String value,
  }) => _sharedPreferences.setString(key.key, value);

  @override
  Future<String?> getString({required SharedPreferencesKey key}) =>
      Future.value(_sharedPreferences.getString(key.key));

  @override
  Future<void> setInt({
    required SharedPreferencesKey key,
    required int value,
  }) => _sharedPreferences.setInt(key.key, value);

  @override
  Future<int?> getInt({required SharedPreferencesKey key}) =>
      Future.value(_sharedPreferences.getInt(key.key));

  @override
  Future<void> setDouble({
    required SharedPreferencesKey key,
    required double value,
  }) => _sharedPreferences.setDouble(key.key, value);

  @override
  Future<double?> getDouble({required SharedPreferencesKey key}) =>
      Future.value(_sharedPreferences.getDouble(key.key));

  @override
  Future<void> setBool({
    required SharedPreferencesKey key,
    required bool value,
  }) async {
    final didPersist = await _sharedPreferences.setBool(key.key, value);
    if (!didPersist) {
      throw StateError('Failed to persist SharedPreferences key: ${key.key}');
    }
  }

  @override
  Future<bool?> getBool({required SharedPreferencesKey key}) =>
      Future.value(_sharedPreferences.getBool(key.key));

  @override
  Future<void> remove({required SharedPreferencesKey key}) =>
      _sharedPreferences.remove(key.key);

  @override
  Future<void> clear() => _sharedPreferences.clear();
}
