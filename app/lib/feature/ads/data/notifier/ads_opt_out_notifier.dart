import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_opt_out_notifier.g.dart';

@Riverpod(keepAlive: true)
class AdsOptOutNotifier extends _$AdsOptOutNotifier {
  static const SharedPreferencesKey _key = SharedPreferencesKey.adsOptOut;
  static final saveMutation = Mutation<void>();

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: _key) ?? false;
  }

  Future<void> toggle() async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final next = !(state.value ?? false);
    await dataSource.setBool(key: _key, value: next);
    state = AsyncData(next);
  }

  Future<void> setOptOut({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: _key, value: value);
    state = AsyncData(value);
  }
}
