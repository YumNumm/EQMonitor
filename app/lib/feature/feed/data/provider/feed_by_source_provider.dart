import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_by_source_provider.g.dart';

@riverpod
class FeedBySource extends _$FeedBySource with CachedNotifier<FeedDetail> {
  @override
  Future<FeedDetail> build(String telegramHash) async {
    await ref.watch(feedRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<FeedDetail> fetch(api.ApiClient client) async {
    final repository = await ref.read(feedRepositoryProvider.future);
    return repository.fetchByTelegramHash(telegramHash, client: client);
  }
}
