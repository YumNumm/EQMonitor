import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_item_details_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

final _item = FeedItem(
  id: 'feed-1',
  feedType: FeedType.developerMessage,
  priority: FeedPriority.normal,
  isImportant: false,
  publishedAt: DateTime(2026, 7, 1, 12, 34),
  expiresAt: null,
  title: 'テストお知らせ',
  summary: '概要テキスト',
  data: const FeedItemData.developerMessage(),
);

class _FakeFeedNotifier extends FeedNotifier {
  new(this.items);

  final List<FeedItem> items;

  @override
  Future<FeedNotifierState> build() async => (items: items, nextCursor: null);
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  List<Override> overrides = const [],
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: child,
      ),
    ),
  );
}

void main() {
  testWidgets('渡された FeedItem から詳細を表示する', (tester) async {
    await _pump(tester, FeedItemDetailsPage(id: 'feed-1', item: _item));
    await tester.pump();
    expect(find.text('テストお知らせ'), findsOneWidget);
  });

  testWidgets('item が無い場合は feedProvider のキャッシュから id で解決する', (tester) async {
    await _pump(
      tester,
      const FeedItemDetailsPage(id: 'feed-1'),
      overrides: [
        feedProvider.overrideWith(() => _FakeFeedNotifier([_item])),
      ],
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('テストお知らせ'), findsOneWidget);
  });

  testWidgets('解決できない場合は見つからない旨を表示する', (tester) async {
    await _pump(
      tester,
      const FeedItemDetailsPage(id: 'missing'),
      overrides: [feedProvider.overrideWith(() => _FakeFeedNotifier([]))],
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('お知らせが見つかりませんでした'), findsOneWidget);
  });
}
