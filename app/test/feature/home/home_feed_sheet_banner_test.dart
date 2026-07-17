import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_feed_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _base = DateTime(2026, 7, 1, 12);

FeedItem _item({
  required String id,
  required DateTime publishedAt,
  FeedPriority priority = FeedPriority.normal,
}) => FeedItem(
  id: id,
  feedType: FeedType.incident,
  priority: priority,
  isImportant: false,
  publishedAt: publishedAt,
  expiresAt: null,
  title: 'タイトル-$id',
  summary: '概要-$id',
  data: const FeedItemData.incident(),
);

class _FakeFeedNotifier extends FeedNotifier {
  _FakeFeedNotifier(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async => (items: items, nextCursor: null);
}

class _FakeFeedLastRead extends FeedLastRead {
  _FakeFeedLastRead(this.initial);

  final DateTime? initial;
  final markReadCalls = <DateTime>[];
  final initializeCalls = <DateTime>[];

  @override
  Future<DateTime?> build() async => initial;

  @override
  Future<void> markRead(DateTime publishedAt) async {
    markReadCalls.add(publishedAt);
    final current = await future;
    if (current != null && !publishedAt.isAfter(current)) {
      return;
    }
    state = AsyncData(publishedAt);
  }

  @override
  Future<void> initializeIfUnset(DateTime publishedAt) async {
    initializeCalls.add(publishedAt);
    final current = await future;
    if (current != null) {
      return;
    }
    state = AsyncData(publishedAt);
  }
}

Future<void> _pump(
  WidgetTester tester, {
  required List<FeedItem> items,
  required _FakeFeedLastRead lastRead,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedProvider.overrideWith(() => _FakeFeedNotifier(items)),
        feedLastReadProvider.overrideWith(() => lastRead),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: const Scaffold(
          body: SingleChildScrollView(child: HomeFeedSheet()),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('未読の緊急お知らせがあればバナーを表示する', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    await _pump(tester, items: [urgent], lastRead: _FakeFeedLastRead(_base));

    expect(find.text('タイトル-urgent'), findsOneWidget);
  });

  testWidgets('未読の緊急お知らせがなければバナーを表示しない', (tester) async {
    final read = _item(
      id: 'read',
      publishedAt: _base.subtract(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    await _pump(tester, items: [read], lastRead: _FakeFeedLastRead(_base));

    expect(find.text('タイトル-read'), findsNothing);
  });

  testWidgets('既読位置が未設定(初回起動)ならバナーを出さず初期化する', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final lastRead = _FakeFeedLastRead(null);
    await _pump(tester, items: [urgent], lastRead: lastRead);

    expect(find.text('タイトル-urgent'), findsNothing);
    expect(lastRead.initializeCalls, isNotEmpty);
    expect(lastRead.initializeCalls.first, urgent.publishedAt);
  });

  testWidgets('×ボタンで既読化されバナーが消える', (tester) async {
    final urgent = _item(
      id: 'urgent',
      publishedAt: _base.add(const Duration(hours: 1)),
      priority: FeedPriority.critical,
    );
    final lastRead = _FakeFeedLastRead(_base);
    await _pump(tester, items: [urgent], lastRead: lastRead);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump();

    expect(lastRead.markReadCalls, [urgent.publishedAt]);
    expect(find.text('タイトル-urgent'), findsNothing);
  });
}
