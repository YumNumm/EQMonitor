import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_data_source.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  // upsertItems は DataSource のロード後に呼ばれることを前提とする。
  // cacheFirstRefresh がキャッシュミスの場合はネットワーク fetch にフォールバックする。

  test('upsertItems: 同一 id のアイテムは in-place で更新される', () async {
    final dataSource = _buildDataSource(
      initial: [_item('id-1', 'original')],
    );
    addTearDown(dataSource.dispose);

    await dataSource.refresh();

    dataSource.upsertItems([_item('id-1', 'updated')]);

    final values = dataSource.notifier.values;
    expect(values.length, 1);
    expect(values[0].id, 'id-1');
    expect(values[0].title, 'updated');
  });

  test('upsertItems: 新規 id のアイテムは末尾に追加される', () async {
    final dataSource = _buildDataSource(
      initial: [_item('id-1', 'item 1')],
    );
    addTearDown(dataSource.dispose);

    await dataSource.refresh();

    dataSource.upsertItems([_item('id-2', 'item 2')]);

    final values = dataSource.notifier.values;
    expect(values.length, 2);
    expect(values[0].id, 'id-1');
    expect(values[1].id, 'id-2');
  });

  test('upsertItems: 更新と追加を同時に処理できる', () async {
    final dataSource = _buildDataSource(
      initial: [_item('id-1', 'item 1'), _item('id-2', 'item 2')],
    );
    addTearDown(dataSource.dispose);

    await dataSource.refresh();

    dataSource.upsertItems([
      _item('id-1', 'item 1 updated'),
      _item('id-3', 'item 3 new'),
    ]);

    final values = dataSource.notifier.values;
    expect(values.length, 3);
    expect(values[0].id, 'id-1');
    expect(values[0].title, 'item 1 updated');
    expect(values[1].id, 'id-2');
    expect(values[2].id, 'id-3');
  });
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

FeedDataSource _buildDataSource({required List<FeedItem> initial}) {
  return FeedDataSource(
    repository: _FakeFeedRepository(initialItems: initial),
    // cacheOnlyClient は cache miss を模倣するため、実際の Dio は不要
    cacheOnlyClient: api.ApiClient(Dio()),
  );
}

FeedItem _item(String id, String title) => FeedItem(
  id: id,
  feedType: FeedType.developerMessage,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime.parse('2026-07-07T00:00:00Z'),
  expiresAt: null,
  title: title,
  summary: null,
  data: const FeedItemData.developerMessage(url: null),
);

/// キャッシュミスを模倣する Fake リポジトリ。
/// client が指定された場合 (cache-only) は例外を投げ、
/// 指定がない場合 (network) は [initialItems] を返す。
final class _FakeFeedRepository extends FeedRepository {
  _FakeFeedRepository({required this.initialItems})
    : super(api: api.ApiClient(Dio()));

  final List<FeedItem> initialItems;

  @override
  Future<FeedListResponse> fetch({
    String? after,
    api.ApiClient? client,
  }) async {
    if (client != null) {
      throw Exception('cache miss');
    }
    return FeedListResponse(feeds: initialItems, nextCursor: null);
  }
}
