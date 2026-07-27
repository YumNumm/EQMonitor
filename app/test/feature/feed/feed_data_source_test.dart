import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_data_source.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

void main() {
  test('RefreshとAppendは通常repositoryだけを使う', () async {
    final repository = _RecordingFeedRepository();
    final dataSource = FeedDataSource(repository: repository);
    addTearDown(dataSource.dispose);

    await dataSource.refresh();
    await dataSource.load(const Append(key: 'cursor-1'));

    expect(repository.clients, [null, null]);
    expect(repository.cursors, [null, 'cursor-1']);
  });
}

final class _RecordingFeedRepository extends FeedRepository {
  _RecordingFeedRepository() : super(api: api.ApiClient(Dio()));

  final List<api.ApiClient?> clients = [];
  final List<String?> cursors = [];

  @override
  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
    clients.add(client);
    cursors.add(after);
    return FeedListResponse(feeds: [_item('id-1')], nextCursor: null);
  }
}

FeedItem _item(String id) => FeedItem(
  id: id,
  feedType: FeedType.developerMessage,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime.parse('2026-07-07T00:00:00Z'),
  expiresAt: null,
  title: 'item',
  summary: null,
  data: const FeedItemData.developerMessage(url: null),
);
