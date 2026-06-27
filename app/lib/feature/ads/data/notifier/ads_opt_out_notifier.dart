import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_opt_out_notifier.g.dart';

@Riverpod(keepAlive: true)
class AdsOptOutNotifier extends _$AdsOptOutNotifier {
  static const SharedPreferencesKey _key = SharedPreferencesKey.adsOptOut;
  static final saveMutation = Mutation<void>();

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key.key) ?? false;
  }

  Future<void> toggle() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final next = !state;
    await prefs.setBool(_key.key, next);
    state = next;
  }

  Future<void> setOptOut({required bool value}) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key.key, value);
    state = value;
  }
}
