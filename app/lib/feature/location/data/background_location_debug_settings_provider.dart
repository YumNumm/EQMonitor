import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_debug_settings_provider.g.dart';

typedef BackgroundLocationDebugSettingsState = ({
  bool notifyLatLng,
  bool notifyRegion,
  bool notifyPrefecture,
  bool notifyApiUpdate,
});

/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。
@Riverpod(keepAlive: true)
class BackgroundLocationDebugSettings
    extends _$BackgroundLocationDebugSettings {
  @override
  Future<BackgroundLocationDebugSettingsState> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return (
      notifyLatLng:
          await dataSource.getBool(
            key: SharedPreferencesKey.bglDebugNotifyLatLng,
          ) ??
          false,
      notifyRegion:
          await dataSource.getBool(
            key: SharedPreferencesKey.bglDebugNotifyRegion,
          ) ??
          false,
      notifyPrefecture:
          await dataSource.getBool(
            key: SharedPreferencesKey.bglDebugNotifyPrefecture,
          ) ??
          false,
      notifyApiUpdate:
          await dataSource.getBool(
            key: SharedPreferencesKey.bglDebugNotifyApiUpdate,
          ) ??
          false,
    );
  }

  Future<void> setNotifyLatLng({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.bglDebugNotifyLatLng,
      value: value,
    );
    final current = state.requireValue;
    state = AsyncData((
      notifyLatLng: value,
      notifyRegion: current.notifyRegion,
      notifyPrefecture: current.notifyPrefecture,
      notifyApiUpdate: current.notifyApiUpdate,
    ));
  }

  Future<void> setNotifyRegion({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.bglDebugNotifyRegion,
      value: value,
    );
    final current = state.requireValue;
    state = AsyncData((
      notifyLatLng: current.notifyLatLng,
      notifyRegion: value,
      notifyPrefecture: current.notifyPrefecture,
      notifyApiUpdate: current.notifyApiUpdate,
    ));
  }

  Future<void> setNotifyPrefecture({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.bglDebugNotifyPrefecture,
      value: value,
    );
    final current = state.requireValue;
    state = AsyncData((
      notifyLatLng: current.notifyLatLng,
      notifyRegion: current.notifyRegion,
      notifyPrefecture: value,
      notifyApiUpdate: current.notifyApiUpdate,
    ));
  }

  Future<void> setNotifyApiUpdate({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.bglDebugNotifyApiUpdate,
      value: value,
    );
    final current = state.requireValue;
    state = AsyncData((
      notifyLatLng: current.notifyLatLng,
      notifyRegion: current.notifyRegion,
      notifyPrefecture: current.notifyPrefecture,
      notifyApiUpdate: value,
    ));
  }
}
