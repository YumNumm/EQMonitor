import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_by_source_provider.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeFeedRepository implements FeedRepository {
  _FakeFeedRepository({this.response, this.error});

  final FeedDetail? response;
  final Object? error;

  String? lastTelegramHash;

  @override
  Future<FeedListResponse> fetch({String? after}) => throw UnimplementedError();

  @override
  Future<FeedDetail> fetchByTelegramHash(String telegramHash) async {
    lastTelegramHash = telegramHash;
    if (error case final error?) {
      throw error;
    }
    return response!;
  }
}

void main() {
  final feed = api.FeedDetailResponse(
    id: 'feed-1',
    feedType: api.FeedType.incident,
    priority: api.FeedPriority.high,
    isImportant: true,
    publishedAt: '2026-07-03T10:00:00+09:00',
    expiresAt: null,
    title: 'メンテナンスのお知らせ',
    summary: null,
    body: '本文',
    data: const api.FeedItemDataUnion.feedIncidentData(
      type: 'INCIDENT',
      url: 'https://status.eqmonitor.app/',
    ),
  );

  test('telegramHash を repository に渡して FeedDetailResponse を返す', () async {
    final repository = _FakeFeedRepository(response: feed.toFeedDetail());
    final container = ProviderContainer(
      retry: (retryCount, error) => null,
      overrides: [
        feedRepositoryProvider.overrideWith((ref) async => repository),
      ],
    );
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
    final container = ProviderContainer(
      retry: (retryCount, error) => null,
      overrides: [
        feedRepositoryProvider.overrideWith((ref) async => repository),
      ],
    );
    addTearDown(container.dispose);

    container.listen(feedBySourceProvider('unknown'), (_, _) {});
    await expectLater(
      container.read(feedBySourceProvider('unknown').future),
      throwsA(isA<Exception>()),
    );
  });
}
