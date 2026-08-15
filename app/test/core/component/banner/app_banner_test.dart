import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[DesignSystemThemeExtension.light()],
  ),
  home: Scaffold(body: child),
);

AppBanner _banner({
  String title = 'タイトル',
  String? description,
  VoidCallback? onTap,
  VoidCallback? onDismiss,
  Widget? trailing,
}) => AppBanner(
  icon: Icons.info_rounded,
  title: title,
  description: description,
  backgroundColor: const Color(0xFF112233),
  foregroundColor: const Color(0xFFFFFFFF),
  onTap: onTap,
  onDismiss: onDismiss,
  trailing: trailing,
);

void main() {
  testWidgets('タイトルと説明を表示する', (tester) async {
    await tester.pumpWidget(_wrap(_banner(description: '説明テキスト')));

    expect(find.text('タイトル'), findsOneWidget);
    expect(find.text('説明テキスト'), findsOneWidget);
  });

  testWidgets('説明が空文字なら説明の Text を作らない', (tester) async {
    await tester.pumpWidget(_wrap(_banner(description: '')));

    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('onDismiss を渡したときだけ閉じるボタンを表示する', (tester) async {
    await tester.pumpWidget(_wrap(_banner()));
    expect(find.byTooltip('閉じる'), findsNothing);

    var dismissed = 0;
    await tester.pumpWidget(_wrap(_banner(onDismiss: () => dismissed++)));
    await tester.tap(find.byTooltip('閉じる'));
    await tester.pump();

    expect(dismissed, 1);
  });

  testWidgets('本体タップで onTap を呼ぶ', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(_wrap(_banner(onTap: () => tapped++)));

    await tester.tap(find.text('タイトル'));
    await tester.pump();

    expect(tapped, 1);
  });

  testWidgets('バナー同士の間隔をバナー自身が持つ', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Column(
          children: [
            _banner(title: '1件目'),
            // 表示条件を満たさないバナーは何も描画しないため余白も出ない
            const SizedBox.shrink(),
            _banner(title: '2件目'),
          ],
        ),
      ),
    );

    Rect surfaceOf(int index) => tester.getRect(
      find.descendant(
        of: find.byType(AppBanner).at(index),
        matching: find.byType(Material),
      ),
    );

    final spacing = DesignSystemThemeExtension.light().spacing.md;
    expect(surfaceOf(1).top - surfaceOf(0).bottom, spacing);
  });
}
