import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_banner_seen_version_notifier.g.dart';

/// アップデートバナーで最後に既読/Dismiss したアプリバージョン。
/// 現在のアプリバージョンと異なる場合にバナーを表示する。
@Riverpod(keepAlive: true)
class UpdateBannerSeenVersion extends _$UpdateBannerSeenVersion {
  @override
  Future<String?> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return dataSource.getString(key: SharedPreferencesKey.whatsNewSeenVersion);
  }

  Future<void> markSeen(String version) async {
    state = AsyncData(version);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setString(
      key: SharedPreferencesKey.whatsNewSeenVersion,
      value: version,
    );
  }
}
