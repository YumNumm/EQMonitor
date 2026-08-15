import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_sheet_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[DesignSystemThemeExtension.light()],
  ),
  home: Scaffold(body: child),
);

void main() {
  testWidgets('ヘッダーのタイトルとアクションを表示する', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const HomeSheetCard(
          children: [
            HomeSheetCardHeader(title: 'カードタイトル', action: Text('操作')),
            Text('本文'),
          ],
        ),
      ),
    );

    expect(find.text('カードタイトル'), findsOneWidget);
    expect(find.text('操作'), findsOneWidget);
    expect(find.text('本文'), findsOneWidget);
  });

  testWidgets('ヘッダーのタイトルとフッターの文字がカード内容の余白に揃う', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HomeSheetCard(
          children: [
            const HomeSheetCardHeader(title: 'カードタイトル'),
            HomeSheetCardFooter(onPressed: () {}),
          ],
        ),
      ),
    );

    final spacing = DesignSystemThemeExtension.light().spacing.lg;
    final card = tester.getRect(find.byType(HomeSheetCard));
    final title = tester.getRect(find.text('カードタイトル'));
    final footerLabel = tester.getRect(find.text('さらに表示'));
    expect(title.left - card.left, spacing);
    // TextButton は自身の内側余白を持つため、文字の右端が揃うかを見る
    expect(card.right - footerLabel.right, spacing);
  });

  testWidgets('フッターは onPressed が null なら無効化される', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const HomeSheetCard(children: [HomeSheetCardFooter(onPressed: null)]),
      ),
    );

    final button = tester.widget<TextButton>(find.byType(TextButton));
    expect(button.onPressed, isNull);
    expect(find.text('さらに表示'), findsOneWidget);
  });

  testWidgets('フッターのタップで onPressed を呼ぶ', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      _wrap(
        HomeSheetCard(
          children: [HomeSheetCardFooter(onPressed: () => tapped++)],
        ),
      ),
    );

    await tester.tap(find.text('さらに表示'));
    await tester.pump();

    expect(tapped, 1);
  });
}
