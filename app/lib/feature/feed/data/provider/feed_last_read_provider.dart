import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_last_read_provider.g.dart';

/// お知らせの既読位置(最後に既読にしたアイテムの publishedAt)を
/// 端末に永続化する。未設定(初回起動)の場合は null。
@Riverpod(keepAlive: true)
class FeedLastRead extends _$FeedLastRead {
  static const _key = SharedPreferencesKey.feedLastReadPublishedAt;

  @override
  Future<DateTime?> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    final millis = await dataSource.getInt(key: _key);
    return millis != null ? DateTime.fromMillisecondsSinceEpoch(millis) : null;
  }

  /// 既読位置を [publishedAt] まで進める。過去方向には戻さない。
  Future<void> markRead(DateTime publishedAt) async {
    final current = await future;
    if (current != null && !publishedAt.isAfter(current)) {
      return;
    }
    await _save(publishedAt);
  }

  /// 未設定(初回起動)の場合のみ既読位置を初期化する。
  /// 初回起動時に過去のお知らせがすべて未読扱いになり
  /// バナーが表示されるのを防ぐ。
  Future<void> initializeIfUnset(DateTime publishedAt) async {
    final current = await future;
    if (current != null) {
      return;
    }
    await _save(publishedAt);
  }

  Future<void> _save(DateTime publishedAt) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setInt(
      key: _key,
      value: publishedAt.millisecondsSinceEpoch,
    );
    state = AsyncData(publishedAt);
  }
}
