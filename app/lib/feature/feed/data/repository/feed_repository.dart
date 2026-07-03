import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_repository.g.dart';

@Riverpod(keepAlive: true)
Future<FeedRepository> feedRepository(Ref ref) async {
  final client = await ref.watch(apiClientProvider.future);
  return FeedRepository(api: client);
}

class FeedRepository {
  FeedRepository({required api.ApiClient api}) : _api = api;

  final api.ApiClient _api;

  Future<FeedListResponse> fetch({
    String? after,
  }) async {
    final response = await _api.feed.getV2Feeds(after: after);
    return response.data.toFeedListResponse();
  }

  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash,
  ) async {
    final response = await _api.feed.getV2FeedsSourceTelegramHash(
      telegramHash: telegramHash,
    );
    return response.data.toFeedDetail();
  }
}
