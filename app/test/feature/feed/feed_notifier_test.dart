import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late api.ApiClient _cacheOnlyClient;
late api.ApiClient _networkClient;

final _cachedFeed = FeedItem(
  id: 'cached-1',
  feedType: FeedType.incident,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime.parse('2026-07-01T00:00:00+09:00'),
  expiresAt: null,
  title: 'キャッシュデータ',
  summary: null,
  data: const FeedItemData.incident(),
);

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

class _FakeFeedRepository implements FeedRepository {
  _FakeFeedRepository();

  @override
  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
    if (identical(client, _cacheOnlyClient)) {
      // キャッシュヒット: キャッシュ用クライアントのときはキャッシュデータを返す
      return FeedListResponse(feeds: [_cachedFeed], nextCursor: null);
    }
    // 通常クライアント: フレッシュデータを返す
    return FeedListResponse(feeds: [_freshFeed], nextCursor: null);
  }

  @override
  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) => throw UnimplementedError();
}

class _CacheMissFeedRepository implements FeedRepository {
  @override
  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) async {
    if (identical(client, _cacheOnlyClient)) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    return FeedListResponse(feeds: [_freshFeed], nextCursor: null);
  }

  @override
  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) => throw UnimplementedError();
}

ProviderContainer _container(FeedRepository repository) {
  _cacheOnlyClient = api.ApiClient(Dio());
  _networkClient = api.ApiClient(Dio());
  return ProviderContainer(
    retry: (retryCount, error) => null,
    overrides: [
      feedRepositoryProvider.overrideWith((ref) async => repository),
      cacheOnlyApiClientProvider.overrideWith((ref) async => _cacheOnlyClient),
      apiClientProvider.overrideWith((ref) async => _networkClient),
      dioProvider.overrideWith((ref) async => Dio()),
    ],
  );
}

Future<void> _pumpMicrotasks() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  group('FeedNotifier (CachedNotifier)', () {
    test('cache hit: 初回値はキャッシュ由来', () async {
      final container = _container(_FakeFeedRepository());
      addTearDown(container.dispose);

      final result = await container.read(feedProvider.future);

      expect(result.items.first.id, 'cached-1');
      expect(result.nextCursor, isNull);
    });

    test('cache hit → SWR: フレッシュデータで更新される', () async {
      final container = _container(_FakeFeedRepository());
      addTearDown(container.dispose);

      container.listen(feedProvider, (_, _) {});

      await container.read(feedProvider.future);
      expect(container.read(feedProvider).value!.items.first.id, 'cached-1');

      await _pumpMicrotasks();

      expect(container.read(feedProvider).value!.items.first.id, 'fresh-1');
    });

    test('cache miss: ネットワークから直接取得', () async {
      final container = _container(_CacheMissFeedRepository());
      addTearDown(container.dispose);

      final result = await container.read(feedProvider.future);

      expect(result.items.first.id, 'fresh-1');
    });

    test('FeedNotifierState の shape が正しい', () async {
      final container = _container(_FakeFeedRepository());
      addTearDown(container.dispose);

      final result = await container.read(feedProvider.future);

      expect(result.items, isA<List<FeedItem>>());
      expect(result.nextCursor, isNull);
      expect(result.hasNext, isFalse);
    });
  });
}
