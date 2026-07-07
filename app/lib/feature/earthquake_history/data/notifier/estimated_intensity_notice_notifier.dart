import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_notice_notifier.g.dart';

@riverpod
class EstimatedIntensityNoticeShown extends _$EstimatedIntensityNoticeShown {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: SharedPreferencesKey.estimatedIntensityNoticeShown,
        ) ??
        false;
  }

  Future<void> markShown() async {
    state = const AsyncData(true);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.estimatedIntensityNoticeShown,
      value: true,
    );
  }
}
