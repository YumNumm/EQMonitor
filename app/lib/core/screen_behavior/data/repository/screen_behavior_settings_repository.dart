import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/screen_behavior/data/model/screen_behavior_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_behavior_settings_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ScreenBehaviorSettingsRepository> screenBehaviorSettingsRepository(
  Ref ref,
) async => ScreenBehaviorSettingsRepository(
  dataSource: await ref.watch(sharedPreferencesDataSourceProvider.future),
);

class const ScreenBehaviorSettingsRepository({
  required final SharedPreferencesDataSource dataSource,
}) {
  Future<ScreenBehaviorSettings> load() async => ScreenBehaviorSettings(
    keepScreenAwake:
        await dataSource.getBool(key: SharedPreferencesKey.keepScreenAwake) ??
        false,
    showWhenLocked:
        await dataSource.getBool(key: SharedPreferencesKey.showWhenLocked) ??
        true,
  );

  Future<void> setKeepScreenAwake({required bool enabled}) => save(
    key: SharedPreferencesKey.keepScreenAwake,
    enabled: enabled,
    defaultValue: false,
  );

  Future<void> setShowWhenLocked({required bool enabled}) => save(
    key: SharedPreferencesKey.showWhenLocked,
    enabled: enabled,
    defaultValue: true,
  );

  Future<void> save({
    required SharedPreferencesKey key,
    required bool enabled,
    required bool defaultValue,
  }) async {
    final previous = await dataSource.getBool(key: key) ?? defaultValue;
    try {
      await dataSource.setBool(key: key, value: enabled);
    } catch (error, stackTrace) {
      // legacy SharedPreferences は disk commit 失敗時もメモリと native listener を更新する。
      try {
        await dataSource.setBool(key: key, value: previous);
      } catch (rollbackError, rollbackStackTrace) {
        talker.error(
          'Failed to restore screen behavior preference',
          rollbackError,
          rollbackStackTrace,
        );
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
