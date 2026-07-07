import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_disabled_provider.g.dart';

/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は dio プロバイダが watch しているため即座に反映される。
@Riverpod(keepAlive: true)
class HttpCacheDisabled extends _$HttpCacheDisabled {
  static const SharedPreferencesKey _key =
      SharedPreferencesKey.httpCacheDisabled;

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: _key) ?? false;
  }

  Future<void> save({required bool isDisabled}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: _key, value: isDisabled);
    state = AsyncData(isDisabled);
  }
}
