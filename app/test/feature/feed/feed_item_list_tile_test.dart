import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_list_tile.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

FeedItem _item({
  FeedPriority priority = FeedPriority.normal,
  bool isImportant = false,
  String? title = 'タイトル',
  String? summary = '概要',
}) => FeedItem(
  id: 'feed-1',
  feedType: FeedType.developerMessage,
  priority: priority,
  isImportant: isImportant,
  publishedAt: DateTime(2026, 7, 1, 12, 34),
  expiresAt: null,
  title: title,
  summary: summary,
  data: const FeedItemData.developerMessage(),
);

Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('タイトル・概要・日時を表示する', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item()));
    expect(find.text('タイトル'), findsOneWidget);
    expect(find.text('概要'), findsOneWidget);
    expect(find.text('2026/07/01 12:34頃発表'), findsOneWidget);
  });

  testWidgets('title が無い場合は summary をタイトルとして表示する', (tester) async {
    await _pump(
      tester,
      FeedItemListTile(item: _item(title: null, summary: '概要のみ')),
    );
    expect(find.text('概要のみ'), findsOneWidget);
  });

  testWidgets('critical は赤系の背景で強調される', (tester) async {
    await _pump(
      tester,
      FeedItemListTile(item: _item(priority: FeedPriority.critical)),
    );
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.tileColor, const Color(0xFFD32F2F).withValues(alpha: 0.4));
  });

  testWidgets('isImportant はオレンジ系の背景で強調される', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item(isImportant: true)));
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.tileColor, const Color(0xFFF57C00).withValues(alpha: 0.4));
  });

  testWidgets('通常のお知らせは背景色なし', (tester) async {
    await _pump(tester, FeedItemListTile(item: _item()));
    final tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.tileColor, isNull);
  });

  testWidgets('タップで onTap が呼ばれる', (tester) async {
    var tapped = false;
    await _pump(
      tester,
      FeedItemListTile(item: _item(), onTap: () => tapped = true),
    );
    await tester.tap(find.byType(ListTile));
    expect(tapped, isTrue);
  });
}
