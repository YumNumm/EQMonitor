import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_tracking_mode.g.dart';

@riverpod
class LocationTrackingMode extends _$LocationTrackingMode {
  @override
  bool build() => get();

  static const _key = 'location_tracking_mode';

  Future<void> set({required bool value}) async {
    state = value;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_key, value);
  }

  bool get() {
    return ref
            .read(sharedPreferencesProvider)
            .getBool(_key) ??
        false;
  }
}
