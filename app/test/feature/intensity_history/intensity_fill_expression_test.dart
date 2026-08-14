import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildIntensityMatchExpression', () {
    late IntensityColors colorModel;

    setUp(() {
      colorModel = AppTheme.eqmonitorDefault().light!.intensity;
    });

    test('空の pairs は透明色のみのフォールバックを返す', () {
      final result = IntensityMatchExpressionBuilder.build([], colorModel);

      expect(result, hasLength(3));
      expect(result[0], equals('match'));
      expect(result[1], equals(<Object>['get', 'code']));
      expect(result[2], equals('rgba(0,0,0,0)'));
    });

    test('1 つのペアで match 式が正しく生成される', () {
      const pairs = [(code: '010', intensity: JmaIntensity.four)];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      // ['match', ['get', 'code'], '010', '#color', 'rgba(0,0,0,0)']
      expect(result[0], equals('match'));
      expect(result[1], equals(<Object>['get', 'code']));
      expect(result[2], equals('010'));
      // 色は colorModel.fromJmaIntensity(four).background.toHexStringRGB() と等しい
      final expectedColor = colorModel
          .fromJmaIntensity(JmaIntensity.four)
          .background
          .toHexStringRGB();
      expect(result[3], equals(expectedColor));
      expect(result[4], equals('rgba(0,0,0,0)'));
      expect(result, hasLength(5));
    });

    test('複数ペアで各 code と色が正しく並ぶ', () {
      const pairs = [
        (code: '010', intensity: JmaIntensity.three),
        (code: '020', intensity: JmaIntensity.fiveLower),
        (code: '030', intensity: JmaIntensity.seven),
      ];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      // ['match', ['get','code'], '010', c1, '020', c2, '030', c3, 'rgba(0,0,0,0)']
      expect(result, hasLength(2 + pairs.length * 2 + 1));
      expect(result[0], equals('match'));
      expect(result[1], equals(<Object>['get', 'code']));

      for (var i = 0; i < pairs.length; i++) {
        final pair = pairs[i];
        final offset = 2 + i * 2;
        expect(result[offset], equals(pair.code));
        final expectedColor = colorModel
            .fromJmaIntensity(pair.intensity)
            .background
            .toHexStringRGB();
        expect(result[offset + 1], equals(expectedColor));
      }

      expect(result.last, equals('rgba(0,0,0,0)'));
    });

    test('色は #RRGGBB 形式の文字列である', () {
      const pairs = [(code: 'ABC', intensity: JmaIntensity.sixLower)];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      final color = result[3] as String;
      // '#' + 6 hex chars
      expect(color, matches(RegExp(r'^#[0-9A-Fa-f]{6}$')));
    });

    test('unknown 震度でも正しく色が返る', () {
      const pairs = [(code: '000', intensity: JmaIntensity.unknown)];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      expect(result, hasLength(5));
      final color = result[3] as String;
      final expectedColor = colorModel
          .fromJmaIntensity(JmaIntensity.unknown)
          .background
          .toHexStringRGB();
      expect(color, equals(expectedColor));
    });

    test('propertyKey を省略した場合は code が使われる', () {
      const pairs = [(code: '010', intensity: JmaIntensity.four)];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      expect(result[1], equals(<Object>['get', 'code']));
    });

    test('同一 code が重複しても match ラベルは一意になり最大震度が採用される', () {
      const pairs = [
        (code: '010', intensity: JmaIntensity.three),
        (code: '010', intensity: JmaIntensity.fiveUpper),
        (code: '010', intensity: JmaIntensity.four),
        (code: '020', intensity: JmaIntensity.one),
      ];

      final result = IntensityMatchExpressionBuilder.build(pairs, colorModel);

      // ['match', ['get','code'], '010', c(5+), '020', c(1), 'rgba(0,0,0,0)']
      expect(result, hasLength(7));
      expect(result[2], equals('010'));
      expect(
        result[3],
        equals(
          colorModel
              .fromJmaIntensity(JmaIntensity.fiveUpper)
              .background
              .toHexStringRGB(),
        ),
      );
      expect(result[4], equals('020'));
      expect(result.last, equals('rgba(0,0,0,0)'));
    });

    test('propertyKey に regioncode を指定すると get 式に反映される', () {
      const pairs = [
        (code: '0110100', intensity: JmaIntensity.four),
        (code: '0110200', intensity: JmaIntensity.fiveLower),
      ];

      final result = IntensityMatchExpressionBuilder.build(
        pairs,
        colorModel,
        propertyKey: 'regioncode',
      );

      // ['match', ['get','regioncode'], '0110100', c1, '0110200', c2, 'rgba(0,0,0,0)']
      expect(result[0], equals('match'));
      expect(result[1], equals(<Object>['get', 'regioncode']));
      expect(result[2], equals('0110100'));
      final expectedColor1 = colorModel
          .fromJmaIntensity(JmaIntensity.four)
          .background
          .toHexStringRGB();
      expect(result[3], equals(expectedColor1));
      expect(result[4], equals('0110200'));
      final expectedColor2 = colorModel
          .fromJmaIntensity(JmaIntensity.fiveLower)
          .background
          .toHexStringRGB();
      expect(result[5], equals(expectedColor2));
      expect(result.last, equals('rgba(0,0,0,0)'));
    });
  });
}
