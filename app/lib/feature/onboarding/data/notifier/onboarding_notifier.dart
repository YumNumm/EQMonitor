import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifier.g.dart';

@riverpod
class OnboardingCompleted extends _$OnboardingCompleted {
  static final completeMutation = Mutation<void>();
  static final resetMutation = Mutation<void>();

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: SharedPreferencesKey.onboardingCompleted,
        ) ??
        false;
  }

  Future<void> complete() async {
    state = const AsyncData(true);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.onboardingCompleted,
      value: true,
    );
  }

  Future<void> reset() async {
    state = const AsyncData(false);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.remove(key: SharedPreferencesKey.onboardingCompleted);
  }
}
