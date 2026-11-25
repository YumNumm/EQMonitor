import 'dart:math';

import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';
import 'package:test/test.dart';

void main() {
  const formula = MeasuredIntensityFormula();

  group('MeasuredIntensityFormula', () {
    test('小数第3位を四捨五入してから小数第2位以下を切り捨てること', () {
      expect(formula.round(3.449), 3.4);
      expect(formula.round(3.4449), 3.4);
      expect(formula.round(3.495), 3.5);
      expect(formula.round(4.4999), 4.5);
      expect(formula.round(0), 0);
    });

    test('負の値は小さい側の 0.1 刻みに丸めること', () {
      expect(formula.round(-0.44), -0.5);
      expect(formula.round(-0.4), -0.4);
    });

    test('加速度から 2log10(a) + 0.94 を求めること', () {
      final acceleration = pow(10, (3.45 - 0.94) / 2).toDouble();

      expect(formula.fromAcceleration(acceleration), 3.4);
      expect(formula.fromAcceleration(1), 0.9);
    });

    test('加速度が 0 以下・非数のときは null を返すこと', () {
      expect(formula.fromAcceleration(0), isNull);
      expect(formula.fromAcceleration(-1), isNull);
      expect(formula.fromAcceleration(double.nan), isNull);
      expect(formula.fromAcceleration(double.infinity), isNull);
    });
  });
}
