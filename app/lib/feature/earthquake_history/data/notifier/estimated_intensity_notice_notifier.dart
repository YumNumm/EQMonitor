import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_notice_notifier.g.dart';

@riverpod
class EstimatedIntensityNoticeShown extends _$EstimatedIntensityNoticeShown {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(
          SharedPreferencesKey.estimatedIntensityNoticeShown.key,
        ) ??
        false;
  }

  Future<void> markShown() async {
    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(SharedPreferencesKey.estimatedIntensityNoticeShown.key, true);
  }
}
