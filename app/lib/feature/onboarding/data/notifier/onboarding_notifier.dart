import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifier.g.dart';

@riverpod
class OnboardingCompleted extends _$OnboardingCompleted {
  static final completeMutation = Mutation<void>();
  static final resetMutation = Mutation<void>();

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(SharedPreferencesKey.onboardingCompleted.key) ?? false;
  }

  Future<void> complete() async {
    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(SharedPreferencesKey.onboardingCompleted.key, true);
  }

  Future<void> reset() async {
    state = false;
    await ref
        .read(sharedPreferencesProvider)
        .remove(SharedPreferencesKey.onboardingCompleted.key);
  }
}
