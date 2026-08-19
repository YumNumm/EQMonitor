import 'package:eqmonitor/core/component/chip/lat_lng_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Widget wrap({LatLngRange? value, void Function(LatLngRange?)? onChanged}) =>
      ProviderScope(
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: LatLngFilterChip(
              latitudeGte: value?.latitudeGte,
              latitudeLte: value?.latitudeLte,
              longitudeGte: value?.longitudeGte,
              longitudeLte: value?.longitudeLte,
              onChanged: onChanged,
            ),
          ),
        ),
      );

  Future<void> openModal(WidgetTester tester) async {
    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();
  }

  Finder fieldByLabel(String label) => find
      .ancestor(of: find.text(label), matching: find.byType(TextField))
      .first;

  bool isDoneEnabled(WidgetTester tester) {
    final button = tester.widget<TextButton>(
      find
          .ancestor(of: find.text('完了'), matching: find.byType(TextButton))
          .first,
    );
    return button.onPressed != null;
  }

  testWidgets('(a) 緯度100（値域外）で「完了」が無効', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pump();

    await openModal(tester);

    await tester.enterText(fieldByLabel('緯度(南)'), '100');
    await tester.pump();

    expect(isDoneEnabled(tester), isFalse, reason: '緯度100は-90〜90の範囲外なので完了は無効');
  });

  testWidgets('(b) latGte=40、latLte=30（逆転）で「完了」が無効', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pump();

    await openModal(tester);

    await tester.enterText(fieldByLabel('緯度(南)'), '40');
    await tester.pump();
    await tester.enterText(fieldByLabel('緯度(北)'), '30');
    await tester.pump();

    expect(isDoneEnabled(tester), isFalse, reason: '緯度(南)>緯度(北)は逆転なので完了は無効');
  });

  testWidgets('(c) 正常入力で「完了」が有効になり、tapで期待LatLngRangeが渡る', (tester) async {
    LatLngRange? received;
    await tester.pumpWidget(wrap(onChanged: (v) => received = v));
    await tester.pump();

    await openModal(tester);

    await tester.enterText(fieldByLabel('緯度(南)'), '35.0');
    await tester.pump();
    await tester.enterText(fieldByLabel('緯度(北)'), '40.0');
    await tester.pump();
    await tester.enterText(fieldByLabel('経度(西)'), '135.0');
    await tester.pump();
    await tester.enterText(fieldByLabel('経度(東)'), '140.0');
    await tester.pump();

    expect(isDoneEnabled(tester), isTrue, reason: '全フィールド正常値なので完了は有効');

    await tester.tap(
      find
          .ancestor(of: find.text('完了'), matching: find.byType(TextButton))
          .first,
    );
    await tester.pumpAndSettle();

    expect(received?.latitudeGte, 35.0);
    expect(received?.latitudeLte, 40.0);
    expect(received?.longitudeGte, 135.0);
    expect(received?.longitudeLte, 140.0);
  });

  testWidgets('(d) プリセットチップ押下でTextFieldにプリセット値が反映される', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pump();

    await openModal(tester);

    await tester.tap(find.text('日本周辺'));
    await tester.pump();

    expect(
      tester.widget<TextField>(fieldByLabel('緯度(南)')).controller?.text,
      '20.0',
    );
    expect(
      tester.widget<TextField>(fieldByLabel('緯度(北)')).controller?.text,
      '50.0',
    );
    expect(
      tester.widget<TextField>(fieldByLabel('経度(西)')).controller?.text,
      '122.0',
    );
    expect(
      tester.widget<TextField>(fieldByLabel('経度(東)')).controller?.text,
      '154.0',
    );
  });

  testWidgets('(e) クリア押下でTextFieldが空になる', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pump();

    await openModal(tester);

    await tester.tap(find.text('日本周辺'));
    await tester.pump();

    await tester.tap(find.text('クリア'));
    await tester.pump();

    expect(
      tester.widget<TextField>(fieldByLabel('緯度(南)')).controller?.text,
      isEmpty,
    );
    expect(
      tester.widget<TextField>(fieldByLabel('緯度(北)')).controller?.text,
      isEmpty,
    );
    expect(
      tester.widget<TextField>(fieldByLabel('経度(西)')).controller?.text,
      isEmpty,
    );
    expect(
      tester.widget<TextField>(fieldByLabel('経度(東)')).controller?.text,
      isEmpty,
    );
  });
}
