import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_tracking_mode.g.dart';

@riverpod
class LocationTrackingMode extends _$LocationTrackingMode {
  @override
  Future<bool> build() async => get();

  Future<bool> get() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final value = await sharedPreferences.getBool(
      key: SharedPreferencesKey.locationTrackingMode,
    );
    return value ?? false;
  }

  Future<void> set({required bool value}) async {
    state = AsyncValue.data(value);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setBool(
      key: SharedPreferencesKey.locationTrackingMode,
      value: value,
    );
  }

  /// 位置情報の権限をリクエストする（拒否済みの場合は再ダイアログは出ない）。
  Future<LocationPermission> requestPermission() async {
    var p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }
    return p;
  }
}
