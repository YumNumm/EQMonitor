import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_notifier.g.dart';

typedef FeedNotifierState = ({List<FeedItem> items, String? nextCursor});

@riverpod
class FeedNotifier extends _$FeedNotifier with CachedNotifier<FeedNotifierState> {
  @override
  Future<FeedNotifierState> fetch(api.ApiClient client) async {
    final repository = await ref.read(feedRepositoryProvider.future);
    final response = await repository.fetch(client: client);
    return (items: response.feeds, nextCursor: response.nextCursor);
  }

  @override
  Future<FeedNotifierState> build() => cachedBuild();

  Future<void> fetchNextData() async {
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    final currentState = state.value;
    if (currentState == null || currentState.nextCursor == null) {
      return;
    }

    state = await state.guardPlus(() async {
      final repository = await ref.read(feedRepositoryProvider.future);
      final response = await repository.fetch(after: currentState.nextCursor);
      return (
        items: [...currentState.items, ...response.feeds],
        nextCursor: response.nextCursor,
      );
    });
  }
}

extension FeedNotifierStateEx on FeedNotifierState {
  bool get hasNext => nextCursor != null;
}
