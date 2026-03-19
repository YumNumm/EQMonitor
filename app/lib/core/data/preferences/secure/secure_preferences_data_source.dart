import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_preferences_data_source.g.dart';

@Riverpod(keepAlive: true)
Future<SecurePreferencesDataSource> securePreferencesDataSource(Ref ref) async {
  final storage = await ref.watch(secureStorageProvider.future);
  return SecurePreferencesDataSource(secureStorage: storage);
}

class SecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  SecurePreferencesDataSource({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) => _secureStorage.write(key: key.key, value: value);

  @override
  Future<String?> getString({required SecureStorageKey key}) =>
      _secureStorage.read(key: key.key);

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) => _secureStorage.write(key: key.key, value: value.toString());

  @override
  Future<int?> getInt({required SecureStorageKey key}) => _secureStorage
      .read(key: key.key)
      .then((value) => value != null ? int.parse(value) : null);

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) => _secureStorage.write(key: key.key, value: value.toString());

  @override
  Future<double?> getDouble({required SecureStorageKey key}) => _secureStorage
      .read(key: key.key)
      .then((value) => value != null ? double.parse(value) : null);

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) => _secureStorage.write(key: key.key, value: value.toString());

  @override
  Future<bool?> getBool({required SecureStorageKey key}) => _secureStorage
      .read(key: key.key)
      .then((value) => value != null ? bool.parse(value) : null);

  @override
  Future<void> remove({required SecureStorageKey key}) =>
      _secureStorage.delete(key: key.key);

  @override
  Future<void> clear() => _secureStorage.deleteAll();
}
