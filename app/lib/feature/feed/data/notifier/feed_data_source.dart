import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_data_source.g.dart';

@riverpod
Future<FeedDataSource> feedDataSource(Ref ref) async {
  final repository = await ref.watch(feedRepositoryProvider.future);
  final dataSource = FeedDataSource(repository: repository);
  ref.onDispose(dataSource.dispose);
  return dataSource;
}

class FeedDataSource extends DataSource<String?, FeedItem> {
  new({required FeedRepository repository})
    : _repository = repository;

  final FeedRepository _repository;

  @override
  Future<LoadResult<String?, FeedItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
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
}
