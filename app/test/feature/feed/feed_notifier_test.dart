import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _freshFeed = FeedItem(
  id: 'fresh-1',
  feedType: FeedType.incident,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime.parse('2026-07-02T00:00:00+09:00'),
  expiresAt: null,
  title: 'フレッシュデータ',
  summary: null,
  data: const FeedItemData.incident(),
);

final class _RecordingFeedRepository implements FeedRepository {
  new({this.nextCursor});

  final String? nextCursor;
  final List<api.ApiClient?> clients = [];
  final List<String?> cursors = [];

  @override
  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
    clients.add(client);
    cursors.add(after);
    return FeedListResponse(
      feeds: [_freshFeed],
      nextCursor: after == null ? nextCursor : null,
    );
  }

  @override
  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) => throw UnimplementedError();
}

ProviderContainer _container(_RecordingFeedRepository repository) {
  return ProviderContainer(
    retry: (retryCount, error) => null,
    overrides: [
      feedRepositoryProvider.overrideWith((ref) async => repository),
      cacheOnlyApiClientProvider.overrideWith(
        (ref) async => api.ApiClient(Dio()),
      ),
      httpCachedApiClientProvider.overrideWith(
        (ref) async => api.ApiClient(Dio()),
      ),
    ],
  );
}

void main() {
  group('FeedNotifier', () {
    test('初回取得はcache-only clientを渡さない', () async {
      final repository = _RecordingFeedRepository();
      final container = _container(repository);
      addTearDown(container.dispose);

      final result = await container.read(feedProvider.future);

      expect(result.items.first.id, 'fresh-1');
      expect(repository.clients, [null]);
      expect(repository.cursors, [null]);
    });

    test('次ページもcursorだけを渡しcache clientを渡さない', () async {
      final repository = _RecordingFeedRepository(nextCursor: 'next-1');
      final container = _container(repository);
      addTearDown(container.dispose);
      await container.read(feedProvider.future);

      await container.read(feedProvider.notifier).fetchNextData();

      expect(repository.clients, [null, null]);
      expect(repository.cursors, [null, 'next-1']);
    });

    test('FeedNotifierState の shape が正しい', () async {
      final repository = _RecordingFeedRepository();
      final container = _container(repository);
      addTearDown(container.dispose);

      final result = await container.read(feedProvider.future);

      expect(result.items, isA<List<FeedItem>>());
      expect(result.nextCursor, isNull);
      expect(result.hasNext, isFalse);
    });
  });
}
