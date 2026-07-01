import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_on_eew_replay_allowed_provider.g.dart';

@Riverpod(keepAlive: true)
class EstimatedIntensityOnEewReplayAllowed
    extends _$EstimatedIntensityOnEewReplayAllowed {
  static const SharedPreferencesKey _key =
      SharedPreferencesKey.isEstimatedIntensityOnEewReplayAllowed;

  @override
  bool build() {
    return ref.read(sharedPreferencesProvider).getBool(_key.key) ?? false;
  }

  Future<void> save({required bool isEnabled}) async {
    await ref.read(sharedPreferencesProvider).setBool(_key.key, isEnabled);
    state = isEnabled;
  }
}
