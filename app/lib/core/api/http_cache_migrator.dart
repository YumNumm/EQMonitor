import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';

const kHttpCacheScopeMigrationVersion = 1;

final class HttpCacheMigrator {
  const new({required this.clearCache, required this.dataSource});

  final Future<void> Function() clearCache;
  final SharedPreferencesDataSource dataSource;

  Future<void> migrate() async {
    final current = await dataSource.getInt(
      key: SharedPreferencesKey.httpCacheScopeMigrationVersion,
    );
    if ((current ?? 0) >= kHttpCacheScopeMigrationVersion) {
      return;
    }
    await clearCache();
    await dataSource.setInt(
      key: SharedPreferencesKey.httpCacheScopeMigrationVersion,
      value: kHttpCacheScopeMigrationVersion,
    );
  }
}
