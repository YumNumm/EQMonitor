import 'package:eqmonitor/feature/changelog/ui/page/changelog_page.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('content があれば MarkdownBody で content を描画する', (tester) async {
    final entry = api.ChangelogEntry(
      version: '3.0.0',
      date: DateTime(2026, 7, 8),
      url: 'https://example.com',
      sections: const [],
      content: '# v3.0.0\n- new feature',
    );
    await tester.pumpWidget(wrap(ChangelogEntryCard(entry: entry)));

    expect(
      find.byWidgetPredicate(
        (w) => w is MarkdownBody && w.data == '# v3.0.0\n- new feature',
      ),
      findsOneWidget,
    );
  });

  testWidgets('content が空なら sections にフォールバックする', (tester) async {
    final entry = api.ChangelogEntry(
      version: '2.6.0',
      date: DateTime(2024, 8, 10),
      url: 'https://example.com',
      sections: const [
        api.ChangelogSection(title: '新機能', items: ['A', 'B']),
      ],
      content: null,
    );
    await tester.pumpWidget(wrap(ChangelogEntryCard(entry: entry)));

    expect(
      find.byWidgetPredicate(
        (w) => w is MarkdownBody && w.data.contains('新機能'),
      ),
      findsOneWidget,
    );
  });
}
