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
  new({required api.ApiClient api}) : _api = api;

  final api.ApiClient _api;

  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
    final response = await (client ?? _api).feed.getV2Feeds(cursor: after);
    return response.data.toFeedListResponse();
  }

  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) async {
    final response = await (client ?? _api).feed.getV2FeedsSourceTelegramHash(
      telegramHash: telegramHash,
    );
    return response.data.toFeedDetail();
  }
}
