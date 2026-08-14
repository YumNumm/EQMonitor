import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_eew_estimation_debug_notifier.g.dart';

/// ホーム画面のEEWカードに、距離減衰式による推計震度と到達予想時刻を
/// 表示するかどうかのデバッグ設定。
///
/// この設定単体では表示可否を決めない。実際の表示可否は
/// `isHomeEewEstimationVisibleProvider` を参照する。
@Riverpod(keepAlive: true)
class HomeEewEstimationDebug extends _$HomeEewEstimationDebug {
  static const SharedPreferencesKey _key =
      SharedPreferencesKey.isHomeEewEstimationDebugEnabled;

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
