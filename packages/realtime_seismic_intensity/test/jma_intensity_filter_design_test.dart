import 'dart:math';

import 'package:realtime_seismic_intensity/src/jma_intensity_filter_design.dart';
import 'package:test/test.dart';

void main() {
  group('JmaIntensityFilterDesign', () {
    test('100 Hz のハイパスが 0.05 Hz の2次バターワースの係数になること', () {
      final highPass = JmaIntensityFilterDesign(samplingRate: 100).stages.first;

      expect(highPass.b0, closeTo(0.997781024102941, 1e-12));
      expect(highPass.b1, closeTo(-1.995562048205882, 1e-12));
      expect(highPass.b2, closeTo(0.997781024102941, 1e-12));
      expect(highPass.a1, closeTo(-1.995557124345789, 1e-12));
      expect(highPass.a2, closeTo(0.995566972065975, 1e-12));
    });

    // 平成8年気象庁告示第4号の計測震度の算出方法で定めるフィルタ（周期効果・ハイカット・ローカット）。
    double jmaFilter(double f) {
      final x = f / 10;
      final periodEffect = sqrt(1 / f);
      final highCut =
          1 /
          sqrt(
            1 +
                0.694 * pow(x, 2) +
                0.241 * pow(x, 4) +
                0.0557 * pow(x, 6) +
                0.009664 * pow(x, 8) +
                0.00134 * pow(x, 10) +
                0.000155 * pow(x, 12),
          );
      final lowCut = sqrt(1 - exp(-pow(f / 0.5, 3)));
      return periodEffect * highCut * lowCut;
    }

    for (final samplingRate in [100, 200]) {
      test('$samplingRate Hz で 0.2〜10 Hz の振幅特性が告示のフィルタと 3% 以内で一致すること', () {
        final design = JmaIntensityFilterDesign(samplingRate: samplingRate);
        for (final f in [0.2, 0.3, 0.5, 0.7, 1.0, 2.0, 3.0, 5.0, 7.0, 10.0]) {
          final ratio = design.magnitudeAt(f) / jmaFilter(f);
          expect(ratio, closeTo(1, 0.03), reason: '$f Hz');
        }
      });
    }
  });
}
