import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_notifier.g.dart';

typedef FeedNotifierState = ({List<FeedItem> items, String? nextCursor});

@riverpod
class FeedNotifier extends _$FeedNotifier {
  @override
  Future<FeedNotifierState> build() async {
    final repository = await ref.read(feedRepositoryProvider.future);
    final response = await repository.fetch();
    return (items: response.feeds, nextCursor: response.nextCursor);
  }

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
