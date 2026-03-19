abstract class PreferencesDataSource<T> {
  Future<void> setString({required T key, required String value});
  Future<String?> getString({required T key});

  Future<void> setInt({required T key, required int value});
  Future<int?> getInt({required T key});

  Future<void> setDouble({required T key, required double value});
  Future<double?> getDouble({required T key});

  Future<void> setBool({required T key, required bool value});
  Future<bool?> getBool({required T key});

  Future<void> remove({required T key});

  Future<void> clear();
}
