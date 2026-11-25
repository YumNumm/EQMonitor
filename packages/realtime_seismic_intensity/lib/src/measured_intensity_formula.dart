import 'dart:math';

final class const MeasuredIntensityFormula() {
  double? fromAcceleration(double acceleration) {
    if (!(acceleration > 0) || acceleration.isInfinite) {
      return null;
    }
    return round(2 * log(acceleration) / ln10 + 0.94);
  }

  // 気象庁の計測震度と同じく、小数第3位を四捨五入してから小数第2位以下を切り捨てる。
  double round(double rawIntensity) =>
      ((rawIntensity * 100).roundToDouble() / 10).floorToDouble() / 10;
}
