import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMagnitudeText(
    WidgetTester tester, {
    required EarthquakeMagnitude? magnitude,
    required MagnitudeTextVariant variant,
    Color? color,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MagnitudeText(
            magnitude: magnitude,
            variant: variant,
            color: color,
          ),
        ),
      ),
    );
  }

  /// 画面上に存在する唯一の [RichText] のプレーンテキストを取り出す。
  String plainText(WidgetTester tester) {
    return tester.widget<RichText>(find.byType(RichText)).text.toPlainText();
  }

  group('MagnitudeText compact', () {
    testWidgets('value: "M" + 小数第1位までの値を一続きで表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.value(value: 7.3),
        variant: MagnitudeTextVariant.compact,
      );

      expect(plainText(tester), 'M7.3');
    });

    testWidgets('value: 整数でも小数第1位まで表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.value(value: 5),
        variant: MagnitudeTextVariant.compact,
      );

      expect(plainText(tester), 'M5.0');
    });

    testWidgets('unknown: "M不明"', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.unknown(),
        variant: MagnitudeTextVariant.compact,
      );

      expect(plainText(tester), 'M不明');
    });

    testWidgets('overM8: "M8超"', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.overM8(),
        variant: MagnitudeTextVariant.compact,
      );

      expect(plainText(tester), 'M8超');
    });

    testWidgets('null: 何も表示しない', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: null,
        variant: MagnitudeTextVariant.compact,
      );

      expect(plainText(tester), '');
    });

    testWidgets('color を指定すると文字色に反映される', (tester) async {
      const color = Color(0xFFAABBCC);
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.value(value: 7.3),
        variant: MagnitudeTextVariant.compact,
        color: color,
      );

      // Text.rich は外側に DefaultTextStyle をラップするため、
      // 指定した style（color を含む）は子 TextSpan に載る。
      final richText = tester.widget<RichText>(find.byType(RichText));
      final innerSpan = (richText.text as TextSpan).children!.first as TextSpan;
      expect(innerSpan.style?.color, color);
    });
  });

  group('MagnitudeText display', () {
    testWidgets('value: "M"ラベルと値を別々に表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.value(value: 7.3),
        variant: MagnitudeTextVariant.display,
      );

      expect(find.text('M'), findsOneWidget);
      expect(find.text('7.3'), findsOneWidget);
    });

    testWidgets('unknown: "M"を出さず "不明" を表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.unknown(),
        variant: MagnitudeTextVariant.display,
      );

      expect(find.text('M'), findsNothing);
      expect(find.text('不明'), findsOneWidget);
    });

    testWidgets('overM8: "M"ラベルと "8超" を表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: const EarthquakeMagnitude.overM8(),
        variant: MagnitudeTextVariant.display,
      );

      expect(find.text('M'), findsOneWidget);
      expect(find.text('8超'), findsOneWidget);
    });

    testWidgets('null: "M"を出さず "調査中" を表示する', (tester) async {
      await pumpMagnitudeText(
        tester,
        magnitude: null,
        variant: MagnitudeTextVariant.display,
      );

      expect(find.text('M'), findsNothing);
      expect(find.text('調査中'), findsOneWidget);
    });
  });
}
