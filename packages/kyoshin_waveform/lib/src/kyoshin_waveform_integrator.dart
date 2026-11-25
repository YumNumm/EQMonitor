import 'dart:math';
import 'dart:typed_data';

// 加速度（gal）を台形則で積分し、積分で増える長周期のずれを2次バターワースのハイパスで除く。
// ハイパスは前後に2回掛けて位相のずれを打ち消すため、記録全体が揃ってから使う。
final class const KyoshinWaveformIntegrator({final double lowCutHz = 0.1}) {
  Float64List velocity({
    required Float64List accelerationGal,
    required int samplingRate,
  }) => _highPass(
    _integrate(
      _highPass(accelerationGal, samplingRate),
      samplingRate,
    ),
    samplingRate,
  );

  Float64List displacement({
    required Float64List accelerationGal,
    required int samplingRate,
  }) => _highPass(
    _integrate(
      velocity(accelerationGal: accelerationGal, samplingRate: samplingRate),
      samplingRate,
    ),
    samplingRate,
  );

  Float64List _integrate(Float64List samples, int samplingRate) {
    final result = Float64List(samples.length);
    final halfStep = 0.5 / samplingRate;
    for (var i = 1; i < samples.length; i++) {
      result[i] = result[i - 1] + (samples[i - 1] + samples[i]) * halfStep;
    }
    return result;
  }

  Float64List _highPass(Float64List samples, int samplingRate) {
    final k = tan(pi * lowCutHz / samplingRate);
    final norm = 1 + sqrt2 * k + k * k;
    final b0 = 1 / norm;
    final a1 = 2 * (k * k - 1) / norm;
    final a2 = (1 - sqrt2 * k + k * k) / norm;
    final forward = _filter(samples, b0: b0, a1: a1, a2: a2);
    final backward = _filter(
      Float64List.fromList(forward.reversed.toList()),
      b0: b0,
      a1: a1,
      a2: a2,
    );
    return Float64List.fromList(backward.reversed.toList());
  }

  Float64List _filter(
    Float64List samples, {
    required double b0,
    required double a1,
    required double a2,
  }) {
    final result = Float64List(samples.length);
    var x1 = 0.0;
    var x2 = 0.0;
    var y1 = 0.0;
    var y2 = 0.0;
    for (var i = 0; i < samples.length; i++) {
      final x = samples[i];
      final y = b0 * (x - 2 * x1 + x2) - a1 * y1 - a2 * y2;
      x2 = x1;
      x1 = x;
      y2 = y1;
      y1 = y;
      result[i] = y;
    }
    return result;
  }
}
