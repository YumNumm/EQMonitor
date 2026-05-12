import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_debug_settings_provider.g.dart';

const _keyNotifyLatLng = 'bgl_debug_latlng';
const _keyNotifyRegion = 'bgl_debug_region';
const _keyNotifyPrefecture = 'bgl_debug_prefecture';

typedef BackgroundLocationDebugSettingsState = ({
  bool notifyLatLng,
  bool notifyRegion,
  bool notifyPrefecture,
});

/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。
@Riverpod(keepAlive: true)
class BackgroundLocationDebugSettings
    extends _$BackgroundLocationDebugSettings {
  @override
  BackgroundLocationDebugSettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return (
      notifyLatLng: prefs.getBool(_keyNotifyLatLng) ?? false,
      notifyRegion: prefs.getBool(_keyNotifyRegion) ?? false,
      notifyPrefecture: prefs.getBool(_keyNotifyPrefecture) ?? false,
    );
  }

  Future<void> setNotifyLatLng({required bool value}) async {
    await ref.read(sharedPreferencesProvider).setBool(_keyNotifyLatLng, value);
    state = (
      notifyLatLng: value,
      notifyRegion: state.notifyRegion,
      notifyPrefecture: state.notifyPrefecture,
    );
  }

  Future<void> setNotifyRegion({required bool value}) async {
    await ref.read(sharedPreferencesProvider).setBool(_keyNotifyRegion, value);
    state = (
      notifyLatLng: state.notifyLatLng,
      notifyRegion: value,
      notifyPrefecture: state.notifyPrefecture,
    );
  }

  Future<void> setNotifyPrefecture({required bool value}) async {
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_keyNotifyPrefecture, value);
    state = (
      notifyLatLng: state.notifyLatLng,
      notifyRegion: state.notifyRegion,
      notifyPrefecture: value,
    );
  }
}
