import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_tracking_mode.g.dart';

@riverpod
class LocationTrackingMode extends _$LocationTrackingMode {
  @override
  Future<bool> build() async => get();

  Future<bool> get() async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final value =
        await ds.getBool(key: SharedPreferencesKey.locationTrackingMode);
    return value ?? false;
  }

  Future<void> set({required bool value}) async {
    state = AsyncValue.data(value);
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setBool(key: SharedPreferencesKey.locationTrackingMode, value: value);
  }
}
