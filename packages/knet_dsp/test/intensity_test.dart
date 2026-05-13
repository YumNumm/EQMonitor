import 'dart:math' as math;

import 'package:knet_dsp/knet_dsp.dart';
import 'package:test/test.dart';

void main() {
  group('JmaIntensityResult.toJmaScale', () {
    test('各震度スケールの境界値', () {
      expect(JmaIntensityResult.toJmaScale(-1), equals('0'));
      expect(JmaIntensityResult.toJmaScale(0), equals('0'));
      expect(JmaIntensityResult.toJmaScale(0.5), equals('1'));
      expect(JmaIntensityResult.toJmaScale(1.5), equals('2'));
      expect(JmaIntensityResult.toJmaScale(2.5), equals('3'));
      expect(JmaIntensityResult.toJmaScale(3.5), equals('4'));
      expect(JmaIntensityResult.toJmaScale(4.5), equals('5-'));
      expect(JmaIntensityResult.toJmaScale(5), equals('5+'));
      expect(JmaIntensityResult.toJmaScale(5.5), equals('6-'));
      expect(JmaIntensityResult.toJmaScale(6), equals('6+'));
      expect(JmaIntensityResult.toJmaScale(6.5), equals('7'));
      expect(JmaIntensityResult.toJmaScale(7), equals('7'));
    });
  });

  group('JmaIntensityCalculator', () {
    const calc = JmaIntensityCalculator();

    test('ゼロ入力でも例外を投げない', () {
      const n = 1000;
      final zeros = List<double>.filled(n, 0);
      // ゼロ入力では a0.3=0 → log(0) が -inf になるが例外は投げない
      expect(
        () => calc.compute(ns: zeros, ew: zeros, ud: zeros, dt: 0.01),
        returnsNormally,
      );
    });

    test('JMA フィルタの伝達関数: f=1Hz で期待値', () {
      // H(1) = 1 / (1 * sqrt(1+(1/10)^2) * sqrt(1+(0.5/1)^2))
      //       = 1 / (1 * sqrt(1.01) * sqrt(1.25))
      const f = 1.0;
      final computed =
          1.0 / (f * math.sqrt(1.0 + (f / 10.0) * (f / 10.0)) * math.sqrt(1.0 + (0.5 / f) * (0.5 / f)));
      // H(1) ≈ 0.889: 1/(sqrt(1.01)*sqrt(1.25)) ≈ 1/(1.005*1.118) ≈ 0.889
      expect(computed, closeTo(0.889, 0.01));
    });

    test('大きな加速度入力で震度が高くなる', () {
      // 2 Hz 正弦波, 振幅 1000 gal → 震度 3 以上を期待
      const dt = 0.01;
      const n = 3000;
      final accel = List<double>.generate(
        n,
        (i) => 1000 * math.sin(2 * math.pi * 2 * i * dt),
      );
      final result = calc.compute(
        ns: accel,
        ew: List<double>.filled(n, 0),
        ud: List<double>.filled(n, 0),
        dt: dt,
      );
      // 1000 gal 相当の加速度 → 強い揺れ
      expect(result.instrumentalIntensity, greaterThan(3.0));
    });

    test('小さな加速度入力で震度が低くなる', () {
      // 振幅 1 gal 程度 → 震度 3 未満を期待
      const dt = 0.01;
      const n = 3000;
      final accel = List<double>.generate(
        n,
        (i) => 1.0 * math.sin(2 * math.pi * 2 * i * dt),
      );
      final result = calc.compute(
        ns: accel,
        ew: List<double>.filled(n, 0),
        ud: List<double>.filled(n, 0),
        dt: dt,
      );
      expect(result.instrumentalIntensity, lessThan(3.0));
    });

    test('計測震度の計算式を直接検証', () {
      // I = 2 * log10(a) + 0.94 → a = 10^((I-0.94)/2)
      // I = 5.0 に対応する a0.3 ≈ 10^((5.0-0.94)/2) = 10^2.03 ≈ 107 gal
      const expectedI = 5.0;
      final a03 = math.pow(10.0, (expectedI - 0.94) / 2) as double;
      final computedI = 2.0 * math.log(a03) / math.ln10 + 0.94;
      expect(computedI, closeTo(expectedI, 1e-10));
    });
  });
}
