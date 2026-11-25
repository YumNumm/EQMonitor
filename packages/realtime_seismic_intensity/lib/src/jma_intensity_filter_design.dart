import 'dart:math';

import 'package:realtime_seismic_intensity/src/biquad_coefficients.dart';

// 0.05 Hz のハイパス以外の6段は、特許第5946067号（防災科学技術研究所）の実施例に示された式による。
// 営利目的で利用する場合は、防災科学技術研究所とのライセンス契約が必要。詳細は README を参照。
final class JmaIntensityFilterDesign({required final int samplingRate}) {
  static const gain = 1.262;
  static const highPassCutoff = 0.05;

  late final List<BiquadCoefficients> stages = [
    _highPass(),
    _a11(f0: 0.45, f1: 7),
    _a12(f1: 7),
    _a13(fb: 0.5, hb1: 1, hb2: 0.75),
    _a14(fc: 12, hc: 0.9),
    _a14(fc: 20, hc: 0.6),
    _a14(fc: 30, hc: 0.6),
  ];

  late final double _fs = samplingRate.toDouble();
  late final double _fs2 = _fs * _fs;

  double magnitudeAt(double frequency) => stages.fold(
    gain,
    (value, stage) =>
        value *
        stage.magnitudeAt(frequency: frequency, samplingRate: samplingRate),
  );

  BiquadCoefficients _highPass() {
    final k = tan(pi * highPassCutoff / _fs);
    final norm = 1 + sqrt2 * k + k * k;
    return BiquadCoefficients(
      b0: 1 / norm,
      b1: -2 / norm,
      b2: 1 / norm,
      a0: 1,
      a1: 2 * (k * k - 1) / norm,
      a2: (1 - sqrt2 * k + k * k) / norm,
    );
  }

  BiquadCoefficients _a11({required double f0, required double f1}) {
    final w1 = 2 * pi * f0;
    final w2 = 2 * pi * f1;
    return BiquadCoefficients(
      b0: 4 * _fs2 + 2 * w2 * _fs,
      b1: -8 * _fs2,
      b2: 4 * _fs2 - 2 * w2 * _fs,
      a0: 8 * _fs2 + (4 * w1 + 2 * w2) * _fs + w1 * w2,
      a1: 2 * w1 * w2 - 16 * _fs2,
      a2: 8 * _fs2 - (4 * w1 + 2 * w2) * _fs + w1 * w2,
    );
  }

  BiquadCoefficients _a12({required double f1}) {
    final w = 2 * pi * f1;
    return BiquadCoefficients(
      b0: 4 * _fs2 + 8.5 * w * _fs + w * w,
      b1: 2 * w * w - 8 * _fs2,
      b2: 4 * _fs2 - 8.5 * w * _fs + w * w,
      a0: 16 * _fs2 + 17 * w * _fs + w * w,
      a1: 2 * w * w - 32 * _fs2,
      a2: 16 * _fs2 - 17 * w * _fs + w * w,
    );
  }

  BiquadCoefficients _a13({
    required double fb,
    required double hb1,
    required double hb2,
  }) {
    final w = 2 * pi * fb;
    return BiquadCoefficients(
      b0: 12 * _fs2 + 12 * hb1 * w * _fs + w * w,
      b1: 10 * w * w - 24 * _fs2,
      b2: 12 * _fs2 - 12 * hb1 * w * _fs + w * w,
      a0: 12 * _fs2 + 12 * hb2 * w * _fs + w * w,
      a1: 10 * w * w - 24 * _fs2,
      a2: 12 * _fs2 - 12 * hb2 * w * _fs + w * w,
    );
  }

  BiquadCoefficients _a14({required double fc, required double hc}) {
    final w = 2 * pi * fc;
    return BiquadCoefficients(
      b0: w * w,
      b1: 10 * w * w,
      b2: w * w,
      a0: 12 * _fs2 + 12 * hc * w * _fs + w * w,
      a1: 10 * w * w - 24 * _fs2,
      a2: 12 * _fs2 - 12 * hc * w * _fs + w * w,
    );
  }
}
