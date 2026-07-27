import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_by_source_provider.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late api.ApiClient _cacheOnlyClient;
late api.ApiClient _networkClient;

final _feed = FeedDetail(
  id: 'feed-1',
  feedType: FeedType.incident,
  priority: FeedPriority.high,
  isImportant: true,
  publishedAt: DateTime.parse('2026-07-03T10:00:00+09:00'),
  expiresAt: null,
  title: 'メンテナンスのお知らせ',
  summary: null,
  body: '本文',
  data: const FeedItemData.incident(url: 'https://status.eqmonitor.app/'),
);

class _FakeFeedRepository implements FeedRepository {
  _FakeFeedRepository({this.response, this.error});

  final FeedDetail? response;
  final Object? error;

  String? lastTelegramHash;

  @override
  Future<FeedListResponse> fetch({String? after, api.ApiClient? client}) =>
      throw UnimplementedError();

  @override
  Future<FeedDetail> fetchByTelegramHash(
    String telegramHash, {
    api.ApiClient? client,
  }) async {
    lastTelegramHash = telegramHash;
    if (identical(client, _cacheOnlyClient)) {
      // キャッシュミス扱いにして通常ロードへフォールバックさせる。
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    if (error case final error?) {
      throw error;
    }
    return response!;
  }
}

ProviderContainer _container(_FakeFeedRepository repository) {
  _cacheOnlyClient = api.ApiClient(Dio());
  _networkClient = api.ApiClient(Dio());
  return ProviderContainer(
    retry: (retryCount, error) => null,
    overrides: [
      feedRepositoryProvider.overrideWith((ref) async => repository),
      cacheOnlyApiClientProvider.overrideWith((ref) async => _cacheOnlyClient),
      httpCachedApiClientProvider.overrideWith((ref) async => _networkClient),
      httpCachedDioProvider.overrideWith((ref) async => Dio()),
    ],
  );
}

void main() {
  test('telegramHash を repository に渡して FeedDetail を返す', () async {
    final repository = _FakeFeedRepository(response: _feed);
    final container = _container(repository);
    addTearDown(container.dispose);

    container.listen(feedBySourceProvider('hash-abc'), (_, _) {});
    final result = await container.read(
      feedBySourceProvider('hash-abc').future,
    );

    expect(result.id, 'feed-1');
    expect(repository.lastTelegramHash, 'hash-abc');
  });

  test('repository のエラーは AsyncError として伝播する', () async {
    final repository = _FakeFeedRepository(error: Exception('not found'));
    final container = _container(repository);
    addTearDown(container.dispose);

    container.listen(feedBySourceProvider('unknown'), (_, _) {});
    await expectLater(
      container.read(feedBySourceProvider('unknown').future),
      throwsA(isA<Exception>()),
    );
  });
}
