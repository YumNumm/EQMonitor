import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'beta_testing_notifier.g.dart';

@riverpod
class BetaTestingAgreed extends _$BetaTestingAgreed {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(SharedPreferencesKey.betaTestingAgreed.key) ?? false;
  }

  Future<void> agree() async {
    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(SharedPreferencesKey.betaTestingAgreed.key, true);
  }
}
