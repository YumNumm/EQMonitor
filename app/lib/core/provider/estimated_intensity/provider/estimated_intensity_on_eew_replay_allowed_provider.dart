import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_on_eew_replay_allowed_provider.g.dart';

@Riverpod(keepAlive: true)
class EstimatedIntensityOnEewReplayAllowed
    extends _$EstimatedIntensityOnEewReplayAllowed {
  static const SharedPreferencesKey _key =
      SharedPreferencesKey.isEstimatedIntensityOnEewReplayAllowed;

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: _key) ?? false;
  }

  Future<void> save({required bool isEnabled}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: _key, value: isEnabled);
    state = AsyncData(isEnabled);
  }
}
