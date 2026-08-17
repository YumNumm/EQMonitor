import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/feed/data/provider/unread_high_urgency_feed_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

FeedItem _item({
  required String id,
  required DateTime publishedAt,
  FeedPriority priority = FeedPriority.normal,
  bool isImportant = false,
}) => FeedItem(
  id: id,
  feedType: FeedType.developerMessage,
  priority: priority,
  isImportant: isImportant,
  publishedAt: publishedAt,
  expiresAt: null,
  title: 'title-$id',
  summary: null,
  data: const FeedItemData.developerMessage(),
);

class _FakeFeedNotifier extends FeedNotifier {
  new(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async => (items: items, nextCursor: null);
}

class _FakeFeedLastRead extends FeedLastRead {
  new(this.value);

  final DateTime? value;

  @override
  Future<DateTime?> build() async => value;
}

Future<ProviderContainer> _container({
  required List<FeedItem> items,
  required DateTime? lastRead,
}) async {
  final container = ProviderContainer(
    overrides: [
      feedProvider.overrideWith(() => _FakeFeedNotifier(items)),
      feedLastReadProvider.overrideWith(() => _FakeFeedLastRead(lastRead)),
    ],
  );
  await container.read(feedProvider.future);
  await container.read(feedLastReadProvider.future);
  return container;
}

void main() {
  final base = DateTime(2026, 7, 1, 12);

  test('既読位置が未設定(初回起動)の場合は null', () async {
    final container = await _container(
      items: [
        _item(
          id: 'a',
          publishedAt: base.add(const Duration(hours: 1)),
          priority: FeedPriority.critical,
        ),
      ],
      lastRead: null,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読の critical を返す', () async {
    final urgent = _item(
      id: 'a',
      publishedAt: base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final container = await _container(items: [urgent], lastRead: base);
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), urgent);
  });

  test('既読済みの緊急お知らせは返さない', () async {
    final container = await _container(
      items: [
        _item(
          id: 'a',
          publishedAt: base.subtract(const Duration(hours: 1)),
          priority: FeedPriority.critical,
        ),
      ],
      lastRead: base,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読でも緊急度が高くなければ返さない', () async {
    final container = await _container(
      items: [_item(id: 'a', publishedAt: base.add(const Duration(hours: 1)))],
      lastRead: base,
    );
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), isNull);
  });

  test('未読の緊急お知らせが複数ある場合は最新の1件を返す', () async {
    final older = _item(
      id: 'old',
      publishedAt: base.add(const Duration(hours: 1)),
      isImportant: true,
    );
    final newer = _item(
      id: 'new',
      publishedAt: base.add(const Duration(hours: 2)),
      priority: FeedPriority.high,
    );
    final container = await _container(items: [older, newer], lastRead: base);
    addTearDown(container.dispose);

    expect(container.read(unreadHighUrgencyFeedProvider), newer);
  });
}
