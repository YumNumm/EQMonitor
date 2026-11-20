import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'release_highlight_seen_version_notifier.g.dart';

/// 新機能の案内を最後に確認したアプリバージョン。
///
/// 新規インストールではオンボーディング完了時に現在のバージョンを保存し、
/// 更新していない端末に案内を出さない。
@Riverpod(keepAlive: true)
class ReleaseHighlightSeenVersion extends _$ReleaseHighlightSeenVersion {
  @override
  Future<String?> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return dataSource.getString(
      key: SharedPreferencesKey.releaseHighlightSeenVersion,
    );
  }

  static final markSeenMutation = Mutation<void>();
  Future<void> markSeen(String version) async {
    state = AsyncData(version);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setString(
      key: SharedPreferencesKey.releaseHighlightSeenVersion,
      value: version,
    );
  }
}
