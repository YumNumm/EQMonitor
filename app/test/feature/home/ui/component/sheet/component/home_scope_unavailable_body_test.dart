import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// `HomeScopeUnavailableBody` 表示用の最小限の `MaterialApp` ラッパー。
///
/// 本体は `Theme.of(context).designSystemThemeExtension` を要求するので、
/// `ThemeExtension` を ThemeData に登録した状態で描画する必要がある。
Widget _wrap(Widget child) {
  final theme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      DesignSystemThemeExtension.light(),
    ],
  );
  return MaterialApp(
    theme: theme,
    home: Scaffold(body: child),
  );
}

void main() {
  testWidgets('nationwide スコープでは空の SizedBox を返す', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HomeScopeUnavailableBody(
          scope: HomeEarthquakeHistoryScope.nationwide,
          onRetry: () {},
        ),
      ),
    );

    // 何もテキストや FilledButton が出ないことを確認
    expect(find.byType(FilledButton), findsNothing);
    expect(find.text('地域を設定する'), findsNothing);
  });

  testWidgets('custom スコープ・未設定では「地域を設定する」ボタンと案内文が出る', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      _wrap(
        HomeScopeUnavailableBody(
          scope: HomeEarthquakeHistoryScope.custom,
          onRetry: () {},
          onConfigureRegion: () => tapped++,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 案内文（部分一致）
    expect(
      find.textContaining('指定地域'),
      findsWidgets,
    );
    final button = find.widgetWithText(FilledButton, '地域を設定する');
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(tapped, 1);
  });

  testWidgets(
    'custom スコープでも onConfigureRegion が null の場合はボタンが出ない',
    (tester) async {
      await tester.pumpWidget(
        _wrap(
          HomeScopeUnavailableBody(
            scope: HomeEarthquakeHistoryScope.custom,
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(FilledButton, '地域を設定する'), findsNothing);
    },
  );
}
