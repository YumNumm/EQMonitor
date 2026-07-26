import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_enabled_notifier.g.dart';

@Riverpod(keepAlive: true)
class EewWarningOverlayEnabled extends _$EewWarningOverlayEnabled {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: SharedPreferencesKey.eewWarningOverlayEnabled,
        ) ??
        true;
  }

  Future<void> set({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.eewWarningOverlayEnabled,
      value: value,
    );
    state = AsyncData(value);
  }
}
