import 'package:eqmonitor/core/api/api_client_provider.dart';
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

  Future<api.FeedListResponse> fetch({String? after}) async {
    final response = await _api.feed.getV2Feeds(after: after);
    return response.data;
  }
}
