import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[DesignSystemThemeExtension.light()],
  ),
  home: Scaffold(body: Align(child: child)),
);

void main() {
  testWidgets('地域名が解決できていればスコープ名の代わりに地域名を表示する', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HomeScopeSelector(
          scope: HomeEarthquakeHistoryScope.custom,
          onScopeChanged: (_) {},
          locationName: '東京都千代田区',
        ),
      ),
    );

    expect(find.text('東京都千代田区'), findsOneWidget);
    expect(find.text('指定地域'), findsNothing);
  });

  testWidgets('地域名がなければスコープ名を表示する', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HomeScopeSelector(
          scope: HomeEarthquakeHistoryScope.nationwide,
          onScopeChanged: (_) {},
        ),
      ),
    );

    expect(find.text('全国'), findsOneWidget);
  });

  testWidgets('タップで開いたメニューからスコープを選択できる', (tester) async {
    final selected = <HomeEarthquakeHistoryScope>[];
    await tester.pumpWidget(
      _wrap(
        HomeScopeSelector(
          scope: HomeEarthquakeHistoryScope.nationwide,
          onScopeChanged: selected.add,
        ),
      ),
    );

    await tester.tap(find.text('全国'));
    await tester.pumpAndSettle();

    expect(find.text('現在地'), findsOneWidget);
    expect(find.text('指定地域'), findsOneWidget);

    await tester.tap(find.text('現在地'));
    await tester.pumpAndSettle();

    expect(selected, [HomeEarthquakeHistoryScope.currentLocation]);
  });

  testWidgets('onEditRegion がなければ地域選び直しの項目を出さない', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HomeScopeSelector(
          scope: HomeEarthquakeHistoryScope.nationwide,
          onScopeChanged: (_) {},
        ),
      ),
    );

    await tester.tap(find.text('全国'));
    await tester.pumpAndSettle();

    expect(find.text('地域を選び直す'), findsNothing);
  });

  testWidgets('onEditRegion があれば地域選び直しの項目から呼び出せる', (tester) async {
    var edited = 0;
    await tester.pumpWidget(
      _wrap(
        HomeScopeSelector(
          scope: HomeEarthquakeHistoryScope.nationwide,
          onScopeChanged: (_) {},
          onEditRegion: () => edited++,
        ),
      ),
    );

    await tester.tap(find.text('全国'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('地域を選び直す'));
    await tester.pumpAndSettle();

    expect(edited, 1);
  });
}
