import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_permission_banner_dismissed_notifier.g.dart';

@riverpod
class LocationPermissionBannerDismissed
    extends _$LocationPermissionBannerDismissed {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: SharedPreferencesKey.locationPermissionBannerDismissed,
        ) ??
        false;
  }

  Future<void> dismiss() async {
    state = const AsyncData(true);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.locationPermissionBannerDismissed,
      value: true,
    );
  }
}
