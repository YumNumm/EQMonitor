import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'beta_testing_notifier.g.dart';

@riverpod
class BetaTestingAgreed extends _$BetaTestingAgreed {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: .betaTestingAgreed) ?? false;
  }

  static final agreeMutation = Mutation<void>();
  Future<void> agree() async {
    state = const AsyncData(true);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: .betaTestingAgreed, value: true);
  }
}
