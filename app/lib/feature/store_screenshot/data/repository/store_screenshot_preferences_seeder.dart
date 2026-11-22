import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';

class const StoreScreenshotPreferencesSeeder() {
  Future<void> seed({
    required SharedPreferencesDataSource dataSource,
    required Map<String, dynamic> values,
  }) async {
    for (final MapEntry(:key, :value) in values.entries) {
      final preferenceKey = SharedPreferencesKey.values.firstWhere(
        (candidate) => candidate.key == key,
        orElse: () => throw ArgumentError.value(key, 'preferences'),
      );
      await switch (value) {
        final bool flag => dataSource.setBool(key: preferenceKey, value: flag),
        final int number => dataSource.setInt(
          key: preferenceKey,
          value: number,
        ),
        final double number => dataSource.setDouble(
          key: preferenceKey,
          value: number,
        ),
        final String text => dataSource.setString(
          key: preferenceKey,
          value: text,
        ),
        _ => throw ArgumentError.value(value, key),
      };
    }
  }
}
