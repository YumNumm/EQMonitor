import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpIcon(
    WidgetTester tester,
    ShindoDbIntensityClass intensityClass,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(
          body: Center(
            child: ShindoDbIntensityClassMapIcon(
              intensityClass: intensityClass,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('ShindoDbIntensityClassMapIcon', () {
    testWidgets('全階級が例外なく描画できること', (tester) async {
      for (final cls in ShindoDbIntensityClass.values) {
        await pumpIcon(tester, cls);
        expect(tester.takeException(), isNull, reason: '$cls');
      }
    });

    testWidgets('現行のJMA震度と一致する階級は JmaIntensityIcon を流用すること', (tester) async {
      for (final cls in ShindoDbIntensityClass.values.where(
        (c) => c.exactJmaIntensity != null,
      )) {
        await pumpIcon(tester, cls);
        expect(find.byType(JmaIntensityIcon), findsOneWidget, reason: '$cls');
      }
    });

    testWidgets('旧階級・歴史的階級はラベルテキストを描画すること', (tester) async {
      for (final cls in ShindoDbIntensityClass.values.where(
        (c) => c.exactJmaIntensity == null,
      )) {
        await pumpIcon(tester, cls);
        expect(find.byType(JmaIntensityIcon), findsNothing, reason: '$cls');
        expect(find.text(cls.label), findsOneWidget, reason: '$cls');
      }
    });
  });

  group('mapIconId', () {
    test('全階級がアイコンIDを持つこと', () {
      for (final cls in ShindoDbIntensityClass.values) {
        expect(cls.mapIconId, isNotEmpty, reason: '$cls');
      }
    });

    test('現行のJMA震度と一致する階級は JmaIntensity のアイコンIDを返すこと', () {
      expect(ShindoDbIntensityClass.four.mapIconId, 'JmaIntensity.small.four');
      expect(
        ShindoDbIntensityClass.fiveLower.mapIconId,
        'JmaIntensity.small.fiveLower',
      );
      expect(
        ShindoDbIntensityClass.seven.mapIconId,
        'JmaIntensity.small.seven',
      );
    });

    test('旧階級・歴史的階級は専用のアイコンIDを返すこと', () {
      expect(
        ShindoDbIntensityClass.five.mapIconId,
        'ShindoDbIntensityClass.small.five',
      );
      expect(
        ShindoDbIntensityClass.six.mapIconId,
        'ShindoDbIntensityClass.small.six',
      );
      expect(
        ShindoDbIntensityClass.unknownFelt.mapIconId,
        'ShindoDbIntensityClass.small.unknownFelt',
      );
    });
  });
}
