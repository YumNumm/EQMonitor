import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/paging/cache_first_refresh.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/foundation.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_data_source.g.dart';

@riverpod
Future<FeedDataSource> feedDataSource(Ref ref) async {
  final repository = await ref.watch(feedRepositoryProvider.future);
  final cacheOnly = await ref.watch(cacheOnlyApiClientProvider.future);
  final dataSource = FeedDataSource(
    repository: repository,
    cacheOnlyClient: cacheOnly,
  );
  ref.onDispose(dataSource.dispose);
  return dataSource;
}

class FeedDataSource extends DataSource<String?, FeedItem> {
  FeedDataSource({
    required FeedRepository repository,
    required api.ApiClient cacheOnlyClient,
  }) : _repository = repository,
       _cacheOnlyClient = cacheOnlyClient;

  final FeedRepository _repository;
  final api.ApiClient _cacheOnlyClient;

  final ValueNotifier<bool> isRevalidating = ValueNotifier(false);
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    isRevalidating.dispose();
    super.dispose();
  }

  @override
  Future<LoadResult<String?, FeedItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await cacheFirstRefresh<FeedItem>(
      fetchPage: ({required cacheOnly}) async {
        final response = await _repository.fetch(
          after: null,
          client: cacheOnly ? _cacheOnlyClient : null,
        );
        return PageData(data: response.feeds, appendKey: response.nextCursor);
      },
      upsert: upsertItems,
      isActive: () => !_disposed,
      isRevalidating: isRevalidating,
      onRevalidateError: (e, st) => talker.error(e, st),
    ),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, FeedItem>> _fetch(String? cursor) async {
    try {
      final response = await _repository.fetch(after: cursor);
      return Success(
        page: PageData(data: response.feeds, appendKey: response.nextCursor),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  /// id 一致で in-place 更新する (背景 revalidate の主目的)。
  /// 未登録の新規は暫定的に末尾へ追加する。お知らせは新しい順のため本来は先頭寄り
  /// が正しいが、revalidate 窓 (数秒) に新規公開された場合のみで、次の定期/手動
  /// リフレッシュで正順に是正される。厳密な先頭挿入は follow-up (Issue #1452)。
  void upsertItems(List<FeedItem> fresh) {
    for (final item in fresh) {
      final currentItems = [...notifier.values];
      final index = currentItems.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        updateItem(index, (_) => item);
        continue;
      }
      insertItem(currentItems.length, item);
    }
  }
}
