import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifier.g.dart';

@Riverpod(keepAlive: true)
class OnboardingCompleted extends _$OnboardingCompleted {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: .onboardingCompleted,
        ) ??
        false;
  }

  static final completeMutation = Mutation<void>();
  Future<void> complete() async {
    state = const AsyncData(true);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: .onboardingCompleted,
      value: true,
    );
  }

  static final resetMutation = Mutation<void>();
  Future<void> reset() async {
    state = const AsyncData(false);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.remove(key: .onboardingCompleted);
  }
}
